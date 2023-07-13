export type PanelOptions = {
    id?: string;
    class?: string | string[];
    hitTest?: boolean;
    visible?: boolean;
    properties?: Record<string, string | number>;
};

type PanelDescendants = Exclude<keyof PanoramaPanelNameMap, "Slider" | "CircularProgressBar" | "SlottedSlider">;

type PanoramaOptionsVector = `${number} ${number} ${number}`;

function panelTyped<K extends PanelDescendants>(type: K, parent: Panel, options?: PanelOptions): PanoramaPanelNameMap[K] {
    const panel = $.CreatePanelWithProperties(type, parent, options?.id ?? "", options?.properties ?? {});

    if (options) {
        if (typeof options.class == "string") panel.AddClass(options.class);

        if (typeof options.class == "object") {
            for (const cl of options.class) {
                panel.AddClass(cl);
            }
        }

        if (options.hitTest != undefined) {
            panel.hittest = options.hitTest;
        }

        if (options.visible != undefined) {
            panel.visible = options.visible;
        }
    }

    return panel;
}

export namespace std {
    export function image(parent: Panel, options?: PanelOptions & { src?: string; scaling?: ScalingFunction }) {
        const image = panelTyped("Image", parent, options);

        if (options) {
            if (options.src) image.SetImage(options.src);
            if (options.scaling) image.SetScaling(options.scaling);
        }

        return image;
    }

    export function panel(parent: Panel, options?: PanelOptions) {
        return panelTyped("Panel", parent, options);
    }

    export function button(parent: Panel, options?: PanelOptions) {
        return panelTyped("Button", parent, options);
    }

    export function toggleButton(parent: Panel, options?: PanelOptions) {
        return panelTyped("ToggleButton", parent, options);
    }

    export function radioButton(parent: Panel, options?: PanelOptions) {
        return panelTyped("RadioButton", parent, options);
    }

    export type LabelText =
        | string
        | ({
              token: string;
          } & Record<string, string | number>);

    export function label(parent: Panel, options?: PanelOptions & { text?: LabelText; html?: boolean }) {
        const label = panelTyped("Label", parent, options);

        if (options) {
            if (options.html) label.html = options.html;
            if (options.text) {
                if (typeof options.text == "string") {
                    label.text = options.text;
                } else {
                    for (const [key, value] of Object.entries(options.text)) {
                        if (key == "token") continue;

                        if (typeof value == "number") {
                            label.SetDialogVariableInt(key, value);
                        } else {
                            label.SetDialogVariable(key, value);
                        }
                    }

                    label.text = $.Localize(options.text.token, label);
                }
            }
        }

        return label;
    }

    export function input(
        parent: Panel,
        options?: PanelOptions & {
            text?: string;
            textmode?: "normal" | "numeric" | "password";
        }
    ) {
        const input = panelTyped(
            "TextEntry",
            parent,
            options
                ? {
                      ...options,
                      properties: options.properties
                          ? {
                                ...options.properties,
                                textmode: options.textmode ?? "normal"
                            }
                          : { textmode: options.textmode ?? "normal" }
                  }
                : undefined
        );

        if (options && options.text) {
            input.text = options.text;
        }

        return input;
    }

    export function progressBar(parent: Panel, options?: PanelOptions & { min?: number; max?: number; value?: number }) {
        const panel = panelTyped("ProgressBar", parent, options);

        if (options) {
            if (options.min) panel.min = options.min;
            if (options.max) panel.max = options.max;
            if (options.value) panel.value = options.value;
        }

        return panel;
    }

    export function scenePanel(parent: Panel, options?: PanelOptions & { hero?: HeroName }) {
        const panel = panelTyped("DOTAScenePanel", parent, options);

        if (options) {
            if (options.hero) panel.SetUnit(options.hero, "default", true);
        }

        return panel;
    }

    interface ParticleScenePanelOptions {
        particleName: ParticlePath;
        particleonly?: boolean;
        cameraOrigin?: PanoramaOptionsVector;
        lookAt?: PanoramaOptionsVector;
        fov?: string;
        startActive?: boolean;
    }

    export function particleScenePanel(parent: Panel, options?: PanelOptions & ParticleScenePanelOptions) {
        const properties: Record<string, string | number> = {};

        if (options) {
            properties.particleName = options.particleName;
            properties.particleOnly = String(options.particleonly ?? false);
            properties.cameraOrigin = options.cameraOrigin ?? "0 0 50";
            properties.lookAt = options.lookAt ?? "0 0 0";
            properties.fov = options.fov ?? "90";
            properties.startActive = String(options.startActive ?? true);
        }

        return panelTyped("DOTAParticleScenePanel", parent, {
            ...options,
            properties
        });
    }

    export function heroImage(
        parent: Panel,
        options?: PanelOptions & {
            hero?: HeroName;
            style?: "icon" | "portrait" | "landscape";
        }
    ) {
        const panel = panelTyped("DOTAHeroImage", parent, options);

        if (options) {
            if (options.hero) panel.heroname = options.hero;
            if (options.style) panel.heroimagestyle = options.style;
        }

        return panel;
    }

    export function abilityImage(parent: Panel, options?: PanelOptions & { ability?: string; scaling?: ScalingFunction }) {
        const panel = panelTyped("DOTAAbilityImage", parent, options);

        if (options) {
            if (options.ability) panel.abilityname = options.ability;
            if (options.scaling) panel.SetScaling(options.scaling);
        }

        return panel;
    }

    export function avatarImage(parent: Panel, options?: PanelOptions & { steamid?: string }) {
        const panel = panelTyped("DOTAAvatarImage", parent, options);
        panel.style.width = "100%;";
        panel.style.height = "100%;";

        if (options) {
            if (options.steamid) panel.steamid = options.steamid;
        }

        return panel;
    }
}
