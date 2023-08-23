type ParticlePath = `particles/${string}.vpcf`;
type HeroName = string & { heroNameBrand: unknown };

declare const enum UpgradeType {
    "stance" = "stance", // Changes to the spells (Selected at the begining of the game)
    "legend" = "legend", // Hero that offers other upgrades
    "blessing" = "blessing", // Changes to the spell category (i.e: basic attack, counter, etc) or a general upgrade
    "shard" = "shard", // Changes to the spells
    "knowledge" = "knowledge", // Improves a blessing
    "item" = "item", // Improvements on the hero body
    "vitality" = "vitality" // More HP
}

declare const enum Stage {
    none = "none",
    battle = "battle",
    adventure = "adventure"
}

declare const enum LegendId {
    "timbersaw" = "timbersaw",
    "apparition" = "apparition"
}

declare const enum UpgradeId {
    "phantomExtraDaggers" = "phantomExtraDaggers",
    "phantomFastDaggers" = "phantomFastDaggers",
    "phantomInstantCounter" = "phantomInstantCounter",
    "phantomDashDaggers" = "phantomDashDaggers",
    "phantomSecondRecast" = "phantomSecondRecast",
    "juggernautReflectSpin" = "juggernautReflectSpin",
    "juggernautDagggerRefresh" = "juggernautDagggerRefresh",
    "juggernautAttackSpin" = "juggernautAttackSpin",
    "timberMobilityChakram" = "timberMobilityChakram",
    "timberSpecialChakram" = "timberSpecialChakram",
    "timberAttackWhirling" = "timberAttackWhirling",
    "apparitionBasicAttack" = "apparitionBasicAttack",
    "apparitionSpecialAttack" = "apparitionSpecialAttack",
    "apparitionMobility" = "apparitionMobility"
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
    firstWarmupDuration = 40,
    warmupDuration = 20,
    adrenalineDuration = 25,
    pickupsSpawnRate = 5,
    bountyHealth = 30,
    gemSpawnTime = 10,
    gemRespawnTime = 15,
    preRoundDuration = 4.0,
    roundDuration = 60,
    roundsToWin = 5,
    roundsDifferenceToWin = 3,
    preStageDuration = 2.0,
    drawTime = 3.0,
    upgradePoints = 2
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

type QUpgradeDefinition = {
    type: UpgradeType;
    id: UpgradeId;
    icon: string;
};
