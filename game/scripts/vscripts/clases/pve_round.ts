import Alliance from './alliance';
import { Centaur, Queen } from './boss';
import GameState, { CustomGameState } from './game_state';

export default class PveRound extends GameState{
    boss: any;
    helper = 3.0 * 30;

    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
        //this.npc = DireZombie(Vector(150, 0, 128))
        this.boss = new Queen(Vector(150, 0, 128));
    }

    Update(): void{
        super.Update();
        //this.npc:Update()

        if(this.boss){
            if(this.helper == 0){
                this.boss.Update();
            } else {
                this.helper = this.helper - 1;
            }
        }
    }

    PveRound(): void{
        GameRules.Addon.SetState(CustomGameState.NONE);
    }
}
