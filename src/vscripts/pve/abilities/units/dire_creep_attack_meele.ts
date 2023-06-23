import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../lib/dota_ts_adapter";
import { attackWithBaseDamage, clampPosition, direction2D, meeleEFX } from "../../../util";

@registerAbility("dire_creep_attack_meele")
class DireCreepAttackMeele extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }

        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;

            return super.GetCooldown(level) + attackSpeed;
        }

        return super.GetCooldown(level);
    }

    OnSpellStart() {
        const cursor = this.GetCursorPosition();
        const origin = this.caster.GetOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange,
            minRange: castRange
        });
        const radius = this.GetSpecialValueFor("radius");
        const direction = direction2D(origin, point);

        meeleEFX(this.caster, direction, radius, Vector(0, 255, 0));

        this.MeeleAttack({
            direction,
            origin,
            radius,
            attackType: "basic",
            // bShakeOnHeroes = true,
            effect: (target: CDOTA_BaseNPC) => {
                attackWithBaseDamage({ source: this.caster, target: target });
                this.PlayEffectsOnImpact(target);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        EmitSoundOn("Hero_Centaur.DoubleEdge", this.caster);

        EmitSoundOnLocationWithCaster(point, "Hero_Juggernaut.PreAttack", this.caster);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });

        EmitSoundOn("Hero_Juggernaut.Attack", target);
    }
}
