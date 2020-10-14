export enum CUSTOM_MouseButtons{
    LEFT_CLICK = 0,
    RIGHT_CLICK = 1
}

// eslint-disable-next-line @typescript-eslint/no-empty-function
const emptyFunction = () => {};

export default class MouseClickController{
    private static instance: MouseClickController;

    private onLeftClickPressed: any = emptyFunction;
    private onLeftClickReleased: any = emptyFunction;
    private onRightClickPressed: any = emptyFunction;
    private onRightClickReleased: any = emptyFunction;

    private constructor(){
        GameUI.SetMouseCallback((eventName, nMouseButton) => {
            if (GameUI.GetClickBehaviors() !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE){
                return false;
            }
            if (eventName === 'pressed'){
                if (nMouseButton === CUSTOM_MouseButtons.LEFT_CLICK){
                    if(GameUI.IsControlDown()){
                        return false;
                    }

                    this.onLeftClickPressed();
                    
                    const reTry = () => {
                        if (GameUI.IsMouseDown(0)){
                            this.onLeftClickPressed();
                            $.Schedule(0.05, reTry);
                        }
                    };

                    $.Schedule(0.05, reTry);

                    return true;
                }
                else if (nMouseButton === CUSTOM_MouseButtons.RIGHT_CLICK){
                    this.onRightClickPressed();
                    return true;
                }
            } else if( eventName === 'released'){
                if (nMouseButton === CUSTOM_MouseButtons.LEFT_CLICK){
                    this.onLeftClickReleased();
                    return true;
                }
                else if (nMouseButton === CUSTOM_MouseButtons.RIGHT_CLICK){
                    this.onRightClickReleased();
                    return true;
                }
            } else if (eventName === 'doublepressed'){ 
                return true;
            }
            return false;
        });    
    }

    
    public static GetInstance(): MouseClickController {
        if (!MouseClickController.instance) {
            MouseClickController.instance = new MouseClickController();
        }

        return MouseClickController.instance;
    }

    public SetOnLeftClickPressed(onPressed: any): void{
        this.onLeftClickPressed = onPressed;
    }

    public SetOnRightClickPressed(onPressed: any): void{
        this.onRightClickPressed = onPressed;
    }

    public SetOnLeftClickReleased(onReleased: any): void{
        this.onLeftClickReleased = onReleased;
    }

    public SetOnRightClickReleased(onReleased: any): void{
        this.onRightClickReleased = onReleased;
    }
}