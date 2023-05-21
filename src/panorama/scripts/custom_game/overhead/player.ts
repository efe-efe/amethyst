import { Color, colors, panels } from "../util";

export default class Player {
  panel: Panel;

  constructor(container: Panel, playerId: PlayerID, color: Color) {
    this.panel = panels.createPanelSimple(container, "player-name");
    const textPanel = panels.createPanelSimple(
      this.panel,
      "player-name__text",
      "Label"
    ) as LabelPanel;
    textPanel.text = Players.GetPlayerName(playerId);
    textPanel.style.color = colors.Gradient(color);
  }

  GetPanel(): Panel {
    return this.panel;
  }
}
