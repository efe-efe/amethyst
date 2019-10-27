"use strict";

//Custom key bindings

var BASIC_ATTACK_INDEX = 0; 
var SECOND_ATTACK_INDEX = 1; 
var MOBILITY_ABILITY_INDEX = 2;
var COUNTER_INDEX = 3;
var SPECIAL_ATTACK_INDEX = 4;
var EX_ULTIMATE_INDEX = 5;
var ULTIMATE_INDEX = 6;
var EX_ABILITY_ONE_INDEX = 7; 
var EX_ABILITY_TWO_INDEX = 8; 
var MOUNT = 9; 

// Handle Left Button events
function OnLeftButtOnPressed()
{
    ExecuteAbility(BASIC_ATTACK_INDEX);
    (function tic()
    {
        if ( GameUI.IsMouseDown( 0 ) ){
            ExecuteAbility(BASIC_ATTACK_INDEX);
            $.Schedule( 0.1, tic );
        }
    })();
}

// Handle Right Button events
function OnRightButtOnPressed()
{
    ExecuteAbility(SECOND_ATTACK_INDEX);
}

// Main mouse event callback
GameUI.SetMouseCallback( function( eventName, arg ) {
	var nMouseButton = arg
	var CONSUME_EVENT = true;
    var CONTINUE_PROCESSING_EVENT = false;
    
	if ( GameUI.GetClickBehaviors() !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE ){
        return CONTINUE_PROCESSING_EVENT;
    }

	if ( eventName === "pressed" )
	{
		if ( nMouseButton === 0 )
		{
            OnLeftButtOnPressed();
            return CONSUME_EVENT;//CONTINUE_PROCESSING_EVENT;
		}

		if ( nMouseButton === 1 )
		{
			OnRightButtOnPressed();
			return CONSUME_EVENT;
        }
    }
	if ( eventName === "doublepressed" ){ return CONSUME_EVENT }
	return CONTINUE_PROCESSING_EVENT;
} );

function ExecuteAbility(index)
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );
    var abilityIndex = Entities.GetAbility( heroIndex, index );
    
    //Debug
    heroIndex = Players.GetSelectedEntities( playerId )[0];
    abilityIndex = Entities.GetAbility( heroIndex, index );

    if(heroIndex == -1){
        $.Msg("[Custom Bindings] Invalid hero: The hero hasn't been asigned yet");
    }
    else if(!abilityIndex){
        $.Msg("[Custom Bindings] Invalid ability: The ability doesn't exist");
    }
    else{
        GameEvents.SendCustomGameEventToServer("execute_ability", { 
            entityIndex: heroIndex,
            abilityIndex: abilityIndex
        });
    }
}

function SendMovementSignal( action, direction )
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );
    
    //Debug
    heroIndex = Players.GetSelectedEntities( playerId )[0];
    
    GameEvents.SendCustomGameEventToServer(action, { 
        entityIndex: heroIndex,
        direction: direction
    });
}

Game.OnPressSpace = function(){    ExecuteAbility(MOBILITY_ABILITY_INDEX) }
Game.OnPress1 = function(){        ExecuteAbility(EX_ABILITY_ONE_INDEX) }
Game.OnPress2 = function(){        ExecuteAbility(EX_ABILITY_TWO_INDEX) }
Game.OnPressQ = function(){        ExecuteAbility(COUNTER_INDEX) }
Game.OnPressE = function(){        ExecuteAbility(SPECIAL_ATTACK_INDEX) }
Game.OnPressR = function(){        ExecuteAbility(EX_ULTIMATE_INDEX) }
Game.OnPressF = function(){        ExecuteAbility(ULTIMATE_INDEX) }
Game.OnPressZ = function(){        ExecuteAbility(MOUNT) }
Game.OnPressW = function(){        SendMovementSignal( "moveUnit", "up" ) }
Game.OnReleaseW = function(){      SendMovementSignal( "stopUnit", "up" ) }
Game.OnPressD = function(){        SendMovementSignal( "moveUnit", "right" ) }
Game.OnReleaseD = function(){      SendMovementSignal( "stopUnit", "right" ) }
Game.OnPressA = function(){        SendMovementSignal( "moveUnit", "left" ) }
Game.OnReleaseA = function(){      SendMovementSignal( "stopUnit", "left" ) }
Game.OnPressS = function(){        SendMovementSignal( "moveUnit", "down" ) }
Game.OnReleaseS = function(){      SendMovementSignal( "stopUnit", "down" ) }
Game.OnPressC = function(){
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );

    var order = {
		OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_HOLD_POSITION,
		QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
        ShowEffects : false,
        TargetIndex : heroIndex
    };
    
    Game.PrepareUnitOrders( order );
}
Game.OnPressShift = function(){            
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );

    GameEvents.SendCustomGameEventToServer("swap_abilities", { 
        entityIndex: heroIndex,
        mode: "press",
    });
}
Game.OnReleaseShift = function(){                  
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );

    GameEvents.SendCustomGameEventToServer("swap_abilities", { 
        entityIndex: heroIndex,
        mode: "release",
    });
}
