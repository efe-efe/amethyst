import { createTimedRadiusMarker } from "../../util";
import { CustomAIType, CustomAIMeta } from "./custom_ai";

export interface SpawnerOptions {
    delayTime: number;
    remainingTime: number;
    origin: Vector;
    name: number;
}

export default class Spawner {
    efx: ParticleID | undefined;
    delayTime: number;
    remainingTime: number;
    origin: Vector;
    name: number;
    marker?: ReturnType<typeof createTimedRadiusMarker>;
    ai: CustomAIType | undefined;

    constructor(options: SpawnerOptions) {
        this.delayTime = options.delayTime;
        this.remainingTime = options.remainingTime * 30;
        this.origin = options.origin;
        this.name = options.name;
        this.CreateEFX();
    }

    Update(): void {
        if (this.remainingTime === -1) {
            return;
        }
        if (this.remainingTime > 0) {
            this.remainingTime--;
        } else {
            this.ai = CustomAIMeta[this.name].factory(this.origin);
            EFX("particles/ai_spawn.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.ai.unit, {
                release: true
            });
            this.Destroy();
        }
    }

    CreateEFX(): void {
        this.marker = createTimedRadiusMarker(undefined, this.origin, 150, this.delayTime, 0.2, "public");

        this.efx = EFX("particles/econ/events/ti10/portal/portal_open_good.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin
        });
    }

    CleanEFX(): void {
        if (this.efx) {
            ParticleManager.DestroyParticle(this.efx, false);
            ParticleManager.ReleaseParticleIndex(this.efx);
        }

        this.marker?.destroy();
    }

    Destroy(): void {
        if (this.remainingTime !== -1) {
            this.CleanEFX();
            this.remainingTime = -1;
        }
    }

    GetAi(): CustomAIType | undefined {
        return this.ai;
    }
}
