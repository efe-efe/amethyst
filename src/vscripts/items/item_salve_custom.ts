import { CustomItem } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";

@registerAbility("item_salve_custom")
class ItemSalve extends CustomItem {
    OnSpellStart() {
        ModifierItemSalve.apply(this.GetCaster(), this.GetCaster(), this, {
            duration: this.GetSpecialValueFor("duration"),
            thinkInterval: this.GetSpecialValueFor("think_interval"),
            healPerTick: this.GetSpecialValueFor("heal_per_tick")
        });
        EmitSoundOn("DOTA_Item.HealingSalve.Activate", this.GetCaster());
        this.SpendCharge();
    }
}

@registerModifier("modifier_item_salve_custom")
class ModifierItemSalve extends CustomModifier {
    healPerTick!: number;

    OnCreated(params: { thinkInterval: number; healPerTick: number }) {
        if (IsServer()) {
            this.healPerTick = params.healPerTick;
            this.StartIntervalThink(params.thinkInterval);
        }
    }

    OnIntervalThink() {
        this.parent.Heal(this.healPerTick, this.ability);
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
        return "particles/items_fx/healing_flask.vpcf";
    }

    // function modifier_item_salve_custom:GetStatusLabel() return "Healing Salve" }
    // function modifier_item_salve_custom:GetStatusPriority() return 1 }
    // function modifier_item_salve_custom:GetStatusStyle() return "Heal" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_salve_custom)
