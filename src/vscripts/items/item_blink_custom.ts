import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerAbility } from "../lib/dota_ts_adapter";
import { clampPosition, getCursorPosition } from "../util";

@registerAbility("item_blink_custom")
class ItemBlink extends CustomAbility {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });

        this.PlayEffectsStart();
        FindClearSpaceForUnit(this.caster, point, true);
        this.PlayEffectsEnd();
    }

    PlayEffectsStart() {
        EmitSoundOn("DOTA_Item.BlinkDagger.Activate", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/items_fx/blink_dagger_start.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsEnd() {
        const particleId = ParticleManager.CreateParticle(
            "particles/items_fx/blink_dagger_end.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
