import Alliance from '../alliance';
import { CustomAI, CustomAIMeta, NPCNames } from './custom_ai';
import GameState from '../game_state';
import Stage from './stage';
import settings from '../../settings';
import { CustomEvents } from '../../custom_events';
import { Reward, RewardsManager } from '../../rewards/rewards';
import { Diamond } from '../gem';
import CustomNPC from './custom_npc';
import BreakableBounty from '../breakable_bounty';

export enum RoomType {
    REGULAR = 0,
    FIRST_ROOM,
    LEVELUP,
    BOSS,
    BONUS,
}

export enum RoomPhases {
    DIAMOND = 0,
    WAVES,
    REWARD_CLAIM,
    REWARD_OFFERING,
}

export interface RoomHeroData {
    customNpc: CustomNPC;
    nextRewardOfferings: Reward[];
    currentReward: Reward;
}

export interface RoomOptions{
    waves: Wave[];
    spawnDiamond: boolean;
    heroesData: RoomHeroData[];
    phases: RoomPhases[];
    type: RoomType;
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
    claimRewardsDelay = 1 * 30;
    rewardsMenuDelay = 2 * 30;
    spawnQueue: Spawn[] = []; 
    ais: CustomAI[] = [];
    waves: Wave[];
    totalNpcs: number;
    remainingTotalNpcs: number;
    remainingWaveNpcs = 0;
    currentWave = -1;
    diamond: Diamond | undefined;
    heroesData: RoomHeroData[];
    rewardEntities: BreakableBounty[] = [];
    phases: RoomPhases[] = [];
    phaseIndex = 0;
    type: RoomType;

    constructor(alliances: Alliance[], duration: number, stage: Stage, options: RoomOptions){
        super(alliances, duration);
        this.waves = options.waves;
        this.totalNpcs = this.GetTotalNPCs(this.waves);
        this.remainingTotalNpcs = this.totalNpcs;
        this.stage = stage;
        this.heroesData = options.heroesData;
        this.phases = options.phases;
        this.phaseIndex = 0;
        this.type = options.type;
        this.SendDataToClient();

        const customEvents = CustomEvents.GetInstance();
        customEvents.RegisterListener('pve:current_reward_applied', () => {
            this.OnRewardApplied();
        });
        customEvents.RegisterListener('pve:next_reward_selected', () => {
            this.OnRewardSelected();
        });

        ListenToGameEvent('entity_killed', (event) => this.OnUnitDies(event), undefined);
        ListenToGameEvent('entity_hurt', (event) => this.OnUnitHurt(event), undefined);
    }
    
    SendDataToClient(): void{
        const data = { 
            remainingEnemies: this.totalNpcs - this.remainingTotalNpcs,
            maxEnemies: this.totalNpcs,
            roomPhases: this.phases.map(phase => (RoomPhases[phase])),
            roomPhaseIndex: this.phaseIndex,
            roomType: RoomType[this.type],
        } as never;
        CustomNetTables.SetTableValue('main' as never, 'pve', data);
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

    OnUnitDies(event: EntityKilledEvent): void{
        const killed = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;

        const previousNpcs = this.ais.length;
        this.ais = this.ais.filter(ai => ai.unit !== killed);
        if(previousNpcs > this.ais.length){
            this.remainingWaveNpcs--;
            this.remainingTotalNpcs--;
            EFX('particles/econ/events/new_bloom/dragon_death.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, killed, {
                release: true,
            });
        }
        this.SendDataToClient();
    }

    OnUnitHurt(event: EntityHurtEvent): void{
        const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
        const ai = this.ais.filter(ai => ai.unit === victim)[0];
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
        
        if(rewardsReady && this.phases[this.phaseIndex] === RoomPhases.REWARD_OFFERING){
            this.IncrementPhase();
        }
    }

    OnRewardApplied(): void{
        let upgradesReady = true;
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                if(customNpc.IsSelectingUpgrade()){
                    upgradesReady = false;
                }
            }
        });
        
        if(upgradesReady && this.phases[this.phaseIndex] === RoomPhases.REWARD_CLAIM){
            this.IncrementPhase();
        }
    }

    Update(): void{
        super.Update();
        const currentPhase = this.phases[this.phaseIndex];

        if(currentPhase === RoomPhases.DIAMOND){
            this.UpdateDiamond();
        }
        if(currentPhase === RoomPhases.WAVES){
            this.UpdateWaves();
        }
        if(currentPhase === RoomPhases.REWARD_CLAIM){
            this.UpdateRewardClaim();
        }
        if(currentPhase === RoomPhases.REWARD_OFFERING){
            this.UpdateRewardOffering();
        }
        if(this.time_remaining === 0){
            this.End();
        }
    }

    UpdateDiamond(): void{
        if(!this.diamond){
            this.diamond = new Diamond(Vector(0, 0, 300));
        } else {
            if(this.diamond.unit.IsAlive()){
                this.diamond.Update();
            } else {
                this.diamond = undefined;
                this.IncrementPhase();
            }
        }
    }

    UpdateWaves(): void{
        if(this.currentWave === -1){
            this.IncrementWave();
        }        

        if(this.remainingWaveNpcs <= 0){
            if(this.currentWave === this.waves.length - 1){
                this.IncrementPhase();
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

    UpdateRewardClaim(): void{
        if(this.claimRewardsDelay === 0){
            this.ClaimRewards();
            this.claimRewardsDelay = this.claimRewardsDelay - 1;
        } else if(this.claimRewardsDelay > 0){
            this.claimRewardsDelay = this.claimRewardsDelay - 1;
        }
        this.rewardEntities.forEach((rewardEntity) => {
            rewardEntity.Update();
        });
    }

    UpdateRewardOffering(): void{
        if(this.rewardsMenuDelay === 0){
            this.OfferRewards();
            this.rewardsMenuDelay = this.rewardsMenuDelay - 1;
        } else if(this.rewardsMenuDelay > 0){
            this.rewardsMenuDelay = this.rewardsMenuDelay - 1;
        }
    }

    OfferRewards(): void{
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            const heroData = this.heroesData.filter((heroData) => heroData.customNpc === customNpc)[0];
            if(customNpc && heroData){
                RewardsManager.OfferRewardsForHero(customNpc, heroData.nextRewardOfferings);
            }
        });
    }

    ClaimRewards(): void{
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc && customNpc.reward){
                const rewardEntity = RewardsManager.ClaimRewardForHero(customNpc, customNpc.reward);
                if(rewardEntity){
                    this.rewardEntities.push(rewardEntity);
                }
            }
        });
    }

    IncrementPhase(): void{
        this.phaseIndex++;
        if(!this.phases[this.phaseIndex]){
            this.SetDuration(settings.PreStageDuration);
        }
        this.SendDataToClient();
    }

    IncrementWave(): void{
        this.currentWave++;
        this.StartWave(this.currentWave);
        this.SendDataToClient();
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