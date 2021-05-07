declare interface CustomEntities {
    SetTreshold(hEntity: CDOTA_BaseNPC, nTreshold: number): void;
    GetTreshold(hEntity: CDOTA_BaseNPC): number;
    SetCollisionDirection(hEntity: CDOTA_BaseNPC, iCollisionDirection: number): void;
    GiveManaCustom(hEntity: CDOTA_BaseNPC, nMana: number, bInformClient?: boolean, bShowOverhead?: boolean): void;
    TrueHeal(hEntity: CDOTA_BaseNPC, nHealAmount: number): void;
    RefreshCooldowns(hEntity: CDOTA_BaseNPC): void;
    GetShield(hEntity: CDOTA_BaseNPC): number;
    Initialize(hEntity: CDOTA_BaseNPC, bIsPVENPC?: boolean): void;
    IsInitialized(hEntity: CDOTA_BaseNPC): boolean;
    SendDataToClient(hEntity: CDOTA_BaseNPC): boolean;
    GetRawDirection(hEntity: CDOTA_BaseNPC): Vector;
    SetDirection(hEntity: CDOTA_BaseNPC, x: number, y: number): void;
    GetEnergy(hEntity: CDOTA_BaseNPC): number;
    FullyFaceTowards(hEntity: CDOTA_BaseNPC, vDirection: Vector): void;
    GiveEnergy(hEntity: CDOTA_BaseNPC, nEnergy: number, bInformClient?: boolean, bShowOverhead?: boolean): void;
    GetMaxEnergy(hEntity: CDOTA_BaseNPC): number;
    GetDirection(hEntity: CDOTA_BaseNPC): Vector;
    Reset(hEntity: CDOTA_BaseNPC): void;
    AutoUpgradeAbilities(hEntity: CDOTA_BaseNPC): void;
    GetAlliance(hEntity: CDOTA_BaseNPC): Alliance;
    IsBanished(hEntity: CDOTA_BaseNPC): boolean;
    SetParent(hEntity: CDOTA_BaseNPC, parent: UnitEntity): void;
    GetParent(hEntity: CDOTA_BaseNPC): UnitEntity | undefined;
    GetNormal(hEntity: CDOTA_BaseNPC, vPosition: Vector, fScale?: number): Vector;
    GetCollisionDirection(hEntity: CDOTA_BaseNPC): Vector;
    IsChanneling(hEntity: CDOTA_BaseNPC): boolean;
    IsDisplacing(hEntity: CDOTA_BaseNPC): boolean;
    IsAnimating(hEntity: CDOTA_BaseNPC): boolean;
    IsCasting(hEntity: CDOTA_BaseNPC): boolean;
    CanWalk(hEntity: CDOTA_BaseNPC): boolean;
    Allies(hEntityA: CDOTA_BaseNPC, hEntityB: CDOTA_BaseNPC): boolean;
    GetDistance(hEntity: CDOTA_BaseNPC, hTarget: CDOTA_BaseNPC): number;
    SafeDestroyModifier(hEntity: CDOTA_BaseNPC, sModifierName: string): void;
    FindUnitsInRadius(hEntity: CDOTA_BaseNPC, origin: Vector, radius: number, nTeamFilter: UnitTargetTeam, nTypeFilter: UnitTargetType, nFlagFilter: UnitTargetFlags, nOrderFilter: FindOrder): CDOTA_BaseNPC[];
}

declare const CustomEntities: CustomEntities;