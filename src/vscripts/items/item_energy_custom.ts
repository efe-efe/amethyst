import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";

@registerAbility("item_energy_custom")
class ItemEnergyBooster extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierItemEnergyBooster.name;
    }
}

@registerModifier("modifier_item_energy_custom")
class ModifierItemEnergyBooster extends CustomModifier {
    DeclareFunctions() {
        return [ModifierFunction.EXTRA_MANA_BONUS];
    }

    GetModifierExtraManaBonus() {
        return this.Value("extra_mana");
    }

    GetEffectName() {
        return "particles/energy_booster/energy_booster.vpcf";
    }

    GetEffectAttachType() {
        return ParticleAttachment.ABSORIGIN_FOLLOW;
    }
}
