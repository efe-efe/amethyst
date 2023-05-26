type ParticlePath = `particles/${string}.vpcf`;
type HeroName = string & { heroNameBrand: unknown };

declare enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1
}

declare enum Custom_ActionModes {
    START = 0,
    STOP = 1
}

type Nothing = Record<symbol, never>;
