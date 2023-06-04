import { BaseModifier, BaseModifierMotionHorizontal, BaseModifierMotionVertical, BaseModifierMotionBoth } from "../../lib/dota_ts_adapter";
import { CustomAbility } from "./custom_ability";

type OnCreatedCustomParams<T extends typeof BaseModifier> = Parameters<InstanceType<T>["OnCreated"]>[0];
type OnCreatedParams<T extends typeof BaseModifier> = OnCreatedCustomParams<T> extends undefined
    ? { duration?: number }
    : OnCreatedCustomParams<T> & { duration?: number };

function hasOne<T extends typeof BaseModifier>(this: T, target: CDOTA_BaseNPC): boolean {
    // eslint-disable-next-line no-restricted-syntax
    return target.HasModifier(this.name);
}

function findOne<T extends typeof BaseModifier>(this: T, target: CDOTA_BaseNPC): InstanceType<T> | undefined {
    // eslint-disable-next-line no-restricted-syntax
    return target.FindModifierByName(this.name) as InstanceType<T>;
}

function findAll<T extends typeof BaseModifier>(this: T, target: CDOTA_BaseNPC): InstanceType<T>[] {
    // eslint-disable-next-line no-restricted-syntax
    return target.FindAllModifiersByName(this.name) as InstanceType<T>[];
}

function createThinker<T extends typeof BaseModifier>(
    this: T,
    caster: CDOTA_BaseNPC | undefined,
    ability: T extends new () => CustomModifier<infer A> ? A : never,
    at: Vector,
    modifierTable: OnCreatedParams<T>,
    phantomBlocker?: true
): [thinker: CDOTA_BaseNPC, modifier: InstanceType<T> | undefined] {
    // eslint-disable-next-line no-restricted-syntax
    const thinker = CreateModifierThinker(
        caster,
        ability,
        this.name,
        modifierTable,
        at,
        caster?.GetTeam() ?? DotaTeam.NOTEAM,
        phantomBlocker ?? false
    );

    // eslint-disable-next-line no-restricted-syntax
    const modifier = thinker.FindModifierByName(this.name) as InstanceType<T> | undefined;

    return [thinker, modifier];
}

export class CustomModifier<A extends CDOTABaseAbility | undefined = CustomAbility> extends BaseModifier {
    caster = this.GetCaster() as CDOTA_BaseNPC;
    parent = this.GetParent();
    ability = this.GetAbility() as A;

    private specialValueCache: Partial<Record<string, number>> = {};

    public static findOne = findOne;
    public static findAll = findAll;
    public static hasOne = hasOne;
    public static createThinker = createThinker;

    static apply<T extends typeof BaseModifier>(
        this: T,
        target: CDOTA_BaseNPC,
        caster: CDOTA_BaseNPC,
        ability: T extends new () => CustomModifier<infer A> ? A : never,
        modifierTable: OnCreatedParams<T>
    ): InstanceType<T> | undefined {
        // eslint-disable-next-line no-restricted-syntax
        return target.AddNewModifier(caster, ability, this.name, modifierTable) as InstanceType<T>;
    }

    // We have to make an unused kv: unknown even though we are overriding an interface method here and have no choice
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnRefresh(kv: unknown) {
        if (!IsValidEntity(this.ability)) {
            return;
        }

        for (const key of Object.keys(this.specialValueCache)) {
            this.specialValueCache[key] = this.ability.GetSpecialValueFor(key);
        }
    }

    Value(name: string) {
        if (!this.ability) {
            throw "Trying to call this.Value for a modifier applied without an ability";
        }

        const cached = this.specialValueCache[name];
        if (cached == undefined) {
            const value = this.ability.GetSpecialValueFor(name);
            this.specialValueCache[name] = value;
            return value;
        } else {
            return cached;
        }
    }
}

export class CustomModifierMotionHorizontal<A extends CDOTABaseAbility | undefined = CustomAbility> extends BaseModifierMotionHorizontal {
    caster = this.GetCaster() as CDOTA_BaseNPC;
    parent = this.GetParent();
    ability = this.GetAbility() as A;

    private specialValueCache: Partial<Record<string, number>> = {};

    public static findOne = findOne;
    public static findAll = findAll;
    public static createThinker = createThinker;

    static apply<T extends typeof BaseModifier>(
        this: T,
        target: CDOTA_BaseNPC,
        caster: CDOTA_BaseNPC,
        ability: T extends new () => CustomModifierMotionHorizontal<infer A> ? A : never,
        modifierTable: OnCreatedParams<T>
    ): InstanceType<T> | undefined {
        // eslint-disable-next-line no-restricted-syntax
        return target.AddNewModifier(caster, ability, this.name, modifierTable) as InstanceType<T>;
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnRefresh(kv: unknown) {
        if (!IsValidEntity(this.ability)) {
            return;
        }

        for (const key of Object.keys(this.specialValueCache)) {
            this.specialValueCache[key] = this.ability.GetSpecialValueFor(key);
        }
    }

    Value(name: string) {
        if (!this.ability) {
            throw "Trying to call this.Value for a modifier applied without an ability";
        }

        const cached = this.specialValueCache[name];
        if (cached == undefined) {
            const value = this.ability.GetSpecialValueFor(name);
            this.specialValueCache[name] = value;
            return value;
        } else {
            return cached;
        }
    }
}

export class CustomModifierMotionVertical<A extends CDOTABaseAbility | undefined = CustomAbility> extends BaseModifierMotionVertical {
    caster = this.GetCaster() as CDOTA_BaseNPC;
    parent = this.GetParent();
    ability = this.GetAbility() as A;

    public static findOne = findOne;
    public static findAll = findAll;
    public static createThinker = createThinker;

    static apply<T extends typeof BaseModifier>(
        this: T,
        target: CDOTA_BaseNPC,
        caster: CDOTA_BaseNPC,
        ability: T extends new () => CustomModifierMotionVertical<infer A> ? A : never,
        modifierTable: OnCreatedParams<T>
    ): InstanceType<T> | undefined {
        // eslint-disable-next-line no-restricted-syntax
        return target.AddNewModifier(caster, ability, this.name, modifierTable) as InstanceType<T>;
    }
}

export class CustomModifierMotionBoth<A extends CDOTABaseAbility | undefined = CustomAbility> extends BaseModifierMotionBoth {
    caster = this.GetCaster() as CDOTA_BaseNPC;
    parent = this.GetParent();
    ability = this.GetAbility() as A;

    public static findOne = findOne;
    public static findAll = findAll;
    public static createThinker = createThinker;

    static apply<T extends typeof BaseModifier>(
        this: T,
        target: CDOTA_BaseNPC,
        caster: CDOTA_BaseNPC,
        ability: T extends new () => CustomModifierMotionBoth<infer A> ? A : never,
        modifierTable: OnCreatedParams<T>
    ): InstanceType<T> | undefined {
        // eslint-disable-next-line no-restricted-syntax
        return target.AddNewModifier(caster, ability, this.name, modifierTable) as InstanceType<T>;
    }
}
