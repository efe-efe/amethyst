import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, direction2D, giveEnergyPercent, giveManaPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierStormUltimate } from "./storm_ultimate";

@registerAbility("storm_special_attack")
class StormSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierStormSpecialAttackThinker.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });

        this.PlayEffectsOnCast(origin, point);
        EmitSoundOn("Hero_StormSpirit.ElectricVortexCast", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCast(origin: Vector, point: Vector) {
        const efx = EFX("particles/storm/storm_special_attack_launch.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp1: point + Vector(0, 0, 2000)
        });
        ParticleManager.SetParticleControlEnt(efx, 0, this.caster, ParticleAttachment.POINT_FOLLOW, "attach_attack1", origin, false);
        ParticleManager.ReleaseParticleIndex(efx);
        EmitSoundOn("Hero_StormSpirit.Attack", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_special_attack_thinker" })
class ModifierStormSpecialAttackThinker extends ModifierThinker {
    origin!: Vector;
    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        this.origin = this.parent.GetAbsOrigin();
    }

    OnReady() {
        EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: this.origin + Vector(0, 0, 1000),
            cp2: this.origin,
            release: true
        });

        let giveMana = true;

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.parent,
            this.parent.GetAbsOrigin(),
            this.Value("radius"),
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.Value("ability_damage"),
                damage_type: DamageTypes.PURE
            });

            ModifierStormSpecialAttack.apply(enemy, this.caster, this.ability, {
                duration: this.Value("duration"),
                originX: this.origin.x,
                originY: this.origin.y
            });

            ModifierStun.apply(enemy, this.caster, this.ability, { duration: 0.1 });

            if (!isObstacle(enemy) && !isGem(enemy)) {
                if (this.ability.GetLevel() >= 2) {
                    enemy.Script_ReduceMana(this.Value("mana_gain_pct"), this.ability);
                    this.GiveMana();
                } else {
                    if (giveMana) {
                        this.GiveMana();
                        giveMana = false;
                    }
                }
            }
        }
        this.Destroy();
    }

    GiveMana() {
        giveManaPercent(this.caster, this.Value("mana_gain_pct"), true, false);
        giveEnergyPercent(this.caster, this.Value("energy_gain_pct"), true, false);

        const modifier = ModifierStormUltimate.findOne(this.caster);
        if (modifier) {
            const extraManaPct = this.Value("mana_gain_pct") * (modifier.GetManaMultiplier() - 1);
            giveManaPercent(this.caster, extraManaPct, true, true);
        }
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_special_attack_efx" })
class ModifierStormSpecialAttack extends CustomModifier {
    particleId!: ParticleID;
    origin!: Vector;

    OnCreated(params: { originX: number; originY: number }) {
        if (IsServer()) {
            this.origin = Vector(params.originX, params.originY, this.parent.GetAbsOrigin().z);
            this.particleId = EFX(
                "particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf",
                ParticleAttachment.CUSTOMORIGIN,
                undefined,
                {
                    cp0: this.origin
                }
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                1,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_hitloc",
                Vector(0, 0, 0),
                true
            );
            this.AddParticle(this.particleId, false, false, -1, false, false);
            EmitSoundOn("Hero_StormSpirit.ElectricVortex", this.parent);
            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            DEFX(this.particleId, false);
            StopSoundOn("Hero_StormSpirit.ElectricVortex", this.parent);
        }
    }

    OnIntervalThink() {
        const direction = direction2D(this.parent.GetAbsOrigin(), this.origin);
        const point = this.parent.GetAbsOrigin().__add(direction.__mul(10));
        this.parent.SetAbsOrigin(point);
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    // function modifier_storm_special_attack_efx:GetStatusLabel() return "Electric Vortex" }
    // function modifier_storm_special_attack_efx:GetStatusPriority() return 1 }
    // function modifier_storm_special_attack_efx:GetStatusStyle() return "StormUnleashed" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Animation(modifier_storm_special_attack_efx)
// Modifiers.Status(modifier_storm_special_attack_efx)
