import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { direction2D, fullyFaceTowards, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("sniper_ultimate")
class SniperUltimate extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 2.5;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            EmitGlobalSound("sniper_snip_ability_assass_02");
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        StopGlobalSound("sniper_snip_ability_assass_02");
    }

    OnSpellStart() {
        ModifierSniperUltimateChanneling.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("duration") });
        EmitGlobalSound("sniper_snip_laugh_08");
    }
}

@registerModifier("modifier_sniper_ultimate_channeling")
class ModifierSniperUltimateChanneling extends CustomModifier<SniperUltimate> {
    OnCreated() {
        if (IsServer()) {
            this.OnIntervalThink();
            this.StartIntervalThink(0.45);
        }
    }

    OnIntervalThink() {
        this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_ATTACK, 1.5);

        const origin = this.parent.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const projectileSpeed = this.Value("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        this.ability.ProjectileAttack({
            source: this.parent,
            effectName: "particles/sniper/sniper_ultimate_new.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 100, projectileDirection.y * 100, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.MAGICAL
                });
                ModifierSniperUltimate.apply(unit, projectile.getSource(), this.ability, { duration: 0.1 });
                this.PlayEffectsTarget(projectile.getSource(), unit, projectile.getPosition());
            },
            onFinish: projectile => {
                const position = projectile.getPosition();
                const source = projectile.getSource();
                const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                    source,
                    position,
                    this.Value("radius") + 50,
                    UnitTargetTeam.ENEMY,
                    UnitTargetType.HERO + UnitTargetType.BASIC,
                    UnitTargetFlags.NONE,
                    FindOrder.ANY
                );
                for (const enemy of enemies) {
                    if (!ModifierSniperUltimate.findOne(enemy)) {
                        ApplyDamage({
                            victim: enemy,
                            attacker: source,
                            damage: this.Value("aoe_damage"),
                            damage_type: DamageTypes.PURE
                        });
                    }
                    const knockbackDirection = projectile.getVelocity().Normalized();

                    ModifierDisplacement.apply(enemy, source, this.ability, {
                        x: knockbackDirection.x,
                        y: knockbackDirection.y,
                        distance: this.Value("radius"),
                        speed: this.Value("radius") / 0.15,
                        peak: 0
                    });
                }
                ScreenShake(position, 100, 300, 0.45, 1000, 0, true);
                this.PlayEffectsExplosion(position);
                this.PlayEffectsProjectileImpact(source, position);
            }
        });

        fullyFaceTowards(this.parent, projectileDirection);
        EmitSoundOn("Ability.Assassinate", this.parent);
    }

    OnDestroy() {
        if (IsServer()) {
            this.parent.FadeGesture(GameActivity.DOTA_ATTACK);
            let particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_techies/techies_base_attack_smokeburst.vpcf",
                ParticleAttachment.CUSTOMORIGIN,
                undefined
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                7,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                this.parent.GetAbsOrigin().__add(Vector(0, 0, 96)),
                true
            );
            ParticleManager.ReleaseParticleIndex(particleId);

            particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_techies/techies_base_attack_explosion.vpcf",
                ParticleAttachment.CUSTOMORIGIN,
                undefined
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                0,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                this.parent.GetAbsOrigin().__add(Vector(0, 0, 96)),
                true
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                3,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                this.parent.GetAbsOrigin().__add(Vector(0, 0, 96)),
                true
            );
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    PlayEffectsProjectileImpact(source: CDOTA_BaseNPC, position: Vector) {
        EmitSoundOn("Hero_Sniper.AssassinateDamage", source);
        const particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, source);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsTarget(source: CDOTA_BaseNPC, target: CDOTA_BaseNPC, position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Sniper.AssassinateDamage", source);
        const particle_cast = "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, target);
        ParticleManager.SetParticleControl(particleId, 0, target.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsExplosion(position: Vector) {
        const particle_cast = "particles/econ/items/techies/techies_arcana/techies_suicide_arcana.vpcf";
        const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Channeling(modifier_sniper_ultimate_channeling)

@registerModifier("modifier_sniper_ultimate_displacement")
class ModifierSniperUltimateDisplacement extends ModifierDisplacement {}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Displacement(modifier_sniper_ultimate_displacement)

@registerModifier("modifier_sniper_ultimate_hit")
class ModifierSniperUltimate extends CustomModifier {}
