import Alliance from './alliance';
import Player from './player';

export enum CustomGameState {
    NONE = 0,
    PRE_WARMUP,
    WARMUP_IN_PROGRESS,
    PRE_ROUND,
    ROUND_IN_PROGRESS,
    PRE_LEVEL,
    LEVEL_IN_PROGRESS,
}

export default class GameState{
    alliances: Alliance[];
    time_remaining: number;
    max_duration: number;

    constructor(alliances: Alliance[], duration: number){
        this.alliances = alliances;
        this.time_remaining = duration * 30;
        this.max_duration = duration;
    }

    Update(): void{
        if(this.time_remaining > 0){
            this.time_remaining = this.time_remaining - 1;
        }
    }

    GetAllPlayers(): Player[]{
        const players: Player[] = [];
        if(this.alliances){
            this.alliances.forEach((alliance) => {
                alliance.players.forEach((player) => {
                    players.push(player);
                });
            });
        }

        return players;
    }

    GetDuration(): number{
        return math.floor(this.time_remaining/30);
    }

    SetDuration(duration: number): void{
        this.time_remaining = duration * 30;
    }

    UpdateGameTimer(time: number): void{
        const minutes = math.floor(time / 60);
        const seconds = time - (minutes * 60);
        const m10 = math.floor(minutes / 10);
        const m01 = minutes - (m10 * 10);
        const s10 = math.floor(seconds / 10);
        const s01 = seconds - (s10 * 10);
        const broadcast_gametimer = {
            timer_minute_10: m10,
            timer_minute_01: m01,
            timer_second_10: s10,
            timer_second_01: s01,
        } as never;
    
        CustomGameEventManager.Send_ServerToAllClients('countdown', broadcast_gametimer);
    }
}
