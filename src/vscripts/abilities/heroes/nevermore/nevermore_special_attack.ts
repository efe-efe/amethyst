import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { ModifierThinker } from "../../../modifiers/modifier_thinker";
import { clampPosition, findUnitsInRadius, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierNevermoreStacks } from "./nevermore_basic_attack";

@registerAbility("nevermore_special_attack")
class NevermoreSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_RAZE_3;
    }

    GetPlaybackRateOverride() {
        return 1.3;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            EmitSoundOn(`nevermore_nev_cast_0${RandomInt(0, 3)}`, this.caster);
            EmitSoundOn("Hero_Nevermore.Attack", this.caster);

            return true;
        }
        return false;
    }

    GetIntrinsicModifierName() {
        return ModifierNevermoreSpecialAttackCharges.name;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined)
        });

        ModifierNevermoreSpecialAttackThinker.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            delayTime: this.GetSpecialValueFor("delay_time")
        });

        // LinkAbilityCooldowns(this.caster, 'nevermore_ex_special_attack')
    }

    // function nevermore_special_attack:OnUpgrade()
    // 	if(this.GetLevel() == 2 ) {
    // 		this.caster.FindModifierByName("modifier_nevermore_special_attack_charges"):AddCharge()
    // 	}
    // }
}

@registerAbility("nevermore_ex_special_attack")
class NevermoreExSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_RAZE_2;
    }

    GetPlaybackRateOverride() {
        return 1.3;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    OnSpellStart() {
        this.caster.RemoveGesture(this.GetAnimation());

        const healPerSoul = this.GetSpecialValueFor("heal_per_soul");
        const heal = this.GetSpecialValueFor("heal");
        const modifier = ModifierNevermoreStacks.findOne(this.caster);
        const souls = modifier?.GetStackCount() ?? 0;
        modifier?.SetStackCount(0);

        this.PlayEffects();
        this.caster.Heal(heal + healPerSoul * souls, this);
        // LinkAbilityCooldowns(this.caster, 'nevermore_special_attack')
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.SoulRing.Activate", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 60, Vector(68, 243, 0));
        ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_nevermore_special_attack_charges")
class ModifierNevermoreSpecialAttackCharges extends ModifierCharges {
    GetMaxCharges() {
        return this.Value("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            this.ability.GetCooldown(this.ability.GetLevel());
        }
        return 0;
    }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Charges(modifier_nevermore_special_attack_charges)

@registerModifier("modifier_nevermore_special_attack_thinker")
class ModifierNevermoreSpecialAttackThinker extends ModifierThinker {
    OnReady() {
        const enemies = findUnitsInRadius(
            this.caster,
            this.origin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            const stacks = ModifierNevermoreSpecialAttack.findOne(enemy)?.GetStackCount() ?? 0;

            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.ability.GetSpecialValueFor("ability_damage") + this.Value("damage_per_stack") * stacks,
                damage_type: DamageTypes.PURE
            });

            ModifierNevermoreSpecialAttack.apply(enemy, this.caster, this.ability, { duration: this.Value("stacks_duration") });
        }

        if (enemies.some(enemy => !isObstacle(enemy) && !isGem(enemy))) {
            giveManaAndEnergyPercent(this.caster, this.Value("mana_gain_pct"), true);
        }

        EmitSoundOnLocationWithCaster(this.origin, "Hero_Nevermore.Shadowraze", this.caster);

        EFX("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: Vector(this.radius, 1, 1),
            release: true
        });

        this.Destroy();
    }
}

@registerModifier("modifier_nevermore_special_attack_stacks")
class ModifierNevermoreSpecialAttack extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    OnStackCountChanged() {
        if (IsServer()) {
            if (this.GetStackCount() > this.Value("max_stacks")) {
                this.SetStackCount(this.Value("max_stacks"));
                return;
            }

            if (this.GetStackCount() == 0) {
                this.Destroy();
            }
        }
    }

    GetEffectName() {
        return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    // function modifier_nevermore_special_attack_stacks:GetStatusLabel() return "Raze" }
    // function modifier_nevermore_special_attack_stacks:GetStatusPriority() return 4 }
    // function modifier_nevermore_special_attack_stacks:GetStatusStyle() return "Raze" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_nevermore_special_attack_stacks)
