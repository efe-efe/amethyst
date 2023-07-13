import { heroOverheadComponent, unitOverheadComponent } from "../components/overhead";
import { toplevelRoot } from "../components/topLevelRoot";
import { subscribeToNetTableAndLoadNow } from "../util";

const root = toplevelRoot("overheadHUD");
const heroOverheads = new Map<EntityIndex, ReturnType<typeof heroOverheadComponent>>();
const unitOverheads = new Map<EntityIndex, ReturnType<typeof unitOverheadComponent>>();

subscribeToNetTableAndLoadNow("units", (table, key, value) => {
    const entityIndex = value.entityIndex as EntityIndex;

    if (value.heroData) {
        const overhead = heroOverheads.get(entityIndex) ?? heroOverheadComponent(root, entityIndex);

        if (!heroOverheads.has(entityIndex)) {
            heroOverheads.set(entityIndex, overhead);
        }

        overhead.update(value);

        return;
    }

    const overhead = unitOverheads.get(entityIndex) ?? unitOverheadComponent(root, entityIndex);

    if (!unitOverheads.has(entityIndex)) {
        unitOverheads.set(entityIndex, overhead);
    }

    overhead.update(value);
});
