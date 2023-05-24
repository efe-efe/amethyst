import { std } from "../std";

export function toplevelRoot(options?: string | { className?: string; visible?: boolean }) {
    const className = typeof options == "string" ? options : options?.className;
    const visible = typeof options == "object" ? options.visible : true;

    const root = std.panel($.GetContextPanel(), { hitTest: false, class: S.fullscreen, visible });

    if (className) {
        root.AddClass(className);
    }

    return root;
}
