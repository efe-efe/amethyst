import Overhead from './overhead';
import Status from './status';
import util, { colors, panels } from '../util';
import Health from '../commonComponents/health';
var StatusScope;
(function (StatusScope) {
    StatusScope[StatusScope["STATUS_SCOPE_PUBLIC"] = 1] = "STATUS_SCOPE_PUBLIC";
    StatusScope[StatusScope["STATUS_SCOPE_LOCAL"] = 2] = "STATUS_SCOPE_LOCAL";
})(StatusScope || (StatusScope = {}));
var BeenHurt;
(function (BeenHurt) {
    BeenHurt[BeenHurt["BEEN_HURT"] = 1] = "BEEN_HURT";
    BeenHurt[BeenHurt["NOT_HURT"] = 0] = "NOT_HURT";
})(BeenHurt || (BeenHurt = {}));
export default class UnitOverhead extends Overhead {
    constructor(unitData) {
        super(unitData.entityIndex);
        const localPlayerId = Game.GetLocalPlayerID();
        this.hideWhenNotHurt = unitData.hideWhenNotHurt ? unitData.hideWhenNotHurt : true;
        this.active = !this.hideWhenNotHurt;
        this.isLocalPlayer = localPlayerId == unitData.playerId;
        this.color = colors.orange;
        this.topPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__top');
        this.midPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__mid');
        this.botPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__bot');
        const resourcesPanel = panels.createPanelSimple(this.botPanel, 'unit-overhead-resources');
        this.healthPanel = panels.createPanelSimple(resourcesPanel, 'unit-overhead-resources__health');
        this.status = new Status(this.midPanel, unitData.entityIndex);
        this.health = new Health(this.healthPanel, {
            color: this.color,
            rounded: true,
            maxTreshold: unitData.maxHealth,
            shieldOnFront: true,
        });
        if (unitData.beenHurt === BeenHurt.NOT_HURT && this.hideWhenNotHurt) {
            this.Hide();
            this.status.Deactivate();
            this.health.Deactivate();
        }
        this.UpdateData(unitData);
    }
    ShouldShowStatus(status) {
        return !util.isEmptyObject(status);
    }
    ShouldActivate(beenHurt) {
        if (this.hideWhenNotHurt && beenHurt === BeenHurt.NOT_HURT) {
            return false;
        }
        return true;
    }
    GetCurrentStatus(status) {
        let currentStatus = undefined;
        for (const modifierName in status) {
            const tempStatus = status[modifierName];
            if (!currentStatus || (tempStatus.priority > currentStatus.priority)) {
                if (tempStatus.scope == StatusScope.STATUS_SCOPE_LOCAL) {
                    if (this.isLocalPlayer) {
                        currentStatus = tempStatus;
                    }
                }
                else {
                    currentStatus = tempStatus;
                }
            }
        }
        return currentStatus;
    }
    UpdateData(unitData) {
        if (!this.active) {
            if (this.ShouldActivate(unitData.beenHurt)) {
                this.Show();
                this.status.Activate();
                this.health.Activate();
                this.active = true;
            }
            else {
                return;
            }
        }
        if (this.ShouldShowStatus(unitData.status)) {
            const currentStatus = this.GetCurrentStatus(unitData.status);
            if (currentStatus) {
                const { label, style_name, trigger, modifier_name, max_stacks, content } = currentStatus;
                if (!this.status.HasData()) {
                    this.status.SetData(label, style_name, trigger, modifier_name, max_stacks, content);
                }
                if (!this.status.IsActive()) {
                    this.status.Activate();
                }
            }
            else {
                this.status.Deactivate();
            }
        }
        else {
            this.status.Deactivate();
        }
        this.health.Update(unitData.health, unitData.health, unitData.maxHealth, unitData.shield);
    }
}
class SwitchPanel {
    constructor(firstPanel, secondPanel) {
        this.childrens = [];
        this.state = 1;
        this.AddPanel(firstPanel);
        this.AddPanel(secondPanel);
        this.Switch();
    }
    ShutDownBoth() {
        this.childrens[0].style.visibility = 'collapse';
        this.childrens[1].style.visibility = 'collapse';
        this.state = -1;
    }
    Switch() {
        if (this.state == 0) {
            this.childrens[0].style.visibility = 'collapse';
            this.childrens[1].style.visibility = 'visible';
            this.state = 1;
        }
        else {
            this.childrens[1].style.visibility = 'collapse';
            this.childrens[0].style.visibility = 'visible';
            this.state = 0;
        }
    }
    SetState(state) {
        if (this.state != state) {
            this.Switch();
        }
    }
    AddPanel(panel) {
        this.childrens.push(panel);
    }
}
