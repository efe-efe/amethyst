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

interface AbilityMeta {
    targetingIndicator: string;
    energyCost: number;
}

type AbilitiesMeta = {
    [key: string]: AbilityMeta;
};

type UnitData = {
    entityIndex: number;
    playerId: number;
    allianceId: string;
    teamId: number;
    name: string;
    health: number;
    maxHealth: number;
    mana: number;
    maxMana: number;
    shield: number;
    heroData?: {
        threshold: number;
        energy: number;
        maxEnergy: number;
        stackbars?: string;
        charges?: string;
        cooldown?: string;
        energyPerCell?: number;
    };
};

type AllianceData = {
    id: AllianceId;
    health: number;
    max_health: number;
    shield: number;
    amethysts: number;
    score: number;
};

interface CustomNetTableDeclarations {
    alliances: {
        [key: string]: AllianceData;
    };
    units: {
        [key: string]: UnitData;
    };
    main: {
        maxScore: {
            max_score: number;
        };
        pve: {
            currentRoom?: number;
            nextReward?: string;
            remainingEnemies?: number;
            maxEnemies?: number;
            roomPhases?: string[];
            roomPhaseIndex?: number;
            roomType?: string;
            currentStage?: number;
        };
        abilities: AbilitiesMeta;
        gameState: {
            gameState: number;
        };
    };
    pve: {
        [key: string]: {
            upgrades: Json<UpgradeId[]>;
        };
    };
    custom_npc_rewards: {
        [key: string]: {
            playerId: number;
            rewards?: any[];
        };
    };
    custom_npc_favors: {
        [key: string]: {
            playerId: number;
            upgrades?: any[];
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

    updateMousePosition: {
        playerId: number;
        x: number;
        y: number;
        z: number;
    };

    pickUpgrade: UpgradeId;

    countdown: {
        timer_minute_10: number;
        timer_minute_01: number;
        timer_second_10: number;
        timer_second_01: number;
    };

    custom_message: {
        text: string;
    };

    not_enough_energy: Nothing;
}
