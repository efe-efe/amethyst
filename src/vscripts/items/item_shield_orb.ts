import { CustomItem } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { ModifierShield } from "../modifiers/modifier_shield";

@registerAbility("item_shield_orb")
class ItemShieldOrb extends CustomItem {
    OnSpellStart() {
        const damage_block = 16;

        ModifierShield.apply(this.GetCaster(), this.GetCaster(), undefined, { duration: 6.0, damageBlock: damage_block });

        EmitSoundOn("Hero_Sven.GodsStrength.Attack", this.GetCaster());
        EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", this.GetCaster());
    }
}
