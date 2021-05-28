import { CustomAIMeta, CustomAITier, NPCNames } from './custom_ai';
import Room, { Wave } from './room';
import GameState from '../game_state';
import Alliance from '../alliance';
import Run from './run';

export interface StageData {
    possibleNPCs: NPCNames[];
}

enum RoomType {
    REGULAR = 0,
    BOSS,
    BONUS,
}

const mobsDistribution: {
    base: number;
    optional: number;
    tier: CustomAITier;
}[][] = [[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 1, },
    { tier: CustomAITier.MID,       base: 0,    optional: 0, }
],[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 2, },
    { tier: CustomAITier.MID,       base: 0,    optional: 0, }
],[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 1, },
    { tier: CustomAITier.MID,       base: 1,    optional: 0, }
],[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 1, },
    { tier: CustomAITier.MID,       base: 1,    optional: 1, },
],[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 1, },
    { tier: CustomAITier.MID,       base: 1,    optional: 1, },
    { tier: CustomAITier.HIGH,      base: 1,    optional: 0, }
],[
    { tier: CustomAITier.BASIC,     base: 4,    optional: 2, },
    { tier: CustomAITier.MID,       base: 1,    optional: 1, },
    { tier: CustomAITier.HIGH,      base: 2,    optional: 0, }
],[
    { tier: CustomAITier.BASIC,     base: 2,    optional: 1, },
    { tier: CustomAITier.MID,       base: 2,    optional: 1, },
    { tier: CustomAITier.HIGH,      base: 3,    optional: 0, }
],[
    { tier: CustomAITier.BOSS,      base: 1,    optional: 0, },
]];

export default class Stage extends GameState{
    possibleNPCs: NPCNames[];
    run: Run;
    rooms: number;
    room: Room | undefined;
    currentRoom = 0;

    constructor(alliances: Alliance[], stageData: StageData, run: Run){
        super(alliances, -1);
        this.run = run;
        this.possibleNPCs = stageData.possibleNPCs;
        this.rooms = RandomInt(6, 8);
        this.SendDataToClient();
    }

    SendDataToClient(): void{
        const tableName = 'main' as never;
        const data = { 
            currentRoom: this.currentRoom + 1, 
        } as never;
        CustomNetTables.SetTableValue(tableName, 'stage', data);
    }

    Update(): void{
        super.Update();
        if(this.room){
            this.room.Update();
        } else {
            if(this.currentRoom < this.rooms){
                const roomType = (this.currentRoom === this.rooms - 2) ? RoomType.BOSS : (this.currentRoom === 0) ? RoomType.BONUS : RoomType.REGULAR;
                this.room = this.GenerateRoom(roomType);
            } else {
                this.End();
            }
        }
    }

    GenerateRoom(roomType: RoomType): Room{
        if(roomType === RoomType.BOSS){
            const waves = [{
                npcs: [this.possibleNPCs[this.possibleNPCs.length - 1]],
            }];

            return new Room(this.alliances, -1, waves, this);
        }
        if(roomType === RoomType.BONUS){
            return new Room(this.alliances, -1, [{ npcs: [] }], this);
        }
        if(RandomInt(1, 100) < 5){
            return new Room(this.alliances, -1, [{ npcs: [] }], this);
        }
        return new Room(this.alliances, -1, this.GenerateWaves(), this);
    }

    GenerateWave(): Wave{
        const wave: Wave = {
            npcs: []
        };

        const distribution = mobsDistribution[this.currentRoom];
        distribution.forEach((mobTier) => {
            const npcs = this.GetAllNpcsOfTier(mobTier.tier);
            const index = RandomInt(0, npcs.length - 1);

            for(let i = 0; i < mobTier.base; i++){
                wave.npcs.push(npcs[index]);
            }
            
            for(let i = 0; i < mobTier.optional; i++){
                if(RandomInt(1,2) === 1){
                    wave.npcs.push(npcs[index]);
                }
            }
        });

        return wave;
    }

    GenerateWaves(): Wave[]{
        const amount = RandomInt(1, 3);
        const waves: Wave[] = [];
        for(let i = 0; i < amount; i++){
            waves.push(this.GenerateWave());
        }

        return waves;
    }

    GetAllNpcsOfTier(tier: CustomAITier): NPCNames[]{
        return this.possibleNPCs.filter((npc) => (CustomAIMeta[npc].tier === tier));
    }

    OnUnitHurt(unit: CDOTA_BaseNPC): void{
        if(this.room){
            this.room.OnUnitHurt(unit);
        }
    }

    OnUnitDies(unit: CDOTA_BaseNPC): void{
        if(this.room){
            this.room.OnUnitDies(unit);
        }
    }

    OnRoomCompleted(): void{
        this.currentRoom++;
        this.room = undefined;
        this.SendDataToClient();
    }

    OnHeroUpgrade(): void{
        if(this.room){
            this.room.OnHeroUpgrade();
        }
    }

    End(): void{
        this.run.OnStageEnd();
    }
}


