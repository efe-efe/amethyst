import { PanelOptions, std } from "../std";

export function delayedProgressBarComponent(parent: Panel, options?: PanelOptions & { min?: number; max?: number; value?: number }) {
    const classes = ["delayed-progress-bar"];

    if (typeof options?.class == "string") {
        classes.push(options.class);
    }

    if (typeof options?.class == "object") {
        classes.push(...options.class);
    }

    const root = std.panel(parent, { class: classes });
    const back = std.progressBar(root, { ...options, class: "delayed-progress-bar__back", min: 0 });
    const front = std.progressBar(root, { ...options, class: "delayed-progress-bar__front", min: 0 });

    function setWidth(width: number) {
        root.style.width = `${width}%`;
    }

    function setMax(value: number) {
        back.max = value;
        front.max = value;
    }

    function setValue(value: number) {
        back.value = value;
        front.value = value;
    }

    return {
        setMax,
        setValue,
        setWidth
    };
}
