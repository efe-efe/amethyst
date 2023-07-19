export type Color = {
    light: [number, number, number];
    dark: [number, number, number];
};

const utils = {
    isEmptyObject(object: any): boolean {
        return Object.keys(object).length == 0;
    },
    getFirstObjectElement(object: any): any {
        for (const key in object) {
            const element = object[key];
            return element;
        }
    },
    getCurrentPlayer(): PlayerID {
        let playerId = Players.GetLocalPlayer();
        if (Game.IsInToolsMode()) {
            const selectedEntity = Players.GetSelectedEntities(playerId)[0];
            if (selectedEntity) {
                playerId = Entities.GetPlayerOwnerID(selectedEntity);
            }
        }

        return playerId;
    }
};

export default utils;

export const colors = {
    local: {
        light: [162, 249, 154],
        dark: [51, 162, 40]
    } as Color,
    yellow: {
        light: [249, 246, 154],
        dark: [196, 192, 42]
    } as Color,
    lightgreen: {
        light: [154, 249, 224],
        dark: [78, 128, 114]
    } as Color,
    pink: {
        light: [197, 77, 168],
        dark: [92, 15, 73]
    } as Color,
    orange: {
        light: [255, 108, 0],
        dark: [219, 99, 11]
    } as Color,
    blue: {
        light: [27, 113, 230],
        dark: [120, 156, 210]
    } as Color,
    gray: {
        light: [240, 240, 240],
        dark: [120, 120, 120]
    } as Color,
    yellowRed: {
        light: [219, 213, 30],
        dark: [229, 0, 72]
    } as Color,
    Gradient: function (color: Color, opacity = "1.0") {
        const colorA = "rgba(" + color.light[0] + "," + color.light[1] + "," + color.light[2] + "," + opacity + ")";
        const colorB = "rgba(" + color.dark[0] + "," + color.dark[1] + "," + color.dark[2] + "," + opacity + ")";
        return "gradient(linear, 0% 0%, 100% 0%, from(" + colorA + "), to(" + colorB + "));";
    }
};

export const math = {
    clamp(num: number, min: number, max: number): number {
        return num < min ? min : num > max ? max : num;
    }
};

export function findModifierByName(entityIndex: EntityIndex, name: string) {
    return findAllModifiers(entityIndex).find(modifier => name == Buffs.GetName(entityIndex, modifier));
}

export function findAllModifiers(entityIndex: EntityIndex) {
    const modifiers = [];

    for (let i = 0; i < Entities.GetNumBuffs(entityIndex); i++) {
        modifiers.push(Entities.GetBuff(entityIndex, i));
    }

    return modifiers;
}

export const panels = {
    createPanelSimple(container: Panel, className: string, type = "Panel"): Panel {
        return $.CreatePanelWithProperties(type, container, className, {
            class: className,
            hittest: "true"
        });
    }
};

export function encodeToJson<T>(value: T): Json<T> {
    return JSON.stringify(value) as unknown as Json<T>;
}

export function decodeFromJson<T>(value: Json<T>) {
    const jsonString = value as unknown as string;
    return JSON.parse(jsonString) as T;
}

export function subscribeToNetTableAndLoadNow<TName extends keyof CustomNetTableDeclarations, T extends CustomNetTableDeclarations[TName]>(
    tableName: TName,
    callback: (tableName: TName, key: keyof T, value: NetworkedData<T[keyof T]>) => void
) {
    $.Msg(`Subscribing to ${tableName}`);
    CustomNetTables.SubscribeNetTableListener(tableName, callback);
    const table = CustomNetTables.GetAllTableValues(tableName);

    table.forEach(element => {
        callback(tableName, element.key, element.value as NetworkedData<T[keyof T]>);
    });
}

export function subscribeToNetTableKey<
    TName extends keyof CustomNetTableDeclarations,
    T extends CustomNetTableDeclarations[TName],
    TKey extends keyof T
>(tableName: TName, toKey: TKey, loadNow: boolean, callback: (data: NetworkedData<T[TKey]>) => void) {
    const listener = CustomNetTables.SubscribeNetTableListener(tableName, function (table, key, data) {
        if ((key as keyof T) == toKey) {
            if (!data) {
                return;
            }

            callback(data as NetworkedData<T[TKey]>);
        }
    });

    if (loadNow) {
        const data = CustomNetTables.GetTableValue(tableName, toKey as unknown as keyof CustomNetTableDeclarations[TName]);

        if (data) {
            callback(data as NetworkedData<T[TKey]>);
        }
    }

    return listener;
}
