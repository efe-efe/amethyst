function GetMousePosition()
{
    var mouse_position_screen = GameUI.GetCursorPosition();
    var mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1])
    
    GameEvents.SendCustomGameEventToServer('update_mouse_position', { 
        x: mouse_position[0], 
        y: mouse_position[1],
        z: mouse_position[2],
        playerID: Players.GetLocalPlayer() 
    });
}
    
(function() {
    GameEvents.Subscribe('get_mouse_position', GetMousePosition);
})();