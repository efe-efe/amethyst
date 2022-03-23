import Player from "./player";

const ALLIANCE_NAMES: {[key: number]: string} = {
    [0]: "DOTA_NO_ALLIANCE",
    [1]: "DOTA_ALLIANCE_RADIANT",
    [2]: "DOTA_ALLIANCE_DIRE",
    [3]: "DOTA_ALLIANCE_LEGION",
    [4]: "DOTA_ALLIANCE_VOID",
};

export default class Alliance{
    teams: DotaTeam[];
    number: number;
    name: string;
    players: Player[] = [];
    amethysts = 0; //change to gems
    wins = 0;
    active = false;

    constructor(allianceNumber: keyof {[key: number]: string}, teams: DotaTeam[]){
        this.teams = teams;
        this.number = allianceNumber;
        this.name = ALLIANCE_NAMES[this.number];
    }

    SendDataToClient(): void{
        if(this.active){
            const data = {
                health: this.GetCurrentHealth(),
                max_health:  this.GetMaxHealth(),
                shield:  this.GetShield(),
                name:  this.name,
                amethysts:  this.amethysts,
                score:  this.wins,
            } as never;

            const tableName = "alliances" as never;
            CustomNetTables.SetTableValue(tableName, this.name, data);
        }
    }

    GetCurrentHealth(): number{
        let current = 0;

        this.players.forEach((player) => {
            const hero = player.hero;
            if (hero){
                current = current + hero.GetHealth();
            }
        });

        return current;
    }

    SetAmethysts(amethysts: number): void{
        this.amethysts = amethysts;
        this.SendDataToClient();
    }

    GetMaxHealth(): number{
        let max = 0;

        this.players.forEach((player) => {
            const hero = player.hero;
            if(hero){
                max = max + hero.GetMaxHealth();
            }
        });

        return max;
    }

    GetShield(): number{
        let current = 0;

        this.players.forEach((player) => {
            const hero = player.hero;
            if(hero){
                current = current + CustomEntitiesLegacy.GetShield(hero);
            }
        });

        return current;
    }

    GetAmethysts(): number{
        return this.amethysts;
    }

    GetPlayers(): Player[]{
        return this.players;
    }

    AddPlayer(player: Player): void{
        this.players.push(player);
        if(!this.active){
            this.active = true;
        }
        
        this.SendDataToClient();
    }

    GetName(): string{
        return this.name;
    }

    GetScore(): number{
        return this.wins;
    }

    SetScore(score: number): void{
        this.wins = score;
        this.SendDataToClient();
    }

    AddAmethsyt(): void{
        this.SetAmethysts(this.GetAmethysts() + 1);
    }

    IsActive(): boolean{
        return this.active;
    }
}