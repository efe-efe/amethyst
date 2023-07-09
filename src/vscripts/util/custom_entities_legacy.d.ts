declare interface CustomEntitiesLegacy {
    SetManaCustom(hEntity: CDOTA_BaseNPC, fMana: number, bInformClient: boolean): void;
    SetThreshold(hEntity: CDOTA_BaseNPC, nTreshold: number): void;
    GetThreshold(hEntity: CDOTA_BaseNPC): number;
    SetCollisionDirection(hEntity: CDOTA_BaseNPC, iCollisionDirection: number): void;
    TrueHeal(hEntity: CDOTA_BaseNPC, nHealAmount: number): void;
    RefreshCooldowns(hEntity: CDOTA_BaseNPC): void;
    GetShield(hEntity: CDOTA_BaseNPC): number;
    Initialize(hEntity: CDOTA_BaseNPC, bIsPVENPC?: boolean): void;
    IsInitialized(hEntity: CDOTA_BaseNPC): boolean;
    SendDataToClient(hEntity: CDOTA_BaseNPC): boolean;
    GetRawDirection(hEntity: CDOTA_BaseNPC): Vector;
    SetDirection(hEntity: CDOTA_BaseNPC, x: number, y: number): void;
    GetEnergy(hEntity: CDOTA_BaseNPC): number;
    GetMaxEnergy(hEntity: CDOTA_BaseNPC): number;
    GetDirection(hEntity: CDOTA_BaseNPC): Vector;
    Reset(hEntity: CDOTA_BaseNPC): void;
    AutoUpgradeAbilities(hEntity: CDOTA_BaseNPC): void;
    GetAlliance(hEntity: CDOTA_BaseNPC): any;
    SetParent(hEntity: CDOTA_BaseNPC, parent: any): void;
    GetParent(hEntity: CDOTA_BaseNPC): any | undefined;
    GetNormal(hEntity: CDOTA_BaseNPC, vPosition: Vector, fScale?: number): Vector;
    GetCollisionDirection(hEntity: CDOTA_BaseNPC): Vector;
    IsChanneling(hEntity: CDOTA_BaseNPC): boolean;
    IsDisplacing(hEntity: CDOTA_BaseNPC): boolean;
    IsAnimating(hEntity: CDOTA_BaseNPC): boolean;
    IsCasting(hEntity: CDOTA_BaseNPC): boolean;
    CanWalk(hEntity: CDOTA_BaseNPC): boolean;
    SetBeenHurt(hEntity: CDOTA_BaseNPC, bBeenHurt: boolean): void;
}

declare const CustomEntitiesLegacy: CustomEntitiesLegacy;
