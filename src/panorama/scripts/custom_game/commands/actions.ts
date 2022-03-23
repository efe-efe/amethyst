export default class Action{
    actionCode: number;
    name: string;

    constructor(name: string, actionCode: number){
        this.actionCode = actionCode;
        this.name = name;
    }

    OnStart(): void{
        $.Msg("Im starting the action: ", this.name);
    }

    OnEnd(): void{
        $.Msg("Im ending the action: ", this.name);
    }
}

export const GetActionByActionCode = (actions: Action[], actionCode: number): Action | undefined => {
    return actions.filter(action => action.actionCode == actionCode)[0];
};