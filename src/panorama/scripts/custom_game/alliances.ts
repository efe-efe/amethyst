class Alliance {
  name: string;
  color:
    | "local"
    | "yellow"
    | "lightgreen"
    | "pink"
    | "orange"
    | "blue"
    | "gray";
  teams: DOTATeam_t[];

  constructor(
    name: string,
    color: "yellow" | "lightgreen" | "pink" | "orange" | "blue" | "gray",
    teams: DOTATeam_t[]
  ) {
    this.name = name;
    this.color = color;
    this.teams = teams;
  }

  GetName(): string {
    return this.name;
  }

  IsLocal(): boolean {
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

  GetColor():
    | "local"
    | "yellow"
    | "lightgreen"
    | "pink"
    | "orange"
    | "blue"
    | "gray" {
    return this.IsLocal() ? "local" : this.color;
  }
}

export default class Alliances {
  private static instance: Alliances;
  private alliances: Alliance[] = [
    new Alliance("DOTA_ALLIANCE_RADIANT", "orange", [
      DOTATeam_t.DOTA_TEAM_GOODGUYS,
      DOTATeam_t.DOTA_TEAM_BADGUYS,
    ]),
    new Alliance("DOTA_ALLIANCE_DIRE", "yellow", [
      DOTATeam_t.DOTA_TEAM_CUSTOM_1,
      DOTATeam_t.DOTA_TEAM_CUSTOM_2,
    ]),
    new Alliance("DOTA_ALLIANCE_LEGION", "blue", [
      DOTATeam_t.DOTA_TEAM_CUSTOM_3,
      DOTATeam_t.DOTA_TEAM_CUSTOM_4,
    ]),
    new Alliance("DOTA_ALLIANCE_VOID", "pink", [
      DOTATeam_t.DOTA_TEAM_CUSTOM_5,
      DOTATeam_t.DOTA_TEAM_CUSTOM_6,
    ]),
  ];

  private constructor() {
    //
  }

  public static GetInstance(): Alliances {
    if (!Alliances.instance) {
      Alliances.instance = new Alliances();
    }

    return Alliances.instance;
  }

  public findAllianceByName(name: string): Alliance | undefined {
    return this.alliances.filter((alliance) => alliance.name == name)[0];
  }

  public findAllianceByTeam(team: DOTATeam_t): Alliance | undefined {
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
