import { modifiers, panels } from "../util";

export default class Charges {
  panel: Panel;
  modifierName: string;
  entityIndex: EntityIndex;

  textPanelMid: LabelPanel;

  constructor(
    container: Panel,
    entityIndex: EntityIndex,
    modifierName: string
  ) {
    this.panel = panels.createPanelSimple(container, "charges");
    this.entityIndex = entityIndex;
    this.modifierName = modifierName;

    const textPanelLeft = panels.createPanelSimple(
      this.panel,
      "charges__text",
      "Label"
    ) as LabelPanel;
    this.textPanelMid = panels.createPanelSimple(
      this.panel,
      "charges__text charges__text--number",
      "Label"
    ) as LabelPanel;
    const textPanelRight = panels.createPanelSimple(
      this.panel,
      "charges__text",
      "Label"
    ) as LabelPanel;

    textPanelLeft.text = "(";
    this.textPanelMid.text = "0";
    textPanelRight.text = ")";

    this.Update();
  }

  Update(): void {
    let modifierIndex = modifiers.findModifierByName(
      this.entityIndex,
      this.modifierName
    );

    if (modifierIndex) {
      modifierIndex = modifierIndex as BuffID;

      const ammount = Buffs.GetStackCount(this.entityIndex, modifierIndex);
      this.textPanelMid.text = ammount.toString();
      this.textPanelMid.style.color = "#FAFAFA";

      if (ammount == 0) {
        this.textPanelMid.style.color = "rgba(238, 53, 0, 1.0)";
      }
    }

    $.Schedule(0.03, () => {
      this.Update();
    });
  }
}
