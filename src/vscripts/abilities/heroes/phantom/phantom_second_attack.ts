import { addAnimation } from "../../../animation";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { precache, resource } from "../../../precache";
import { hasUpgrade } from "../../../upgrades/framework/upgrade_definitions";
import {
    clampPosition,
    direction2D,
    findUnitsInRadius,
    getCursorPosition,
    giveManaAndEnergyPercent,
    isGem,
    isObstacle
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPhantomStacks } from "./phantom_basic_attack";

const resources = precache({
    swoop: resource.fx("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"),
    swoopExtra: resource.fx(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
    ),
    impact: resource.fx("particles/juggernaut/juggernaut_second_attack_parent.vpcf"),
    blinkStart: resource.fx(
        "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
    ),
    blinkEnd: resource.fx("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf")
});

class PhantomSecondAttackCommon extends CustomAbility {
    PlayEffectsOnImpact(target: CDOTA_BaseNPC, stacks: number) {
        EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", target);
        const offset = 100;
        const origin = this.caster.GetAbsOrigin();
        const direction = direction2D(origin, target.GetAbsOrigin());
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        if (stacks == 3) {
            EmitSoundOn("Hero_PhantomAssassin.Spatter", target);
        }

        const particleId = ParticleManager.CreateParticle(
            stacks == 3 ? resources.swoop.path : resources.swoopExtra.path,
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 1, direction2D(finalPosition, origin));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerAbility("phantom_second_attack")
class PhantomSecondAttack extends PhantomSecondAttackCommon {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 80;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, { maxRange: castRange, minRange: castRange });
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster);

        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(this.caster)
        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const damagePerStack = this.GetSpecialValueFor("damage_per_stack");
        const direction = direction2D(origin, point);
        const stacks = ModifierPhantomStacks.findOne(this.caster)?.GetStackCount() ?? 0;
        const finalDamage = damage + stacks * damagePerStack;

        const units = this.MeeleAttack({
            direction,
            origin,
            radius,
            // bShakeOnHeroes = true,
            effect: target => {
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: finalDamage,
                    damage_type: DamageTypes.PHYSICAL,
                    ability: this
                });
                if (stacks == 3) {
                    // const modifier = this.caster.FindModifierByName("modifier_phantom_mobility_charges")
                    // if modifier then
                    // 	if this.GetLevel() >= 2 then
                    // 		modifier:RefreshCharges()
                    // 	else
                    // 		modifier:AddCharge()
                    // 	}
                    // }
                    EmitSoundOn("DOTA_Item.MagicWand.Activate", this.caster);
                }

                if (!isObstacle(target) && !isGem(target)) {
                    giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                }
                this.PlayEffectsOnImpact(target, stacks);
            }
        });

        this.PlayEffectsOnFinish(direction, radius);
        this.caster.RemoveModifierByName(ModifierPhantomStacks.name);
        EmitSoundOn("Hero_PhantomAssassin.Attack", this.caster);

        if (units.length > 0 && hasUpgrade(this.caster, UpgradeId.phantomSecondRecast)) {
            ModifierPhantomSecondAttackRecast.apply(this.caster, this.caster, undefined, {
                abilityLeft: PhantomSecondAttack.name,
                abilityRight: PhantomSecondAttackRecast.name,
                duration: 3.0
            });
        }
    }

    PlayEffectsOnFinish(direction: Vector, radius: number) {
        const origin = this.caster.GetAbsOrigin();
        const efx = EFX(resources.impact.path, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp0f: direction,
            cp3: Vector(radius, 0, 0)
        });
        ParticleManager.SetParticleControl(efx, 60, Vector(255, 0, 255));
        ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0));
        ParticleManager.ReleaseParticleIndex(efx);
    }

    // function phantom_second_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_second_attack_recast")
    // }
}

@registerAbility("phantom_second_attack_recast")
class PhantomSecondAttackRecast extends PhantomSecondAttackCommon {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(this.caster)
        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined)
        });
        const extraDamage = this.GetSpecialValueFor("extra_damage");

        EmitSoundOn("Hero_PhantomAssassin.Blur", this.caster);
        EFX(resources.blinkStart.path, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp3: origin,
            release: true
        });
        FindClearSpaceForUnit(this.caster, point, true);
        EmitSoundOn("Hero_PhantomAssassin.Blur.Break", this.caster);

        EFX(resources.blinkEnd.path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            cp3: this.caster.GetAbsOrigin(),
            release: true
        });

        const enemies = findUnitsInRadius(
            this.caster,
            this.caster.GetAbsOrigin(),
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                attacker: this.caster,
                damage: this.caster.GetAverageTrueAttackDamage(this.caster) + extraDamage,
                damage_type: DamageTypes.PHYSICAL,
                victim: enemy,
                ability: this
            });
            this.PlayEffectsOnImpact(enemy, 0);
            EmitSoundOn("Hero_PhantomAssassin.Spatter", enemy);
        }

        EmitSoundOn("Hero_PhantomAssassin.Attack", this.caster);
        addAnimation(this.caster, GameActivity.DOTA_ATTACK_EVENT, { duration: 0.5, rate: 1.5 });
    }
}

@registerModifier("modifier_phantom_second_attack_recast")
class ModifierPhantomSecondAttackRecast extends ModifierRecast<undefined> {}
