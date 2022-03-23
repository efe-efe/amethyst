import LayoutController from "./layout/layoutController";

const layout = LayoutController.GetInstance();

export class ReadyBar{
    duration: number;
    container: Panel;
    textPanel: LabelPanel;

    constructor(duration: number){
        this.duration = duration;
        this.container = layout.GetTopPanel().FindChildTraverse("ready-bar")!;
        this.textPanel = this.container.FindChildTraverse("ready-bar__title") as LabelPanel;
        this.textPanel.text = "READY?";
        this.Activate();
    }

    private Activate(): void{
        this.container.style.height = "200px";
        this.Update();
    }

    private Update(): void{
        $.Schedule(1.0, () => {
            if(this.duration < 0){
                this.container.style.height = "0px";
                return;
            }

            this.duration = this.duration - 1;
            const text = this.duration > 0 ? this.duration.toString() : "FIGHT!";
            this.textPanel.text = text;
            this.Update();
        });
    }
}