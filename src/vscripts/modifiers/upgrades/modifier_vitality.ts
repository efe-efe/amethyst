import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "./modifier_upgrade";

@registerModifier()
export class ModifierVitality extends ModifierUpgrade<undefined> {
    extraHealth = 50;

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    OnStackCountChanged() {
        if (IsServer()) {
            EmitSoundOn("Hero_Oracle.FortunesEnd.Target", this.parent);
            EFX("particles/gems/emerald.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
                cp3: {
                    ent: this.parent,
                    point: "attach_hitloc"
                },
                release: true
            });
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.HEALTH_BONUS];
    }

    GetModifierHealthBonus() {
        return this.GetStackCount() * this.extraHealth;
    }
}
