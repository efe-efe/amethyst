import Alliance from './alliance';
import { CustomPlayerHeroNPC } from './custom_npc';

export default class Player{
    id: PlayerID;
    userid: number;
    hero: CDOTA_BaseNPC_Hero | undefined = undefined;
    alliance: Alliance | undefined = undefined;
    customNpc: CustomPlayerHeroNPC | undefined = undefined;
    team = DotaTeam.NOTEAM;
    cursor_position = Vector(0,0,0);

    constructor(id: PlayerID, userid: number){
        this.id = id;
        this.userid = userid;
    }

    SetHero(hero: CDOTA_BaseNPC_Hero): void{
        this.hero = hero;
        CustomEntitiesLegacy.SendDataToClient(hero);
    }

    SetCustomNPC(customNpc: CustomPlayerHeroNPC): void{
        this.customNpc = customNpc;
    }
    
    GetId(): PlayerID{
        return this.id;
    }

    GetCursorPosition(): Vector{
        return this.cursor_position;
    }
    
    SetTeam(team: DotaTeam): void{
        this.team = team;
    }
    
    SetAlliance(alliance: Alliance): void{
        this.alliance = alliance;
    }
    
    UpdateCursorPosition(position: Vector): void{
        this.cursor_position = position;
    }
}