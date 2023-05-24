export interface BaseAbility extends CDOTA_Ability_Lua {}
export class BaseAbility {}

export interface BaseItem extends CDOTA_Item_Lua {}
export class BaseItem {}

export interface BaseModifier extends CDOTA_Modifier_Lua {}
export class BaseModifier {
    public static apply<T extends typeof BaseModifier>(
        this: T,
        target: CDOTA_BaseNPC,
        caster?: CDOTA_BaseNPC,
        ability?: CDOTABaseAbility,
        modifierTable?: object
    ): InstanceType<T> | undefined {
        return target.AddNewModifier(caster || target, ability, this.name, modifierTable || {}) as any;
    }

    // Custom event
    OnHealDone(event: ModifierHealDoneEvent): void {}
}

declare global {
    interface ModifierHealDoneEvent {
        healer: CDOTA_BaseNPC;
        target: CDOTA_BaseNPC;
        ability?: CDOTABaseAbility;
        heal: number;
    }
}

export interface BaseModifierMotionHorizontal extends CDOTA_Modifier_Lua_Horizontal_Motion {}
export class BaseModifierMotionHorizontal extends BaseModifier {}

export interface BaseModifierMotionVertical extends CDOTA_Modifier_Lua_Vertical_Motion {}
export class BaseModifierMotionVertical extends BaseModifier {}

export interface BaseModifierMotionBoth extends CDOTA_Modifier_Lua_Motion_Both {}
export class BaseModifierMotionBoth extends BaseModifier {}

// Add standard base classes to prototype chain to make `super.*` work as `self.BaseClass.*`
setmetatable(BaseAbility.prototype, {
    __index: CDOTA_Ability_Lua ?? C_DOTA_Ability_Lua
});
setmetatable(BaseItem.prototype, {
    __index: CDOTA_Item_Lua ?? C_DOTA_Item_Lua
});
setmetatable(BaseModifier.prototype, { __index: CDOTA_Modifier_Lua });

declare global {
    let beforeModifierOnCreated: ((modifier: CDOTA_Modifier_Lua) => void) | undefined;
    let beforeAbilitySpawn: ((ability: CDOTABaseAbility) => void) | undefined;
}

export const registerAbility = (name?: string) => (ability: new () => CDOTA_Ability_Lua | CDOTA_Item_Lua) => {
    if (name !== undefined) {
        // @ts-ignore
        ability.name = name;
    } else {
        name = ability.name;
    }

    const [env] = getFileScope();

    if (env[name]) {
        clearTable(env[name]);
    } else {
        env[name] = {};
    }

    toDotaClassInstance(env[name], ability);

    const originalSpawn = (env[name] as CDOTA_Ability_Lua).Spawn;
    env[name].Spawn = function () {
        if (beforeAbilitySpawn) {
            beforeAbilitySpawn(this);
            beforeAbilitySpawn = undefined;
        }
        this.____constructor();
        if (originalSpawn) {
            originalSpawn.call(this);
        }
    };
};

export const registerModifier = (params?: { customNameForI18n?: string }) => (modifier: new () => CDOTA_Modifier_Lua) => {
    let name = params?.customNameForI18n;

    if (name !== undefined) {
        // @ts-ignore
        modifier.name = name;
    } else {
        name = modifier.name;
    }

    const [env, source] = getFileScope();
    const [fileName] = string.gsub(source, ".*scripts[\\/]vscripts[\\/]", "");

    if (env[name]) {
        clearTable(env[name]);
    } else {
        env[name] = {};
    }

    toDotaClassInstance(env[name], modifier);

    const originalOnCreated = (env[name] as CDOTA_Modifier_Lua).OnCreated;
    env[name].OnCreated = function (parameters: any) {
        if (beforeModifierOnCreated) {
            beforeModifierOnCreated(this);
            beforeModifierOnCreated = undefined;
        }
        this.____constructor();
        if (originalOnCreated !== undefined) {
            originalOnCreated.call(this, parameters);
        }
    };

    let type = LuaModifierMotionType.NONE;
    let base = (modifier as any).____super;
    while (base) {
        if (base === BaseModifierMotionBoth) {
            type = LuaModifierMotionType.BOTH;
            break;
        } else if (base === BaseModifierMotionHorizontal) {
            type = LuaModifierMotionType.HORIZONTAL;
            break;
        } else if (base === BaseModifierMotionVertical) {
            type = LuaModifierMotionType.VERTICAL;
            break;
        }

        base = base.____super;
    }

    LinkLuaModifier(name, fileName, type);
};

/**
 * Use to expose top-level functions in entity scripts.
 * Usage: registerEntityFunction("OnStartTouch", (trigger: TriggerStartTouchEvent) => { <your code here> });
 */
export function registerEntityFunction(name: string, f: (...args: any[]) => any) {
    const [env] = getFileScope();
    env[name] = function (this: void, ...args: any[]) {
        f(...args);
    };
}

function clearTable(table: object) {
    for (const key in table) {
        delete (table as any)[key];
    }
}

function getFileScope(): [any, string] {
    let level = 1;
    while (true) {
        const info = debug.getinfo(level, "S");
        if (info && info.what === "main") {
            return [getfenv(level), info.source!];
        }

        level += 1;
    }
}

function toDotaClassInstance(instance: any, table: new () => any) {
    let { prototype } = table;
    while (prototype) {
        for (const key in prototype) {
            // Using hasOwnProperty to ignore methods from metatable added by ExtendInstance
            // https://github.com/SteamDatabase/GameTracking-Dota2/blob/7edcaa294bdcf493df0846f8bbcd4d47a5c3bd57/game/core/scripts/vscripts/init.lua#L195
            if (!instance.hasOwnProperty(key)) {
                instance[key] = prototype[key];
            }
        }

        prototype = getmetatable(prototype);
    }
}
