import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCooldown } from "../../../modifiers/modifier_cooldown";
import { ModifierSilence } from "../../../modifiers/modifier_silence";
import {
    attackWithBaseDamage,
    clampPosition,
    direction2D,
    getCursorPosition,
    giveManaAndEnergyPercent,
    isCountering,
    isGem,
    isObstacle,
    lock,
    replenishEFX,
    tryLock
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("spectre_basic_attack")
class SpectreBasicAttack extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierSpectreBasicAttack.name;
    }

    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }

        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;
            return super.GetCooldown(level) + attackSpeed;
        }

        return super.GetCooldown(level);
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        if (IsServer()) {
            const slow = ModifierSpectreBasicAttack.findOne(this.caster)?.IsCooldownReady() ? 0.3 : 0.0;
            return 1.1 - slow;
        }

        return 0;
    }

    GetCastingCrawl() {
        return this.GetSpecialValueFor("cast_point_speed_pct");
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange,
            minRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const cooldownReduction = this.GetSpecialValueFor("cooldown_reduction");
        const cooldownReductionCounter = this.GetSpecialValueFor("cooldown_reduction_counter");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const direction = direction2D(origin, point);
        const charged = ModifierSpectreBasicAttack.findOne(this.caster)?.IsCooldownReady() ?? false;
        const radius =
            this.GetSpecialValueFor("radius") + meeleExtraRadius + (charged ? this.GetSpecialValueFor("charged_extra_radius") : 0);

        if (charged) {
            ScreenShake(point, 100, 100, 0.45, 1000, 0, true);
        }

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: charged ? undefined : 1,
            attackType: "basic",
            effect: (target: CDOTA_BaseNPC) => {
                attackWithBaseDamage({ source: this.caster, target });

                if (!isObstacle(target) && !isGem(target)) {
                    giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                }

                this.PlayEffectsOnImpact(target, target.GetAbsOrigin(), charged);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        this.PlayEffectsOnFinish(direction, charged, radius);
        this.PlayEffectsOnCast(charged);
    }

    PlayEffectsOnFinish(direction: Vector, charged: boolean, radius: number) {
        const origin = this.caster.GetAbsOrigin();

        this.PlayEffectsMeele(origin, direction, radius, charged);

        if (charged) {
            this.PlayEffectsMeeleExplosion(origin);
            this.PlayEffectsMeeleDecorators(origin, direction, radius);
        }
    }

    PlayEffectsMeele(origin: Vector, direction: Vector, radius: number, charged: boolean) {
        const particleId = EFX("particles/spectre/spectre_basic_attack_parent.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp0f: direction,
            cp3: Vector(radius, 0, 0)
        });
        ParticleManager.SetParticleControl(particleId, 60, Vector(107, 14, 103));
        ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));

        if (charged) {
            ParticleManager.SetParticleControl(particleId, 4, Vector(1, 0, 0));
        }

        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsMeeleDecorators(origin: Vector, direction: Vector, radius: number) {
        const particleId = ParticleManager.CreateParticle(
            "particles/spectre/spectre_basic_attack_charged.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, origin);
        ParticleManager.SetParticleControl(particleId, 1, Vector(radius, radius, radius));
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsMeeleExplosion(origin: Vector) {
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 2, origin);
        ParticleManager.SetParticleControl(particleId, 4, origin);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCast(charged: boolean) {
        EmitSoundOn("Hero_Spectre.PreAttack", this.caster);
        if (charged) {
            EmitSoundOn("Hero_Sven.Layer.GodsStrength", this.caster);
        }
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC, position: Vector, charged: boolean) {
        if (charged) {
            EmitSoundOn("Hero_BountyHunter.Jinada", target);
            const particleId = ParticleManager.CreateParticle(
                "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf",
                ParticleAttachment.POINT,
                target
            );
            ParticleManager.ReleaseParticleIndex(particleId);
            return;
        }

        EmitSoundOn("Hero_Spectre.Attack", target);
        EFX("particles/phantom/phantom_basic_attack.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_spectre/spectre_desolate.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControlForward(particleId, 0, direction2D(this.caster.GetAbsOrigin(), position));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_spectre_basic_attack_cooldown")
export class ModifierSpectreBasicAttack extends ModifierCooldown {
    attackSpeedLock = lock();

    particleId?: ParticleID;

    OnCreated() {
        super.OnCreated();

        // this.damage_bonus_desolate = this.ability.GetSpecialValueFor("damage_bonus_desolate");
    }

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE, ModifierFunction.ATTACK_POINT_CONSTANT];
    }

    OnBasicAttackEnded() {
        if (this.GetRemainingTime() > 0) {
            return;
        } else {
            this.StartCooldown();
        }
    }

    OnBasicAttackLanded(event: { target: CDOTA_BaseNPC }): void {
        if (this.IsCooldownReady()) {
            ModifierSilence.apply(event.target, this.parent, this.ability, {
                duration: this.Value("silence_duration")
            });

            if (!isObstacle(event.target) && !isGem(event.target)) {
                giveManaAndEnergyPercent(this.caster, this.Value("mana_gain_pct"), true);
                ModifierSpectreDesolate.apply(event.target, this.parent, this.ability, { duration: this.Value("desolate_duration") });
            }

            if (!isObstacle(event.target) && !isCountering(event.target)) {
                this.parent.Heal(this.Value("heal_charged"), this.ability);
            }
        }
    }

    GetModifierPreAttack_BonusDamage() {
        if (!this.IsCooldownReady()) {
            return 0;
        }
        return this.ability.GetSpecialValueFor("charged_damage");
    }

    OnAttackLanded(event: ModifierAttackEvent) {
        if (event.attacker != this.parent) {
            return;
        }

        if (ModifierSpectreDesolate.findOne(event.target) && !isObstacle(event.target)) {
            this.parent.Heal(this.Value("heal_desolate"), this.ability);
            this.PlayEffectsLifeSteal();
        }
    }

    GetModifierAttackPointConstant() {
        if (!this.IsCooldownReady() || !IsServer()) {
            return 0;
        }

        return tryLock(this.attackSpeedLock, () => 0.2 + this.caster.GetAttackAnimationPoint(), 0);
    }

    OnReplenish() {
        replenishEFX(this.parent);
        this.PlayEffectsWeapon();
    }

    OnCooldownStart() {
        this.StopEffectsWeapon();
    }

    PlayEffectsLifeSteal() {
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            )
        );
    }

    PlayEffectsWeapon() {
        if (IsServer()) {
            const origin = this.caster.GetAbsOrigin();
            this.particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_nevermore/nevermore_base_attack_c.vpcf",
                ParticleAttachment.CUSTOMORIGIN,
                this.caster
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                0,
                this.caster,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                3,
                this.caster,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                origin,
                true
            );
        }
    }
    StopEffectsWeapon() {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    GetEffectName() {
        return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetReplenishTime() {
        return this.Value("replenish_time");
    }

    // GetPreAttackDamage(params){
    //     if (params.victim:HasModifier("modifier_spectre_desolate_custom")){
    //         return this.damage_bonus_desolate
    //     }
    //     return 0
    // }
}

// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Cooldown(modifier_spectre_basic_attack_cooldown)
// Modifiers.OnEvent(modifier_spectre_basic_attack_cooldown)
// Modifiers.PreAttackDamage(modifier_spectre_basic_attack_cooldown)

@registerModifier("modifier_spectre_basic_attack_attack")
class ModifierSpectreBasicAttackBuff extends CustomModifier {}

@registerModifier("modifier_spectre_desolate_custom")
class ModifierSpectreDesolate extends CustomModifier {
    IsDebuff() {
        return true;
    }

    IsHidden() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    GetEffectName() {
        return "particles/units/heroes/hero_spectre/spectre_desolate_debuff.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetTexture() {
        return "spectre_desolate_modifier";
    }
    // function modifier_spectre_desolate_custom:GetStatusLabel() return "Desolate" }
    // function modifier_spectre_desolate_custom:GetStatusPriority() return 6 }
    // function modifier_spectre_desolate_custom:GetStatusStyle() return "Desolate" }
}
// if (IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_spectre_desolate_custom)
