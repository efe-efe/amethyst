import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../../../../modifiers/modifier_combat_events";
import { ModifierStun } from "../../../../modifiers/modifier_stunned";
import { createTimedRadiusMarker } from "../../../../util";
import { QueenBlink } from "./queen_blink";

@registerAbility("queen_dodge")
class QueenDodge extends CustomAbility {
    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const jumps = 4;

        ModifierQueenDodge.apply(this.caster, this.caster, this, { jumps: jumps });
    }
}

@registerModifier({ customNameForI18n: "modifier_queen_dodge" })
class ModifierQueenDodge extends ModifierCombatEvents {
    origin!: Vector;
    jumps!: number;
    angleDiff!: number;
    marker?: ReturnType<typeof createTimedRadiusMarker>;

    particleId?: ParticleID;
    radius = 700;
    count = 0;
    nextTarget = 0;
    aoeRadius = 250;
    delayTime = 0.7;

    OnCreated(params: { jumps: number }) {
        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
            this.jumps = params.jumps;
            this.angleDiff = 360 / this.jumps;

            this.OnIntervalThink();
            this.StartIntervalThink(this.delayTime);

            this.marker = createTimedRadiusMarker(this.caster, this.origin, this.radius, 1.0 * this.jumps, 0.2, "public");
            this.particleId = ParticleManager.CreateParticle("particles/queen/queenDodge.vpcf", ParticleAttachment.WORLDORIGIN, undefined);
            ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 1, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(this.particleId, 3, Vector(this.radius, 0, 0));
        }
    }

    OnDestroy() {
        if (IsServer()) {
            if (this.count == this.jumps) {
                QueenBlink.findOne(this.parent)?.Blink(this.origin);
            }

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }

            this.marker?.destroy();

            this.ability.StartCooldown(this.ability.GetLevel());
        }
    }

    OnIntervalThink() {
        if (this.count == this.jumps) {
            this.Destroy();
            return;
        }

        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_2, 1.5);

        if (this.count == 0) {
            const point = RotatePosition(
                this.origin,
                QAngle(0, this.angleDiff * this.nextTarget, 0),
                this.origin.__add(Vector(this.radius, 0, 0))
            );
            QueenBlink.findOne(this.parent)?.Blink(point);
        }

        this.count = this.count++;

        let newPoint = this.origin;

        if (this.count != this.jumps) {
            this.nextTarget = RandomIntWithExeption(0, this.jumps, this.nextTarget);
            newPoint = RotatePosition(
                this.origin,
                QAngle(0, this.angleDiff * this.nextTarget - 1, 0),
                this.origin.__add(Vector(this.radius, 0, 0))
            );
        }

        createTimedRadiusMarker(this.caster, newPoint, this.aoeRadius, this.delayTime, 0.2, "public");
    }

    OnHit() {
        if (IsServer()) {
            this.Destroy();
            ModifierStun.apply(this.parent, this.parent, undefined, { duration: 2.5 });
            return true;
        }

        return true;
    }

    CheckState() {
        return {
            [ModifierState.COMMAND_RESTRICTED]: true,
            [ModifierState.STUNNED]: true
        };
    }
}
