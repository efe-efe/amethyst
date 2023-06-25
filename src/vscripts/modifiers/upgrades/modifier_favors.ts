import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierUpgrade } from "./modifier_upgrade";

@registerModifier({ customNameForI18n: "modifier_upgrade_juggernaut_blade_dance_recast" })
export class ModifierUpgradeJuggernautBladeDanceReacast extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_juggernaut_fury_attack" })
export class ModifierUpgradeJuggernautFuryAttack extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_juggernaut_fury_reflects" })
export class ModifierUpgradeJuggernautFuryReflects extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_juggernaut_refresh_dagger" })
export class ModifierUpgradeJuggernautRefreshDagger extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_juggernaut_spinning_ward" })
export class ModifierUpgradeJuggernautSpinningWard extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_act_while_countering" })
export class ModifierUpgradePhantomActCounter extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_countering_stacks" })
export class ModifierUpgradePhantomCounterStacks extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_coup_cast_fast" })
export class ModifierUpgradePhantomFastCoup extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_critical_recast" })
export class ModifierUpgradePhantomCritRecast extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_extra_daggers" })
export class ModifierUpgradePhantomExtraDaggers extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_fast_daggers" })
export class ModifierUpgradePhantomFastDaggers extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_quick_recast" })
export class ModifierUpgradePhantomQuickRecast extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_phantom_strike_instant" })
export class ModifierUpgradeSniperStrikeInstant extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_sniper_jump_knockback" })
export class ModifierUpgradeSniperJumpKnockback extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_sniper_snipe_cast_fast" })
export class ModifierUpgradeSniperFastSnipe extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_storm_ranged_remnant" })
export class ModifierUpgradeStormRangedRemnant extends ModifierUpgrade {}

@registerModifier({ customNameForI18n: "modifier_upgrade_storm_unleashed_knockback" })
export class ModifierUpgradeStormUnleashedKnockback extends ModifierUpgrade {}
