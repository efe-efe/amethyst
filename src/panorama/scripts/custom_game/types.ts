export enum CustomGameState {
    NONE = 0,
    PRE_WARMUP,
    WARMUP_IN_PROGRESS,
    PRE_ROUND,
    ROUND_IN_PROGRESS,
    PRE_RUN,
    RUN_IN_PROGRESS,
    POST_RUN
}

export type TargetingIndicator = {
    Type: string;
    ModifierName?: string;
    ModifierType?: string;
    ModifierLength?: number;
    ModifierStacks?: number;
    DisplayRange?: number;
    Fixed?: number;
};

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
