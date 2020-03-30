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
function OnLeftButtonPressed()
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
function OnRightButtonPressed()
{
    ExecuteAbility(SECOND_ATTACK_INDEX);
}


// Handle Right Button events
function OnRightButtonReleased()
{
    OnReleaseKey("m2");
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
            OnLeftButtonPressed();
            if(Game.IsInToolsMode()){
                return CONTINUE_PROCESSING_EVENT;
            } else {
                return CONSUME_EVENT;
            }
		}

		if ( nMouseButton === 1 )
		{
			OnRightButtonPressed();
			return CONSUME_EVENT;
        }
    }
    if (eventName === "released"){
        if ( nMouseButton === 1 )
		{
			OnRightButtonReleased();
			return CONSUME_EVENT;
        }
    }
	if ( eventName === "doublepressed" ){ return CONSUME_EVENT }
	return CONTINUE_PROCESSING_EVENT;
} );

function OnReleaseKey( key ){
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );
    heroIndex = Players.GetSelectedEntities( playerId )[0]; //DEBUG
    
    GameEvents.SendCustomGameEventToServer("key_released", { 
        entityIndex: heroIndex,
        key: key,
    });
}

function ExecuteAbility(index)
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );
    heroIndex = Players.GetSelectedEntities( playerId )[0]; //DEBUG
    var abilityIndex = Entities.GetAbility( heroIndex, index );

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

function UseItem(itemSlot)
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex( playerId );
    heroIndex = Players.GetSelectedEntities( playerId )[0]; //DEBUG

    if(heroIndex == -1){
        $.Msg("[Custom Bindings] Invalid hero: The hero hasn't been asigned yet");
    }
    else{
        GameEvents.SendCustomGameEventToServer("use_item", { 
            entityIndex: heroIndex,
            itemSlot: itemSlot
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
Game.OnPress1 = function(){        UseItem(0) }
Game.OnPress2 = function(){        UseItem(1) }
Game.OnPress3 = function(){        UseItem(2) }
Game.OnPress4 = function(){        UseItem(3) }
Game.OnPress5 = function(){        UseItem(4) }
Game.OnPress6 = function(){        UseItem(5) }
Game.OnPressQ = function(){        ExecuteAbility(COUNTER_INDEX) }
Game.OnPressE = function(){        ExecuteAbility(SPECIAL_ATTACK_INDEX) }
Game.OnPressR = function(){        ExecuteAbility(EX_ULTIMATE_INDEX) }
Game.OnPressF = function(){        ExecuteAbility(ULTIMATE_INDEX) }
Game.OnPressZ = function(){        ExecuteAbility(MOUNT) }
Game.OnReleaseSpace = function(){   OnReleaseKey("space") }
Game.OnPressW = function(){        SendMovementSignal( "move_unit", "up" ) }
Game.OnReleaseW = function(){      SendMovementSignal( "stop_unit", "up" ) }
Game.OnPressD = function(){        SendMovementSignal( "move_unit", "right" ) }
Game.OnReleaseD = function(){      SendMovementSignal( "stop_unit", "right" ) }
Game.OnPressA = function(){        SendMovementSignal( "move_unit", "left" ) }
Game.OnReleaseA = function(){      SendMovementSignal( "stop_unit", "left" ) }
Game.OnPressS = function(){        SendMovementSignal( "move_unit", "down" ) }
Game.OnReleaseS = function(){      SendMovementSignal( "stop_unit", "down" ) }
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
