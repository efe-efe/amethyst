"use strict";

function UpdateScore( data )
{
	//	$.Msg( "OnItemWillSpawn: ", data );

	if( data.winnerId == DOTATeam_t.DOTA_TEAM_GOODGUYS){
		$( "#RadiantScore" ).text = data.wins
	} else if ( data.winnerId == DOTATeam_t.DOTA_TEAM_BADGUYS){
		$( "#DireScore" ).text = data.wins;
	} else if ( data.winnerId == DOTATeam_t.DOTA_TEAM_CUSTOM_1){
		$( "#CustomOneScore" ).text = data.wins;
	} else if ( data.winnerId == DOTATeam_t.DOTA_TEAM_CUSTOM_2){
		$( "#CustomTwoScore" ).text = data.wins;
	}	
}

(function()
{
	// We use a nettable to communicate victory conditions to make sure we get the value regardless of timing.
	//CustomNetTables.SubscribeNetTableListener( "game_state", OnGameStateChanged );

    GameEvents.Subscribe( "update_score", UpdateScore );
	//UpdateTimer();
})();
