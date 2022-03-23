import Item from "./Item";

export enum PickupTypes {
    HEALTH = 0,
    MANA,
    SHIELD,
    DEATH,
}

const PICKUP_ITEM_NAMES = {
    [PickupTypes.HEALTH]: "item_health_orb",
    [PickupTypes.MANA]: "item_mana_orb",
    [PickupTypes.SHIELD]: "item_shield_orb",
    [PickupTypes.DEATH]: "item_death_orb"
};

const PICKUP_PARTICLES = {
    [PickupTypes.HEALTH]: "particles/generic_gameplay/rune_regeneration.vpcf",
    [PickupTypes.MANA]: "particles/generic_gameplay/rune_doubledamage.vpcf",
    [PickupTypes.SHIELD]: "particles/generic_gameplay/rune_bounty.vpcf",
    [PickupTypes.DEATH]: "particles/generic_gameplay/rune_haste.vpcf"
};

export default class Pickup extends Item{
    type: PickupTypes;
    origin: Vector;
    scale: number;
    drop: CDOTA_Item_Physical;

    constructor(type: PickupTypes, origin: Vector, scale = 1.0){
        super();
        this.type = type;
        this.origin = origin;
        this.scale = scale;

        this.SetItem(CreateItem(PICKUP_ITEM_NAMES[this.type], undefined, undefined)!);
        this.item!.LaunchLootInitialHeight(false, 0, 50, 0.5, this.origin);
        this.drop = CreateItemOnPositionForLaunch(this.origin, this.item);
        ParticleManager.CreateParticle(PICKUP_PARTICLES[this.type], ParticleAttachment.ABSORIGIN_FOLLOW, this.drop as unknown as CDOTA_BaseNPC);
        this.drop.SetModelScale(this.scale);
    }

    Destroy(): void{
        if(!this.picked){
            UTIL_Remove(this.GetItem());
        }

        if(this.drop !== undefined && !this.drop.IsNull()){
            UTIL_Remove(this.drop);
        }
    }
}
