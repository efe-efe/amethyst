import { std } from "../std";
import { cellsComponent } from "./cells";

export function resourceComponent(parent: Panel) {
    const root = std.panel(parent, { class: "resource" });
    const progress = std.progressBar(root, { class: "resource__progress", min: 0 });
    const cells = cellsComponent(root);

    function update(current: number, max: number) {
        progress.value = current;
        progress.max = max;
    }

    function setCells(amount: number) {
        cells.setCells(amount);
    }

    return {
        update,
        setCells
    };
}
