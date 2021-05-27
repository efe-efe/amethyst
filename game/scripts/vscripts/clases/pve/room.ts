import Alliance from '../alliance';
import { CustomAI, CustomAIFactories, NPCNames } from './custom_ai';
import GameState, { CustomGameState } from '../game_state';

export interface NPCGroup {
    name: NPCNames;
    ammount: number;
}

export interface RoomData{
    waves: Wave[];
    totalNpcs: number;
    currentRoom: number;
}
export interface Wave {
    npcGroups: NPCGroup[];
    totalNpcs: number;
}

export interface Spawn {
    delayTime: number;
    remainingTime: number;
    origin: Vector;
    name: number;
    marker: CDOTA_Buff | undefined;
}
export default class Room extends GameState{
    remainingAfterTime = 3 * 30;
    spawnQueue: Spawn[] = []; 
    ais: CustomAI[] = [];
    roomData: RoomData;
    remainingTotalNpcs: number;
    remainingWaveNpcs: number;
    currentWave = 0;

    constructor(alliances: Alliance[], duration: number, roomData: RoomData){
        super(alliances, duration);
        this.roomData = roomData;
        this.remainingTotalNpcs = roomData.totalNpcs;
        this.remainingWaveNpcs = this.roomData.waves[this.currentWave].totalNpcs;
        this.StartWave(this.currentWave);
        this.SendDataToClient();
    }

    SendDataToClient(): void{
        const tableName = 'main' as never;
        const data = { 
            remainingEnemies: this.roomData.totalNpcs - this.remainingTotalNpcs,
            currentRoom: this.roomData.currentRoom + 1, 
            maxEnemies: this.roomData.totalNpcs
        } as never;
        CustomNetTables.SetTableValue(tableName, 'room', data);
    }

    StartWave(waveNumber: number): void{
        this.remainingWaveNpcs = this.roomData.waves[waveNumber].totalNpcs;
        this.roomData.waves[waveNumber].npcGroups.forEach(npcGroup => {
            for(let i = 0; i < npcGroup.ammount; i++){
                const x = RandomInt(-1500, 1500);
                const y = RandomInt(-1500, 1500);
                const origin = Vector(x, y, 128);
                this.SchedulAiSpawn(origin, npcGroup.name, 1.0);
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

        this.spawnQueue.forEach((scheduledSpawn) => {
            if(scheduledSpawn.remainingTime > 0){
                scheduledSpawn.remainingTime = scheduledSpawn.remainingTime - 1;
            } else {
                const ai = CustomAIFactories[scheduledSpawn.name](scheduledSpawn.origin);
                this.ais.push(ai);
                EFX('particles/ai_spawn.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, ai.unit, {
                    release: true,
                });

                this.spawnQueue = this.spawnQueue.filter((spawn) => { spawn !== scheduledSpawn; });
            }
        });

        this.ais.forEach((ai) => {
            ai.Update();
        });

        if(this.remainingWaveNpcs <= 0){
            if(this.currentWave === this.roomData.waves.length - 1){
                if(this.remainingAfterTime === 0){
                    this.End();
                }
                if(this.remainingAfterTime > 0){
                    this.remainingAfterTime = this.remainingAfterTime - 1;
                }
            } else {
                this.currentWave++;
                this.StartWave(this.currentWave);
            }
        }
    }

    SkipWave(): void{
        this.spawnQueue.forEach((scheduledSpawn) => {
            if(scheduledSpawn.marker){
                scheduledSpawn.marker.Destroy();
            }
            this.remainingWaveNpcs--;
            this.remainingTotalNpcs--;
        });
        this.ais.forEach((ai) => {
            if(ai.unit.IsAlive()){
                ai.unit.ForceKill(false);
            }
        });
    }

    SkipRoom(): void{
        this.currentWave = this.roomData.waves.length - 1;
        this.SkipWave();
    }

    SchedulAiSpawn(origin: Vector, name: number, delayTime: number): void{
        this.spawnQueue.push({
            delayTime: delayTime * 30,
            remainingTime: delayTime * 30,
            origin,
            name,
            marker: (CreateTimedRadiusMarker(undefined, origin, 150, delayTime, 0.2, RADIUS_SCOPE_PUBLIC) as CDOTA_BaseNPC).FindModifierByName('radius_marker_thinker'),
        });
    }
    
    End(): void{
        GameRules.Addon.SetState(CustomGameState.PRE_ROOM);
    }
}