import { CustomAbility, CustomItem } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { allianceDefinitions, findAllianceDefinitionByTeam, findAllianceDefinitionByUnit } from "../alliance_definitions";
import { registerModifier } from "../lib/dota_ts_adapter";

// @Refactor Create an "attachTo" method so I can have OnIntervalThink
// @Refactor Maybe I should consider the delay and calculate the duration based on that..
export type ModifierThinkerParams = {
    delayTime?: number;
    radius?: number;
    visibility?: "visible" | "collapse";
    scope?: "public" | "local";
    behavior?: "follow" | "static";
    content?: "clearout" | "fillup" | "static";
};

@registerModifier()
export class ModifierThinker<A extends CDOTABaseAbility | undefined = CustomAbility | CustomItem> extends CustomModifier<A> {
    initialized = false;
    delayTime!: number;
    radius!: number;
    scope!: "public" | "local";
    behavior!: "follow" | "static";
    content!: "clearout" | "fillup" | "static";
    visibility!: "visible" | "collapse";
    origin!: Vector;

    particleIds: ParticleID[] = [];
    counter = 0;

    OnCreated(params: ModifierThinkerParams) {
        if (IsServer()) {
            this.initialized = true;
            this.delayTime = params.delayTime ?? 0;
            this.radius = params.radius ?? 0;
            this.scope = params.scope ?? "public";
            this.behavior = params.behavior ?? "static";
            this.content = params.content ?? "static";
            this.visibility = params.visibility ?? "visible";
            this.origin = this.parent.GetAbsOrigin();

            if (this.radius > 0 && this.visibility == "visible") {
                this.DrawVisuals(this.delayTime > 0 ? 0 : 1);
            }

            this.initialized = this.delayTime <= 0;
            this.StartIntervalThink(0.03);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.StartIntervalThink(-1);
            this.RemoveVisuals();
            UTIL_Remove(this.parent);
        }
    }

    OnIntervalThink() {
        if (this.behavior == "follow") {
            this.parent.SetAbsOrigin(this.caster.GetAbsOrigin());
        }

        if (!this.initialized) {
            const percentage = this.counter / (this.delayTime * 30);
            this.UpdateVisuals(percentage);

            // if(self:GetTimedActions()[self.counter/30]){
            //     self:GetTimedActions()[self.counter/30](self)
            // }

            this.counter++;

            if (percentage >= 1.0) {
                this.initialized = true;
                this.counter = 0;
            }
        } else {
            if (this.counter == 0) {
                this.RemoveVisuals();
                if (this.visibility == "visible") {
                    this.DrawVisuals(this.GetDuration() - this.delayTime);
                }

                this.OnReady();
            }

            if (this.content == "clearout") {
                const percentage = this.counter / ((this.GetDuration() - this.delayTime) * 30);
                this.UpdateVisuals(percentage);
            }
            this.counter = this.counter + 1;
        }
    }

    OnReady() {}

    UpdateVisuals(percentage: number) {
        for (const particleId of this.particleIds) {
            ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin().__add(Vector(0, 0, 16)));
            ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, percentage, 0));
        }
    }

    DrawVisuals(percentage: number) {
        const casterAlliance = findAllianceDefinitionByUnit(this.caster);

        if (this.scope == "public") {
            for (const alliance of allianceDefinitions) {
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
                    const alliance = findAllianceDefinitionByTeam(team);
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

        this.particleIds = [];
    }

    //     function modifier:GetTimedActions()
    //         if getTimedActions then return getTimedActions(self) }
    //         return {}
    //     }
}
