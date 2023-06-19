import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { PuckBasicAttack, PuckBasicAttackRelated } from "./puck_basic_attack";
import { PuckCounter } from "./puck_counter";

@registerAbility("puck_ultimate")
class PuckUltimate extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_5;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierPuckUltimateThinker.createThinker(this.caster, this, point, {
            duration: this.GetSpecialValueFor("duration") + 0.2,
            delayTime: this.GetSpecialValueFor("duration")
        });

        EmitSoundOn("Hero_Puck.Dream_Coil", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_ultimate_thinker" })
class ModifierPuckUltimateThinker extends ModifierThinker {
    particleId?: ParticleID;

    IsAura() {
        return true;
    }

    GetModifierAura() {
        return ModifierPuckUltimateCheck.name;
    }

    GetAuraRadius() {
        return this.radius;
    }

    GetAuraDuration() {
        return 0.0;
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);
        if (IsServer()) {
            const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                this.parent.GetAbsOrigin(),
                this.radius,
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );

            for (const enemy of enemies) {
                ModifierPuckUltimate.apply(enemy, this.caster, this.ability, {
                    duration: this.Value("duration"),
                    x: this.parent.GetAbsOrigin().x,
                    y: this.parent.GetAbsOrigin().y,
                    z: this.parent.GetAbsOrigin().z
                });
                ModifierStun.apply(enemy, this.caster, this.ability, {
                    duration: this.Value("initial_stun_duration")
                });
            }

            this.particleId = ParticleManager.CreateParticle(
                "particles/econ/items/puck/puck_alliance_set/puck_dreamcoil_aproset.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_EXECUTED];
    }

    OnAbilityExecuted(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.caster) {
                return;
            }
            const basicAttack = PuckBasicAttack.findOne(this.caster);
            const counter = PuckCounter.findOne(this.caster);
            const basicAttackRelated = PuckBasicAttackRelated.findOne(this.caster);
            if (event.ability == counter || event.ability == basicAttackRelated || event.ability == basicAttack) {
                basicAttack?.LaunchProjectile(this.parent.GetAbsOrigin(), CustomAbilitiesLegacy.GetCursorPosition(this.ability));
            }
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_ultimate_debuff" })
class ModifierPuckUltimate extends CustomModifier {
    origin!: Vector;

    OnCreated(params: { x: number; y: number; z: number }) {
        if (IsServer()) {
            this.origin = Vector(params.x, params.y, params.z);
            this.PlayEffects();
        }
    }

    PlayEffects() {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControl(particleId, 0, this.origin);
        ParticleManager.SetParticleControlEnt(
            particleId,
            1,
            this.parent,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.parent.GetAbsOrigin(),
            true
        );

        this.AddParticle(particleId, false, false, -1, false, false);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_ultimate_area_check" })
class ModifierPuckUltimateCheck extends CustomModifier {
    IsHidden() {
        return true;
    }

    IsPurgable() {
        return false;
    }

    OnDestroy() {
        if (IsServer()) {
            if (ModifierPuckUltimate.findOne(this.parent)) {
                ApplyDamage({
                    victim: this.parent,
                    attacker: this.caster,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });
                this.parent.RemoveModifierByName(ModifierPuckUltimate.name);
                ModifierStun.apply(this.parent, this.caster, this.ability, {
                    duration: this.Value("snap_stun_duration")
                });
                EmitSoundOn("Hero_Puck.Dream_Coil_Snap", this.parent);
            }
        }
    }
}
