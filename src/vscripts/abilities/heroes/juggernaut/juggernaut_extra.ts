import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { clampPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("juggernaut_extra")
class JuggernautExtra extends CustomAbility {
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
        const duration = this.GetSpecialValueFor("duration");
        const radius = this.GetSpecialValueFor("radius");
        const shield = this.GetSpecialValueFor("shield");

        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(this.caster.GetAbsOrigin(), cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        const healingWard = CreateUnitByName(
            "npc_dota_creature_juggernaut_healing_totem",
            point,
            true,
            this.caster,
            this.caster,
            this.caster.GetTeam()
        );

        healingWard.SetControllableByPlayer(this.caster.GetPlayerOwnerID(), true);

        if (this.GetLevel() >= 2) {
            const units = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                point,
                radius,
                UnitTargetTeam.FRIENDLY,
                UnitTargetType.HERO + UnitTargetType.BASIC,
                UnitTargetFlags.NONE,
                FindOrder.ANY
            ).filter(unit => unit != healingWard);

            for (const unit of units) {
                ModifierJuggernautExtraShield.apply(unit, this.caster, undefined, {
                    duration: 6.0,
                    damageBlock: shield
                });
            }
        }

        // 	Prevent nearby units from getting stuck
        ResolveNPCPositions(healingWard.GetAbsOrigin(), healingWard.GetHullRadius() + healingWard.GetCollisionPadding());
        ModifierJuggernautExtraWard.apply(healingWard, this.caster, this, { duration });

        const juggernautExtraRecast = this.caster.FindAbilityByName(JuggernautExtraRecast.name) as JuggernautExtraRecast; //@Refactor: Find a better way to do this
        juggernautExtraRecast.SetHealingWardIndex(healingWard.GetEntityIndex());

        ModifierJuggernautExtraRecast.apply(this.caster, this.caster, undefined, {
            duration,
            abilityLeft: JuggernautExtra.name,
            abilityRight: JuggernautExtraRecast.name,
            charges: 999
        });
        this.PlayEffects(healingWard);

        // 	if caster:HasModifier("modifier_upgrade_juggernaut_spinning_ward") then
        //         healingWard:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })
        // 	end
    }

    PlayEffects(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Juggernaut.HealingWard.Cast", this.caster);
        const particleId = EFX(
            "particles/econ/items/undying/fall20_undying_head/fall20_undying_soul_rip_heal.vpcf",
            ParticleAttachment.CUSTOMORIGIN,
            target,
            {}
        );
        ParticleManager.SetParticleControlEnt(
            particleId,
            0,
            target,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            target.GetAbsOrigin(),
            true
        );
        ParticleManager.SetParticleControlEnt(
            particleId,
            1,
            this.caster,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.caster.GetAbsOrigin(),
            true
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // function juggernaut_extra:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_extra_recast")
    // end
}
// if IsClient() then require("wrappers/abilities") end
// Abilities.Castpoint(juggernaut_extra)

@registerAbility("juggernaut_extra_recast")
class JuggernautExtraRecast extends CustomAbility {
    healingWardIndex?: EntityIndex;

    OnSpellStart() {
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        if (this.healingWardIndex) {
            const healingWard = EntIndexToHScript(this.healingWardIndex) as CDOTA_BaseNPC;
            healingWard.MoveToPosition(point);
            this.PlayEffects(point);
        }
    }

    SetHealingWardIndex(index: EntityIndex) {
        this.healingWardIndex = index;
    }

    PlayEffects(point: Vector) {
        const particleId = ParticleManager.CreateParticle(
            "particles/ui_mouseactions/clicked_basemove.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, point);
        ParticleManager.SetParticleControl(particleId, 1, Vector(0, 255, 0));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // function juggernaut_extra_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_extra")
    // end
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_extra_shield" })
class ModifierJuggernautExtraShield extends ModifierShield {
    DeclareFunctions() {
        return [ModifierFunction.TOOLTIP];
    }

    OnTooltip() {
        return this.GetStackCount();
    }

    // function modifier_juggernaut_extra_shield:GetStatusLabel() return "Totem Shield" end
    // function modifier_juggernaut_extra_shield:GetStatusPriority() return 3 end
    // function modifier_juggernaut_extra_shield:GetStatusStyle() return "Shield" end
}
// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Status(modifier_juggernaut_extra_shield)
// Modifiers.Shield(modifier_juggernaut_extra_shield)

@registerModifier({ customNameForI18n: "modifier_juggernaut_extra_ward" })
class ModifierJuggernautExtraWard extends CustomModifier<JuggernautExtra> {
    radius = 0;
    health = 1;
    particleIds: ParticleID[] = [];

    IsAura() {
        return true;
    }

    GetModifierAura() {
        return ModifierJuggernautExtra.name;
    }

    GetAuraRadius() {
        return this.radius;
    }

    GetAuraDuration() {
        return 0.5;
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraEntityReject(unit: CDOTA_BaseNPC) {
        return !CustomEntitiesLegacy.Allies(this.caster, unit);
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnCreated() {
        this.radius = this.ability.GetSpecialValueFor("radius");
        if (IsServer()) {
            if (this.caster.HasModifier("modifier_upgrade_juggernaut_spinning_ward")) {
                this.health = 5;
            }

            this.PlayEffectsOnCreated();
            this.StartIntervalThink(0.03);
            EmitSoundOn("Hero_Juggernaut.HealingWard.Loop", this.parent);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }
            EFX(
                "particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward_death.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {
                    release: true
                }
            );
            this.parent.Kill(undefined, this.parent);

            this.ability.StartCooldown(this.ability.GetCooldown(0));

            if (this.caster.HasModifier("modifier_juggernaut_extra_recast")) {
                this.caster.RemoveModifierByName("modifier_juggernaut_extra_recast");
            }

            StopSoundOn("Hero_Juggernaut.HealingWard.Stop", this.parent);
            EmitSoundOn("Hero_Juggernaut.HealingWard.Stop", this.parent);
        }
    }

    OnIntervalThink() {
        const percentage = (this.GetDuration() - this.GetRemainingTime()) / this.GetDuration() + 0.03;
        ParticleManager.SetParticleControl(this.particleIds[1], 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
        ParticleManager.SetParticleControl(this.particleIds[1], 1, Vector(this.radius, percentage, 0));
    }

    PlayEffectsOnCreated() {
        let particleId = ParticleManager.CreateParticle(
            "particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_eruption_dc.vpcf",
            ParticleAttachment.CUSTOMORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/econ/items/juggernaut/jugg_fall20_immortal/jugg_fall20_immortal_healing_ward.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 100)));
        ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, 1, 1));
        ParticleManager.SetParticleControlEnt(
            particleId,
            2,
            this.parent,
            ParticleAttachment.POINT_FOLLOW,
            "attach_hitloc",
            this.parent.GetAbsOrigin(),
            true
        );
        this.particleIds.push(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/progress_circle/generic_progress_circle_small.vpcf",
            ParticleAttachment.WORLDORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
        ParticleManager.SetParticleControlForward(particleId, 0, Vector(0, -1, 0));
        ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, 0, 1));
        ParticleManager.SetParticleControl(particleId, 15, Vector(1, 255, 1));
        ParticleManager.SetParticleControl(particleId, 16, Vector(1, 0, 0));
        this.particleIds.push(particleId);
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_DEATH, ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    OnDeath(event: ModifierInstanceEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }
            this.Destroy();
        }
    }

    GetModifierIncomingDamage_Percentage() {
        if (IsServer()) {
            this.health = this.health - 1;
            if (this.health == 0) {
                this.parent.ForceKill(false);
            }
        }
        return -100;
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_extra_recast" })
class ModifierJuggernautExtraRecast extends ModifierRecast {
    // function modifier_juggernaut_extra_recast:GetRecastKey()
    // 	if self:GetRecastAbility():GetAbilityIndex() == 6 then
    // 		return "R"
    // 	end
    // 	return "F"
    // end
}
// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Recast(modifier_juggernaut_extra_recast)

@registerModifier({ customNameForI18n: "modifier_juggernaut_extra" })
class ModifierJuggernautExtra extends CustomModifier<JuggernautExtra> {
    healPerSecond = 0;

    OnCreated() {
        this.healPerSecond = this.ability.GetSpecialValueFor("heal_per_second");

        if (IsServer()) {
            this.OnIntervalThink();
            this.StartIntervalThink(1.0);
        }
    }

    OnIntervalThink() {
        this.parent.Heal(this.healPerSecond, this.ability);
    }

    DeclareFunctions() {
        return [ModifierFunction.TOOLTIP];
    }

    OnTooltip() {
        //@Refactor: This will not work
        return this.healPerSecond;
    }
}
