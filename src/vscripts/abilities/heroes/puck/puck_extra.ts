import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { clampPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("puck_extra")
class PuckExtra extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    GetManaCost(level: number) {
        if (IsServer() && ModifierPuckExtraRecast.findOne(this.caster)) {
            return 0;
        }
        return super.GetManaCost(level);
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });
        const preSilenceDuration = this.GetSpecialValueFor("pre_silence_duration");
        const radius = this.GetSpecialValueFor("radius");

        FindClearSpaceForUnit(this.caster, point, true);

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            point,
            radius,
            UnitTargetTeam.FRIENDLY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ModifierPuckExtra.apply(enemy, this.caster, this, { duration: preSilenceDuration });
        }

        this.PlayEffectsOnCast(radius);
        // CreateRadiusMarker(caster, point, self.radius, RADIUS_SCOPE_PUBLIC);
    }

    PlayEffectsOnCast(radius: number) {
        EmitSoundOn("Hero_Puck.Waning_Rift", this.caster);
        EmitSoundOn(`puck_puck_ability_rift_0${RandomInt(1, 3)}`, this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/puck/puck_fairy_wing/puck_waning_rift_fairy_wing.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, Vector(radius, radius, radius));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_extra_debuff" })
class ModifierPuckExtra extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.ON_ORDER];
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent) {
            if (event.order_type == UnitOrder.CAST_POSITION || event.order_type == UnitOrder.CAST_NO_TARGET) {
                if (this.ability.GetLevel() >= 2) {
                    if (!ModifierPuckExtraMark.findOne(this.caster)) {
                        ModifierPuckExtraMark.apply(this.caster, this.caster, this.ability, { duration: 5.0 });
                        ModifierPuckExtraRecast.apply(this.caster, this.caster, this.ability, {
                            abilityLeft: PuckExtra.name,
                            duration: 5.0
                        });
                        EFX("particles/puck/puck_ex_base_attack.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                            release: true
                        });
                    } else {
                        this.caster.RemoveModifierByName(ModifierPuckExtraMark.name);
                    }
                }

                this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_silence", {
                    duration: this.Value("silence_duration")
                });
                EmitSoundOn("Hero_Puck.IIllusory_Orb_Damage", this.parent);
                const particleId = ParticleManager.CreateParticle(
                    "particles/units/heroes/hero_puck/puck_waning_rift.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                );
                ParticleManager.SetParticleControl(particleId, 1, Vector(100, 100, 100));
                ParticleManager.ReleaseParticleIndex(particleId);
                this.Destroy();
            }
        }
    }
    // function modifier_puck_extra_debuff:GetStatusLabel() return "SpellBlock" }
    // function modifier_puck_extra_debuff:GetStatusPriority() return 4 }
    // function modifier_puck_extra_debuff:GetStatusStyle() return "SpellBlock" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_puck_extra_debuff)

//@Refactor maybe it should be a generic modifier (but that would make it not repeteable... mm)
@registerModifier({ customNameForI18n: "modifier_puck_extra_recast" })
class ModifierPuckExtraRecast extends ModifierRecast {}

@registerModifier({ customNameForI18n: "modifier_puck_extra_recast_used" })
class ModifierPuckExtraMark extends CustomModifier {}
