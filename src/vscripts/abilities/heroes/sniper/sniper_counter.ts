import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("sniper_counter")
class SniperCounter extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");
        ModifierSniperCounter.apply(this.caster, this.caster, this, { duration });
        this.RefreshAbility("sniper_second_attack");
        this.RefreshAbility("sniper_ex_second_attack");
        this.PlayEffects();
        EFX("particles/items2_fx/smoke_of_deceit.vpcf", ParticleAttachment.WORLDORIGIN, this.caster, {
            cp0: this.caster.GetAbsOrigin(),
            cp1: Vector(500, 500, 500),
            release: true
        });
    }

    RefreshAbility(abilityName: string) {
        const ability = this.caster.FindAbilityByName(abilityName);
        if (ability) {
            ability.EndCooldown();
        }
    }

    PlayEffects() {
        const origin = this.caster.GetAbsOrigin();
        EmitSoundOn("DOTA_Item.SmokeOfDeceit.Activate", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/sniper/sniper_counter.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 3, Vector(origin.x, origin.y, origin.z + 64));
        ParticleManager.SetParticleControl(particleId, 0, origin);

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/riki/riki_head_ti8/riki_smokebomb_ti8_start_ring.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            )
        );
    }
}

@registerModifier("modifier_sniper_counter")
class ModifierSniperCounter extends CustomModifier<SniperCounter> {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnDestroy() {
        if (IsServer()) {
            this.ability.StartCooldown(this.ability.GetCooldown(0));
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.INVISIBILITY_LEVEL, ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierInvisibilityLevel() {
        return 2;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    CheckState() {
        return {
            [ModifierState.INVISIBLE]: true,
            [ModifierState.TRUESIGHT_IMMUNE]: false
        };
    }
}
