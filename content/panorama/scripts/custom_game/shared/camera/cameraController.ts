export default class CameraController{
    private thinkInterval = 0.01;
    private LERP_INITIAL = 0.10;
    private LERP_FAST = 0.05;
    private cameraOffsetY = -120;
    private cameraDistance = 0;
    private cameraDistanceActual = 0;
    private cameraDistanceLerp = 30;

    private playerId = Players.GetLocalPlayer();
    private hero = Players.GetPlayerHeroEntityIndex(this.playerId);
    private heroOrigin = Entities.GetAbsOrigin(this.hero);
    private initialized = false;

    constructor(){
        this.Update();
    }

    private Update(): void{
        this.heroOrigin = Entities.GetAbsOrigin(this.hero);

        if(!this.heroOrigin){ 
            this.playerId = Players.GetLocalPlayer();
            this.hero = Players.GetPlayerHeroEntityIndex(this.playerId);
            $.Schedule(this.thinkInterval, () => {
                this.Update();
            }); 
            return; 
        }

        if(this.initialized === false){
            GameUI.SetCameraTargetPosition(this.heroOrigin, 0.0);
            this.initialized = true;
            $.Schedule(this.thinkInterval, () => {
                this.Update();
            }); 
            return; 
        }

        this.UpdatePosition();
        this.UpdateDistance();
        $.Schedule(this.thinkInterval, () => {
            this.Update();
        }); 
    }

    private UpdatePosition(): void{
        const mousePosition = GameUI.GetCursorPosition();
        const sw = Game.GetScreenWidth();
        const sh = Game.GetScreenHeight();

        //$.Msg(heroScreenX, "<-- x ! y --> ", heroScreenY)
        let cameraPosition = [];
        let cameraPositionLerp = this.LERP_INITIAL;
        let heroScreenX = Game.WorldToScreenX(this.heroOrigin[0], this.heroOrigin[1], this.heroOrigin[2]);	
        let heroScreenY = Game.WorldToScreenY(this.heroOrigin[0], this.heroOrigin[1], this.heroOrigin[2]);


        if(heroScreenX == -1 && heroScreenY == -1){
            cameraPosition = this.heroOrigin;
            cameraPositionLerp = this.LERP_FAST;
        } else { 

            if(heroScreenX < 0){
                heroScreenX = 0;
                cameraPositionLerp = this.LERP_FAST;
            }
            if(heroScreenX > sw){
                heroScreenX = sw;
                cameraPositionLerp = this.LERP_FAST;
            }

            if(heroScreenY < 0){
                heroScreenY = 0;
                cameraPositionLerp = this.LERP_FAST;
            }
            if(heroScreenY > sh){
                heroScreenY = sh;
                cameraPositionLerp = this.LERP_FAST;
            }

            const distanceX = (heroScreenX - mousePosition[0]);
            const distanceY = (heroScreenY - mousePosition[1]) + this.cameraOffsetY;

            const newScreenPosX = heroScreenX + distanceX * -1/2.5; 
            const newScreenPosY = heroScreenY + distanceY * -1/2.5;
            
            /*

            const currentCameraPosition: number[] = GameUI.GetCameraPosition();
            const currentScreenPositionX = Game.WorldToScreenX(
                currentCameraPosition[0], currentCameraPosition[1], currentCameraPosition[2]
            );
            const currentScreenPositionY = Game.WorldToScreenY(
                currentCameraPosition[0], currentCameraPosition[1], currentCameraPosition[2]
            );

            if(!GameUI.GetScreenWorldPosition([currentScreenPositionX, newScreenPosY])){
                newScreenPosY = currentScreenPositionY;
            }
            */
            
            
            if(!GameUI.GetScreenWorldPosition([newScreenPosX, newScreenPosY])){
                return;
            } 

            cameraPosition = Game.ScreenXYToWorld(newScreenPosX, newScreenPosY);

            /*
            $.Msg(currentCameraPosition, '\n', cameraPosition, '\n\n');
            $.Msg('[',newScreenPosX, ', ', newScreenPosY, ']\n', '[',currentScreenPositionX, ', ', currentScreenPositionY, ']\n\n');
            */
        }

        GameUI.SetCameraTargetPosition(cameraPosition, cameraPositionLerp);
    }

    private UpdateDistance(): void{
        // Smooth camera distance changes
        if (this.cameraDistanceActual < this.cameraDistance){
            this.cameraDistanceActual = this.cameraDistanceActual + this.cameraDistanceLerp;
        } else if(this.cameraDistanceActual > this.cameraDistance) {
            this.cameraDistanceActual = this.cameraDistanceActual - this.cameraDistanceLerp;
        }

        GameUI.SetCameraLookAtPositionHeightOffset(this.cameraDistanceActual);
    }
}