export enum CUSTOM_KeyStates {
    NEVER_PRESSED = 0,
    PRESSED_AT_LEAST_ONCE = 1,
}

export default class Key{
    public keyCode: string;
    public state: CUSTOM_KeyStates;
    public text: string;

    constructor(keyCode: string, text?: string, state: CUSTOM_KeyStates = CUSTOM_KeyStates.NEVER_PRESSED){
        this.keyCode = keyCode;
        this.state = state;
        if(text){
            this.text = text;
        } else {
            this.text = keyCode;
        }
    }

    public SetPressedAtLeastOnce(): void{
        this.state = CUSTOM_KeyStates.PRESSED_AT_LEAST_ONCE;
    }

    public SetNeverPressed(): void{
        this.state = CUSTOM_KeyStates.NEVER_PRESSED;
    }
}

export const GetKeyByKeyCode = (keys: Key[], keyCode: string): Key | undefined => {
    return keys.filter(key => key.keyCode == keyCode)[0];
};