import { CustomItem } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { giveManaAndEnergy } from "../util";

@registerAbility("item_clarity_custom")
class ItemClarity extends CustomItem {
    OnSpellStart() {
        ModifierItemClarity.apply(this.GetCaster(), this.GetCaster(), this, {
            duration: this.GetSpecialValueFor("duration"),
            thinkInterval: this.GetSpecialValueFor("think_interval"),
            manaPerTick: this.GetSpecialValueFor("mana_per_tick")
        });
        EmitSoundOn("DOTA_Item.ClarityPotion.Activate", this.GetCaster());
        this.SpendCharge();
    }
}

@registerModifier("modifier_item_clarity_custom")
class ModifierItemClarity extends CustomModifier {
    manaPerTick!: number;

    OnCreated(params: { manaPerTick: number; thinkInterval: number }) {
        if (IsServer()) {
            this.manaPerTick = params.manaPerTick;
            this.StartIntervalThink(params.thinkInterval);
        }
    }

    OnIntervalThink() {
        giveManaAndEnergy(this.GetParent(), this.manaPerTick, true);
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage() {
        if (IsServer()) {
            this.Destroy();
        }

        return 0;
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }

    GetStatusEffectName() {
        return "particles/items_fx/healing_clarity.vpcf";
    }

    // function modifier_item_clarity_custom:GetStatusLabel() return "Clarity Potion" }
    // function modifier_item_clarity_custom:GetStatusPriority() return 0 }
    // function modifier_item_clarity_custom:GetStatusStyle() return "Mana" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_clarity_custom)
