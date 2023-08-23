import { defineUpgrade } from "./framework/upgrade_definitions";

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.juggernautReflectSpin,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "file://{images}/spellicons/juggernaut_blade_fury.png"
});

defineUpgrade({
    type: UpgradeType.stance,
    id: UpgradeId.juggernautDagggerRefresh,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "raw://resource/flash3/images/spellicons/juggernaut_special_attack.png"
});

defineUpgrade({
    type: UpgradeType.shard,
    id: UpgradeId.juggernautAttackSpin,
    validHeroes: ["npc_dota_hero_juggernaut"],
    icon: "file://{images}/spellicons/juggernaut_blade_fury.png"
});
