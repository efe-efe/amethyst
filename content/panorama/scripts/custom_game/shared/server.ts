import { CustomActionEvent } from '../../../../../common/interfaces';
import { Custom_ActionModes, Custom_ActionTypes } from '../../../../../common/enums';

const server = {
    sendActionSignalToServer: (payload: any): void => {
        let playerId = Players.GetLocalPlayer();

        if(Game.IsInToolsMode()){
            const selectedEntity = Players.GetSelectedEntities(playerId)[0];
            if(selectedEntity){
                playerId = Entities.GetPlayerOwnerID(selectedEntity);
            }
        }

        const data: CustomActionEvent = {
            playerId
            playerID: playerId, //Idk why this has to be this way...
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