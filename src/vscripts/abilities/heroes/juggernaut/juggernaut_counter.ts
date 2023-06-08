import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { clamp, clampPosition, isObstacle, strongPurge } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("juggernaut_counter")
class JuggernautCounter extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("counter_duration");
        ModifierJuggernautCounter.apply(this.caster, this.caster, undefined, { duration: duration });
        //   LinkAbilityCooldowns(caster, "juggernaut_ex_counter");
    }

    // function juggernaut_counter:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_counter_recast")
    // end
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_counter_countering" })
class ModifierJuggernautCounter extends ModifierCounter {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            EmitSoundOn("Hero_Juggernaut.Attack", this.caster);
            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(
                    "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            if (!event.triggerCounters) {
                return true;
            }

            const juggernautCounter = this.parent.FindAbilityByName(JuggernautCounter.name);

            ModifierJuggernautCounterRecast.apply(this.parent, this.parent, undefined, {
                abilityLeft: JuggernautCounter.name,
                abilityRight: JuggernautCounterRecast.name,
                charges: juggernautCounter?.GetSpecialValueFor("recasts") ?? 0,
                duration: juggernautCounter?.GetSpecialValueFor("recast_time") ?? 0
            });

            strongPurge(this.parent);
            this.PlayEffectsOnTrigger();

            if (event.attackCategory == "projectile") {
                if (event.projectile.getIsReflectable()) {
                    event.projectile.setVelocity(event.projectile.getVelocity().__mul(-1.2), event.projectile.getPosition());
                    event.projectile.setSource(this.parent);
                    // projectile:SetVisionTeam(self:GetParent():GetTeam())
                    event.projectile.resetDistanceTraveled();
                    // projectile:ResetRehit()
                } else {
                    if (event.projectile.getIsDestructible()) {
                        event.projectile.scheduleDestroy();
                    }
                }
            }
            return false;
        }

        return false;
    }

    AfterHit() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    PlayEffectsOnTrigger() {
        EmitSoundOn("juggernaut_jug_ability_bladefury_05", this.parent);

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            )
        );
    }

    DeclareFunctions() {
        return [...super.DeclareFunctions(), ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_SPAWN;
    }

    GetOverrideAnimationRate() {
        return 0.1;
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_counter_recast" })
class ModifierJuggernautCounterRecast extends ModifierRecast {
    GetEffectName() {
        return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}

abstract class JuggernautSlash extends CustomAbility {
    Slash(point: Vector, damage: number, particle: string) {
        const from = this.caster.GetAbsOrigin();
        FindClearSpaceForUnit(this.caster, point, true);
        const to = this.caster.GetAbsOrigin();

        const enemies = CustomEntitiesLegacy.FindUnitsInLine(
            this.caster,
            to,
            from,
            100,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE
        );

        for (const enemy of enemies) {
            this.SingleAttack({
                target: enemy,
                effect: target => {
                    ApplyDamage({
                        victim: target,
                        attacker: this.caster,
                        damage: damage,
                        damage_type: DamageTypes.PHYSICAL
                    });
                    this.PlayEffectsOnTarget(target);
                }
            });
        }

        this.OnSlashEnded(enemies);
        this.PlayEffectsOnSlash(from, to, particle);
    }

    abstract OnSlashEnded(targets: CDOTA_BaseNPC[]): void;

    PlayEffectsOnSlash(from: Vector, to: Vector, particle: string) {
        EmitSoundOn("Hero_Juggernaut.BladeDance", this.caster);
        EmitSoundOn("Hero_Juggernaut.Attack", this.caster);

        EFX(particle, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: from,
            cp1: to,
            release: true
        });
    }

    PlayEffectsOnTarget(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", target);
        EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", target);
        EmitSoundOn("Hero_Juggernaut.Attack", target);
    }
}

@registerAbility("juggernaut_counter_recast")
class JuggernautCounterRecast extends JuggernautSlash {
    // function juggernaut_counter_recast:GetRecastTime() return
    //    self:GetCaster():FindAbilityByName("juggernaut_counter"):GetSpecialValueFor("recast_time")
    // end

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const minRange = this.GetSpecialValueFor("min_range");
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined), minRange });
        const juggernautCounter = this.caster.FindAbilityByName(JuggernautCounter.name);
        const damage = juggernautCounter?.GetSpecialValueFor("ability_damage") ?? 0;
        //  const juggernaut_ex_counter = caster:FindAbilityByName("juggernaut_ex_counter")
        this.Slash(point, damage, "particles/juggernaut/juggernaut_counter_recast.vpcf");
        //  self:GetRecastAbility():StartCooldown(self:GetRecastAbility():GetCooldown(0))
        //  if juggernaut_ex_counter then
        //     juggernaut_ex_counter:StartCooldown(juggernaut_ex_counter:GetCooldown(0))
        //  end
    }

    OnSlashEnded(targets: CDOTA_BaseNPC[]): void {
        const validTargets = targets.filter(target => !isObstacle(target) /*&& isCountering(target) */).length;
        const modifier = ModifierJuggernautCounterRecast.findOne(this.caster);

        if (modifier) {
            if (validTargets <= 0) {
                modifier.Destroy();
            } else {
                modifier.SetDuration(modifier.GetDuration(), true);
            }
        }
    }

    // function juggernaut_counter_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_counter")
    // end
}

@registerAbility("juggernaut_ex_counter")
class JuggernautExCounter extends JuggernautSlash {
    GetAnimation() {
        return GameActivity.DOTA_TAUNT;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetAnimationTranslate() {
        return Translate.odachi;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const minRange = this.GetSpecialValueFor("min_range");
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined), minRange });
        const damage = this.GetSpecialValueFor("ability_damage") ?? 0;

        if (!ModifierJuggernautExCounterRecast.findOne(this.caster)) {
            ModifierJuggernautExCounterRecast.apply(this.caster, this.caster, undefined, {
                abilityLeft: JuggernautExCounter.name,
                charges: this.GetSpecialValueFor("recasts"),
                duration: this.GetSpecialValueFor("recast_time")
            });
        }
        this.Slash(point, damage, "particles/juggernaut/juggernaut_ex_counter.vpcf");
        // LinkAbilityCooldowns(caster, 'juggernaut_counter')
    }

    GetManaCost(level: number) {
        if (IsServer() && ModifierJuggernautExCounterRecast.findOne(this.caster)) {
            return 0;
        }
        return super.GetManaCost(level);
    }

    OnSlashEnded(targets: CDOTA_BaseNPC[]): void {
        const validTargets = targets.filter(target => !isObstacle(target) /*&& isCountering(target) */).length;
        const modifier = ModifierJuggernautExCounterRecast.findOne(this.caster);

        if (modifier) {
            if (validTargets <= 0) {
                modifier.Destroy();
            } else {
                modifier.SetDuration(modifier.GetDuration(), true);
            }
        }

        const swiftnessDuration = this.GetSpecialValueFor("swiftness_duration");
        const swiftnessPct = this.GetSpecialValueFor("swiftness_pct");
        ModifierJuggernautSwiftness.apply(this.caster, this.caster, undefined, {
            swiftnessPct: swiftnessPct * validTargets,
            duration: swiftnessDuration
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_ex_counter_recast" })
class ModifierJuggernautExCounterRecast extends ModifierRecast {
    GetEffectName() {
        return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_swiftness" })
class ModifierJuggernautSwiftness extends CustomModifier<undefined> {
    maxSpeedPct = 100;

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated(params: { swiftnessPct: number }) {
        if (IsServer()) {
            this.SetStackCount(clamp(params.swiftnessPct, this.maxSpeedPct, 0));
        }
    }

    OnRefresh(params: { swiftnessPct: number }) {
        if (IsServer()) {
            this.SetStackCount(clamp(this.GetStackCount() + params.swiftnessPct, this.maxSpeedPct, 0));
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.GetStackCount();
    }

    CheckState() {
        return {
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    GetEffectName() {
        return "particles/items2_fx/butterfly_buff.vpcf";
    }

    GetTexture() {
        return "modifier_swiftness";
    }
}
