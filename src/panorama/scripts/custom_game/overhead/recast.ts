import { panels } from "../util";

export default class Recast {
    panel: Panel;
    imagePanel: AbilityImage;
    textPanel: LabelPanel;
    modifier: BuffID | undefined;

    constructor(container: Panel) {
        this.panel = panels.createPanelSimple(container, "recast");
        this.imagePanel = panels.createPanelSimple(this.panel, "recast__image", "DOTAAbilityImage") as AbilityImage;
        this.textPanel = panels.createPanelSimple(this.panel, "recast__text", "Label") as LabelPanel;

        this.imagePanel.abilityname = "";
        this.textPanel.text = "Hello";

        this.Deactivate();
    }

    public Deactivate(): void {
        this.panel.SetHasClass("recast--deactivated", true);
    }

    public Activate(abilityName: string, key: string): void {
        this.imagePanel.abilityname = abilityName;
        this.textPanel.text = key;
        this.panel.SetHasClass("recast--deactivated", false);
    }
}
