import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { direction2D, meeleEFX } from "../../../../util";

@registerAbility("centaur_axe_attack")
class CentaurAxeAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const damage = 20;

        const point = this.GetCursorPosition();
        const radius = this.GetSpecialValueFor("radius");
        const direction = direction2D(origin, point);
        const modifier = this.caster.FindModifierByName("modifier_juggernaut_ex_counter");

        meeleEFX(this.caster, direction, radius, modifier ? Vector(0, 255, 0) : undefined);
        meeleEFX(this.caster, direction, radius / 2, modifier ? Vector(0, 255, 0) : undefined);

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: 1,
            attackType: "basic",
            // bShakeOnHeroes = true,
            effect: (target: CDOTA_BaseNPC) => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.PHYSICAL
                });

                this.PlayEffectsOnImpact(target);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        EmitSoundOn("Hero_Centaur.DoubleEdge", this.caster);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", target);
        const offset = 100;
        const origin = this.caster.GetAbsOrigin();
        const direction = direction2D(origin, target.GetAbsOrigin());
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 1, direction2D(finalPosition, origin));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
