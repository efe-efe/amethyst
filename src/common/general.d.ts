type ParticlePath = `particles/${string}.vpcf`;
type HeroName = string & { heroNameBrand: unknown };

declare const enum Stage {
    none = "none",
    battle = "battle",
    adventure = "adventure"
}

declare const enum UpgradeId {
    "phantomExtraDaggers" = "phantomExtraDaggers",
    "phantomFastDaggers" = "phantomFastDaggers"
}

declare enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1
}

declare enum Custom_ActionModes {
    START = 0,
    STOP = 1
}

declare const enum Constants {
    maxThreshold = 30,
    maxEnergy = 100,
    warmupDuration = 20,
    adrenalineDuration = 25,
    pickupsSpawnRate = 5,
    bountyHealth = 30
}

declare const enum AllianceId {
    "none" = "none",
    "radiant" = "radiant",
    "dire" = "dire",
    "legion" = "legion",
    "void" = "void"
}

declare function unreachable(x: never): never;

// Json is an opaque type which you can only use in encode/decode
type Json<T> = {
    jsonBrand: unknown & T;
};
