import Alliance from './alliance';
import { CustomAI, CustomAIFactories, NPCNames } from './custom_ai';
import GameState, { CustomGameState } from './game_state';

export interface WaveGroup {
    name: NPCNames;
    ammount: number;
}
export default class Wave extends GameState{
    helper = 3.0 * 30;
    ais: CustomAI[] = [];
    wavesInfo: WaveGroup[][];
    aliveAis = 0;

    constructor(alliances: Alliance[], duration: number, wavesInfo: WaveGroup[][]){
        super(alliances, duration);
        this.wavesInfo = wavesInfo;

        wavesInfo.forEach(waveInfo => {
            waveInfo.forEach(waveGroup => {
                for(let i = 0; i < waveGroup.ammount; i++){
                    const x = RandomInt(-1500, 1500);
                    const y = RandomInt(-1500, 1500);
                    const ai = CustomAIFactories[waveGroup.name](Vector(x, y, 128));
                    this.ais.push(ai);
                    this.aliveAis = this.aliveAis + 1;
                    EFX('particles/ai_spawn.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, ai.unit, {
                        release: true,
                    });
                }
            });
        });
    }

    OnUnitDies(unit: CDOTA_BaseNPC): void{
        const previousAis = this.ais.length;
        this.ais = this.ais.filter(ai => ai.unit !== unit);
        if(previousAis > this.ais.length){
            this.aliveAis = this.aliveAis - 1;
        }
    }

    OnUnitHurt(unit: CDOTA_BaseNPC): void{
        const ai = this.ais.filter(ai => ai.unit === unit)[0];
        if(ai){
            ai.OnHurt();
        }
    }

    Update(): void{
        super.Update();

        this.ais.forEach((ai) => {
            ai.Update();
        });

        if(this.aliveAis <= 0){
            this.EndWave();
        }
    }

    EndWave(): void{
        GameRules.Addon.SetState(CustomGameState.PRE_WAVE);
    }
}