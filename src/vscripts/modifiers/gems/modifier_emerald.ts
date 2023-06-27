import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier("modifier_emerald")
export class ModifierEmerald extends CustomModifier<undefined> {
    particleId!: ParticleID;

    OnCreated(params: { healPerSecond: number }) {
        if (IsServer()) {
            this.SetStackCount(params.healPerSecond);
            this.StartIntervalThink(1.0);
            this.particleId = ParticleManager.CreateParticle(
                "particles/gems/emerald_regen_owner.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        if (IsServer()) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnIntervalThink() {
        this.parent.Heal(this.GetStackCount(), undefined);

        EFX(
            "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_target_death_beam.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent,
            {
                cp1: this.parent.GetAbsOrigin(),
                release: true
            }
        );
        EFX(
            "particles/econ/items/dazzle/dazzle_ti6_gold/dazzle_ti6_shallow_grave_gold_flash.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.parent,
            {
                release: true
            }
        );
        EFX("particles/gems/emerald_hammers.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
            cp3: {
                ent: this.parent,
                point: "attach_hitloc"
            },
            release: true
        });
    }

    DeclareFunctions() {
        return [ModifierFunction.TOOLTIP];
    }

    OnTooltip() {
        return this.GetStackCount();
    }

    GetTexture() {
        return "modifier_emerald";
    }
}
