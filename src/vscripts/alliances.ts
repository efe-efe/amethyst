import { allianceDefinitions } from "./alliance_definitions";
import { getUnitShieldPoints } from "./modifiers/modifier_shield";
import { Player } from "./players";

export type Alliance = {
    teams: DotaTeam[];
    id: AllianceId;
    players: Player[];
    gems: number;
    wins: number;
    active: boolean;
};

export const alliances: Alliance[] = [];

for (const definition of allianceDefinitions) {
    alliances.push({
        id: definition.id,
        teams: definition.teams,
        players: [],
        gems: 0,
        wins: 0,
        active: false
    });
}

export function getAllianceHealth(alliance: Alliance) {
    return alliance.players.reduce((a, b) => (b.entity?.handle.GetHealth() ?? 0) + a, 0);
}

export function getAllianceMaxHealth(alliance: Alliance) {
    return alliance.players.reduce((a, b) => (b.entity?.handle.GetMaxHealth() ?? 0) + a, 0);
}

export function getAllianceShield(alliance: Alliance) {
    return alliance.players.reduce((a, b) => (b.entity ? getUnitShieldPoints(b.entity.handle) : 0) + a, 0);
}

export function setAllianceGems(alliance: Alliance, gems: number) {
    alliance.gems = gems;
    // this.SendDataToClient();
}

export function findAllianceByUnit(unit: CDOTA_BaseNPC) {
    return alliances.find(alliance => alliance.teams.some(team => team == unit.GetTeam()));
}

export function findAllianceByTeam(team: DotaTeam) {
    return alliances.find(alliance => alliance.teams.find(allianceTeam => allianceTeam == team));
}

export function findFirstAliveAlliancePlayer(alliance: Alliance) {
    return alliance.players.find(player => player.entity?.handle.IsAlive())?.entity?.handle;
}

// export default class AllianceLegacy {
// SendDataToClient(): void {
//     if (this.active) {
//         const data = {
//             health: this.GetCurrentHealth(),
//             max_health: this.GetMaxHealth(),
//             shield: this.GetShield(),
//             name: this.name,
//             amethysts: this.amethysts,
//             score: this.wins
//         } as never;
//         const tableName = "alliances" as never;
//         CustomNetTables.SetTableValue(tableName, this.name, data);
//     }
// }
// AddPlayer(player: Player): void {
//     this.players.push(player);
//     if (!this.active) {
//         this.active = true;
//     }
//     this.SendDataToClient();
// }
// SetScore(score: number): void {
//     this.wins = score;
//     this.SendDataToClient();
// }
// AddAmethsyt(): void {
//     this.SetAmethysts(this.GetAmethysts() + 1);
// }
// }
