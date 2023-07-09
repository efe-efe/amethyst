import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { ModifierRoot } from "../modifiers/modifier_root";
import { areUnitsAllied, direction2D, getCursorPosition } from "../util";

@registerAbility("item_atos_custom")
class ItemAtos extends CustomAbility {
    GetCastingCrawl() {
        return 90;
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const duration = this.GetSpecialValueFor("duration");
        const projectileDirection = direction2D(origin, point);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/rod_of_atos/rod_of_atos_attack.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ModifierRoot.apply(unit, projectile.getSource(), this, { duration: duration });
                this.PlayEffectsOnImpact(unit);
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("DOTA_Item.RodOfAtos.Target", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "DOTA_Item.RodOfAtos.Cast", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/items2_fx/rod_of_atos_attack_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        const particleId = ParticleManager.CreateParticle(
            "particles/items2_fx/rod_of_atos_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            target
        );
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
