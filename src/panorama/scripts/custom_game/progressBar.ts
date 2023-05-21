export default class ProgressBar {
  id: string;
  parent: Panel;
  panel: Panel;
  resizablePanel: Panel;
  fixedPanel: Panel;
  foregroundPanel: Panel;
  backgroundPanel: Panel;
  textPanel: LabelPanel;
  cellsPanel: Panel;
  delayPanel: Panel;

  cellWidth: number | undefined = undefined;

  constructor(id: string, parent: Panel, data: any) {
    this.id = id;
    this.parent = parent;

    const foreground_color = data.foreground_color || "#FAFAFA";
    const background_color = data.background_color || "rgba(36, 42, 53, 0.8)";
    const font_size = data.font_size || "12px";
    const delayed = data.delayed || false;
    const show_value = data.show_value || false;
    const border_radius = data.border_radius || "0";

    this.panel = $.CreatePanelWithProperties("Panel", parent, id, {
      class: "ProgressBar",
      hittest: "false",
      hittestchildren: "false",
    });

    this.resizablePanel = $.CreatePanelWithProperties(
      "Panel",
      this.panel,
      "id",
      {
        id: "ProgressBar__Resizable",
        class: "ProgressBar__Resizable",
        hittest: "false",
        hittestchildren: "false",
      }
    );

    this.fixedPanel = $.CreatePanelWithProperties("Panel", this.panel, "id", {
      class: "ProgressBar__Fixed",
      id: "ProgressBar__Fixed",
      hittest: "false",
      hittestchildren: "false",
    });

    this.backgroundPanel = $.CreatePanelWithProperties(
      "Panel",
      this.resizablePanel,
      "id",
      {
        id: "ProgressBar__Background",
        class: "ProgressBar__Background",
        hittest: "false",
        hittestchildren: "false",
      }
    );

    this.textPanel = $.CreatePanelWithProperties(
      "Label",
      this.fixedPanel,
      "id",
      {
        id: "ProgressBar__Text",
        class: "ProgressBar__Text",
        hittest: "false",
        hittestchildren: "false",
        text: "-",
      }
    );

    this.cellsPanel = $.CreatePanelWithProperties(
      "Panel",
      this.fixedPanel,
      "id",
      {
        id: "ProgressBar__Cells",
        class: "ProgressBar__Cells",
        hittest: "false",
        hittestchildren: "false",
      }
    );

    this.delayPanel = $.CreatePanelWithProperties(
      "Panel",
      this.backgroundPanel,
      "id",
      {
        id: "ProgressBar__Delay",
        class: "ProgressBar__Delay",
        hittest: "false",
        hittestchildren: "false",
      }
    );

    this.foregroundPanel = $.CreatePanelWithProperties(
      "Panel",
      this.backgroundPanel,
      "id",
      {
        id: "ProgressBar__Foreground",
        class: "ProgressBar__Foreground",
        hittest: "false",
        hittestchildren: "false",
      }
    );

    this.foregroundPanel.style.width = "0%";
    this.foregroundPanel.style.borderRadius = border_radius;
    this.delayPanel.style.borderRadius = border_radius;
    this.backgroundPanel.style.borderRadius = border_radius;
    this.delayPanel.style.visibility = (delayed && "visible") || "collapse";
    this.textPanel.style.visibility = (show_value && "visible") || "collapse";
    this.textPanel.style.fontSize = font_size;

    this.backgroundPanel.style.backgroundColor = background_color;
    this.foregroundPanel.style.backgroundColor = foreground_color;
  }

  SetTotalWidth(width: number): void {
    this.panel.style.width = width + "%";
  }

  SetPanelWidth(width: number): void {
    this.resizablePanel.style.width = width + "%";
  }

  SetProgress(progress: number): void {
    this.foregroundPanel.style.width = progress.toString() + "%";
    this.delayPanel.style.width = progress.toString() + "%";
  }

  SetValue(value: string): void {
    this.textPanel.text = value;
  }

  SetForegroundColor(color: string): void {
    this.foregroundPanel.style.backgroundColor = color;
  }

  SetVisibility(visibility: "visible" | "collapse" | null): void {
    this.panel.style.visibility = visibility;
  }

  SetBorder(data: {
    top?: string;
    left?: string;
    right?: string;
    bottom?: string;
  }): void {
    if (data.left) {
      this.backgroundPanel.style.borderLeft =
        data.left + "px solid rgb(36, 42, 53);";
    }
    if (data.right) {
      this.backgroundPanel.style.borderRight =
        data.right + "px solid rgb(36, 42, 53);";
    }
    if (data.top) {
      this.backgroundPanel.style.borderTop =
        data.top + "px solid rgb(36, 42, 53);";
    }
    if (data.bottom) {
      this.backgroundPanel.style.borderBottom =
        data.bottom + "px solid rgb(36, 42, 53);";
    }
  }

  SetBorderRadius(data: {
    topRight?: string;
    topLeft?: string;
    bottomRight?: string;
    bottomLeft?: string;
  }): void {
    if (data.topRight) {
      this.backgroundPanel.style.borderTopRightRadius = data.topRight + "px;";
      this.foregroundPanel.style.borderTopRightRadius = data.topRight + "px;";
      this.delayPanel.style.borderTopRightRadius = data.topRight + "px;";
    }
    if (data.topLeft) {
      this.backgroundPanel.style.borderTopLeftRadius = data.topLeft + "px;";
      this.foregroundPanel.style.borderTopLeftRadius = data.topLeft + "px;";
      this.delayPanel.style.borderTopLeftRadius = data.topLeft + "px;";
    }
    if (data.bottomRight) {
      this.backgroundPanel.style.borderBottomRightRadius =
        data.bottomRight + "px;";
      this.foregroundPanel.style.borderBottomRightRadius =
        data.bottomRight + "px;";
      this.delayPanel.style.borderBottomRightRadius = data.bottomRight + "px;";
    }
    if (data.bottomLeft) {
      this.backgroundPanel.style.borderBottomLeftRadius =
        data.bottomLeft + "px;";
      this.foregroundPanel.style.borderBottomLeftRadius =
        data.bottomLeft + "px;";
      this.delayPanel.style.borderBottomLeftRadius = data.bottomLeft + "px;";
    }
  }

  GetProgress(): number {
    return parseInt(this.foregroundPanel.style.width!.split("%")[0], 10);
  }

  GetParent(): Panel {
    return this.parent;
  }

  /*
    SetCellWidth(width: number): void{
        if(width == this.cellWidth){
            return;
        }

        this.cellWidth = width;
        for(const i = 0; i < this.cellsPanel.GetChildCount(); i++){
            $.Msg('AQUI DESTRUYENDO AL HIJO: ', i);
        }

        for(const i = 0; i < parseInt(this.panel.style.width.split('%')[0],10); i = i + this.cellWidth){
            $.Msg('i = ', i, ' cell width = ', this.cellWidth)

            const cell = $.CreatePanelWithProperties('Panel', this.cellsPanel, 'id', {
                class: 'ProgressBar__Cell',
                hittest: 'false',
                hittestchildren: 'false'
            });
            cell.style.width = this.cellWidth.toString() + '%';

            if(i == 0){
                cell.style.borderLeft = 0;
            }
        }
    }
    */
}
