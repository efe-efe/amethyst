import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierObstacle extends CustomModifier<undefined> {
    previousOrigin!: Vector;
    fowBlocker?: CBaseEntity;

    IsHidden() {
        return true;
    }

    IsPermanent() {
        return true;
    }

    SetFowBlocker(fowBlocker: CBaseEntity) {
        this.fowBlocker = fowBlocker;
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_DEATH];
    }

    OnDeath(event: ModifierInstanceEvent) {
        if (IsServer() && event.unit == this.parent) {
            this.PlayEffectsOnDeath();
            this.parent.AddNoDraw();

            if (this.fowBlocker) {
                UTIL_Remove(this.fowBlocker);
            }
        }
    }

    PlayEffectsOnDeath() {
        const origin = this.parent.GetAbsOrigin();
        EmitSoundOn("Hero_Furion.ForceOfNature", this.parent);

        const particleIdMain = ParticleManager.CreateParticle("particles/box_destroy.vpcf", ParticleAttachment.WORLDORIGIN, this.parent);
        const particleIdSecond = ParticleManager.CreateParticle(
            "particles/world_destruction_fx/tree_destruction_snow_b.vpcf",
            ParticleAttachment.WORLDORIGIN,
            this.parent
        );

        ParticleManager.SetParticleControl(particleIdMain, 0, origin);
        ParticleManager.SetParticleControl(particleIdMain, 1, origin);
        ParticleManager.SetParticleControl(particleIdMain, 2, origin);
        ParticleManager.SetParticleControl(particleIdMain, 4, origin);
        ParticleManager.SetParticleControl(particleIdMain, 5, origin);
        ParticleManager.ReleaseParticleIndex(particleIdMain);

        ParticleManager.SetParticleControl(particleIdSecond, 0, origin);
        ParticleManager.SetParticleControl(particleIdSecond, 5, origin);
        ParticleManager.ReleaseParticleIndex(particleIdSecond);
    }
}
