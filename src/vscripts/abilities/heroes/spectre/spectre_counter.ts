import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ProjectileBehavior } from "../../../projectiles";
import { createRadiusMarker, direction2D, fullyFaceTowards, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierSpectreBasicAttack } from "./spectre_basic_attack";

@registerAbility("spectre_counter")
class SpectreCounter extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("counter_duration");
        ModifierSpectreCounter.apply(this.caster, this.caster, this, { duration: duration });

        EmitSoundOn("Hero_Spectre.HauntCast", this.caster);
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            )
        );
        // LinkAbilityCooldowns(this.caster, 'spectre_ex_counter')
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_counter_countering" })
class ModifierSpectreCounter extends ModifierCounter {
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/spectre/spectre_counter.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
            this.StartIntervalThink(0.03);
        }
    }

    OnIntervalThink() {
        const mouse = CustomAbilitiesLegacy.GetCursorPosition(this.ability);
        const direction = direction2D(this.parent.GetAbsOrigin(), mouse);
        this.PlayEffectsOnCast();
        fullyFaceTowards(this.parent, Vector(direction.x, direction.y, this.parent.GetForwardVector().z));
    }

    OnDestroy() {
        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );

            ParticleManager.ReleaseParticleIndex(particleId);

            EmitSoundOn("Hero_Spectre.HauntCast", this.parent);
            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_EXECUTED, ModifierFunction.ON_ORDER];
    }

    OnAbilityExecuted(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent && event.ability != SpectreCounterRecast.findOne(this.parent)) {
            this.Destroy();
        }
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent && (event.order_type == UnitOrder.STOP || event.order_type == UnitOrder.HOLD_POSITION)) {
            this.Destroy();
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            const direction =
                event.attackCategory == "projectile"
                    ? event.projectile.getVelocity().Normalized()
                    : direction2D(event.source.GetAbsOrigin(), this.parent.GetAbsOrigin());

            //@Refactor check on this... Idk why i manually destroy it
            if (event.attackCategory == "projectile" && event.projectile.getIsDestructible()) {
                event.projectile.scheduleDestroy();
            }

            const projection = direction.x * this.parent.GetForwardVector().x + direction.y * this.parent.GetForwardVector().y;

            if (projection <= -0.8) {
                ModifierSpectreBasicAttack.findOne(this.parent)?.Replenish();

                if (!ModifierSpectreCounterRecast.findOne(this.parent)) {
                    ModifierSpectreCounterRecast.apply(this.parent, this.parent, this.ability, {
                        abilityLeft: SpectreCounter.name,
                        abilityRight: SpectreCounterRecast.name,
                        duration: 5.0
                    });
                }

                if (this.ability.GetLevel() >= 2) {
                    // this.parent.FindModifierByName('modifier_spectre_mobility_charges'):RefreshCharges()
                }
                this.PlayEffectsOnTrigger();

                return false;
            }
        }
        return true;
    }

    PlayEffectsOnCast() {
        const particleId = ParticleManager.CreateParticle(
            "particles/spectre/spectre_counter_shield.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControlForward(particleId, 0, this.parent.GetForwardVector());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnTrigger() {
        EmitSoundOn("Hero_Spectre.Reality", this.parent);
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_spectre/spectre_death.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 3, this.parent.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_terrorblade_reflection.vpcf";
    }

    Visuals() {
        return [];
    }

    GetMovementSpeedPercentage() {
        return 80;
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_counter_recast" })
class ModifierSpectreCounterRecast extends ModifierRecast {}

@registerAbility("spectre_counter_recast")
class SpectreCounterRecast extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    // GetIgnoreActivationCycle() {
    //     return true;
    // }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.PlayEffectsOnPhase();
            return true;
        }
        return false;
    }

    // HasPriority(){
    // 	return true
    // }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const spectreCounter = SpectreCounter.findOne(this.caster);

        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = spectreCounter?.GetSpecialValueFor("ability_damage") ?? 0;

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/spectre/spectre_ex_second_attack.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 80)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                this.TeleportTarget(unit, projectile.getSource());
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("Hero_Nevermore.Raze_Flames", this.caster);
    }

    TeleportTarget(target: CDOTA_BaseNPC, caster: CDOTA_BaseNPC) {
        const casterOrigin = caster.GetAbsOrigin();
        const targetOrigin = target.GetAbsOrigin();
        const direction = direction2D(targetOrigin, casterOrigin);
        const distance = casterOrigin.__sub(targetOrigin).Length2D();
        const newOrigin = casterOrigin.__add(caster.GetForwardVector().__mul(150));

        this.ProjectileAttack({
            distance: distance,
            startRadius: this.GetSpecialValueFor("hitbox_return"),
            source: this.caster,
            effectName: "particles/spectre/spectre_ex_second_attack.vpcf",
            spawnOrigin: targetOrigin.__add(Vector(0, 0, 80)),
            velocity: direction.__mul(this.GetSpecialValueFor("projectile_speed_return")),
            groundOffset: 0,
            unitBehavior: ProjectileBehavior.NOTHING,
            wallBehavior: ProjectileBehavior.NOTHING,
            onFinish: () => {
                FindClearSpaceForUnit(target, newOrigin, true);
                EFX("particles/units/heroes/hero_spectre/spectre_death.vpcf", ParticleAttachment.WORLDORIGIN, target, {
                    cp0: targetOrigin,
                    cp3: targetOrigin,
                    release: true
                });
                EFX(
                    "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    target,
                    {
                        cp0: newOrigin,
                        release: true
                    }
                );
            }
        });
    }

    PlayEffectsOnPhase() {
        EmitSoundOn("Hero_Spectre.Haunt", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 15, Vector(128, 32, 108));
        ParticleManager.SetParticleControl(particleId, 16, Vector(1, 0, 0));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.RequiemOfSouls.Damage", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.SetParticleControl(particleId, 2, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerAbility("spectre_ex_counter")
class SpectreExCounter extends CustomAbility {
    OnSpellStart() {
        ModifierSpectreExCounter.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("delay_time") });
        EmitSoundOn("Hero_Spectre.HauntCast", this.caster);

        // LinkAbilityCooldowns(this.caster, 'spectre_counter')
    }
}

@registerModifier({ customNameForI18n: "modifier_spectre_ex_counter" })
class ModifierSpectreExCounter extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            const origin = this.parent.GetAbsOrigin();
            const particleId = ParticleManager.CreateParticle(
                "particles/spectre/spectre_ex_counter.vpcf",
                ParticleAttachment.OVERHEAD_FOLLOW,
                this.parent
            );
            ParticleManager.SetParticleControl(particleId, 2, Vector(this.Value("radius"), this.Value("radius"), this.Value("radius")));
            ParticleManager.SetParticleControlEnt(
                particleId,
                3,
                this.parent,
                ParticleAttachment.ABSORIGIN_FOLLOW,
                "attach_hitloc",
                origin,
                true
            );
            ParticleManager.SetParticleControlEnt(
                particleId,
                6,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack2",
                origin,
                true
            );
            this.AddParticle(particleId, false, false, -1, false, false);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            const origin = this.parent.GetAbsOrigin();

            const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                origin,
                this.Value("radius"),
                UnitTargetTeam.ENEMY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            );

            const giveHealth = enemies.some(enemy => !isObstacle(enemy) && !isGem(enemy));

            for (const enemy of enemies) {
                ApplyDamage({
                    victim: enemy,
                    attacker: this.parent,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });

                ModifierFadingSlow.apply(enemy, this.caster, undefined, {
                    duration: this.Value("fading_slow_duration"),
                    maxSlowPct: this.Value("fading_slow_pct")
                });

                ModifierSpectreExCounterDebuff.apply(enemy, this.caster, this.ability, {
                    duration: 0.25
                });

                EFX(
                    "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    enemy,
                    {
                        cp0: enemy.GetAbsOrigin(),
                        release: true
                    }
                );
                EFX(
                    "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf",
                    ParticleAttachment.WORLDORIGIN,
                    enemy,
                    {
                        cp0: enemy.GetAbsOrigin(),
                        release: true
                    }
                );
            }

            if (giveHealth) {
                this.parent.Heal(this.Value("heal"), this.ability);
            }

            EmitSoundOn("Hero_ShadowDemon.DemonicPurge.Damage", this.parent);

            const particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );

            ParticleManager.SetParticleControl(particleId, 2, Vector(this.Value("radius"), this.Value("radius"), this.Value("radius")));
            createRadiusMarker(this.parent, origin, this.Value("radius"), "public", 0.1);
        }
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_grimstroke_ink_swell.vpcf";
    }

    // function modifier_spectre_ex_counter:GetStatusLabel() return "Revenant" }
    // function modifier_spectre_ex_counter:GetStatusPriority() return 2 }
    // function modifier_spectre_ex_counter:GetStatusStyle() return "Revenant" }
    // function modifier_spectre_ex_counter:GetStatusContentType() return STATUS_CONTENT_FILLUP }
}

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_ex_counter)

@registerModifier({ customNameForI18n: "modifier_spectre_ex_counter_debuff" })
class ModifierSpectreExCounterDebuff extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(0.03);
        }
    }

    OnIntervalThink() {
        const direction = direction2D(this.parent.GetAbsOrigin(), this.caster.GetAbsOrigin());
        const point = this.parent.GetAbsOrigin().__add(direction.__mul(40));
        this.parent.SetAbsOrigin(point);
    }
}
