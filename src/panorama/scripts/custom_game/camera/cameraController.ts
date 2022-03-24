(function(){
    const LERP_INITIAL = 0.10;
    const LERP_FAST = 0.05;
    const thinkInterval = 0.01;
    const cameraOffsetY = -120;
    const cameraDistance = 0;
    const cameraDistanceLerp = 30;
    let cameraDistanceActual = 0;
    let playerId = Players.GetLocalPlayer();
    let hero = Players.GetPlayerHeroEntityIndex(playerId);
    let heroOrigin = Entities.GetAbsOrigin(hero);
    let initialized = false;

    Update();

    function Update(): void{
        heroOrigin = Entities.GetAbsOrigin(hero);

        if(!heroOrigin){ 
            playerId = Players.GetLocalPlayer();
            hero = Players.GetPlayerHeroEntityIndex(playerId);
            $.Schedule(thinkInterval, Update); 
            return; 
        }

            
        if(Game.IsInToolsMode()){
            const heroIndex = Players.GetSelectedEntities(playerId)[0];
            if(heroIndex){
                heroOrigin = Entities.GetAbsOrigin(heroIndex);
            }
        }

        if(initialized === false){
            GameUI.SetCameraTargetPosition(heroOrigin, 0.0);
            initialized = true;
            $.Schedule(thinkInterval, Update); 
            return; 
        }

        UpdatePosition();
        UpdateDistance();
        $.Schedule(thinkInterval, Update); 
    }

    function UpdatePosition(): void{
        const mousePosition = GameUI.GetCursorPosition();
        const sw = Game.GetScreenWidth();
        const sh = Game.GetScreenHeight();

        let cameraPosition = [];
        let cameraPositionLerp = LERP_INITIAL;
        let heroScreenX = Game.WorldToScreenX(heroOrigin[0], heroOrigin[1], heroOrigin[2]);	
        let heroScreenY = Game.WorldToScreenY(heroOrigin[0], heroOrigin[1], heroOrigin[2]);


        if(heroScreenX == -1 && heroScreenY == -1){
            cameraPosition = heroOrigin;
            cameraPositionLerp = LERP_FAST;
        } else { 
            if(heroScreenX < 0){
                heroScreenX = 0;
                cameraPositionLerp = LERP_FAST;
            }
            if(heroScreenX > sw){
                heroScreenX = sw;
                cameraPositionLerp = LERP_FAST;
            }

            if(heroScreenY < 0){
                heroScreenY = 0;
                cameraPositionLerp = LERP_FAST;
            }
            if(heroScreenY > sh){
                heroScreenY = sh;
                cameraPositionLerp = LERP_FAST;
            }

            const distanceX = (heroScreenX - mousePosition[0]);
            const distanceY = (heroScreenY - mousePosition[1]) + cameraOffsetY;

            const newScreenPosX = heroScreenX + distanceX * -1/2.5; 
            const newScreenPosY = heroScreenY + distanceY * -1/2.5;
            
            if(!GameUI.GetScreenWorldPosition([newScreenPosX, newScreenPosY])){
                return;
            } 

            cameraPosition = Game.ScreenXYToWorld(newScreenPosX, newScreenPosY);
        }

        GameUI.SetCameraTargetPosition(cameraPosition, cameraPositionLerp);
    }

    function UpdateDistance(): void{
        // Smooth camera distance changes
        if (cameraDistanceActual < cameraDistance){
            cameraDistanceActual = cameraDistanceActual + cameraDistanceLerp;
        } else if(cameraDistanceActual > cameraDistance) {
            cameraDistanceActual = cameraDistanceActual - cameraDistanceLerp;
        }
        GameUI.SetCameraLookAtPositionHeightOffset(cameraDistanceActual);
    }
})();