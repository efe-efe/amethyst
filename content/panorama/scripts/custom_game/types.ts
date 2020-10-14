export type AllianceData = {
    max_health: number;
    amethysts: number;
    health: number;
    score: number;
    name: string;
    shield: number;
}

export type HeroData = {
    entityIndex: EntityIndex;
    teamId: DOTATeam_t;
    playerId: PlayerID;
    allianceName: string;
    name: string;
    health: number;
    maxHealth: number;
    treshold: number;
    shield: number;
    mana: number;
    maxMana: number;
    status: StatusTypes;
    recast: RecastTypes;
    stackbars: string;
    charges: string;
    cooldown: string;
}

export type StatusTypes = {
    [modifierName: string]: StatusType
}

export type RecastTypes = {
    [modifierName: string]: RecastType
}

export type RecastType = {
    ability_name: string;
    key: string;
    modifier_name: string;
}

export type StatusType = {
    scope: number;
    trigger: number;
    label: string;
    modifier_name: string;
    content: number;
    priority: number;
    style_name: string;
    max_stacks?: number;
}