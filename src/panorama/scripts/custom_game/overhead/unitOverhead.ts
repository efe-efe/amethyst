import Overhead from "./overhead";
import { statusComponent } from "./status";
import util, { Color, colors, panels } from "../util";
import Health from "../commonComponents/health";
import { StatusType, StatusTypes } from "../types";
import { std } from "../std";

enum StatusScope {
    STATUS_SCOPE_PUBLIC = 1,
    STATUS_SCOPE_LOCAL
}

enum BeenHurt {
    BEEN_HURT = 1,
    NOT_HURT = 0
}

export default class UnitOverhead extends Overhead {
    botPanel: Panel;
    healthPanel: Panel;
    color: Color;
    active: boolean;

    botSwitchPanel: SwitchPanel | undefined;

    health: Health;
    isLocalPlayer: boolean;
    // hideWhenNotHurt: boolean;

    constructor(unitData: UnitData) {
        super(unitData.entityIndex as EntityIndex);
        const localPlayerId = Game.GetLocalPlayerID();

        // this.hideWhenNotHurt = unitData.hideWhenNotHurt ? unitData.hideWhenNotHurt : true;
        // this.active = !this.hideWhenNotHurt;
        this.active = true;

        this.isLocalPlayer = localPlayerId == unitData.playerId;
        this.color = colors.orange;
        const statusPanel = std.panel(this.containerPanel, { class: "unit-overhead__status" });
        this.botPanel = panels.createPanelSimple(this.containerPanel, "unit-overhead__bot");
        const resourcesPanel = panels.createPanelSimple(this.botPanel, "unit-overhead-resources");
        this.healthPanel = panels.createPanelSimple(resourcesPanel, "unit-overhead-resources__health");

        // statusComponent(statusPanel, unitData.entityIndex);

        this.health = new Health(this.healthPanel, {
            color: this.color,
            rounded: true,
            maxTreshold: unitData.maxHealth,
            shieldOnFront: true
        });

        // if (unitData.beenHurt === BeenHurt.NOT_HURT && this.hideWhenNotHurt) {
        //     this.Hide();
        //     this.health.Deactivate();
        // }

        this.UpdateData(unitData);
    }

    ShouldShowStatus(status: StatusTypes): boolean {
        return !util.isEmptyObject(status);
    }

    ShouldActivate(beenHurt: BeenHurt): boolean {
        // if (this.hideWhenNotHurt && beenHurt === BeenHurt.NOT_HURT) {
        //     return false;
        // }
        return true;
    }

    GetCurrentStatus(status: StatusTypes): StatusType | undefined {
        let currentStatus = undefined;

        for (const modifierName in status) {
            const tempStatus = status[modifierName];

            if (!currentStatus || tempStatus.priority > currentStatus.priority) {
                if (tempStatus.scope == StatusScope.STATUS_SCOPE_LOCAL) {
                    if (this.isLocalPlayer) {
                        currentStatus = tempStatus;
                    }
                } else {
                    currentStatus = tempStatus;
                }
            }
        }

        return currentStatus;
    }

    public UpdateData(unitData: UnitData): void {
        if (!this.active) {
            // if (this.ShouldActivate(unitData.beenHurt)) {
            this.Show();
            this.health.Activate();
            this.active = true;
            // } else {
            //     return;
            // }
        }
        // if (this.ShouldShowStatus(unitData.status)) {
        //     const currentStatus = this.GetCurrentStatus(unitData.status);
        //     if (currentStatus) {
        //         const { label, style_name, trigger, modifier_name, max_stacks, content } = currentStatus;
        //     }
        // }

        // this.health.Update(unitData.health, unitData.health, unitData.maxHealth, unitData.shield);
    }
}

class SwitchPanel {
    childrens: Panel[] = [];
    state: 0 | 1 | -1 = 1;

    constructor(firstPanel: Panel, secondPanel: Panel) {
        this.AddPanel(firstPanel);
        this.AddPanel(secondPanel);
        this.Switch();
    }

    ShutDownBoth(): void {
        this.childrens[0].style.visibility = "collapse";
        this.childrens[1].style.visibility = "collapse";
        this.state = -1;
    }

    Switch(): void {
        if (this.state == 0) {
            this.childrens[0].style.visibility = "collapse";
            this.childrens[1].style.visibility = "visible";
            this.state = 1;
        } else {
            this.childrens[1].style.visibility = "collapse";
            this.childrens[0].style.visibility = "visible";
            this.state = 0;
        }
    }

    SetState(state: 0 | 1): void {
        if (this.state != state) {
            this.Switch();
        }
    }

    AddPanel(panel: Panel): void {
        this.childrens.push(panel);
    }
}
