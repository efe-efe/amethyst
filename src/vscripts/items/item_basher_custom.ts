import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { ModifierStun } from "../modifiers/modifier_stunned";
import { clampPosition, direction2D, meeleEFX } from "../util";

@registerAbility("item_basher_custom")
class ItemBasher extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetCastingCrawl() {
        return 30;
    }

    OnSpellStart() {
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const origin = this.caster.GetOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange
        });
        const radius = this.GetSpecialValueFor("radius");
        const direction = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");

        meeleEFX(this.caster, direction, radius, Vector(255, 255, 0));

        this.MeeleAttack({
            direction,
            origin,
            radius,
            effect: (target: CDOTA_BaseNPC) => {
                ModifierStun.apply(target, this.caster, this, { duration: duration });
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL
                });

                this.PlayEffectsOnImpact(target);
            },
            baseSound: "DOTA_Item.SkullBasher.PreAttack"
        });

        this.PlayEffectsOnFinish(point);
    }

    PlayEffectsOnFinish(position: Vector) {
        const offset = 40;
        const origin = this.caster.GetAbsOrigin();
        const direction = direction2D(origin, position);
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        let particleId = ParticleManager.CreateParticle(
            "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target
        );
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
