import { std } from "../std";

//@Refactor maybe the rounded propertie goes on the health component
export function progressBarComponent(
    parent: Panel,
    options: {
        rounded?: boolean;
        color?: string;
        backgroundColor?: string;
        delayed?: boolean;
        text?: {};
    }
) {
    const color = options.color ?? "#FAFAFA";
    const backgroundColor = options.backgroundColor ?? "rgba(36, 42, 53, 0.8)";

    // const font_size = options.font_size || "12px";
    const delayed = options.delayed ?? false;
    // const show_value = options.show_value || false;

    const root = std.panel(parent, { class: "progressBar" });
    const resizablePanel = std.panel(root, { class: "progressBar__resizable" });
    const fixedPanel = std.panel(root, { class: "progressBar__fixed" });
    const backgroundPanel = std.panel(resizablePanel, { class: "progressBar__background" });
    const textPanel = std.label(fixedPanel, {
        class: "progressBar__Text",
        text: "-"
    });
    const cellsPanel = std.panel(fixedPanel, { class: "progressBar__cells" });
    const delayPanel = std.panel(backgroundPanel, { class: "progressBar__delay" });
    const foregroundPanel = std.panel(backgroundPanel, { class: "progressBar__foreground" });

    root.SetHasClass("progressBar--rounded", options.rounded ? true : false);

    foregroundPanel.style.width = "0%";
    foregroundPanel.style.backgroundColor = color;

    delayPanel.style.visibility = delayed ? "visible" : "collapse";

    // textPanel.style.visibility = (show_value && "visible") || "collapse";
    // textPanel.style.fontSize = font_size;

    backgroundPanel.style.backgroundColor = backgroundColor;

    function setVisible(visible: boolean) {
        root.visible = visible;
    }

    return {
        setVisible
    };
}

// export default class ProgressBar {
//     SetTotalWidth(width: number): void {
//         this.panel.style.width = width + "%";
//     }

//     SetPanelWidth(width: number): void {
//         this.resizablePanel.style.width = width + "%";
//     }

//     SetProgress(progress: number): void {
//         this.foregroundPanel.style.width = progress.toString() + "%";
//         this.delayPanel.style.width = progress.toString() + "%";
//     }

//     SetValue(value: string): void {
//         this.textPanel.text = value;
//     }

//     SetForegroundColor(color: string): void {
//         this.foregroundPanel.style.backgroundColor = color;
//     }

//     SetVisibility(visibility: "visible" | "collapse" | null): void {
//         this.panel.style.visibility = visibility;
//     }

//     SetBorder(data: { top?: string; left?: string; right?: string; bottom?: string }): void {
//         if (data.left) {
//             this.backgroundPanel.style.borderLeft = data.left + "px solid rgb(36, 42, 53);";
//         }
//         if (data.right) {
//             this.backgroundPanel.style.borderRight = data.right + "px solid rgb(36, 42, 53);";
//         }
//         if (data.top) {
//             this.backgroundPanel.style.borderTop = data.top + "px solid rgb(36, 42, 53);";
//         }
//         if (data.bottom) {
//             this.backgroundPanel.style.borderBottom = data.bottom + "px solid rgb(36, 42, 53);";
//         }
//     }

//     SetBorderRadius(data: { topRight?: string; topLeft?: string; bottomRight?: string; bottomLeft?: string }): void {
//         if (data.topRight) {
//             this.backgroundPanel.style.borderTopRightRadius = data.topRight + "px;";
//             this.foregroundPanel.style.borderTopRightRadius = data.topRight + "px;";
//             this.delayPanel.style.borderTopRightRadius = data.topRight + "px;";
//         }
//         if (data.topLeft) {
//             this.backgroundPanel.style.borderTopLeftRadius = data.topLeft + "px;";
//             this.foregroundPanel.style.borderTopLeftRadius = data.topLeft + "px;";
//             this.delayPanel.style.borderTopLeftRadius = data.topLeft + "px;";
//         }
//         if (data.bottomRight) {
//             this.backgroundPanel.style.borderBottomRightRadius = data.bottomRight + "px;";
//             this.foregroundPanel.style.borderBottomRightRadius = data.bottomRight + "px;";
//             this.delayPanel.style.borderBottomRightRadius = data.bottomRight + "px;";
//         }
//         if (data.bottomLeft) {
//             this.backgroundPanel.style.borderBottomLeftRadius = data.bottomLeft + "px;";
//             this.foregroundPanel.style.borderBottomLeftRadius = data.bottomLeft + "px;";
//             this.delayPanel.style.borderBottomLeftRadius = data.bottomLeft + "px;";
//         }
//     }

//     GetProgress(): number {
//         return parseInt(this.foregroundPanel.style.width!.split("%")[0], 10);
//     }

//     GetParent(): Panel {
//         return this.parent;
//     }

//     /*
//     SetCellWidth(width: number): void{
//         if(width == this.cellWidth){
//             return;
//         }

//         this.cellWidth = width;
//         for(const i = 0; i < this.cellsPanel.GetChildCount(); i++){
//             $.Msg('AQUI DESTRUYENDO AL HIJO: ', i);
//         }

//         for(const i = 0; i < parseInt(this.panel.style.width.split('%')[0],10); i = i + this.cellWidth){
//             $.Msg('i = ', i, ' cell width = ', this.cellWidth)

//             const cell = $.CreatePanelWithProperties('Panel', this.cellsPanel, 'id', {
//                 class: 'progressBar__Cell',
//                 hittest: 'false',
//                 hittestchildren: 'false'
//             });
//             cell.style.width = this.cellWidth.toString() + '%';

//             if(i == 0){
//                 cell.style.borderLeft = 0;
//             }
//         }
//     }
//     */
// }
