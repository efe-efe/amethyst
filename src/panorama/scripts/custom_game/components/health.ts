import { std } from "../std";
import { colors } from "../util";
import { cellsComponent } from "./cells";
import { delayedProgressBarComponent } from "./delayedProgressBar";

export function healthComponent(
    parent: Panel,
    options: {
        text?: {
            size: number;
            percentage: number;
        };
        color: string;
        rounded: boolean;
        shieldDisplay: "over" | "side";
    }
) {
    const healthAndShield = std.panel(parent, { class: "health" });
    const cells = cellsComponent(parent);
    const value = std.label(parent, { class: "health__value" });

    const fontSize = options.text?.size; //13px
    const usePercentage = options.text?.percentage; //false

    const healthProgressBar = delayedProgressBarComponent(healthAndShield, {
        // color: colors.Gradient(options.color),
        //     backgroundColor: "black",
        class: "health__health-progress"
        //     rounded: options.rounded
    });

    const shieldProgressBar = std.progressBar(healthAndShield, {
        min: 0,
        class: "health__shield-progress"
        //     color: colors.Gradient(colors.gray),
        //     backgroundColor: "black",
        //     rounded: options.rounded
    });

    let active = true;

    healthAndShield.SetHasClass("health--side-shield", options.shieldDisplay == "side");

    function update(health: number, threshold: number, maxHealth: number, shield: number) {
        if (!active) {
            return;
        }

        const healeableAmount = Constants.maxThreshold - threshold;
        const potentialHealth = Math.min(maxHealth, health + healeableAmount);

        shieldProgressBar.max = shield;
        shieldProgressBar.value = shield;

        cells.setCells((maxHealth + shield) / 25);

        //         let healthPanelWidth;
        //         let healthProgress;
        //         let healthTotalWidth;

        shieldProgressBar.visible = shield > 0;

        if (shield <= 0) {
            //             healthPanelWidth = (100 * potentialHealth) / maxHealth;
            //             if (potentialHealth == 0) {
            //                 healthProgress = 0;
            //             } else {
            //                 healthProgress = (100 * health) / potentialHealth;
            //             }
            //             healthTotalWidth = 100;
        }

        if (options.shieldDisplay == "over") {
            healthProgressBar.setMax(maxHealth);
            healthProgressBar.setValue(health);
            //                 healthTotalWidth = 100;
            //                 const shieldTotalWidth = (100 * shield) / maxHealth;
            //                 this.shieldProgressBar.SetTotalWidth(shieldTotalWidth);
        }

        if (options.shieldDisplay == "side") {
            healthAndShield.style.width = `${(100 * (potentialHealth + shield)) / (maxHealth + shield)}%`;
            healthProgressBar.setWidth((100 * health) / (potentialHealth + shield));
            shieldProgressBar.style.width = `${(100 * shield) / (potentialHealth + shield)}%`;

            healthProgressBar.setMax(health);
            healthProgressBar.setValue(health);
        }

        //         if (this.showValue) {
        //             let value = health.toString();

        //             if (this.usePercentage) {
        //                 value = Math.floor((100 * potentialHealth) / maxHealth).toString() + "%";
        //             }
        //             value.text = value;
        //         }

        //         if (this.shieldOnFront) {
        //             this.UpdateCellsShieldOnFront(health, maxHealth);
        //         } else {
        //             this.UpdateCells(health, healeableAmount, maxHealth, shield);
        //         }
    }

    return {
        update
    };
}

//         healthAndShield.style.height = "100%";
//         healthAndShield.style.width = "100%";

//         cells.style.flowChildren = "right";
//         cells.style.height = "100%";
//         cells.style.width = "100%";
//         cells.style.borderRadius = this.rounded ? this.borderRadius + "px" : "0";

//         if (this.showValue) {
//             value.style.align = "center center";
//             value.style.textShadow = "0px 0px 8px 7.0 #000000b0";
//             value.style.color = "#FAFAFA";
//             value.style.fontSize = fontSize;
//             value.style.fontFamily = "Radiance, FZLanTingHei-R-GBK, TH Sarabun New, Gulim,MingLiU";
//         } else {
//             value.style.visibility = "collapse";
//         }
//     }

//     Activate(): void {
//         healthAndShield.style.visibility = "visible";
//         this.active = true;
//     }

//     Deactivate(): void {
//         healthAndShield.style.visibility = "collapse";
//         this.active = false;
//     }

//     UpdateCellsShieldOnFront(health: number, maxHealth: number): void {
//         this.UpdateCells(health, health, maxHealth, 0);
//     }

//     UpdateCells(health: number, healeableAmount: number, maxHealth: number, shield: number): void {
//         const potentialHealthPoints = health + shield + healeableAmount;
//         const cellsTotalWidth = (100 * potentialHealthPoints) / (maxHealth + shield);
//         cells.style.width = cellsTotalWidth + "%";

//         const rest = potentialHealthPoints % this.maxTreshold;
//         const cells = Math.ceil(potentialHealthPoints / this.maxTreshold);

//         while (cellss.length < cells) {
//             this.AddCell();
//         }

//         while (cellss.length > cells) {
//             this.RemoveCell();
//         }

//         cellss.forEach((panel, i) => {
//             let cellWidth = this.GetCellWidth(this.maxTreshold, potentialHealthPoints);
//             if (i == cellss.length - 1 && rest > 0) {
//                 cellWidth = this.GetCellWidth(rest, potentialHealthPoints);
//             }

//             panel.style.width = cellWidth + "%";
//         });
//     }

//     GetCellWidth(value: number, potentialHealthPoints: number): number {
//         return (100 * value) / potentialHealthPoints;
//     }

//     AddCell(): void {
//         const index = cells.GetChildCount();
//         const panel = panels.createPanelSimple(cells, "cell_panel_" + index);

//         panel.style.borderRight = "1px solid rgba(0, 0, 0, 0.6)";
//         panel.style.height = "100%";

//         cellss.push(panel);
//     }

//     RemoveCell(): void {
//         cellss[cellss.length - 1].DeleteAsync(0);
//         cellss.pop();
//     }
// }
