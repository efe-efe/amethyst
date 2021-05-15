import Alliance from './alliance';
import { Centaur, DireZombie, Queen, CustomAI, DireZombieRager } from './custom_ai';
import GameState, { CustomGameState } from './game_state';

export interface WaveGroup {
    name: NPCNames;
    ammount: number;
}

export enum NPCNames {
    DIRE_ZOMBIE = 'DireZombie',
    DIRE_ZOMBIE_RAGER = 'DireZombieRager',
    QUEEN = 'Queen',
    CENTAUR = 'Centaur',
}

const NPCFactories = {
    [NPCNames.DIRE_ZOMBIE]: (origin: Vector): CustomAI => {
        return new DireZombie(origin);
    },
    [NPCNames.DIRE_ZOMBIE_RAGER]: (origin: Vector): CustomAI => {
        return new DireZombieRager(origin);
    },
    [NPCNames.QUEEN]: (origin: Vector): CustomAI => {
        return new Queen(origin);
    },
    [NPCNames.CENTAUR]: (origin: Vector): CustomAI => {
        return new Centaur(origin);
    }
};

export default class Wave extends GameState{
    helper = 3.0 * 30;
    npcs: CustomAI[] = [];
    wavesInfo: WaveGroup[][];
    aliveNpcs = 0;

    constructor(alliances: Alliance[], duration: number, wavesInfo: WaveGroup[][]){
        super(alliances, duration);
        this.wavesInfo = wavesInfo;

        wavesInfo.forEach(waveInfo => {
            waveInfo.forEach(waveGroup => {
                for(let i = 0; i < waveGroup.ammount; i++){
                    const x = RandomInt(-1500, 1500);
                    const y = RandomInt(-1500, 1500);
                    const npc = NPCFactories[waveGroup.name](Vector(x, y, 128));
                    this.npcs.push(npc);
                    this.aliveNpcs = this.aliveNpcs + 1;
                }
            });
        });
    }

    OnUnitDies(unit: CDOTA_BaseNPC): void{
        const previousNpcs = this.npcs.length;
        this.npcs = this.npcs.filter(npc => npc.unit !== unit);
        if(previousNpcs > this.npcs.length){
            this.aliveNpcs = this.aliveNpcs - 1;
        }
    }

    Update(): void{
        super.Update();

        this.npcs.forEach((npc) => {
            npc.Update();
        });

        if(this.aliveNpcs <= 0){
            this.EndWave();
        }
    }

    EndWave(): void{
        GameRules.Addon.SetState(CustomGameState.PRE_WAVE);
    }
}