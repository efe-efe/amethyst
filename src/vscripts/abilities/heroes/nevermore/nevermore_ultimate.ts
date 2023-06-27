import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { ProjectileBehavior } from "../../../projectiles";
import { direction2D } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierNevermoreStacks } from "./nevermore_basic_attack";

@registerAbility("nevermore_ultimate")
class NevermoreUltimate extends CustomAbility {
    thinkerModifier?: ModifierNevermoreUltimateThinker;
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_6;
    }
    GetPlaybackRateOverride() {
        return 1.0;
    }
    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.thinkerModifier = ModifierNevermoreUltimateThinker.createThinker(this.caster, this, this.caster.GetAbsOrigin(), {
                delayTime: this.GetCastPoint(),
                radius: this.GetSpecialValueFor("radius"),
                duration: this.GetSpecialValueFor("duration") + this.GetCastPoint()
            })[1];

            this.particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            );
            EmitGlobalSound("Hero_Nevermore.ROS.Arcana.Cast");
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        this.thinkerModifier?.Destroy();

        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, true);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }

        StopGlobalSound("Hero_Nevermore.ROS.Arcana.Cast");
    }

    OnSpellStart() {
        this.thinkerModifier?.Destroy();

        const origin = this.caster.GetAbsOrigin();
        const radius = this.GetSpecialValueFor("radius");
        const baseDamage = this.GetSpecialValueFor("base_damage");
        const damagePerSoul = this.GetSpecialValueFor("damage_per_soul");
        const modifier = ModifierNevermoreStacks.findOne(this.caster);
        const souls = modifier?.GetStackCount() ?? 0;
        const damage = (baseDamage + souls * damagePerSoul) / 2;

        const lines = 5 + souls * 3;
        const initialAngleDeg = this.caster.GetAnglesAsVector().y;
        const deltaAngle = 360 / lines;

        for (let i = 0; i < lines; i++) {
            let facingAngleDeg = initialAngleDeg + deltaAngle * i;

            if (facingAngleDeg > 360) {
                facingAngleDeg = facingAngleDeg - 360;
            }
            const facingAngle = math.rad(facingAngleDeg);
            const facingVector = Vector(math.cos(facingAngle), math.sin(facingAngle), 0).Normalized();
            const velocity = facingVector.__mul(1800);

            this.ProjectileAttack({
                source: this.caster,
                effectName: "particles/nevermore/nevermore_basic_attack.vpcf",
                spawnOrigin: origin.__add(Vector(0, 0, 80)),
                velocity: velocity,
                groundOffset: 0,
                distance: radius,
                unitBehavior: ProjectileBehavior.NOTHING,
                wallBehavior: ProjectileBehavior.NOTHING,
                unitTest: (unit, projectile) =>
                    unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
                onFinish: projectile => {
                    this.PlayEffectsOnFinish(projectile.getPosition());
                }
            });
        }

        this.DamageEnemiesInArea(origin, radius, damage);
        this.DamageEnemiesInArea(origin, radius / 2, damage);

        ScreenShake(origin, 100, 300, 0.45, 1000, 0, true);

        modifier?.SetStackCount(0);

        this.PlayEffectsLines(lines);
    }

    DamageEnemiesInArea(origin: Vector, radius: number, damage: number) {
        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: damage,
                damage_type: DamageTypes.PURE
            });
            EmitSoundOn("Hero_Spectre.Attack", enemy);
        }
    }

    PlayEffectsLines(lines: number) {
        EmitSoundOn("Hero_Nevermore.ROS.Arcana", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, Vector(lines, 0, 0));
        ParticleManager.SetParticleControlForward(particleId, 2, this.caster.GetForwardVector());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnFinish(position: Vector) {
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_explosion.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_nevermore_ultimate_thinker")
class ModifierNevermoreUltimateThinker extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.PlayEffects();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.StopEffects();
        }
    }

    PlayEffects() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 1, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 3, Vector(this.radius, 0, 0));
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnIntervalThink() {
        super.OnIntervalThink();

        if (IsServer()) {
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
                const direction = direction2D(enemy.GetAbsOrigin(), this.origin);
                const point = enemy.GetAbsOrigin().__add(direction.__mul(8));
                enemy.SetAbsOrigin(point);
                FindClearSpaceForUnit(enemy, enemy.GetAbsOrigin(), true);
            }
        }
    }
}
