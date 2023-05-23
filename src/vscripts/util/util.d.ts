declare function SendOverheadHealMessage(this: void, hEntity: CDOTA_BaseNPC, nValue: number): void;
declare function SendOverheadDamageMessage(this: void, hEntity: CDOTA_BaseNPC, nValue: number): void;
declare function EFX(this: void, path: string, attach: ParticleAttachment, parent: CBaseEntity | undefined, options: any): ParticleID;
declare function CreateTimedRadiusMarker(
    this: void,
    hEntity: CDOTA_BaseNPC | undefined,
    origin: Vector,
    radius: number,
    delay: number,
    duration: number,
    scope: number
): object;
declare const RADIUS_SCOPE_PUBLIC = 1;
declare const RADIUS_SCOPE_LOCAL = 2;
