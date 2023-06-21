import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierMarsSoldier } from "./mars_extra";

@registerAbility("mars_ultimate")
class MarsUltimate extends CustomAbility {
    thinkerModifier?: ModifierMarsUltimateThinker;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.thinkerModifier = ModifierMarsUltimateThinker.createThinker(this.caster, this, this.caster.GetAbsOrigin(), {
                delayTime: this.GetCastPoint(),
                radius: this.GetSpecialValueFor("radius"),
                duration: this.GetSpecialValueFor("duration") + this.GetCastPoint()
            })[1];

            return true;
        }

        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        this.thinkerModifier?.Destroy();
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_ultimate_area_check" })
class ModifierMarsUltimateMark extends CustomModifier {}

@registerModifier({ customNameForI18n: "modifier_mars_ultimate_thinker" })
class ModifierMarsUltimateThinker extends ModifierThinker {
    particleId?: ParticleID;

    IsAura() {
        return this.initialized;
    }

    GetModifierAura() {
        return ModifierMarsUltimateMark.name;
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
        EmitSoundOn("Hero_Mars.ArenaOfBlood", this.parent);
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            EmitSoundOn("Hero_Mars.ArenaOfBlood.End", this.parent);
            this.StopEffects();
        }
    }

    OnReady() {
        if (IsServer()) {
            this.PlayEffectsOnCreated();
            EmitSoundOn("Hero_Mars.ArenaOfBlood.Start", this.parent);

            const origin = this.parent.GetAbsOrigin();
            const vector = origin.__add(Vector(this.radius, 0, 0));
            const soldierRadius = this.ability.GetSpecialValueFor("soldier_radius");
            const count = 32;

            const angleDiff = 360 / count;

            for (let i = 0; i < count; i++) {
                const location = RotatePosition(origin, QAngle(0, angleDiff * i, 0), vector);
                const direction = RotatePosition(Vector(0, 0, 0), QAngle(0, 200 + angleDiff * i, 0), Vector(1, 0, 0));

                CreateUnitByNameAsync(
                    "npc_dota_mars_ultimate_soldier",
                    location,
                    false,
                    this.caster,
                    undefined,
                    this.caster.GetTeamNumber(),
                    (unit: CDOTA_BaseNPC) => {
                        unit.SetForwardVector(direction);
                        unit.SetNeverMoveToClearSpace(true);

                        ModifierMarsSoldier.apply(unit, this.caster, this.ability, {
                            duration: this.GetDuration(),
                            visibility: i % 2 == 0 ? "visible" : "notVisible",
                            behavior: i % 2 == 0 ? "fade" : "notFade",
                            x: direction.x,
                            y: direction.y,
                            radius: soldierRadius
                        });
                    }
                );
            }
        }
    }

    PlayEffectsOnCreated() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 1, Vector(this.radius, 1, 1));
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}
