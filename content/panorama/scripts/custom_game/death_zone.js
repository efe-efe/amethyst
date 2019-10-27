function OnDeathZoneInitiated()
{
    $('#DeathZoneText').style.opacity = 1.0;

    $.Schedule( 8.0, function(){
        $('#DeathZoneText').style.opacity = 0.0;
    });

}


(function () {
    GameEvents.Subscribe( "death_zone_initiated", OnDeathZoneInitiated );
})();