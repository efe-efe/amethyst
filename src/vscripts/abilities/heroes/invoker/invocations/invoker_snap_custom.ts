import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierStun } from "../../../../modifiers/modifier_stunned";
import { direction2D } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";

@registerAbility("invoker_snap_custom")
class InvokerSnap extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_GHOST_WALK;
    }
    GetPlaybackRateOverride() {
        return 1.5;
    }
    GetCastingCrawl() {
        return 20;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const duration = this.GetSpecialValueFor("duration");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/invoker/invoker_snap_custom.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ModifierInvokerSnap.apply(unit, projectile.getSource(), this, { duration: duration });

                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.PURE
                });
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnFinish(position: Vector) {
        EFX(
            "particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: position,
                cp3: position,
                release: true
            }
        );
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Invoker.Attack", this.caster);
        EmitSoundOn("Hero_Invoker.ColdSnap.Cast", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_snap_custom" })
class ModifierInvokerSnap extends CustomModifier {
    inCooldown = false;

    OnCreated() {
        if (IsServer()) {
            EmitSoundOn("Hero_Invoker.ColdSnap", this.parent);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_TAKEDAMAGE];
    }

    OnIntervalThink() {
        this.inCooldown = false;
        this.StartIntervalThink(-1);
    }

    OnTakeDamage(event: ModifierInstanceEvent) {
        if (IsServer() && event.unit == this.parent && !this.inCooldown) {
            this.inCooldown = true;
            this.StartIntervalThink(this.Value("off_time"));

            ModifierStun.apply(this.parent, this.caster, undefined, {
                duration: this.Value("stun_duration")
            });
            this.PlayEffects(event.attacker);
        }
    }

    PlayEffects(attacker: CDOTA_BaseNPC) {
        const direction = direction2D(attacker.GetAbsOrigin(), this.parent.GetAbsOrigin());

        const efx = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf",
            ParticleAttachment.POINT_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControlEnt(efx, 0, this.parent, ParticleAttachment.POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true);
        ParticleManager.SetParticleControl(efx, 1, this.parent.GetAbsOrigin().__add(direction));
        ParticleManager.ReleaseParticleIndex(efx);

        EmitSoundOn("Hero_Invoker.ColdSnap.Freeze", this.parent);
    }

    GetEffectName() {
        return "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    // function modifier_invoker_snap_custom:GetStatusLabel() return "Cold Snap" }
    // function modifier_invoker_snap_custom:GetStatusPriority() return 2 }
    // function modifier_invoker_snap_custom:GetStatusStyle() return "ColdSnap" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_invoker_snap_custom)
