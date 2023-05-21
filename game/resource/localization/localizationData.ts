import {
  AbilityLocalization,
  LocalizationData,
  ModifierLocalization,
  StandardLocalization,
} from "~generator/localizationInterfaces";

export function GenerateLocalizationData(): LocalizationData {
  const Abilities: Array<AbilityLocalization> =
    new Array<AbilityLocalization>();
  const Modifiers: Array<ModifierLocalization> =
    new Array<ModifierLocalization>();
  const StandardTooltips: Array<StandardLocalization> =
    new Array<StandardLocalization>();

  const localization_info: LocalizationData = {
    AbilityArray: Abilities,
    ModifierArray: Modifiers,
    StandardArray: StandardTooltips,
  };

  StandardTooltips.push({
    classname: "addon_game_name",
    name: "Amethyst",
  });

  StandardTooltips.push({
    classname: "DOTA_GoodGuys",
    name: "Radiant",
  });

  StandardTooltips.push({
    classname: "DOTA_BadGuys",
    name: "Radiant",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom1",
    name: "Dire",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom2",
    name: "Dire",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom3",
    name: "Legion",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom4",
    name: "Legion",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom5",
    name: "Void",
  });

  StandardTooltips.push({
    classname: "DOTA_Custom6",
    name: "Void",
  });

  StandardTooltips.push({
    classname: "DOTA_HeroSelectorCategory_PrimaryAttribute_Strength",
    name: "Meele",
  });

  StandardTooltips.push({
    classname: "DOTA_HeroSelectorCategory_PrimaryAttribute_Agility",
    name: "Ranged",
  });

  StandardTooltips.push({
    classname: "DOTA_HeroSelectorCategory_PrimaryAttribute_Intelligence",
    name: "",
  });

  Abilities.push({
    ability_classname: "mars_basic_attack",
    name: "Spear attack",
    description:
      'Melee attack that deals <b><font color="#ffffff">base damage</font></b>. Successfully hitting a target generate a <b><font color="#ff5d00 ">Precision Stack</font></b>',
    notes: [
      '<b><font color="#ff5d00">PRECISION STACK:</font></b> Extra effects on E.',
    ],
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_second_attack",
    name: "God's Rebuke",
    description:
      'Mars smashes enemies in a cone in front of him with his shield, knocking them back and dealing ${multiplier} times his base attack and inflicts <b><font color="#FFC1AA">Fading Slow</font></b>.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the damage multiplier.',
    notes: [
      '<b><font color="#FFC1AA">Fading Slow:</font></b> reduce movement speed by ${fading_slow_pct}% for ${fading_slow_duration}s. The effect decays linearly over time, gradually restoring the target\'s speed over the duration of this debuff.',
    ],
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },

      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_counter",
    name: "Bulwark",
    description:
      'Mars wields his massive shield to block melee attack and reflect projectiles in front of him. Lasts for ${counter_duration}s.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases duration.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_special_attack",
    name: "Spear of Mars",
    description:
      'Mars throws his legendary Spear with deadly precision, dealing @{ability_damage} to the first enemy unit it strikes. The target is also skewered on the spear, pushing it back. If a skewered hero hits a wall or a cliff, they will receive ${extra_damage} damage and be impaled to it and an <b><font color="#94A551">Root</font></b> will be applied. Consumes all <b><font color="#ff5d00 ">Precision Stacks</font></b> and deal @{damage_per_stack} extra damage per stack consumed.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Applies <b><font color="#ffffff">Stun</font></b> instead of <b><font color="#94A551">Root</font></b>.',
    notes: [
      '<b><font color="#ffffff">STUN:</font></b> Target is unable to move and use abilities during $@{stun_duration}s',
    ],
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_mobility",
    name: "God's fall",
    description:
      'Mars prepares and then leaps through the air to land at the indicated location, dealing @{ability_damage} damage to nearby enemies.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increments cast range.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_ultimate",
    name: "Arena Of Blood",
    description:
      "Mars summons an arena lined with the undead warriors of the Ash Legion, who block enemy attacks and movement. Enemy heroes near the inside edge of the arena will be attacked by spears, dealing @{ability_damage} damage and knocking them back.",
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_extra",
    name: "Summon Warrior",
    description:
      'Mars summons an single warrior of the Ash Legion, who block enemy attacks and movement. Enemy heroes close to the warrior will be attacked by spears, dealing @{ability_damage} damage and knocking them back.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Can be recasted.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_ex_basic_attack",
    name: "Food from the crowd",
    description:
      'Mars eats food that has been thrown by the crowd, healing himself for ${heal} health. Heal an additional ${heal_per_tick} health every ${think_interval}s during $@{duration}s.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Reduces the cooldown.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "mars_ex_second_attack",
    name: "God's Punishment",
    description:
      'Mars smashes enemies in a cone in front of him with his shield, knocking them back and dealing @{ability_damage} and inflicting <b><font color="#CB8CFF">Sleep</font></b>.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases sleep duration',
    notes: [
      '<b><font color="#CB8CFF">Sleep:</font></b> Target is unable to act during ${sleep_duration}s. Any damage received will break this state.',
    ],
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });

  Abilities.push({
    ability_classname: "nevermore_basic_attack",
    name: "Necromastery",
    description:
      'Shadow Fiend launches a projectile that deals <b><font color="#ffffff">base damage</font></b> and steals the <b><font color="#ff2727 ">Soul</font></b> from heroes he hits. Each <b><font color="#ff2727 ">Soul</font></b> gives Shadow Fiend @{damage_per_stack} damage.',
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },

      {
        ability_special: "max_stacks",
        text: "MAX SOULS",
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_second_attack",
    name: "Soul Release",
    description:
      'Shadow Fiend launches a projectile that deals @{ability_damage} damage, applies <b><font color="#FFC1AA">Fading Slow</font></b> and steals the <b><font color="#ff2727 ">Soul</font></b> from heroes he hits. It consumes all the <b><font color="#ff2727 ">Souls</font></b> to decrease the cooldown of this ability in ${cd_reduction_per_soul}s per soul consumed.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the cooldown reduction.',
    notes: [
      '<b><font color="#FFC1AA">Fading Slow:</font></b> reduce movement speed by ${fading_slow_pct}% for ${fading_slow_duration}s. The effect decays linearly over time, gradually restoring the target\'s speed over the duration of this debuff.',
    ],
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },

      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_special_attack",
    name: "Shadowraze",
    description:
      'After a ${delay_time}s delay, Shadow Fiend razes the ground at the targeted location, dealing @{ability_damage} damage and adding a Shadow Raze stack to enemy units in the area that lasts for ${stacks_duration}s. The enemy to takes @{damage_per_stack} damage bonus Shadow Raze damage per stack. You can stack up to $@{max_charges} charges.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the max charges by one.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },

      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_counter",
    name: "Presence of the Dark Lord",
    description:
      'Counters the next projectile or melee attack. Countering an attack banishes yourself for $@{banish_duration}s. Shadow Fiend appears on the mouse location. Enemies on the arrival area recives @{ability_damage} damage and gets <b><font color="#DC8668 ">Fear</font></b> for $@{fear_duration}s.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the area of effect',
    notes: [
      '<b><font color="#DC8668">FEAR:</font></b> forces unit to move away from the Fear inflictor. Unit is unable to act while feared',
    ],
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_mobility",
    name: "Pressence of the Dark Lord",
    description:
      'Shadow Fiend dashes towards the target direction, dealing @{ability_damage} damage and applying <b><font color="#FFC1AA">Fading Slow</font></b> to all enemies on the path. Give 2 <b><font color="#ff2727 ">Souls</font></b> stacks per target hit.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the <b><font color="#FFC1AA">Fading Slow</font></b> duration.',
    notes: [
      '<b><font color="#FFC1AA">Fading Slow:</font></b> reduce movement speed by ${fading_slow_pct}% for ${fading_slow_duration}s. The effect decays linearly over time, gradually restoring the target\'s speed over the duration of this debuff.',
    ],
    ability_specials: [
      {
        ability_special: "mana_gain_pct",
        text: '<font color="#00A6DE">MANA GAIN</font>',
        percentage: true,
      },

      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_ultimate",
    name: "Requiem of Souls",
    description:
      'Shadow Fiend gathers his captured souls to release them as lines of demonic energy, dragging towards himself all enemies on the casting process. Deals ${base_damage} damage and extra ${damage_per_soul} damage for every <b><font color="#ff2727 ">Soul</font></b> consumed.  Enemies near the edge only take half damage. Any unit damaged will have its movement speed reduced by ${reduction_ms}% for ${slow_duration}s.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>:,<font color="#B2B5B3">CAST POINT</font>:',
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_extra",
    name: "Tornado of souls",
    description:
      'Shadow Fiend gathers his captured souls to release them as demonic gargoyles that follows him for $@{duration}. During that period of time, deals ${damage_per_think} damage plus extra ${damage_per_soul} per <b><font color="#ff2727 ">Soul</font></b> consumed every ${think_interval}s to enemies arround him. It also slows enemies for ${slow_pct}%.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the duration.',
  });
  Abilities.push({
    ability_classname: "nevermore_ex_special_attack",
    name: "Soul Eater",
    description:
      'Shadow Fiend consumes all the captured <b><font color="#ff2727 ">Souls</font></b> to heals himself by $@{heal} plus ${heal_per_soul} per <b><font color="#ff2727 ">Soul</font></b> consumed.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the base heal ammount.',
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });
  Abilities.push({
    ability_classname: "nevermore_ex_counter",
    name: "Wrath of the Dark lord",
    description:
      'Enemies near to Shadowfiend recives @{ability_damage} damage and gets <b><font color="#DC8668 ">Fear</font></b> for $@{fear_duration}s.n<b><font color="#61ffd0"><img src="file://{images}/custom_game/add.png" />LEVEL UPGRADE</font></b><br>Increases the area of effect.',
    notes: [
      '<b><font color="#DC8668">FEAR:</font></b> forces unit to move away from the Fear inflictor. Unit is unable to act while feared',
    ],
    ability_specials: [
      {
        ability_special: "AbilityCastPoint",
        text: '<font color="#B2B5B3">CAST POINT</font>',
      },
    ],
  });

  Abilities.push({
    ability_classname: "item_health_orb",
    name: "+6 Health",
  });
  Abilities.push({
    ability_classname: "item_mana_orb",
    name: "+8 Mana",
  });
  Abilities.push({
    ability_classname: "item_death_orb",
    name: "Death orb",
  });
  Abilities.push({
    ability_classname: "item_shield_orb",
    name: "Shield orb",
  });
  Abilities.push({
    ability_classname: "storm_ex_special_attack_AbilityCastPoint",
    name: '<font color="#B2B5B3">CAST POINT</font>:',
  });
  Abilities.push({
    ability_classname: "vengeful_mobility",
    name: "Jump",
    ability_specials: [
      {
        ability_special: "recast",
        text: "Back",
      },

      {
        ability_special: "ultimate",
        text: "Jump ultimate",
      },

      {
        ability_special: "ultimate_recast",
        text: "Back ultimate",
      },
    ],
  });
  Modifiers.push({
    modifier_classname: "modifier_shield",
    name: "Shield",
    description: "Blocks incoming damage.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_butterfly_custom",
    name: "Flutter",
    description: "Movement and attack speed increased.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_diffusal_custom",
    name: "Inhibit",
    description:
      "Moving slower. Every damage instance received reduces your mana.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_energy_custom",
    name: "Inner Mana",
    description: "Has extra mana.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_salve_custom",
    name: "Healing",
    description:
      "Healing hp per second. If the unit recives damage, the effect is lost",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_clarity_custom",
    name: "Mana",
    description:
      "Gaining mana per second. If the unit recives damage, the effect is lost",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_mekansm_custom",
    name: "Restore",
    description: "Healing over time.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_meteor_custom",
    name: "Meteor Hammer",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_moon_custom",
    name: "Shade Sight",
    description: "Attack speed increased.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_nullifier_custom",
    name: "Nullify",
    description: "Slowed and dispelled when any damage is received.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_orchid_custom",
    name: "Soul Burn",
    description: "Silenced. Recives extra damage when ends.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_soul_custom",
    name: "Sacrifice",
    description: "Has temporary extra mana.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_boots_custom",
    name: "Speed",
    description: "Moving faster.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_vitality_custom",
    name: "Inner Health",
    description: "Has extra health.",
  });

  Modifiers.push({
    modifier_classname: "modifier_item_yasha_custom",
    name: "Swiftness",
    description: "Increased movement speed.",
  });

  Modifiers.push({
    modifier_classname: "modifier_adrenaline",
    name: "Adrenaline",
    description: `Moving {${LocalizationModifierProperty.MOVESPEED_BONUS_PERCENTAGE}}% faster. Removed on casting any ability or getting hit by an enemy ability.`,
  });

  Modifiers.push({
    modifier_classname: "modifier_generic_silence",
    name: "Silenced",
    description: "Can't cast spells.",
  });

  Modifiers.push({
    modifier_classname: "modifier_generic_fading_slow",
    name: "Fading slow",
    description: "This unit moves slower. Gains movement speed every second.",
  });

  Modifiers.push({
    modifier_classname: "modifier_generic_stunned",
    name: "Stunned",
    description: "Can't act.",
  });

  Modifiers.push({
    modifier_classname: "modifier_generic_sleep",
    name: "Sleep",
    description: "Unable to act. Any damage recivied will awakens the hero",
  });

  Modifiers.push({
    modifier_classname: "modifier_generic_root",
    name: "Rooted",
    description: "Unable to move",
  });

  Modifiers.push({
    modifier_classname: "modifier_spectre_desolate_custom",
    name: "Desolate",
    description: "This unit is desolated by Spectre's weapon.",
  });

  Modifiers.push({
    modifier_classname: "modifier_spectre_counter",
    name: "Counter",
    description: "Blocking damage. Moving slower.",
  });

  Modifiers.push({
    modifier_classname: "modifier_spectre_ex_special_attack",
    name: "Blind",
    description: "Vision radius reduced.",
  });

  Modifiers.push({
    modifier_classname: "modifier_spectre_special_attack_buff",
    name: "Faster",
    description: "This unit moves faster while walking on the trail.",
  });

  Modifiers.push({
    modifier_classname: "modifier_spectre_special_attack_debuff",
    name: "Slower",
    description: "This unit moves slower.",
  });

  Modifiers.push({
    modifier_classname: "modifier_sniper_basic_attack_charges",
    name: "Bullets",
    description: "Basic attack charges.",
  });

  Modifiers.push({
    modifier_classname: "modifier_sniper_counter",
    name: "Inivisible",
    description: "Invisible. Moving faster.",
  });

  Modifiers.push({
    modifier_classname: "modifier_sniper_shrapnel_debuff",
    name: "Shrapnel",
    description: "Moving slower. Reciving shrapnel damage",
  });

  Modifiers.push({
    modifier_classname: "modifier_phantom_strike_stack",
    name: "Stack",
    description: "Stack charges. Consumed by some abilities to increase damage",
  });

  Modifiers.push({
    modifier_classname: "modifier_phantom_special_attack_charges",
    name: "Charge",
    description: "Stifling dagger charges",
  });

  Modifiers.push({
    modifier_classname: "modifier_phantom_mobility_charges",
    name: "Charge",
    description: "Swift charges",
  });

  Modifiers.push({
    modifier_classname: "modifier_juggernaut_counter_countering",
    name: "Countering",
    description: "Countering damage. Unable to move.",
  });

  Modifiers.push({
    modifier_classname: "modifier_juggernaut_mobility",
    name: "Blade Fury",
    description: "Moving faster. Can't cast spells.",
  });

  Modifiers.push({
    modifier_classname: "modifier_juggernaut_ultimate_slashing",
    name: "Omnislash",
    description: "Invencible. Unable to act.",
  });

  // Return data to compiler
  return localization_info;
}
