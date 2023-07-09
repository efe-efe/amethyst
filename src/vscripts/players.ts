import { Alliance } from "./alliances";
import { CustomPlayerHeroNPC } from "./clases/pve/custom_npc";
import { Entity } from "./entities";

export type Player = {
    id: PlayerID;
    team: DotaTeam.NOTEAM;
    cursorPosition: Vector;
    entity?: Entity;
    alliance?: Alliance;
    customNpc?: CustomPlayerHeroNPC;
};

export const players: Player[] = [];

export function createPlayer(id: PlayerID) {
    const player: Player = {
        id: id,
        entity: undefined,
        alliance: undefined,
        customNpc: undefined,
        team: DotaTeam.NOTEAM,
        cursorPosition: Vector(0, 0, 0)
    };

    players.push(player);

    return player;
}

// export default class Player {

//     SetHero(hero: CDOTA_BaseNPC_Hero): void {
//         this.hero = hero;
//         CustomEntitiesLegacy.SendDataToClient(hero);
//     }

//     SetCustomNPC(customNpc: CustomPlayerHeroNPC): void {
//         this.customNpc = customNpc;
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

// RegisterPlayer(hero: CDOTA_BaseNPC_Hero, customNpc: CustomPlayerHeroNPC): boolean {
//     const team = hero.GetTeamNumber();
//     const playerID = hero.GetPlayerOwnerID();
//     const userID = playerID + 1;

//     if (playerID == -1) {
//         hero.Destroy();
//         print(
//             "ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER: \n\t playerID: " +
//                 playerID +
//                 "\n\t hero: " +
//                 hero.GetName() +
//                 "\n\t team: " +
//                 team
//         );
//         return false;
//     } else {
//         let player = this.FindPlayerById(playerID);
//         if (!player) {
//             player = new Player(playerID, userID);
//             this.players.push(player);
//             const alliance = findAllianceByTeam(team);

//             if (!alliance) {
//                 print(`ERROR: THE PLAYER ${playerID} IN TEAM ${team} IS NOT PART OF ANY ALLIANCE!`);
//                 return false;
//             }

//             player.SetTeam(team);
//             player.SetAlliance(alliance);
//             player.SetHero(hero);
//             player.SetCustomNPC(customNpc);

//             alliance.AddPlayer(player);
//         }

//         return true;
//     }
// }
