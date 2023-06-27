import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierUpgradePhantomQuickRecast } from "../../../modifiers/upgrades/modifier_favors";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { direction2D, getCursorPosition, isCountering } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("phantom_extra")
class PhantomExtra extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }

    GetPlaybackRateOverride() {
        return 0.7;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetManaCost(level: number) {
        if (IsServer() && ModifierPhantomExtraRecast.findOne(this.caster)) {
            return 0;
        }
        return super.GetManaCost(level);
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const direction = direction2D(origin, point);
        const distance = this.GetCastRange(Vector(0, 0, 0), undefined);

        ModifierPhantomExtraDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.2,
            peak: 30,
            teamFilter: UnitTargetTeam.ENEMY
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_PhantomAssassin.Strike.Start", this.caster);
        const particleId = ParticleManager.CreateParticle("particles/blink_purple.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_phantom_extra_displacement")
class ModifierPhantomExtraDisplacement extends ModifierDisplacement {
    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
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
                this.OnImpact(enemy);
            }

            const particleId = ParticleManager.CreateParticle(
                "particles/phantom/mobility_trail.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.parent
            );
            ParticleManager.SetParticleControl(particleId, 0, this.origin);
            ParticleManager.SetParticleControl(particleId, 1, this.parent.GetAbsOrigin());
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer() && event.collision == "unit") {
            for (const unit of event.units) {
                this.OnImpact(unit);
            }
        }
    }

    OnImpact(target: CDOTA_BaseNPC) {
        if (!ModifierPhantomExtraMark.findOne(target)) {
            this.ability.SingleAttack({
                target: target,
                effect: target => {
                    if (!isCountering(target)) {
                        ModifierFadingSlow.apply(target, this.parent, undefined, {
                            duration: this.Value("fading_slow_duration"),
                            maxSlowPct: this.Value("fading_slow_pct")
                        });
                    }

                    ModifierPhantomExtraMark.apply(target, this.parent, this.ability, { duration: 0.3 });

                    if (this.ability.GetLevel() >= 2 || ModifierUpgradePhantomQuickRecast.findOne(this.parent)) {
                        if (!ModifierPhantomExtraMark.findOne(this.parent)) {
                            const recastDuration = 3;

                            ModifierPhantomExtraMark.apply(this.parent, this.parent, this.ability, {
                                duration: recastDuration
                            });

                            ModifierPhantomExtraRecast.apply(this.parent, this.parent, this.ability, {
                                abilityLeft: PhantomExtra.name,
                                duration: recastDuration,
                                charges: 0 //@Refactor gotta find a better way to do this...
                            });
                        }
                    }

                    ApplyDamage({
                        victim: target,
                        attacker: this.parent,
                        damage: this.Value("ability_damage"),
                        damage_type: DamageTypes.PHYSICAL
                    });
                    this.PlayEffectsOnImpact(target);
                }
            });
        }
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX("particles/phantom/phantom_basic_attack.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });
        EmitSoundOn("Hero_PhantomAssassin.Attack", target);
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }
}

@registerModifier("modifier_phantom_extra")
class ModifierPhantomExtraMark extends CustomModifier {
    IsPurgable() {
        return false;
    }

    IsHidden() {
        return true;
    }
}

@registerModifier("modifier_phantom_extra_recast")
class ModifierPhantomExtraRecast extends ModifierRecast {
    IsHidden(): boolean {
        return false;
    }
    // OnDestroy(){
    // 	if(IsServer()){
    // 		if(this.GetRemainingTime() < 0.05){
    // 			this.GetParent():RemoveModifierByName('modifier_phantom_extra_slashes')
    // 		}
    // 	}
    // }
}
