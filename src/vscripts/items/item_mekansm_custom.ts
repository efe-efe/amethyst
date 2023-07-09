import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { createRadiusMarker, findUnitsInRadius } from "../util";

@registerAbility("item_mekansm_custom")
class ItemMekansm extends CustomAbility {
    GetCastingCrawl() {
        return 0;
    }

    GetAnimation() {
        return GameActivity.DOTA_GENERIC_CHANNEL_1;
    }

    OnSpellStart() {
        const radius = this.GetSpecialValueFor("radius");
        const duration = this.GetSpecialValueFor("duration");
        const heal = this.GetSpecialValueFor("heal");

        const allies = findUnitsInRadius(
            this.caster,
            this.caster.GetAbsOrigin(),
            radius,
            UnitTargetTeam.FRIENDLY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const ally of allies) {
            ModifierItemMekansm.apply(ally, this.caster, this, { duration: duration });
            ally.Heal(heal, this);
            this.PlayEffectsTarget(ally);
        }

        createRadiusMarker(this.caster, this.caster.GetAbsOrigin(), radius, "public", 0.1);
        this.PlayEffects();
    }

    PlayEffects() {
        EmitSoundOn("DOTA_Item.Mekansm.Activate", this.caster);
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle("particles/items2_fx/mekanism.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
        );
    }

    PlayEffectsTarget(target: CDOTA_BaseNPC) {
        EmitSoundOn("DOTA_Item.Mekansm.Target", target);

        const particleId = ParticleManager.CreateParticle(
            "particles/items2_fx/mekanism_recipient.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target
        );
        ParticleManager.SetParticleControl(particleId, 1, target.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_item_mekansm_custom")
class ModifierItemMekansm extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        this.parent.Heal(this.Value("heal_per_tick"), this.ability);
    }

    // function modifier_item_mekansm_custom:GetStatusLabel() return "Mekansm" }
    // function modifier_item_mekansm_custom:GetStatusPriority() return 3 }
    // function modifier_item_mekansm_custom:GetStatusStyle() return "Mekansm" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_item_mekansm_custom)
