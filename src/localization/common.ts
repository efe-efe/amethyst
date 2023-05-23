import { createKeyword } from "./util";

const baseDamage = createKeyword("base damage");

const fadingSlow = createKeyword("Fading Slow", {
    description:
        "Reduce movement speed by X percent. The effect decays linearly over time, gradually restoring the target's speed over the duration of this debuff.",
    icon: "fading_slow",
    color: "#FFC1AA",
    dynamic: true
});

const stun = createKeyword("Stun", {
    description: "Target is unable to move and use abilities.",
    icon: "stun"
});

const sleep = createKeyword("Sleep", {
    description: "Target is unable to act. Any damage received will break this state.",
    icon: "sleep",
    color: "#CB8CFF"
});

const silence = createKeyword("Silence", {
    description: "Target is unable to use abilities.",
    icon: "silence",
    color: "#C5FAFF"
});

const spellBlock = createKeyword("Spell Block", {
    description: "If affected unit cast any spell, it recives Silence for X seconds.",
    icon: "spell_block",
    color: "#ed4747",
    dynamic: true
});

const fear = createKeyword("Fear", {
    description: "The target runs uncontrollably in the opposite direction to the cause of fear.",
    icon: "fear",
    color: "#DC8668"
});

const channeling = createKeyword("Channeled", {
    description:
        "Caster stops acting for the duration of this ability. This ability ends when the caster takes another action or is interrupted by another ability.",
    icon: "clock",
    color: "#FBDE39"
});

const root = createKeyword("Root", {
    description: "Target is unable to move.",
    icon: "root",
    color: "#94A551"
});

export const keywords = {
    baseDamage,
    fadingSlow,
    stun,
    sleep,
    silence,
    spellBlock,
    fear,
    channeling,
    root
};

export const manaValue: [string, string] = ["mana_gain_pct", "%<font color='#00A6DE'>MANA GAIN</font>"];
export const castpointValue: [string, string] = ["AbilityCastPoint", "<font color='#B2B5B3'>CAST POINT</font>"];
