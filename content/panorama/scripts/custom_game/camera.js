var camera_distance = 0;
var camera_distance_actual = 0;

var CAMERA_POSITION_LERP_INITIAL = 0.10;
var CAMERA_POSITION_LERP_FAST = 0.05;

var camera_distance_lerp = 30;

var camera_offset_Y = -120;

//Call it without data.playerId to affect all players
function ChangeDistanceOffset(data){
    var localPlayerId = Game.GetLocalPlayerID();

    if(data.playerId == localPlayerId){
        camera_distance = data.offset;

        if(data.lerp){
            camera_distance_lerp = data.lerp;
        }
    }
}

function UpdatePosition()
{
    var initialized = false;

    (function tic()
    {
        var player_id = Players.GetLocalPlayer();
        var hero = Players.GetPlayerHeroEntityIndex( player_id );
        var hero_origin = Entities.GetAbsOrigin(hero);
        
        if(!hero_origin){ 
            hero = Players.GetPlayerHeroEntityIndex( player_id );
            $.Schedule( 0.01, tic ); return; 
        }

        if(initialized == false){
            GameUI.SetCameraTargetPosition( hero_origin, 0.0 );
            initialized = true;
            $.Schedule( 0.01, tic ); return; 
        }

        var hero_screen_x = Game.WorldToScreenX( hero_origin[0], hero_origin[1], hero_origin[2] );	
        var hero_screen_y = Game.WorldToScreenY( hero_origin[0], hero_origin[1], hero_origin[2] );
        var mouse_position = GameUI.GetCursorPosition();

        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();

        var camera_position_lerp = CAMERA_POSITION_LERP_INITIAL;
        if( hero_screen_x < 0 ){
            hero_screen_x = 0
            camera_position_lerp = CAMERA_POSITION_LERP_FAST
        }
        if( hero_screen_x > sw ){
            hero_screen_x = sw
            camera_position_lerp = CAMERA_POSITION_LERP_FAST
        }

        if( hero_screen_y < 0 ){
            hero_screen_y = 0
            camera_position_lerp = CAMERA_POSITION_LERP_FAST
        }
        if( hero_screen_y > sh ){
            hero_screen_y = sh
            camera_position_lerp = CAMERA_POSITION_LERP_FAST
        }

        var distance_x = (hero_screen_x - mouse_position[0]);
        var distance_y = (hero_screen_y - mouse_position[1]) + camera_offset_Y;

        var pos_x = hero_screen_x + (distance_x)*-1/2.5; 
        var pos_y = hero_screen_y + distance_y*-1/2.5;

        var camera_position = Game.ScreenXYToWorld(pos_x, pos_y);

        // Smooth camera distance changes
        if ( camera_distance_actual < camera_distance ){
            camera_distance_actual = camera_distance_actual + camera_distance_lerp;
        } else if( camera_distance_actual > camera_distance ) {
            camera_distance_actual = camera_distance_actual - camera_distance_lerp;
        }

        GameUI.SetCameraTargetPosition( camera_position, camera_position_lerp );
        GameUI.SetCameraLookAtPositionHeightOffset( camera_distance_actual );

        $.Schedule( 0.01, tic );
    })();
}

function UpdatePosition2()
{
    var initialized = false;

    (function tic()
    {
        var player_id = Players.GetLocalPlayer();
        var hero = Players.GetPlayerHeroEntityIndex( player_id );
        var hero_origin = Entities.GetAbsOrigin(hero);
        
        if(!hero_origin){ 
            hero = Players.GetPlayerHeroEntityIndex( player_id );
            $.Schedule( 0.01, tic ); return; 
        }

        if(initialized == false){
            GameUI.SetCameraTargetPosition( hero_origin, 0.0 );
            initialized = true;
            $.Schedule( 0.01, tic ); return; 
        }
        
        var hero_screen_x = Game.WorldToScreenX( hero_origin[0], hero_origin[1], hero_origin[2] );	
        var hero_screen_y = Game.WorldToScreenY( hero_origin[0], hero_origin[1], hero_origin[2] );
        var mouse_position = GameUI.GetCursorPosition();

        

        var distance_x = (hero_screen_x - mouse_position[0]);
        var distance_y = (hero_screen_y - mouse_position[1]);

    

        var fastTransition = true;
     
        var MaxCamDistance_x = 1300;
        var MaxCamDistance_y = 450;
        var CameraOffset_Y = -120;
        

        if(Math.abs(distance_x) > MaxCamDistance_x)
        {
            if(distance_x > 0)
            {
                distance_x = MaxCamDistance_x;
            }
            else
            {
                distance_x = -MaxCamDistance_x;
            }
        }

        
        if(Math.abs(distance_y) > MaxCamDistance_y)
        {
            if(distance_y > 0)
            {
                distance_y = MaxCamDistance_y;
                fastTransition = false;
            }
            else
            {
                distance_y = -MaxCamDistance_y;
                fastTransition = false;
            }
        }
        
        distance_y  = distance_y + CameraOffset_Y; //Vertical offset.

        var pos_x = hero_screen_x + (distance_x)*-0.4; 
        var pos_y = hero_screen_y + distance_y*-0.6;

        var camera_position = Game.ScreenXYToWorld(pos_x, pos_y);
        //Values to make camera stand perfectly still in current pos: x 801 ,y 451
    
        if(fastTransition == true)
        {
            GameUI.SetCameraTargetPosition( camera_position, 0.14 )
        }
        else
        {
            GameUI.SetCameraTargetPosition( camera_position, 0.17 )
        }   
        $.Schedule( 0.01, tic );
    })();
}

(function() {
    UpdatePosition();
    GameEvents.Subscribe( "change_distance_offset", ChangeDistanceOffset );
})();

