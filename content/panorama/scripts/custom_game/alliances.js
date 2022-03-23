class Alliance {
    constructor(name, color, teams) {
        this.name = name;
        this.color = color;
        this.teams = teams;
    }
    GetName() {
        return this.name;
    }
    IsLocal() {
        const localPlayerId = Game.GetLocalPlayerID();
        const localPlayerTeam = Players.GetTeam(localPlayerId);
        let isLocal = false;
        this.teams.forEach((team) => {
            if (team == localPlayerTeam) {
                isLocal = true;
            }
        });
        return isLocal;
    }
    GetColor() {
        return this.IsLocal() ? "local" : this.color;
    }
}
export default class Alliances {
    constructor() {
        this.alliances = [
            new Alliance("DOTA_ALLIANCE_RADIANT", "orange", [DOTATeam_t.DOTA_TEAM_GOODGUYS, DOTATeam_t.DOTA_TEAM_BADGUYS]),
            new Alliance("DOTA_ALLIANCE_DIRE", "yellow", [DOTATeam_t.DOTA_TEAM_CUSTOM_1, DOTATeam_t.DOTA_TEAM_CUSTOM_2]),
            new Alliance("DOTA_ALLIANCE_LEGION", "blue", [DOTATeam_t.DOTA_TEAM_CUSTOM_3, DOTATeam_t.DOTA_TEAM_CUSTOM_4]),
            new Alliance("DOTA_ALLIANCE_VOID", "pink", [DOTATeam_t.DOTA_TEAM_CUSTOM_5, DOTATeam_t.DOTA_TEAM_CUSTOM_6]),
        ];
        //
    }
    static GetInstance() {
        if (!Alliances.instance) {
            Alliances.instance = new Alliances();
        }
        return Alliances.instance;
    }
    findAllianceByName(name) {
        return this.alliances.filter(alliance => alliance.name == name)[0];
    }
    findAllianceByTeam(team) {
        let returnAlliance = undefined;
        this.alliances.forEach((alliance) => {
            alliance.teams.forEach((allianceTeam) => {
                if (allianceTeam == team) {
                    returnAlliance = alliance;
                }
            });
        });
        return returnAlliance;
    }
}
Alliances.GetInstance();
