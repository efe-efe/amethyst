import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierThinker<A extends CDOTABaseAbility | undefined = CustomAbility> extends CustomModifier<A> {
    initialized = false;
    delayTime!: number;
    radius!: number;
    scope!: "public" | "local";
    behavior!: "follow" | "static";
    particleIds: ParticleID[] = [];
    counter = 0;

    OnCreated(params: {
        delayTime?: number;
        radius?: number;
        visibility?: "visible" | "collapse";
        scope?: "public" | "local";
        behavior?: "follow" | "static";
    }) {
        this.initialized = true;

        this.delayTime = params.delayTime ?? 0;
        this.radius = params.radius ?? 0;
        this.scope = params.scope ?? "public";
        this.behavior = params.behavior ?? "static";

        const visibility = params.visibility ?? "visible";

        if (IsServer()) {
            if (this.radius > 0 && visibility == "visible") {
                this.DrawVisuals();
            }
        }

        if (this.delayTime > 0) {
            this.initialized = false;
            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.RemoveVisuals();
        }
    }

    OnIntervalThink() {
        if (!this.initialized) {
            const percentage = this.counter / (this.delayTime * 30);

            if (IsServer()) {
                if (this.behavior == "follow") {
                    this.parent.SetAbsOrigin(this.caster.GetAbsOrigin());
                }
                for (const particleId of this.particleIds) {
                    ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
                    ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, percentage, 0));
                }

                // if(self:GetTimedActions()[self.counter/30]){
                //     self:GetTimedActions()[self.counter/30](self)
                // }
            }

            if (percentage >= 1.0) {
                this.initialized = true;
                this.OnReady();
            }

            this.counter++;
        }
    }

    OnReady() {}

    DrawVisuals() {
        const percentage = this.delayTime > 0 ? 0 : 1;
        const casterAlliance = CustomEntitiesLegacy.GetAlliance(this.caster);

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
                    if (alliance == casterAlliance) {
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

    //     function modifier:GetTimedActions()
    //         if getTimedActions then return getTimedActions(self) }
    //         return {}
    //     }
}
