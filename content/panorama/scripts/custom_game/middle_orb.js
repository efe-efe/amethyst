function OnMiddleOrbScheduled( data )
{
    GameUI.PingMinimapAtLocation( data.spawn_location );
}


(function () {
    GameEvents.Subscribe( "middle_orb_scheduled", OnMiddleOrbScheduled );
})();