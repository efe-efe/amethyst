import { std } from "../std";

export function toplevelRoot(options?: string | string[] | { className?: string | string[]; visible?: boolean }) {
    function parseClassName(classNames: string | string[] | undefined) {
        return typeof classNames == "string" ? [classNames] : classNames;
    }

    const classNames = typeof options == "string" || Array.isArray(options) ? parseClassName(options) : parseClassName(options?.className);
    const visible = typeof options == "object" && !Array.isArray(options) ? options.visible : true;

    const root = std.panel($.GetContextPanel(), { hitTest: false, class: S.fullscreen, visible });

    if (Array.isArray(classNames)) {
        for (const className of classNames) {
            root.AddClass(className);
        }
    }

    return root;
}
