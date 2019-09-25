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


        var distance_x = (hero_screen_x - mouse_position[0]);
        var distance_y = (hero_screen_y - mouse_position[1]);

        var pos_x = hero_screen_x + (distance_x)*-1/2.5; 
        var pos_y = hero_screen_y + distance_y*-1/2.5;

        var camera_position = Game.ScreenXYToWorld(pos_x, pos_y);
        
        GameUI.SetCameraTargetPosition( camera_position, 0.15 )

        $.Schedule( 0.01, tic );
    })();
}

//TODO: Make it UTIL
function ArrayEquals(array1, array2) {
    // if the other array is a falsy value, return
    if (!array2)
        return false;

    // compare lengths - can save a lot of time 
    if (array1.length != array2.length)
        return false;

    for (var i = 0, l=array1.length; i < l; i++) {
        // Check if we have nested arrays
        if (array1[i] instanceof Array && array2[i] instanceof Array) {
            // recurse into the nested arrays
            if (!array1[i].equals(array2[i]))
                return false;       
        }           
        else if (array1[i] != array2[i]) { 
            // Warning - two different object instances will never be equal: {x:20} != {x:20}
            return false;   
        }           
    }       
    return true;
}

//array1-array2
function ArrayRest(array1, array2){
    var rest = array1.map(function (num, idx) {
        return num - array2[idx];
    })

    return rest;
}

//array1+array2
function ArraySum(array1, array2){
    var sum = array1.map(function (num, idx) {
        return num + array2[idx];
    })

    return sum;
}

//array1+array2
function ArrayMult(array1, factor){
    var mult = array1.map(function (num) {
        return num * factor;
    })

    return mult;
}

(function() {
    $.Msg("Camera Loaded");
    UpdatePosition();
})();

