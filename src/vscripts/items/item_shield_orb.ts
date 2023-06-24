import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { ModifierShield } from "../modifiers/modifier_shield";

@registerAbility("item_shield_orb")
class ItemShieldOrb extends CustomAbility {
    OnSpellStart() {
        const damage_block = 16;

        ModifierShield.apply(this.caster, this.caster, undefined, { duration: 6.0, damageBlock: damage_block });

        EmitSoundOn("Hero_Sven.GodsStrength.Attack", this.caster);
        EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", this.caster);
    }
}
