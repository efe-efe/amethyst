import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierSpectreSpecialAttackBuff, ModifierSpectreSpecialAttackDebuff } from "./spectre_special_attack";

@registerAbility("spectre_ultimate")
class SpectreUltimate extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.6;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierSpectreUltimateThinker.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius"),
            duration: this.GetSpecialValueFor("duration"),
            content: "clearout"
        });
        EmitSoundOn("Hero_Spectre.HauntCast", this.caster);
    }
}
// if (IsClient()){ require("wrappers/abilities") }
// Abilities.Castpoint(spectre_ultimate)

@registerModifier({ customNameForI18n: "modifier_spectre_ultimate" })
export class ModifierSpectreUltimate extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            if (this.caster == this.parent) {
                ModifierSpectreSpecialAttackBuff.apply(this.parent, this.parent, this.ability, {});
                this.SetStackCount(1);
            } else {
                this.SetStackCount(2);
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            if (this.IsDebuff() && this.GetStackCount() == 2) {
                EmitSoundOn("Hero_Spectre.DaggerImpact", this.parent);

                ModifierSpectreSpecialAttackDebuff.apply(this.parent, this.caster, this.ability, {
                    duration: 5.0
                });
                this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", {
                    duration: 5.0,
                    max_slow_pct: 50
                });
                if (IsServer()) {
                    ApplyDamage({
                        victim: this.parent,
                        attacker: this.caster,
                        damage: this.Value("ability_damage"),
                        damage_type: DamageTypes.PURE
                    });
                }
            } else {
                this.parent.RemoveModifierByName(ModifierSpectreSpecialAttackBuff.name);
            }
        }
    }

    IsDebuff() {
        return this.GetStackCount() == 2 && !CustomEntitiesLegacy.Allies(this.caster, this.parent);
    }

    DeclareFunctions() {
        return [ModifierFunction.BONUS_VISION_PERCENTAGE, ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetBonusVisionPercentage() {
        if (this.IsDebuff()) {
            return -80;
        }

        return 0;
    }

    GetModifierPreAttack_BonusDamage() {
        if (!this.IsDebuff()) {
            return this.Value("bonus_damage");
        }

        return 0;
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_ultimate_thinker" })
class ModifierSpectreUltimateThinker extends ModifierThinker {
    origin!: Vector;
    particleId?: ParticleID;

    IsAura() {
        return this.initialized;
    }

    GetModifierAura() {
        return ModifierSpectreUltimate.name;
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
            this.origin = this.parent.GetAbsOrigin();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                this.origin,
                this.radius,
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );

            for (const enemy of enemies) {
                ModifierSpectreUltimate.findOne(enemy)?.SetStackCount(1);
            }

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
        }
    }

    OnReady() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/spectre/spectre_ultimate.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleId, 0, this.origin);
        ParticleManager.SetParticleControl(this.particleId, 1, Vector(this.radius, this.radius, 1));
        EmitSoundOn("Hero_Spectre.HauntCast", this.parent);
        EmitSoundOn("Hero_Spectre.Reality", this.parent);
    }
}