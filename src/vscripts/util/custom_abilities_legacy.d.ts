declare interface CustomAbilitiesLegacy {
    GetEnergyCost(hAbility: CDOTA_Ability_Lua): number;
    HasBehavior(hAbility: CDOTA_Ability_Lua, nBehavior: AbilityBehavior): boolean;
    IsNotTalentNorAttribute(hAbility: CDOTABaseAbility): boolean;
    GetCursorPosition(hAbility: CDOTABaseAbility): Vector;
}

declare const CustomAbilitiesLegacy: CustomAbilitiesLegacy;
