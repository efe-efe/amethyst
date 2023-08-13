import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCombatEvents, OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { findUnitsInRadius, strongPurge } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { defineAbility } from "../../framework/ability_definition";
import { addAnimation, removeAnimation } from "../../../animation";
import { hasUpgrade } from "../../../upgrade_definitions";
import { precache, resource } from "../../../precache";

const resources = precache({
    explosion: resource.fx("particles/econ/items/axe/axe_ti9_immortal/axe_ti9_beserkers_call_owner_aoe_dome.vpcf"),
    trail: resource.fx("particles/econ/events/ti9/phase_boots_ti9.vpcf"),
    spin: resource.fx("particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"),
    spinReflect: resource.fx("particles/econ/items/juggernaut/jugg_sword_jade/juggernaut_blade_fury_jade.vpcf"),
    damage: resource.fx("particles/juggernaut/juggernaut_mobility_impact.vpcf")
});

@registerAbility("juggernaut_mobility")
class JuggernautMobility extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");

        strongPurge(this.caster);

        ModifierJuggernautMobility.apply(this.caster, this.caster, this, { duration: duration });

        const random = RandomInt(1, 9);
        if (random > 1) {
            EmitSoundOn(`juggernaut_jug_ability_bladefury_0${random}`, this.caster);
        }
    }
}

@registerModifier("modifier_juggernaut_mobility")
export class ModifierJuggernautMobility extends ModifierCombatEvents {
    particleId!: ParticleID;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    StatusEffectPriority() {
        return 2.0;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(this.Value("think_interval"));
            this.PlayEffects();
            addAnimation(this.caster, GameActivity.DOTA_OVERRIDE_ABILITY_1);
        }
    }

    OnIntervalThink() {
        const enemies = findUnitsInRadius(
            this.parent,
            this.parent.GetAbsOrigin(),
            this.Value("radius"),
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.MAGIC_IMMUNE_ENEMIES,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            if (hasUpgrade(this.parent, UpgradeId.juggernautAttackSpin)) {
                this.ability.SingleAttack({
                    attackType: "basic",
                    target: enemy,
                    effect: target => {
                        ApplyDamage({
                            victim: target,
                            attacker: this.caster,
                            damage: this.Value("damage_per_second"),
                            damage_type: DamageTypes.PURE,
                            ability: this.ability
                        });
                        this.PlayEffectsOnImpact(target);
                    }
                });
            } else {
                ApplyDamage({
                    victim: enemy,
                    attacker: this.caster,
                    damage: this.Value("damage_per_second"),
                    damage_type: DamageTypes.PURE,
                    ability: this.ability
                });
                this.PlayEffectsOnImpact(enemy);
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.StopEffects();
            EmitSoundOn("Hero_Juggernaut.BladeFuryStop", this.parent);
            removeAnimation(this.caster, GameActivity.DOTA_OVERRIDE_ABILITY_1);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.ON_ORDER];
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent && (event.order_type == UnitOrder.STOP || event.order_type == UnitOrder.HOLD_POSITION)) {
            this.Destroy();
        }
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    CheckState() {
        return {
            [ModifierState.NO_UNIT_COLLISION]: true,
            [ModifierState.SILENCED]: true
        };
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Juggernaut.Attack", target);
        EmitSoundOn("Hero_Juggernaut.BladeFury.Impact", target);
        EFX(resources.damage.path, ParticleAttachment.ABSORIGIN, target, {
            release: true
        });
    }

    PlayEffects() {
        EmitSoundOn("Hero_Juggernaut.BladeFuryStart", this.parent);

        const path = this.ShouldReflect() ? resources.spinReflect.path : resources.spin.path;
        this.particleId = ParticleManager.CreateParticle(path, ParticleAttachment.ABSORIGIN_FOLLOW, this.parent);
        ParticleManager.SetParticleControl(this.particleId, 5, Vector(this.Value("radius"), 1, 1));
        ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
    }

    ShouldReflect() {
        return this.ability.GetLevel() >= 2 || hasUpgrade(this.parent, UpgradeId.juggernautReflectSpin);
    }

    StopEffects() {
        StopSoundOn("Hero_Juggernaut.BladeFuryStart", this.parent);

        ParticleManager.DestroyParticle(this.particleId, false);
        ParticleManager.ReleaseParticleIndex(this.particleId);

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(resources.explosion.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.GetCaster())
        );
    }

    GetEffectName() {
        return resources.trail.path;
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    OnHit(event: OnHitEvent) {
        if (IsServer() && event.attackCategory == "projectile") {
            if (!this.ShouldReflect()) {
                return true;
            }

            if (event.projectile.getIsReflectable() == true) {
                event.projectile.setVelocity(event.projectile.getVelocity().__mul(-1.2), event.projectile.getPosition());
                event.projectile.setSource(this.parent);
                // event.projectile.SetVisionTeam(this.parent:GetTeam())
                event.projectile.resetDistanceTraveled();
                // event.projectile.ResetRehit()
                EmitSoundOn("Hero_Juggernaut.Attack", this.parent);
            }

            return false;
        }

        return true;
    }
}

defineAbility(JuggernautMobility, {
    category: "mobility"
});
