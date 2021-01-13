import MouseClickController from './mouseClickController';
import Key, { CUSTOM_KeyStates } from './key';
import Action from './actions';

export default class Command {
    key: Key;
    action: Action;
    mouseClickController = MouseClickController.GetInstance();

    constructor(key: Key, action: Action){
        this.key = key;
        this.action = action;
        this.mouseClickController = MouseClickController.GetInstance();

        this.Set();
    }

    Set(): void{
        if(this.key.keyCode == 'MOUSE_1'){
            this.mouseClickController.SetOnLeftClickPressed(() => this.action.OnStart());
            this.mouseClickController.SetOnLeftClickReleased(() => this.action.OnEnd());
        } else if(this.key.keyCode == 'MOUSE_2'){
            this.mouseClickController.SetOnRightClickPressed(() => this.action.OnStart());
            this.mouseClickController.SetOnRightClickReleased(() => this.action.OnEnd());
        }
        else {
            Game.AddCommand('+' + this.key.keyCode + 'Key', () => {
                if(this.key.state == CUSTOM_KeyStates.NEVER_PRESSED){
                    this.key.SetPressedAtLeastOnce();
                }
                this.action.OnStart();
            }, '', 0);
            Game.AddCommand('-' + this.key.keyCode + 'Key', () => {
                if(this.key.state == CUSTOM_KeyStates.NEVER_PRESSED){
                    return;
                }
                this.action.OnEnd();
            }, '', 0);
        }
    }

    UnSet(){
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        const emptyFunction = () => {};
        Game.AddCommand('+' + this.key.keyCode + 'Key', emptyFunction, '', 0);
        Game.AddCommand('-' + this.key.keyCode + 'Key', emptyFunction, '', 0);

        this.key.SetNeverPressed();
    }
}

export const GetCommandByActionCode = (commands: Command[], actionCode: number): Command | undefined => {
    return commands.filter(command => command.action.actionCode == actionCode)[0];
};