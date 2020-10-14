interface CustomActionEvent {
    playerId: number;
    payload?: any;
}

const enum Custom_ActionModes {
    START = 0,
    STOP = 1,
} 
const enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1,
} 

const server = {
    sendActionSignalToServer: (payload: any): void => {
        const data: CustomActionEvent = {
            playerId: Players.GetLocalPlayer(),
            payload
        };

        GameEvents.SendCustomGameEventToServer<CustomActionEvent>('custom_action', data);
    },
    sendStopAbilitySignalToServer: (abilityEntityIndex: AbilityEntityIndex): void => {
        const payload = {
            abilityEntityIndex,
            type: Custom_ActionTypes.ABILITY, 
            mode: Custom_ActionModes.STOP,
        };
        server.sendActionSignalToServer(payload);
    },
    sendStartMovementSignalToServer: (direction: number[]): void => {
        const payload = {
            direction,
            type: Custom_ActionTypes.MOVEMENT, 
            mode: Custom_ActionModes.START,
        };

        server.sendActionSignalToServer(payload);
    },
    sendStopMovementSignalToServer: (direction: number[]): void => {
        const payload = {
            direction,
            type: Custom_ActionTypes.MOVEMENT, 
            mode: Custom_ActionModes.STOP,
        };

        server.sendActionSignalToServer(payload);
    },
};

export default server;