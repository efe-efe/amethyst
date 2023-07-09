import { precacheResources, startGame } from "./game_init";

// eslint-disable-next-line @typescript-eslint/naming-convention
function Precache(this: void, context: CScriptPrecacheContext) {
    precacheResources(context);
}

// eslint-disable-next-line @typescript-eslint/naming-convention
function Activate() {
    startGame();
}

// eslint-disable-next-line @typescript-eslint/naming-convention
Object.assign(getfenv(), { Activate, Precache });
