import { precache, resource } from "./precache";

type LegendDefinition = {
    id: LegendId;
    model: string;
};

type LegendOptions = {
    id: LegendId;
    model: string;
};

const resources = precache({
    apparitionModel: resource.model("models/items/ancient_apparition/aa_frozenberserker_head/aa_frozenberserker_head.vmdl"),
    timbersawModel: resource.model("models/items/shredder/timbersaw_ti9_immortal_offhand/timbersaw_ti9_immortal_offhand_blade.vmdl")
});

export const legendDefinitions: LegendDefinition[] = [];

export function defineLegend(options: LegendOptions) {
    legendDefinitions.push({
        id: options.id,
        model: options.model
    });

    print(`Defined legend: ${options.id}`);
}

defineLegend({
    id: LegendId.apparition,
    model: resources.apparitionModel.path
});

defineLegend({
    id: LegendId.timbersaw,
    model: resources.timbersawModel.path
});

export function findLegendById(id: LegendId) {
    return legendDefinitions.find(definition => definition.id == id);
}
