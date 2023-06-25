import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../../modifiers/modifier_thinker";
import { getCursorPosition } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";

@registerAbility("invoker_sun_custom")
class InvokerSun extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const point = getCursorPosition(this.caster);

        ModifierInvokerSunThiner.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            delayTime: this.GetSpecialValueFor("delay_time")
        });
    }
}

@registerModifier()
class ModifierInvokerSunThiner extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            AddFOWViewer(this.caster.GetTeamNumber(), this.origin, this.radius, this.delayTime + 0.2, true);

            this.particleId = EFX(
                "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf",
                ParticleAttachment.WORLDORIGIN,
                this.caster,
                {
                    cp0: this.origin,
                    cp1: Vector(this.radius, 0, 0)
                }
            );
            EmitSoundOn("Hero_Invoker.SunStrike.Charge", this.parent);
        }
    }

    OnReady() {
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
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.Value("ability_damage"),
                damage_type: DamageTypes.PURE
            });
        }

        EFX("particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: Vector(this.origin.x, this.origin.y, 0),
            cp1: Vector(this.radius, 0, 0),
            release: true
        });

        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, true);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }

        StopSoundOn("Hero_Invoker.SunStrike.Charge", this.parent);
        EmitSoundOn("Hero_Invoker.SunStrike.Ignite", this.parent);
        this.Destroy();
    }
}
