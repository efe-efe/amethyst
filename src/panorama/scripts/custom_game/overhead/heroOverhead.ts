import Overhead from "./overhead";
import { statusComponent } from "./status";
import util, { colors, panels } from "../util";
import Charges from "./charges";
import Cooldown from "./cooldown";
import Stacks from "./stacks";
import Health from "../commonComponents/health";
import Alliances from "../alliances";
import Castpoint from "./castpoint";
import MultipleBars from "../commonComponents/multipleBars";
import { StatusType, StatusTypes } from "../types";

enum StatusScope {
    STATUS_SCOPE_PUBLIC = 1,
    STATUS_SCOPE_LOCAL
}

const alliances = Alliances.GetInstance();

export default class HeroOverhead extends Overhead {
    botPanel: Panel;
    chargesPanel: Panel;
    healthPanel: Panel;
    manaPanel: Panel;
    castpointPanel: Panel;
    ammoPanel: Panel;
    stackbarsPanel: Panel;
    cooldownPanel: Panel;
    energyPanel: Panel;

    botSwitchPanel: SwitchPanel | undefined;

    health: Health;
    energy: MultipleBars | undefined;
    mana: MultipleBars | undefined;
    castpoint: Castpoint;
    charges: Charges | undefined;
    cooldown: Cooldown | undefined;
    stacks: Stacks | undefined;

    isLocalPlayer: boolean;

    constructor(heroData: any) {
        super(heroData.entityIndex as EntityIndex);
        const alliance = alliances.findAllianceByTeam(heroData.teamId)!;
        const localPlayerId = Game.GetLocalPlayerID();
        const color = colors[alliance.GetColor()];

        this.isLocalPlayer = localPlayerId == heroData.playerId;
        const statusPanel = panels.createPanelSimple(this.containerPanel, "unit-overhead__status");
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
                valuePerCell: 25
            });
            this.energy = new MultipleBars(this.energyPanel, {
                value: heroData.energy,
                maxValue: heroData.maxEnergy,
                className: "energy",
                fullColor: colors.Gradient(colors.yellowRed),
                valuePerCell: heroData.energyPerCell || 100
            });
        }

        statusComponent(statusPanel, this.entityIndex, { playerId: heroData.playerId as PlayerID, color: color });
        this.health = new Health(this.healthPanel, {
            color: color,
            rounded: true
        });
        this.castpoint = new Castpoint(this.castpointPanel, this.entityIndex);
        this.botSwitchPanel = new SwitchPanel(this.cooldownPanel, this.stackbarsPanel);

        if (heroData.cooldown && this.isLocalPlayer) {
            this.cooldown = new Cooldown(this.cooldownPanel, this.entityIndex, heroData.cooldown);
            this.botSwitchPanel.SetState(0);
        }
        if (heroData.stackbars && this.isLocalPlayer) {
            this.stacks = new Stacks(this.ammoPanel, this.entityIndex, heroData.stackbars);
            this.botSwitchPanel.SetState(1);
        }
        if (heroData.charges && this.isLocalPlayer) {
            this.charges = new Charges(this.chargesPanel, this.entityIndex, heroData.charges);
        }

        this.UpdateData(heroData);
    }

    ShouldShowStatus(status: StatusTypes): boolean {
        return !util.isEmptyObject(status);
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

    public UpdateData(heroData: any) {
        this.health.Update(heroData.health, heroData.threshold, heroData.maxHealth, heroData.shield);
        if (this.mana) {
            this.mana.Update(heroData.mana, heroData.maxMana);
        }
        if (this.energy) {
            this.energy.Update(heroData.energy, heroData.maxEnergy);
        }
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
