import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";

@registerAbility("invoker_walk_custom")
class InvokerWalk extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_GHOST_WALK;
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetCastingCrawl() {
        return 100;
    }

    OnSpellStart() {
        ModifierInvokerWalk.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("duration") });

        EFX("particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
        EmitSoundOn("Hero_Invoker.GhostWalk", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_invoker_walk_custom" })
class ModifierInvokerWalk extends CustomModifier {
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

    // function modifier_invoker_walk_custom:GetStatusLabel() return "Ghost Walk" }
    // function modifier_invoker_walk_custom:GetStatusPriority() return 1 }
    // function modifier_invoker_walk_custom:GetStatusStyle() return "GhostWalk" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_invoker_walk_custom)
