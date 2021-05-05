import Alliance from './alliance';
import { Centaur, DireZombie, Queen, CustomNPC } from './custom_npc';
import GameState, { CustomGameState } from './game_state';

export interface WaveGroup {
    name: NPCNames;
    ammount: number;
}

export enum NPCNames {
    DIRE_ZOMBIE = 'DireZombie',
    QUEEN = 'Queen',
    CENTAUR = 'Centaur',
}

const NPCFactories = {
    [NPCNames.DIRE_ZOMBIE]: (origin: Vector): CustomNPC => {
        return new DireZombie(origin);
    },
    [NPCNames.QUEEN]: (origin: Vector): CustomNPC => {
        return new Queen(origin);
    },
    [NPCNames.CENTAUR]: (origin: Vector): CustomNPC => {
        return new Centaur(origin);
    }
};

export default class Wave extends GameState{
    helper = 3.0 * 30;
    npcs: CustomNPC[] = [];
    waveGroups: WaveGroup[];
    aliveNpcs = 0;

    constructor(alliances: Alliance[], duration: number, waveGroups: WaveGroup[]){
        super(alliances, duration);
        this.waveGroups = waveGroups;

        waveGroups.forEach(waveGroup => {
            for(let i = 0; i < waveGroup.ammount; i++){
                const x = RandomInt(0, 2500);
                const y = RandomInt(0, 2500);
                const npc = NPCFactories[waveGroup.name](Vector(x, y, 128));
                this.npcs.push(npc);
                this.aliveNpcs = this.aliveNpcs + 1;
            }
        });
    }

    Update(): void{
        super.Update();

        if(this.helper == 0){
            this.npcs.forEach((npc) => {
                if(npc.GetUnit() && !npc.GetUnit().IsNull() && npc.GetUnit().IsAlive()){
                    npc.Update();
                }
            });
        } else {
            this.helper = this.helper - 1;
        }

        if(this.aliveNpcs <= 0){
            this.EndWave();
        }
    }

    EndWave(): void{
        GameRules.Addon.SetState(CustomGameState.PRE_WAVE);
    }
}