const thinkInterval = 0.01;
let cached: [number, number, number] = [0, 0, 0];

function Update() {
    const mousePositionScreen = GameUI.GetCursorPosition();
    const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);

    if (cached[0] != mousePosition[0] || cached[1] != mousePosition[1] || cached[2] != mousePosition[2]) {
        GameEvents.SendCustomGameEventToServer("updateMousePosition", {
            x: mousePosition[0],
            y: mousePosition[1],
            z: mousePosition[2],
            playerId: Players.GetLocalPlayer()
        });
        cached = mousePosition;
    }

    $.Schedule(thinkInterval, () => {
        Update();
    });
}

Update();
