const thinkInterval = 0.01;
let cached: [number, number, number] | undefined = undefined;

function Update(): void {
    const mousePositionScreen = GameUI.GetCursorPosition();
    const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);

    if (!cached) {
        cached = mousePosition;
    } else if (cached[0] == mousePosition[0] && cached[1] == mousePosition[1] && cached[2] == mousePosition[2]) {
        $.Schedule(thinkInterval, () => {
            Update();
        });

        return;
    }

    const data = {
        x: mousePosition[0],
        y: mousePosition[1],
        z: mousePosition[2],
        playerId: Players.GetLocalPlayer()
    } as never;

    GameEvents.SendCustomGameEventToServer("update_mouse_position", data);

    $.Schedule(thinkInterval, () => {
        Update();
    });
}

Update();
