declare interface CustomAbilities {
    GetEnergyCost(hAbility: CDOTA_Ability_Lua): number;
    HasBehavior(hAbility: CDOTA_Ability_Lua, nBehavior: AbilityBehavior): boolean;
}

declare const CustomAbilities: CustomAbilities;