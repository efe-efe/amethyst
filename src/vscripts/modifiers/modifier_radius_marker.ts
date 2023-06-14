import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

//@Refactor check if this is neccesary
// @Refactor Maybe i should use ModifierThinker
@registerModifier({ customNameForI18n: "modifier_radius_marker" })
export class ModifierRadiusMarker extends CustomModifier<undefined> {
    particleIds: ParticleID[] = [];
    counter = 0;
    initialized = false;
    radius!: number;
    delay!: number;
    afterDelay!: number;
    scope!: "public" | "local";

    OnCreated(params: { radius: number; delay: number; afterDelay: number; scope: "public" | "local" }) {
        if (IsServer()) {
            this.radius = params.radius;
            this.delay = params.delay;
            this.afterDelay = params.afterDelay;
            this.scope = params.scope;

            this.DrawVisuals();

            if (this.delay > 0) {
                this.StartIntervalThink(0.03);
            } else {
                this.initialized = true;
                this.OnIntervalThink();
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.RemoveVisuals();
            UTIL_Remove(this.GetParent());
        }
    }

    OnIntervalThink() {
        if (!this.initialized) {
            const percentage = this.counter / (this.delay * 30);

            if (IsServer()) {
                for (const particleId of this.particleIds) {
                    ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
                    ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, percentage, 0));
                }
            }

            if (percentage >= 1.0) {
                this.initialized = true;
            }

            this.counter = this.counter + 1;
        } else {
            this.SetDuration(this.afterDelay, true);
            this.StartIntervalThink(-1);
        }
    }

    DrawVisuals() {
        const percentage = this.delay > 0 ? 0 : 1.0;
        const caster_alliance = CustomEntitiesLegacy.GetAlliance(this.caster);

        if (this.scope == "public") {
            for (const alliance of GameRules.Addon.alliances) {
                for (const team of alliance.teams) {
                    const particleId = ParticleManager.CreateParticleForTeam(
                        "particles/progress_circle/generic_progress_circle.vpcf",
                        ParticleAttachment.WORLDORIGIN,
                        this.caster,
                        team
                    );

                    ParticleManager.SetParticleControlForward(particleId, 0, Vector(0, -1, 0));
                    ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
                    ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, percentage, 1));
                    ParticleManager.SetParticleControl(particleId, 16, Vector(1, 0, 0));
                    const alliance = GameRules.Addon.FindAllianceByTeam(team);
                    if (alliance == caster_alliance) {
                        ParticleManager.SetParticleControl(particleId, 15, Vector(70, 70, 250));
                    } else {
                        ParticleManager.SetParticleControl(particleId, 15, Vector(250, 70, 70));
                    }
                    this.particleIds.push(particleId);
                }
            }
        }
        if (this.scope == "local") {
            const parentOwner = this.caster.GetPlayerOwner();
            const particleId = ParticleManager.CreateParticleForPlayer(
                "particles/progress_circle/generic_progress_circle.vpcf",
                ParticleAttachment.WORLDORIGIN,
                this.caster,
                parentOwner
            );

            ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
            ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, percentage, 1));
            ParticleManager.SetParticleControl(particleId, 15, Vector(70, 70, 250));
            this.particleIds.push(particleId);
        }
    }

    RemoveVisuals() {
        for (const particleId of this.particleIds) {
            ParticleManager.DestroyParticle(particleId, false);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }
}
