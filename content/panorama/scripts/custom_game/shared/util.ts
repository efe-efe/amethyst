export type Color = {
    light: [number, number, number];
    dark: [number, number, number];
}

type GenericData = {
    key: string | number | symbol;
    value: never;
}

export default {
    isEmptyObject(object: any): boolean{
        return Object.keys(object).length == 0;
    },
    getFirstObjectElement(object: any): any{
        for(const key in object){
            const element = object[key];
            return element;
        }
    }
};
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
    Gradient: function(color: Color, opacity = '1.0'): string{
        const colorA = 'rgba(' + color.light[0] + ',' + color.light[1] + ',' + color.light[2] + ',' + opacity + ')';
        const colorB = 'rgba(' + color.dark[0] + ',' + color.dark[1] + ',' + color.dark[2] + ',' + opacity + ')';
        return 'gradient(linear, 0% 0%, 100% 0%, from(' + colorA + '), to(' + colorB + '));';
    }
};

export const math = {
    clamp(num: number, min: number, max: number): number{
        return num < min ? min : num > max ? max : num;
    }
};

export const modifiers = {
    findModifierByName(entityIndex: EntityIndex, name: string): BuffID | boolean{
        for (let i = 0; i < Entities.GetNumBuffs(entityIndex); i++)
        {
            const buffName = Buffs.GetName(entityIndex, Entities.GetBuff(entityIndex, i));
            if (buffName == name) {
                return Entities.GetBuff(entityIndex, i);
            }
        }
        return false;
    }
};

export const entities = {
    isVisibleByLocal(entityIndex: EntityIndex): boolean{
        if(modifiers.findModifierByName(entityIndex,'modifier_visible')){
            return true;
        }
        return false;
    }
};

export const panels = {
    createPanelSimple(container: Panel, className: string, type = 'Panel'): Panel{
        return $.CreatePanelWithProperties(type, container, className, {
            class: className,
            hittest: 'true',
        });
    }
};

export const tables = {
    subscribeToNetTableAndLoadNow(tableName: never, callback: (tableName: never, key: string | number | symbol, value: never) => void): void{
        CustomNetTables.SubscribeNetTableListener(tableName, callback);
        const data = CustomNetTables.GetAllTableValues(tableName);

        data.forEach((d) => {
            const parsedD = d  as GenericData;
            callback(tableName, parsedD.key, parsedD.value);
        });
    },
    subscribeToNetTableKey(table: never, key: string, loadNow: boolean, callback: any): NetTableListenerID | undefined{
        const listener = CustomNetTables.SubscribeNetTableListener(table, function(table, tableKey, data){
            if (key == tableKey){
                if (!data) {
                    return;
                }

                callback(data);
            }
        });
        
        if(loadNow){
            const data = CustomNetTables.GetTableValue(table, key);

            if (data) {
                callback(data);
            }
        }

        return listener;
    }
};