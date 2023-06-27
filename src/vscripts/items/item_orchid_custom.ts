import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { direction2D, getCursorPosition } from "../util";

@registerAbility("item_orchid_custom")
class ItemOrchid extends CustomAbility {
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
        const damage = this.GetSpecialValueFor("ability_damage");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/orchid_proj.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });

                ModifierItemOrchid.apply(unit, projectile.getSource(), this, { duration: duration });
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("DOTA_Item.Orchid.Activate", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "DOTA_Item.Orchid.Activate", this.caster);

        const particleId = ParticleManager.CreateParticle("particles/orchid_proj_impact.vpcf", ParticleAttachment.ABSORIGIN, this.caster);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_item_orchid_custom")
class ModifierItemOrchid extends CustomModifier {
    particleId?: ParticleID;

    OnCreated() {
        this.SetStackCount(0);
        this.particleId = ParticleManager.CreateParticle(
            "particles/items2_fx/orchid.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
    }

    OnDestroy() {
        if (IsServer()) {
            ApplyDamage({
                victim: this.parent,
                attacker: this.caster,
                damage: this.GetStackCount(),
                damage_type: DamageTypes.PURE
            });
            this.PlayEffectsOnDestroy();

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage(event: ModifierAttackEvent) {
        this.SetStackCount(this.GetStackCount() + event.damage);
        return 0;
    }

    CheckState() {
        return {
            [ModifierState.SILENCED]: true
        };
    }

    PlayEffectsOnDestroy() {
        const particleId = ParticleManager.CreateParticle("particles/items2_fx/orchid_pop.vpcf", ParticleAttachment.ABSORIGIN, this.parent);
        ParticleManager.SetParticleControl(particleId, 1, Vector(this.GetStackCount() * 100));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    GetEffectName() {
        return "particles/generic_gameplay/generic_silenced.vpcf";
    }
    GetEffectAttachType() {
        return ParticleAttachment.OVERHEAD_FOLLOW;
    }

    // function modifier_item_orchid_custom:GetStatusLabel() return "Soul Burn" }
    // function modifier_item_orchid_custom:GetStatusPriority() return 5 }
    // function modifier_item_orchid_custom:GetStatusStyle() return "Silence" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_orchid_custom)
