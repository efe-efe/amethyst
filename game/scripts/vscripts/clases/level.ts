import Alliance from './alliance';
import { CustomAI, CustomAIFactories, NPCNames } from './custom_ai';
import GameState, { CustomGameState } from './game_state';

export interface NPCGroup {
    name: NPCNames;
    ammount: number;
}

export interface ILevel{
    waves: Wave[];
    totalNpcs: number;
    currentLevel: number;
}
export interface Wave {
    npcGroups: NPCGroup[];
    totalNpcs: number
} 
export default class Level extends GameState{
    helper = 3.0 * 30;
    ais: CustomAI[] = [];
    level: ILevel;
    remainingTotalNpcs: number;
    remainingWaveNpcs: number;
    currentWave = 0;

    constructor(alliances: Alliance[], duration: number, level: ILevel){
        super(alliances, duration);
        this.level = level;
        this.remainingTotalNpcs = level.totalNpcs;
        this.remainingWaveNpcs = this.level.waves[this.currentWave].totalNpcs;
        this.StartWave(this.currentWave);
        this.SendDataToClient();
    }

    SendDataToClient(): void{
        const tableName = 'main' as never;
        const data = { 
            remainingEnemies: this.level.totalNpcs - this.remainingTotalNpcs,
            currentLevel: this.level.currentLevel + 1, 
            maxEnemies: this.level.totalNpcs
        } as never;
        CustomNetTables.SetTableValue(tableName, 'level', data);
    }

    StartWave(waveNumber: number): void{
        this.remainingWaveNpcs = this.level.waves[waveNumber].totalNpcs;
        this.level.waves[waveNumber].npcGroups.forEach(npcGroup => {
            for(let i = 0; i < npcGroup.ammount; i++){
                const x = RandomInt(-1500, 1500);
                const y = RandomInt(-1500, 1500);
                const ai = CustomAIFactories[npcGroup.name](Vector(x, y, 128));
                this.ais.push(ai);
                EFX('particles/ai_spawn.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, ai.unit, {
                    release: true,
                });
            }
        });
    }

    OnUnitDies(unit: CDOTA_BaseNPC): void{
        const previousNpcs = this.ais.length;
        this.ais = this.ais.filter(ai => ai.unit !== unit);
        if(previousNpcs > this.ais.length){
            this.remainingWaveNpcs--;
            this.remainingTotalNpcs--;
        }
        this.SendDataToClient();
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

        if(this.remainingWaveNpcs <= 0){
            if(this.currentWave === this.level.waves.length - 1){
                this.EndLevel();
            } else {
                this.currentWave++;
                this.StartWave(this.currentWave);
            }
        }
    }

    SkipWave(): void{
        this.ais.forEach((ai) => {
            if(ai.unit.IsAlive()){
                ai.unit.ForceKill(false);
            }
        });
    }

    SkipLevel(): void{
        this.currentWave = this.level.waves.length - 1;
        this.SkipWave();
    }
    
    EndLevel(): void{
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                customNpc.RequestUpgrades();
            }
        });

        GameRules.Addon.SetState(CustomGameState.PRE_LEVEL);
    }
}