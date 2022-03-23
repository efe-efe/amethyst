import { colors, panels } from "../util";
export default class Player {
    constructor(container, playerId, color) {
        this.panel = panels.createPanelSimple(container, "player-name");
        const textPanel = panels.createPanelSimple(this.panel, "player-name__text", "Label");
        textPanel.text = Players.GetPlayerName(playerId);
        textPanel.style.color = colors.Gradient(color);
    }
    GetPanel() {
        return this.panel;
    }
}
