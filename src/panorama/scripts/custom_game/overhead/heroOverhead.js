import Overhead from "./overhead";
import Recast from "./recast";
import Status from "./status";
import util, { colors, panels } from "../util";
import Player from "./player";
import Charges from "./charges";
import Cooldown from "./cooldown";
import Stacks from "./stacks";
import Health from "../commonComponents/health";
import Alliances from "../alliances";
import Castpoint from "./castpoint";
import MultipleBars from "../commonComponents/multipleBars";
var StatusScope;
(function (StatusScope) {
    StatusScope[StatusScope["STATUS_SCOPE_PUBLIC"] = 1] = "STATUS_SCOPE_PUBLIC";
    StatusScope[StatusScope["STATUS_SCOPE_LOCAL"] = 2] = "STATUS_SCOPE_LOCAL";
})(StatusScope || (StatusScope = {}));
const alliances = Alliances.GetInstance();
export default class HeroOverhead extends Overhead {
    constructor(heroData) {
        super(heroData.entityIndex);
        const alliance = alliances.findAllianceByTeam(heroData.teamId);
        const localPlayerId = Game.GetLocalPlayerID();
        this.isLocalPlayer = localPlayerId == heroData.playerId;
        this.color = colors[alliance.GetColor()];
        this.topPanel = panels.createPanelSimple(this.containerPanel, "unit-overhead__top");
        this.midPanel = panels.createPanelSimple(this.containerPanel, "unit-overhead__mid");
        this.botPanel = panels.createPanelSimple(this.containerPanel, "unit-overhead__bot unit-overhead__bot--hero");
        this.chargesPanel = panels.createPanelSimple(this.botPanel, "unit-overhead-charges");
        const resourcesPanel = panels.createPanelSimple(this.botPanel, "unit-overhead-resources");
        this.healthPanel = panels.createPanelSimple(resourcesPanel, "unit-overhead-resources__health");
        this.manaPanel = panels.createPanelSimple(resourcesPanel, "unit-overhead-resources__mana");
        this.energyPanel = panels.createPanelSimple(resourcesPanel, "unit-overhead-resources__energy");
        this.castpointPanel = panels.createPanelSimple(resourcesPanel, "unit-overhead-resources__castpoint");
        this.ammoPanel = panels.createPanelSimple(this.botPanel, "unit-overhead-ammo");
        this.stackbarsPanel = panels.createPanelSimple(this.ammoPanel, "unit-overhead-ammo__stackbars");
        this.cooldownPanel = panels.createPanelSimple(this.ammoPanel, "unit-overhead-ammo__cooldown");
        if (alliance.IsLocal()) {
            this.mana = new MultipleBars(this.manaPanel, {
                value: heroData.mana,
                maxValue: heroData.maxMana,
                className: "mana",
                fullColor: colors.Gradient(colors.blue),
                valuePerCell: 25,
            });
            this.energy = new MultipleBars(this.energyPanel, {
                value: heroData.energy,
                maxValue: heroData.maxEnergy,
                className: "energy",
                fullColor: colors.Gradient(colors.yellowRed),
                valuePerCell: heroData.energyPerCell || 100,
            });
        }
        this.recast = new Recast(this.topPanel);
        this.status = new Status(this.midPanel, heroData.entityIndex);
        const player = new Player(this.midPanel, heroData.playerId, this.color);
        this.health = new Health(this.healthPanel, {
            color: this.color,
            rounded: true,
        });
        this.castpoint = new Castpoint(this.castpointPanel, heroData.entityIndex);
        this.midSwitchPanel = new SwitchPanel(player.GetPanel(), this.status.GetPanel());
        this.botSwitchPanel = new SwitchPanel(this.cooldownPanel, this.stackbarsPanel);
        if (heroData.cooldown && this.isLocalPlayer) {
            this.cooldown = new Cooldown(this.cooldownPanel, heroData.entityIndex, heroData.cooldown);
            this.botSwitchPanel.SetState(0);
        }
        if (heroData.stackbars && this.isLocalPlayer) {
            this.stacks = new Stacks(this.ammoPanel, heroData.entityIndex, heroData.stackbars);
            this.botSwitchPanel.SetState(1);
        }
        if (heroData.charges && this.isLocalPlayer) {
            this.charges = new Charges(this.chargesPanel, heroData.entityIndex, heroData.charges);
        }
        this.UpdateData(heroData);
    }
    ShouldShowStatus(status) {
        return !util.isEmptyObject(status);
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
    UpdateData(heroData) {
        if (!util.isEmptyObject(heroData.recast) && this.isLocalPlayer) {
            const currentRecast = util.getFirstObjectElement(heroData.recast);
            this.recast.Activate(currentRecast.ability_name, currentRecast.key);
        }
        else {
            this.recast.Deactivate();
        }
        if (this.ShouldShowStatus(heroData.status)) {
            const currentStatus = this.GetCurrentStatus(heroData.status);
            if (currentStatus) {
                const { label, style_name, trigger, modifier_name, max_stacks, content } = currentStatus;
                if (!this.status.HasData()) {
                    this.status.SetData(label, style_name, trigger, modifier_name, max_stacks, content);
                }
                if (!this.status.IsActive()) {
                    this.status.Activate();
                }
                this.midSwitchPanel.SetState(1);
            }
            else {
                this.status.Deactivate();
                this.midSwitchPanel.SetState(0);
            }
        }
        else {
            this.status.Deactivate();
            this.midSwitchPanel.SetState(0);
        }
        this.health.Update(heroData.health, heroData.treshold, heroData.maxHealth, heroData.shield);
        if (this.mana) {
            this.mana.Update(heroData.mana, heroData.maxMana);
        }
        if (this.energy) {
            this.energy.Update(heroData.energy, heroData.maxEnergy);
        }
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
        this.childrens[0].style.visibility = "collapse";
        this.childrens[1].style.visibility = "collapse";
        this.state = -1;
    }
    Switch() {
        if (this.state == 0) {
            this.childrens[0].style.visibility = "collapse";
            this.childrens[1].style.visibility = "visible";
            this.state = 1;
        }
        else {
            this.childrens[1].style.visibility = "collapse";
            this.childrens[0].style.visibility = "visible";
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
