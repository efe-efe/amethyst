import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierThinker } from "../../../modifiers/modifier_thinker";
import { clampPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierSniperCharges } from "./sniper_basic_attack";

class SniperSpecialAttackCommon extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    PlayEffects(point: Vector, path: string) {
        EmitSoundOn("Hero_Sniper.ShrapnelShoot", this.caster);
        const particleId = ParticleManager.CreateParticle(path, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster);
        ParticleManager.SetParticleControlEnt(
            particleId,
            0,
            this.caster,
            ParticleAttachment.POINT_FOLLOW,
            "attach_attack1",
            this.caster.GetAbsOrigin(),
            false
        );
        ParticleManager.SetParticleControl(particleId, 1, point.__add(Vector(0, 0, 2000)));
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerAbility("sniper_special_attack")
class SniperSpecialAttack extends SniperSpecialAttackCommon {
    GetIntrinsicModifierName() {
        return "modifier_sniper_special_attack_charges";
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierSniperSpecialAttackThinker.createThinker(this.caster, this, Vector(point.x, point.y, origin.z), {
            duration: this.GetSpecialValueFor("duration"),
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });

        this.PlayEffects(point, "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf");
        // LinkAbilityCooldowns(caster, 'sniper_ex_special_attack')
    }

    // function sniper_special_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "sniper_special_attack_recast")
    // }
}

@registerAbility("sniper_ex_special_attack")
class SniperExSpecialAttack extends SniperSpecialAttackCommon {
    GetCastingCrawl() {
        return 100;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierSniperExSpecialAttackThinker.createThinker(this.caster, this, Vector(point.x, point.y, origin.z), {
            duration: this.GetSpecialValueFor("duration"),
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });

        this.PlayEffects(point, "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel_launch.vpcf");
        // 	LinkAbilityCooldowns(caster, 'sniper_special_attack')
    }
}

@registerModifier({ customNameForI18n: "modifier_sniper_shrapnel_debuff" })
class ModifierSniperSpecialAttackDebuff extends CustomModifier {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return true;
    }

    IsPurgable() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        ApplyDamage({
            victim: this.parent,
            attacker: this.caster,
            damage: this.Value("damage_per_think"),
            damage_type: DamageTypes.PURE
        });
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -this.Value("slow_pct");
    }
}

@registerModifier({ customNameForI18n: "modifier_sniper_shrapnel_thinker_custom" })
export class ModifierSniperSpecialAttackThinker extends ModifierThinker {
    particleId!: ParticleID;

    IsAura() {
        return this.initialized;
    }

    GetModifierAura() {
        return ModifierSniperSpecialAttackDebuff.name;
    }

    GetAuraRadius() {
        return this.Value("radius");
    }

    GetAuraDuration() {
        return this.Value("debuff_linger");
    }

    GetAuraSearchTeam() {
        return UnitTargetTeam.BOTH;
    }

    GetAuraEntityReject(unit: CDOTA_BaseNPC) {
        return CustomEntitiesLegacy.Allies(this.caster, unit);
    }

    GetAuraSearchType() {
        return UnitTargetType.HERO + UnitTargetType.BASIC;
    }

    OnReady() {
        if (IsServer()) {
            const direction = this.parent.GetAbsOrigin().__sub(this.caster.GetAbsOrigin()).Normalized();
            AddFOWViewer(this.caster.GetTeamNumber(), this.parent.GetAbsOrigin(), this.Value("radius"), this.Value("duration"), false);
            this.PlayEffects(direction);
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.StopEffects();
        }
    }

    PlayEffects(direction: Vector) {
        EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", this.parent);
        this.particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 1, Vector(this.Value("radius"), 0, 0));
        ParticleManager.SetParticleControlForward(this.particleId, 2, direction.__add(Vector(0, 0, 0.1)));
    }

    StopEffects() {
        ParticleManager.DestroyParticle(this.particleId, false);
        ParticleManager.ReleaseParticleIndex(this.particleId);
        StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", this.parent);
    }
}

@registerModifier({ customNameForI18n: "modifier_sniper_ex_special_attack_thinker" })
class ModifierSniperExSpecialAttackThinker extends ModifierThinker {
    particleId!: ParticleID;

    IsAura() {
        return this.initialized;
    }

    GetModifierAura() {
        return ModifierSniperExSpecialAttack.name;
    }

    GetAuraRadius() {
        return this.Value("radius");
    }

    GetAuraDuration() {
        return this.Value("buff_linger");
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

    OnReady() {
        if (IsServer()) {
            AddFOWViewer(this.caster.GetTeamNumber(), this.parent.GetAbsOrigin(), this.Value("radius"), this.Value("duration"), false);
            this.PlayEffectsOnCreated();
            this.PlayEffectsAoe();
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.StopEffects();
            UTIL_Remove(this.parent);
        }
    }

    PlayEffectsOnCreated() {
        const origin = this.parent.GetAbsOrigin();
        let particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, origin);
        ParticleManager.SetParticleControl(particleId, 1, origin);
        ParticleManager.SetParticleControl(particleId, 2, origin);

        particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, origin);
        ParticleManager.SetParticleControl(particleId, 1, origin.__add(Vector(0, 0, 1000)));
        ParticleManager.SetParticleControl(particleId, 2, origin);
    }

    PlayEffectsAoe() {
        const origin = this.parent.GetAbsOrigin();
        EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", this.parent);
        this.particleId = ParticleManager.CreateParticle(
            "particles/sniper/sniper_ex_special_attack.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleId, 0, origin);
        ParticleManager.SetParticleControl(this.particleId, 1, Vector(this.Value("radius"), 0, 0));
    }

    StopEffects() {
        ParticleManager.DestroyParticle(this.particleId, false);
        ParticleManager.ReleaseParticleIndex(this.particleId);
        StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", this.parent);
    }
}

@registerModifier({ customNameForI18n: "modifier_sniper_ex_special_attack_buff" })
class ModifierSniperExSpecialAttack extends CustomModifier {
    particleId!: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(0.1);
            this.particleId = ParticleManager.CreateParticle(
                "particles/sniper/sniper_ex_special_attack_buff.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnIntervalThink() {
        if (this.parent == this.caster) {
            ModifierSniperCharges.findOne(this.parent)?.RefreshCharges();
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE, ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.Value("extra_damage");
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("ms_pct");
    }
}

@registerAbility("sniper_special_attack_recast")
class SniperSpecialAttackRecast extends CustomAbility {
    // function sniper_special_attack_recast:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
    // function sniper_special_attack_recast:GetPlaybackRateOverride() 	return 1.5 end
    // function sniper_special_attack_recast:GetCastPointSpeed() 			return 10 end
    // function sniper_special_attack_recast:OnSpellStart()
    //     local caster = self:GetCaster()
    //     local point = ClampPosition(caster:GetOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
    //     local duration = self:GetSpecialValueFor("duration")
    //     CreateModifierThinker(
    //         caster, --hCaster
    //         self, --hAbility
    //         "modifier_sniper_shrapnel_thinker_custom", --modifierName
    //         { duration = duration },
    //         Vector(point.x, point.y, caster:GetOrigin().z), --vOrigin
    //         caster:GetTeamNumber(), --nTeamNumber
    //         false --bPhantomBlocker
    //     )
    //     self:PlayEffects(point)
    //     if self:GetLevel() == 2 then
    //         caster:AddNewModifier(caster, self, "modifier_sniper_special_attack_recast_recast", { duration = 1.5 })
    //     end
    // end
    // function sniper_special_attack_recast:PlayEffects(point)
    //     EmitSoundOn("Hero_Sniper.ShrapnelShoot", self:GetCaster())
    //     local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
    //     local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    //     ParticleManager:SetParticleControlEnt(
    //         effect_cast,
    //         0,
    //         self:GetCaster(),
    //         PATTACH_POINT_FOLLOW,
    //         "attach_attack1",
    //         self:GetCaster():GetOrigin(), -- unknown
    //         false -- unknown, true
    //     )
    //     ParticleManager:SetParticleControl(effect_cast, 1, point + Vector(0, 0, 2000))
    //     ParticleManager:ReleaseParticleIndex(effect_cast)
    // end
    // function sniper_special_attack_recast:OnUpgrade()
    //     CustomAbilitiesLegacy:LinkUpgrades(self, "sniper_special_attack")
    // end
}
// if IsClient() then require("wrappers/abilities") end
// Abilities.Castpoint(sniper_special_attack_recast)
