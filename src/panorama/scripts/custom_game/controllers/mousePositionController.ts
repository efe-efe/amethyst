(function(){
    const thinkInterval = 0.01;
    
    function Update(): void{
        const mousePositionScreen = GameUI.GetCursorPosition();
        const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);
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
})();