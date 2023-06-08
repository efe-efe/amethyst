/**
 * This file contains types for the events you want to send between the UI (Panorama)
 * and the server (VScripts).
 *
 * IMPORTANT:
 *
 * The dota engine will change the type of event data slightly when it is sent, so on the
 * Panorama side your event handlers will have to handle NetworkedData<EventType>, changes are:
 *   - Booleans are turned to 0 | 1
 *   - Arrays are automatically translated to objects when sending them as event. You have
 *     to change them back into arrays yourself! See 'toArray()' in src/panorama/hud.ts
 */

interface CustomNetTableDeclarations {
    units: {
        [key: string]: {
            entityIndex: number;
            teamId: number;
            playerId: number;
            allianceName: string;
            name: string;
            health: number;
            maxHealth: number;
            mana: number;
            maxMana: number;
        };
    };
}
/**
 * Client server request defines a remote procedure call from client to server
 *
 * Declare custom client-server requests as
 * interface CSRequests {
 *      requestName: [input, output]
 * }
 */

// Separate definition
interface CustomGameEventDeclarations {
    customAction: {
        playerIndex: number;
        payload:
            | {
                  type: Custom_ActionTypes.ABILITY;
                  mode: Custom_ActionModes;
                  abilityEntityIndex: number;
              }
            | {
                  type: Custom_ActionTypes.MOVEMENT;
                  direction: number[];
                  mode: Custom_ActionModes;
              };
    };

    refundPoints: { playerIndex: number };

    swapRF: { playerIndex: number };
}
