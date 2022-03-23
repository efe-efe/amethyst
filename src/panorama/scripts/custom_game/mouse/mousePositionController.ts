export default class MousePositionController{
    private static instance: MousePositionController;
    private thinkInterval = 0.01;

    private constructor(){
        this.Update();
    }

    public static GetInstance(): MousePositionController {
        if (!MousePositionController.instance) {
            MousePositionController.instance = new MousePositionController();
        }

        return MousePositionController.instance;
    }

    public Update(): void{
        const mousePositionScreen = GameUI.GetCursorPosition();
        const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);
        const data = { 
            x: mousePosition[0], 
            y: mousePosition[1],
            z: mousePosition[2],
            playerId: Players.GetLocalPlayer() 
        } as never;

        GameEvents.SendCustomGameEventToServer("update_mouse_position", data);
        
        $.Schedule(this.thinkInterval, () => {
            this.Update();
        }); 
    }
}

MousePositionController.GetInstance();
