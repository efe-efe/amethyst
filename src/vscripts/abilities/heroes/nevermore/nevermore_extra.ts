import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { areUnitsAllied } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("nevermore_extra")
class NevermoreExtra extends CustomAbility {
    particleId?: ParticleID;

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.particleId = EFX(
                "particles/nevermore/nevermore_ex_second_attack_casting.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster,
                {}
            );
            EmitSoundOn("Hero_Nevermore.ROS.Arcana.Cast", this.caster);
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        if (this.particleId) {
            DEFX(this.particleId, true);
        }
        StopSoundOn("Hero_Nevermore.ROS.Arcana.Cast", this.caster);
    }

    GetAnimation() {
        return GameActivity.DOTA_TELEPORT;
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetCastingCrawl() {
        return 100;
    }

    OnSpellStart() {
        this.caster.AddNewModifier(this.caster, this, "modifier_nevermore_extra", {
            duration: this.GetSpecialValueFor("duration")
        });

        EmitSoundOn("Hero_Nevermore.Shadowraze.Arcana", this.caster);
    }
}

@registerModifier("modifier_nevermore_extra")
class ModifierNevermoreExtra extends CustomModifier {
    particleId?: ParticleID;

    IsAura() {
        return true;
    }

    GetModifierAura() {
        return ModifierNevermoreExtraDebuff.name;
    }

    GetAuraRadius() {
        return this.Value("radius");
    }

    GetAuraDuration() {
        return 0.5;
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraEntityReject(entity: CDOTA_BaseNPC) {
        if (areUnitsAllied(this.caster, entity)) {
            return true;
        }
        return false;
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnCreated() {
        if (IsServer()) {
            const origin = this.caster.GetAbsOrigin();

            this.particleId = EFX("particles/nevermore/nevermore_ex_second_attack.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                cp2: Vector(this.Value("radius"), 0, 0)
            });

            ParticleManager.SetParticleControlEnt(
                this.particleId,
                1,
                this.caster,
                ParticleAttachment.POINT_FOLLOW,
                AttachLocation.hitloc,
                origin,
                true
            );
        }
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    // function modifier_nevermore_extra:GetStatusLabel() return "Tornado" }
    // function modifier_nevermore_extra:GetStatusPriority() return 4 }
    // function modifier_nevermore_extra:GetStatusStyle() return "Tornado" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_nevermore_extra)

@registerModifier("modifier_nevermore_extra_debuff")
class ModifierNevermoreExtraDebuff extends CustomModifier {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return true;
    }

    IsPurgable() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            victim: this.parent,
            attacker: this.caster,
            damage: this.Value("damage_per_think"),
            damage_type: DamageTypes.PURE
        });
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -this.Value("slow_pct");
    }
}
