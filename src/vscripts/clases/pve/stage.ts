import { CustomAIMeta, CustomAITier, NPCNames } from "./custom_ai";
import Room, { RoomHeroData, RoomPhases, RoomType, Wave } from "./room";
import GameState from "../game_state";
import Alliance from "../alliance";
import Run from "./run";
import { RewardsManager } from "../../rewards/rewards";

export interface StageData {
    possibleNPCs: NPCNames[];
}

const mobsDistribution: {
    base: number;
    optional: number;
    tier: CustomAITier;
}[][] = [
    [
        { tier: CustomAITier.BASIC, base: 5, optional: 1 },
        { tier: CustomAITier.MID, base: 0, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 4, optional: 2 },
        { tier: CustomAITier.MID, base: 0, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 4, optional: 1 },
        { tier: CustomAITier.MID, base: 1, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 4, optional: 1 },
        { tier: CustomAITier.MID, base: 1, optional: 1 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 4, optional: 1 },
        { tier: CustomAITier.MID, base: 1, optional: 1 },
        { tier: CustomAITier.HIGH, base: 1, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 4, optional: 2 },
        { tier: CustomAITier.MID, base: 1, optional: 1 },
        { tier: CustomAITier.HIGH, base: 2, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 2, optional: 1 },
        { tier: CustomAITier.MID, base: 2, optional: 1 },
        { tier: CustomAITier.HIGH, base: 3, optional: 0 }
    ],
    [
        { tier: CustomAITier.BASIC, base: 2, optional: 1 },
        { tier: CustomAITier.MID, base: 2, optional: 1 },
        { tier: CustomAITier.HIGH, base: 3, optional: 0 }
    ]
];

export default class Stage extends GameState {
    possibleNPCs: NPCNames[];
    run: Run;
    room: Room | undefined;
    totalNpcRooms: number;
    currentRoomNumber = 0;
    currentNpcRoomNumber = 0;

    constructor(alliances: Alliance[], stageData: StageData, run: Run) {
        super(alliances, -1);
        this.run = run;
        this.possibleNPCs = stageData.possibleNPCs;
        this.totalNpcRooms = RandomInt(6, 8);
        this.SendDataToClient();
    }

    SendDataToClient(): void {
        const tableName = "main" as never;
        const data = {
            currentRoom: this.currentNpcRoomNumber + 1
        } as never;
        CustomNetTables.SetTableValue(tableName, "pve", data);
    }

    Update(): void {
        super.Update();
        if (this.room) {
            this.room.Update();
        } else {
            if (this.currentNpcRoomNumber < this.totalNpcRooms) {
                const spawnDiamond = this.currentRoomNumber === 2 || this.currentRoomNumber === 6;
                this.room = this.GenerateRoom(spawnDiamond);
            } else {
                this.End();
            }
        }
    }

    GenerateRoomType(): RoomType {
        if (this.currentNpcRoomNumber === 0) {
            return RoomType.FIRST_ROOM;
        }
        if (this.currentNpcRoomNumber === this.totalNpcRooms - 1) {
            return RoomType.BOSS;
        }
        if (this.currentNpcRoomNumber === 3) {
            return RoomType.LEVELUP;
        }
        return RoomType.BOSS;
    }

    GenerateRoom(spawnDiamond: boolean): Room {
        const type = this.GenerateRoomType();

        return new Room(this.alliances, -1, this, {
            waves: this.GenerateWaves(type),
            spawnDiamond,
            heroesData: this.GenerateHeroesData(),
            type,
            phases: this.GeneratePhases(type)
        });
    }

    GeneratePhases(type: RoomType): RoomPhases[] {
        if (type === RoomType.FIRST_ROOM) {
            return [RoomPhases.REWARD_CLAIM, RoomPhases.WAVES, RoomPhases.REWARD_OFFERING];
        }

        if (type === RoomType.LEVELUP) {
            return [RoomPhases.DIAMOND, RoomPhases.WAVES, RoomPhases.REWARD_CLAIM, RoomPhases.REWARD_OFFERING];
        }

        return [RoomPhases.WAVES, RoomPhases.REWARD_CLAIM, RoomPhases.REWARD_OFFERING];
    }

    GenerateHeroesData(): RoomHeroData[] {
        const heroesData: RoomHeroData[] = [];

        this.GetAllPlayers().forEach(player => {
            const customNpc = player.customNpc;
            if (customNpc) {
                const nextRewardOfferings = RewardsManager.GenerateRewards(customNpc, {
                    amount: this.GetRewardsAmount()
                });

                const currentReward = customNpc.reward;
                if (currentReward) {
                    heroesData.push({
                        customNpc,
                        nextRewardOfferings,
                        currentReward
                    });
                }
            }
        });

        return heroesData;
    }

    GetRewardsAmount(): number {
        const percentage = RandomInt(1, 100);

        if (percentage < 75) {
            return 1;
        }
        if (percentage >= 75 && percentage < 90) {
            return 2;
        }
        return 3;
    }

    GenerateWave(): Wave {
        const wave: Wave = {
            npcs: []
        };

        const distribution = mobsDistribution[this.currentNpcRoomNumber];
        distribution.forEach(mobTier => {
            const npcs = this.GetAllNpcsOfTier(mobTier.tier);

            for (let i = 0; i < mobTier.base; i++) {
                const index = RandomInt(0, npcs.length - 1);
                wave.npcs.push(npcs[index]);
            }

            for (let i = 0; i < mobTier.optional; i++) {
                const index = RandomInt(0, npcs.length - 1);
                if (RandomInt(1, 2) === 1) {
                    wave.npcs.push(npcs[index]);
                }
            }
        });

        return wave;
    }

    GenerateWaves(type: RoomType): Wave[] {
        if (type === RoomType.BONUS) {
            return [{ npcs: [] }];
        }
        if (type === RoomType.BOSS) {
            return [
                {
                    npcs: [this.possibleNPCs[this.possibleNPCs.length - 1]]
                }
            ];
        }

        let amount = RandomInt(2, 3);
        if (type === RoomType.FIRST_ROOM) {
            amount = 1;
        }

        const waves: Wave[] = [];
        for (let i = 0; i < amount; i++) {
            waves.push(this.GenerateWave());
        }

        return waves;
    }

    GetAllNpcsOfTier(tier: CustomAITier): NPCNames[] {
        return this.possibleNPCs.filter(npc => CustomAIMeta[npc].tier === tier);
    }

    OnRoomCompleted(): void {
        if (this.room) {
            if (
                this.room.type === RoomType.REGULAR ||
                this.room.type === RoomType.BOSS ||
                this.room.type === RoomType.LEVELUP ||
                this.room.type === RoomType.FIRST_ROOM
            ) {
                this.currentNpcRoomNumber++;
            }
            this.currentRoomNumber++;
        }
        this.room = undefined;
        this.SendDataToClient();
    }

    End(): void {
        this.run.OnStageEnd();
    }
}
