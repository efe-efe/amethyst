type Resource = { type: PrecacheType | "unit"; path: string };

const precacheState: {
    resources: Resource[];
    locked: boolean;
} = {
    resources: [],
    locked: false
};

export function precache<T extends { [key: string]: Resource }>(resources: T): T {
    if (!precacheState.locked && !IsClient()) {
        precacheState.resources.push(...Object.values(resources));
    }

    return resources;
}

export function getPrecacheListAndLock(): Resource[] {
    precacheState.locked = true;
    return precacheState.resources;
}

export namespace resource {
    export type FX = ReturnType<typeof fx>;
    export type Unit = ReturnType<typeof unit>;

    export function fx(path: `${string}.vpcf`) {
        return { type: PrecacheType.particle, path } as const;
    }

    export function model(path: `${string}.vmdl`) {
        return { type: PrecacheType.model, path } as const;
    }

    export function fxRaw(path: string) {
        return { type: PrecacheType.particle, path: path as `${string}.vpcf` } as const;
    }

    export function soundFile(path: `${string}.vsndevts`) {
        return { type: PrecacheType.soundfile, path } as const;
    }

    export function unit(path: `npc_dota_${string}`) {
        return { type: "unit", path } as const;
    }
}
