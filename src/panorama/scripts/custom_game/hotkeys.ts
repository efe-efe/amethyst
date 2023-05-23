import { setOnLeftClickPressed, setOnLeftClickReleased, setOnRightClickPressed, setOnRightClickReleased } from "./mouse";

export type KeyCode = "W" | "A" | "S" | "D" | "R" | "E" | "F" | "Q" | "C" | "1" | "2" | "Space" | "MOUSE_1" | "MOUSE_2";

export function registerKeyBind(code: KeyCode, onPressed: () => void, onReleased: () => void) {
    if (code == "MOUSE_1") {
        setOnLeftClickPressed(() => onPressed());
        setOnLeftClickReleased(() => onReleased());
        return;
    }

    if (code == "MOUSE_2") {
        setOnRightClickPressed(() => onPressed());
        setOnRightClickReleased(() => onReleased());
        return;
    }

    const commandName = `Custom_Key_Bind_${Date.now().toString()}_${code}`;

    Game.AddCommand("+" + commandName, onPressed, "", 0);
    Game.AddCommand("-" + commandName, onReleased, "", 0);

    Game.CreateCustomKeyBind(code, "+" + commandName);
}
