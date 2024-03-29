const server = {
    sendActionSignalToServer: (
        payload:
            | { type: number; mode: Custom_ActionModes; abilityEntityIndex: AbilityEntityIndex }
            | { type: number; mode: Custom_ActionModes; direction: number[] }
    ): void => {
        let playerId = Players.GetLocalPlayer();

        if (Game.IsInToolsMode()) {
            const selectedEntity = Players.GetSelectedEntities(playerId)[0];
            if (selectedEntity) {
                playerId = Entities.GetPlayerOwnerID(selectedEntity);
            }
        }

        const data = {
            playerIndex: playerId,
            payload
        };

        GameEvents.SendCustomGameEventToServer("customAction", data);
    },
    sendStopAbilitySignalToServer: (abilityEntityIndex: AbilityEntityIndex): void => {
        const payload = {
            abilityEntityIndex,
            type: 1,
            mode: 1
        };
        server.sendActionSignalToServer(payload);
    },
    sendStartMovementSignalToServer: (direction: number[]): void => {
        const payload = {
            direction,
            type: 0,
            mode: 0
        };

        server.sendActionSignalToServer(payload);
    },
    sendStopMovementSignalToServer: (direction: number[]): void => {
        const payload = {
            direction,
            type: 0,
            mode: 1
        };

        server.sendActionSignalToServer(payload);
    }
};

export default server;
