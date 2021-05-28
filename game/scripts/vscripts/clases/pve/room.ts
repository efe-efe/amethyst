import Alliance from '../alliance';
import { CustomAI, CustomAIMeta, NPCNames } from './custom_ai';
import GameState from '../game_state';
import Stage from './stage';
import settings from '../../settings';
import Upgrades from '../../upgrades/upgrades';
import { CustomEvents } from '../../custom_events';
import { RewardTypes } from '../../rewards/rewards';

export interface RoomData{
    waves: Wave[];
}
export interface Wave {
    npcs: NPCNames[];
}
export interface Spawn {
    delayTime: number;
    remainingTime: number;
    origin: Vector;
    name: number;
    marker: CDOTA_Buff | undefined;
}
export default class Room extends GameState{
    stage: Stage;
    favorsDelay = 1 * 30;
    rewardsDelay = -1;
    spawnQueue: Spawn[] = []; 
    ais: CustomAI[] = [];
    waves: Wave[];
    totalNpcs: number;
    remainingTotalNpcs: number;
    remainingWaveNpcs = 0;
    currentWave = 0;

    constructor(alliances: Alliance[], duration: number, waves: Wave[], stage: Stage){
        super(alliances, duration);
        this.waves = waves;
        this.totalNpcs = this.GetTotalNPCs(waves);
        this.remainingTotalNpcs = this.totalNpcs;
        this.stage = stage;
        this.StartWave(this.currentWave);
        this.SendDataToClient();

        const customEvents = CustomEvents.GetInstance();
        customEvents.RegisterListener('pve:apply_favor', () => {
            this.OnFavorApplied();
        });
        customEvents.RegisterListener('pve:reward_selected', () => {
            this.OnRewardSelected();
        });
    }
    
    SendDataToClient(): void{
        const tableName = 'main' as never;
        const data = { 
            remainingEnemies: this.totalNpcs - this.remainingTotalNpcs,
            maxEnemies: this.totalNpcs
        } as never;
        CustomNetTables.SetTableValue(tableName, 'stage', data);
    }

    StartWave(waveNumber: number): void{
        const wave = this.waves[waveNumber];
        this.remainingWaveNpcs = wave.npcs.length;
        wave.npcs.forEach(npc => {
            const x = RandomInt(-1500, 1500);
            const y = RandomInt(-1500, 1500);
            const origin = Vector(x, y, 128);
            this.SchedulAiSpawn(origin, npc, 1.0);
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

    OnRewardSelected(): void{
        let rewardsReady = true;
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                if(customNpc.IsSelectingReward()){
                    rewardsReady = false;
                }
            }
        });
        
        if(rewardsReady){
            this.SetDuration(settings.PreStageDuration);
        }
    }

    OnFavorApplied(): void{
        let favorsReady = true;
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                if(customNpc.IsSelectingFavor()){
                    favorsReady = false;
                }
            }
        });
        
        if(favorsReady){
            this.rewardsDelay = 2 * 30;
        }
    }

    Update(): void{
        super.Update();

        if(this.remainingWaveNpcs <= 0){
            if(this.currentWave === this.waves.length - 1){
                if(this.favorsDelay === 0){
                    this.GenerateFavors();
                    this.favorsDelay = this.favorsDelay - 1;
                }
                if(this.favorsDelay > 0){
                    this.favorsDelay = this.favorsDelay - 1;
                }

                if(this.rewardsDelay === 0){
                    this.GenerateBounties();
                    this.rewardsDelay = this.rewardsDelay - 1;
                }
                if(this.rewardsDelay > 0){
                    this.rewardsDelay = this.rewardsDelay - 1;
                }

                if(this.time_remaining === 0){
                    this.End();
                }
            } else {
                this.IncrementWave();
            }
        } else {
            this.spawnQueue.forEach((scheduledSpawn) => {
                if(scheduledSpawn.remainingTime > 0){
                    scheduledSpawn.remainingTime = scheduledSpawn.remainingTime - 1;
                } else {
                    const ai = CustomAIMeta[scheduledSpawn.name].factory(scheduledSpawn.origin);
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
        }
    }

    GenerateFavors(): void{
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                if(customNpc.reward && customNpc.reward.type === RewardTypes.FAVOR){
                    customNpc.RequestFavors();
                }
                if(customNpc.reward && customNpc.reward.type === RewardTypes.ENHANCEMENT){
                    customNpc.RequestEnhancements();
                }
                if(customNpc.reward && customNpc.reward.type === RewardTypes.TARRASQUE){
                    const regenerationUpgrade = Upgrades.filter((upgrade) => upgrade.id === 'restore_health')[0];
                    customNpc.ApplyFavor(regenerationUpgrade);
                }
            }
        });
    }

    GenerateBounties(): void{
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                customNpc.RequestBounties();
            }
        });
    }

    IncrementWave(): void{
        this.currentWave++;
        this.StartWave(this.currentWave);
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
        this.currentWave = this.waves.length - 1;
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

    GetTotalNPCs(waves: Wave[]): number{
        return waves.reduce((a, wave) => a + wave.npcs.length, 0);
    }
    
    End(): void{
        this.stage.OnRoomCompleted();
    }
}