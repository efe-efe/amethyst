type LocalizationAbilityOptions = {
    title?: string;
    description: string;
    lore?: string[];
    upgrade?: string;
    values?: [string, string][];
    secondaryAbility?: string;
};

type LocalizationModifierOptions = {
    title: string;
    description?: string;
};

const silent = process.argv.includes("--silent");

function logLocalization(codeName: string, type?: string) {
    if (!silent) {
        console.log(`Added localization for ${type ?? "key"}: ${codeName}`);
    }
}

export const allTokens: [string, string][] = [];

export function localizeAbility(codeName: string, options: LocalizationAbilityOptions) {
    const prefix = `DOTA_Tooltip_Ability_${codeName}`;

    if (options.title) {
        allTokens.push([prefix, options.title]);
    }

    if (options.lore) {
        allTokens.push([`${prefix}_lore`, options.lore.join("<br><br>")]);
    }

    for (const [key, value] of options.values ?? []) {
        allTokens.push([`${prefix}_${key}`, `${value}:`]);
    }

    let description = options.description;

    if (options.secondaryAbility) {
        description += options.secondaryAbility;
    }

    if (options.upgrade) {
        description += options.upgrade;
    }

    allTokens.push([`${prefix}_Description`, description]);

    logLocalization(codeName, "ability");
}

export function localizeModifier(codeName: string, options: LocalizationModifierOptions) {
    const prefix = `DOTA_Tooltip_${codeName}`;

    allTokens.push([prefix, options.title]);

    if (options.description) {
        allTokens.push([`${prefix}_Description`, options.description]);
    }

    logLocalization(codeName, "modifier");
}

export function localize(key: string, value: string) {
    allTokens.push([key, value]);
    logLocalization(key);
}

export function localizeUpgrade(
    upgradeId: UpgradeId,
    options: {
        title: string;
        description: string;
    }
) {
    localize(`Upgrade_${upgradeId}`, options.title);
    localize(`Upgrade_${upgradeId}_Description`, options.description);

    logLocalization(upgradeId, "upgrade");
}
