import { toplevelRoot } from "../components/topLevelRoot";
import { std } from "../std";
import { subscribeToNetTableKey } from "../util";

const root = toplevelRoot(["loadingHUD"]);
std.label(root, { class: "loadingText", text: "Loading..." });

function setVisibility(visible: boolean, delay: number) {
    root.style.transitionDuration = `${delay}s`;
    root.SetHasClass("loadingHUD--visible", visible);
}

const delay = 0.3;

subscribeToNetTableKey("main", "loading", true, loading => {
    if (loading.loading == 0) {
        setVisibility(false, delay);
        return;
    }

    setVisibility(true, 0);
});
