import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { QueenAttack } from "./queen_attack";

@registerAbility("queen_daggers")
class QueenDaggers extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const count = 16;
        const angleDiff = 360 / count;
        const vector = origin.__add(Vector(1, 0, 0));
        const queenAttack = QueenAttack.findOne(this.caster);
        const distance = (queenAttack?.GetCastRange(Vector(0, 0, 0), undefined) ?? 1) * 2;

        for (let i = 0; i < count; i++) {
            const location = RotatePosition(origin, QAngle(0, angleDiff * i, 0), vector);
            queenAttack?.LaunchProjectile(location, 600, distance, 7);
        }

        EmitSoundOn("Hero_QueenOfPain.ShadowStrike", this.caster);
    }
}
