import { Player, createPlayer, players } from "./players";

export type FindStage<Union, Stage> = Union extends { stage: Stage } ? Union : never;
export type Game = CompactUnion<"stage", Stage, AddStage>;

declare let game: Game;

declare global {
    interface GameConfig {
        players: Player[];
    }

    interface BaseStage {
        config: GameConfig;

        players(): Player[];
    }

    // Must be based on BaseStage
    interface AddStage {
        [Stage.none]: BaseStage;
    }
}

export enum MapNames {
    "pvp" = "pvp",
    "pve" = "pve"
}

export function findPlayerById(playerId: PlayerID) {
    return players.find(player => player.id == playerId);
}

export function getMode() {
    return GetMapName() === MapNames.pvp ? MapNames.pvp : GetMapName() === MapNames.pve ? MapNames.pve : "none";
}

export function getGame() {
    return game;
}

export function setStage(stage: Game) {
    game = stage;

    print(`Stage set to ${stage.stage}`);
}

export function initStartingStage(): Game {
    //@Refactor: This is where to find players...
    const players: Player[] = [];

    for (let index = 0; index < 64; index++) {
        if (PlayerResource.IsValidPlayerID(index)) {
            print(`Registered player ${index}: ${PlayerResource.GetPlayerName(index)}`);
            players.push(createPlayer(index));
        }
    }

    return {
        stage: Stage.none,
        config: {
            players: players
        },
        players: () => players
    };
}
