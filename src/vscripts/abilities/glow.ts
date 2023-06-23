import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { CustomAbility } from "./framework/custom_ability";
import { CustomModifier } from "./framework/custom_modifier";

@registerAbility("glow")
class Glow extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierGlow.name;
    }
}

@registerModifier({ customNameForI18n: "modifier_glow" })
class ModifierGlow extends CustomModifier {
    particleId?: ParticleID;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    OnCreated() {
        this.PlayEffects();
    }

    OnDestroy() {
        this.StopEffects();
    }

    CheckState() {
        return {
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_UNIT_COLLISION]: true,
            [ModifierState.MAGIC_IMMUNE]: true
        };
    }

    PlayEffects() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/dev/new_heroes/new_hero_aoe_ring_embers.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent
        );
        ParticleManager.SetParticleControl(this.particleId, 1, Vector(20, 1, 1));
        ParticleManager.SetParticleControl(this.particleId, 15, Vector(148, 0, 59));
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}
