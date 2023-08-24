import { Alliance } from "./alliances";
import { Entity } from "./entities";
import { Upgrade } from "./upgrades/framework/upgrade_definitions";

export type Player = {
    id: PlayerID;
    team: DotaTeam.NOTEAM;
    cursorPosition: Vector;
    entity?: Entity;
    alliance?: Alliance;
    upgrades: Upgrade[];
};

export const players: Player[] = [];

export function createPlayer(id: PlayerID) {
    const player: Player = {
        id: id,
        entity: undefined,
        alliance: undefined,
        team: DotaTeam.NOTEAM,
        cursorPosition: Vector(0, 0, 0),
        upgrades: []
    };

    players.push(player);

    return player;
}

// export default class Player {

//     SetHero(hero: CDOTA_BaseNPC_Hero): void {
//         this.hero = hero;
//         CustomEntitiesLegacy.SendDataToClient(hero);
//     }

//     GetId(): PlayerID {
//         return this.id;
//     }

//     GetCursorPosition(): Vector {
//         return this.cursorPosition;
//     }

//     SetTeam(team: DotaTeam): void {
//         this.team = team;
//     }

//     SetAlliance(alliance: Alliance): void {
//         this.alliance = alliance;
//     }

// }
