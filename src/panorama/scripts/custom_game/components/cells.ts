import { std } from "../std";

export function cellsComponent(parent: Panel) {
    const root = std.panel(parent, { class: "cells" });
    let cells: Panel[] = [];

    function setCells(amount: number) {
        for (const cell of cells) {
            cell.DeleteAsync(0);
        }

        cells = [];

        for (let i = 0; i < amount; i++) {
            const cell = std.panel(root, { class: "cells__cell" });
            cell.SetHasClass("cells__cell--last", i == amount - 1);
            cells.push(cell);
        }
    }

    return {
        root,
        setCells
    };
}
