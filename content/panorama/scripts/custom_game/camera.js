var camera_distance = 0;
var camera_distance_actual = 0;
var camera_distance_lerp = 30;
var camera_position_lerp = 0.15;
var camera_position_lerp_fast = 0.05;

function ChangeDistanceOffset(data){
    camera_distance = data.offset;

    if(data.lerp){
        camera_distance_lerp = data.lerp;
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
        
        camera_position_lerp = 0.15;
        if( hero_screen_x < 0 ){
            hero_screen_x = 0
            camera_position_lerp = camera_position_lerp_fast
        }
        if( hero_screen_x > sw ){
            hero_screen_x = sw
            camera_position_lerp = camera_position_lerp_fast
        }

        if( hero_screen_y < 0 ){
            hero_screen_y = 0
            camera_position_lerp = camera_position_lerp_fast
        }
        if( hero_screen_y > sh ){
            hero_screen_y = sh
            camera_position_lerp = camera_position_lerp_fast
        }

        var distance_x = (hero_screen_x - mouse_position[0]);
        var distance_y = (hero_screen_y - mouse_position[1]);

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

(function() {
    UpdatePosition();
    GameEvents.Subscribe( "change_distance_offset", ChangeDistanceOffset );
})();

