export enum CustomGameState {
  NONE = 0,
  PRE_WARMUP,
  WARMUP_IN_PROGRESS,
  PRE_ROUND,
  ROUND_IN_PROGRESS,
  PRE_RUN,
  RUN_IN_PROGRESS,
  POST_RUN,
}

export type AllianceData = {
  max_health: number;
  amethysts: number;
  health: number;
  score: number;
  name: string;
  shield: number;
};

export type TargetingIndicator = {
  Type: string;
  ModifierName?: string;
  ModifierType?: string;
  ModifierLength?: number;
  ModifierStacks?: number;
  DisplayRange?: number;
  Fixed?: number;
};

export interface UnitData {
  playerId?: PlayerID;
  entityIndex: EntityIndex;
  teamId: DOTATeam_t;
  health: number;
  maxHealth: number;
  shield: number;
  status: StatusTypes;
  hideWhenNotHurt?: boolean;
  beenHurt: 0 | 1;
}

export interface HeroData extends UnitData {
  playerId: PlayerID;
  allianceName: string;
  name: string;
  treshold: number;
  mana: number;
  maxMana: number;
  recast: RecastTypes;
  stackbars: string;
  charges: string;
  cooldown: string;
  energy: number;
  maxEnergy: number;
  energyPerCell?: number;
  abilities: {
    [key: string]: {
      name: string;
      level: number;
    };
  };
}

export type StatusTypes = {
  [modifierName: string]: StatusType;
};

export type RecastTypes = {
  [modifierName: string]: RecastType;
};

export type RecastType = {
  ability_name: string;
  key: string;
  modifier_name: string;
};

export type StatusType = {
  scope: number;
  trigger: number;
  label: string;
  modifier_name: string;
  content: number;
  priority: number;
  style_name: string;
  max_stacks?: number;
};
