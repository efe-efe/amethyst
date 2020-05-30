"use strict";

//Custom key bindings
var BASIC_ATTACK_INDEX = 0; 
var SECOND_ATTACK_INDEX = 1; 
var MOBILITY_ABILITY_INDEX = 2;
var COUNTER_INDEX = 3;
var SPECIAL_ATTACK_INDEX = 4;
var EX_ULTIMATE_INDEX = 5;
var ULTIMATE_INDEX = 6;

function OnLeftButtonPressed(){
    var entities = GameUI.FindScreenEntities( GameUI.GetCursorPosition() )
    entities.forEach(function(entity, i){
        if(i == 0){
            if(entity && entity.entityIndex){
                if(Entities.IsShop(entity.entityIndex)){
                    $.DispatchEvent('DOTAHUDToggleShop');
                }
            }
        }
    })

    ExecuteAbility(BASIC_ATTACK_INDEX, true);

    $.Schedule(0.1, function tic(){
        if (GameUI.IsMouseDown(0)){
            ExecuteAbility(BASIC_ATTACK_INDEX, false);
            $.Schedule(0.1, tic);
        }
    })
}

function OnRightButtonPressed(){
    $.Msg(CustomNetTables.GetAllTableValues("heroes"));

    ExecuteAbility(SECOND_ATTACK_INDEX, true);
}

function OnRightButtonReleased(){
    OnReleaseKey("m2");
}

GameUI.SetMouseCallback( function( eventName, arg ) {
	var nMouseButton = arg

	if ( GameUI.GetClickBehaviors() !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE ){
        return false;
    }
    if ( eventName === "pressed" ){
		if ( nMouseButton === 0 ){
            OnLeftButtonPressed();
            if(GameUI.IsControlDown()){
                return false;
            }
            return true;
		}

		if ( nMouseButton === 1 ){
			OnRightButtonPressed();
			return true;
        }
    }
    if (eventName === "released"){
        if ( nMouseButton === 1 ){
			OnRightButtonReleased();
			return true;
        }
    }
	if ( eventName === "doublepressed" ){ 
        return true;
    }
	return false;
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

function ExecuteAbility(index, showEffects)
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
    heroIndex = Players.GetSelectedEntities(playerId)[0]; //DEBUG
    var abilityIndex = Entities.GetAbility(heroIndex, index);

    if(heroIndex == -1){
        $.Msg("[Custom Bindings] Invalid hero: The hero hasn't been asigned yet");
        return;
    }
    if(!abilityIndex){
        $.Msg("[Custom Bindings] Invalid ability: The ability doesn't exist");
        return;
    }
    if(!Abilities.IsInAbilityPhase(abilityIndex)){
        var mouse_position_screen = GameUI.GetCursorPosition();
        var mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1])

        var abilityBehavior = Abilities.GetBehavior( abilityIndex )
        if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT){
            var order = {
                OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION,
                TargetIndex : heroIndex,
                Position : mouse_position,
                QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                ShowEffects : showEffects,
                AbilityIndex : abilityIndex,
            };
            Game.PrepareUnitOrders( order );
        }
        if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET){
            var order = {
                OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET,
                TargetIndex : heroIndex,
                QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                ShowEffects : showEffects,
                AbilityIndex : abilityIndex,
            };
            Game.PrepareUnitOrders( order );
        }
    }
}

function UseItem(itemSlot)
{
    var playerId = Players.GetLocalPlayer();
    var heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
    heroIndex = Players.GetSelectedEntities(playerId)[0]; //DEBUG
    var abilityIndex = Entities.GetItemInSlot(heroIndex, itemSlot);

    if(heroIndex == -1){
        $.Msg("[Custom Bindings] Invalid hero: The hero hasn't been asigned yet");
        return;
    }
    if(!abilityIndex){
        $.Msg("[Custom Bindings] Invalid ability: The ability doesn't exist");
        return;
    }
    if(!Abilities.IsInAbilityPhase(abilityIndex)){
        var mouse_position_screen = GameUI.GetCursorPosition();
        var mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1])

        var abilityBehavior = Abilities.GetBehavior( abilityIndex )
        if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT){
            var order = {
                OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION,
                TargetIndex : heroIndex,
                Position : mouse_position,
                QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                ShowEffects : true,
                AbilityIndex : abilityIndex,
            };
            Game.PrepareUnitOrders( order );
        }
        if(abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET){
            var order = {
                OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET,
                TargetIndex : heroIndex,
                QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
                ShowEffects : true,
                AbilityIndex : abilityIndex,
            };
            Game.PrepareUnitOrders( order );
        }
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

Game.OnPressSpace = function(){    ExecuteAbility(MOBILITY_ABILITY_INDEX, true) }
Game.OnPress1 = function(){        UseItem(0) }
Game.OnPress2 = function(){        UseItem(1) }
Game.OnPress3 = function(){        UseItem(2) }
Game.OnPress4 = function(){        UseItem(3) }
Game.OnPress5 = function(){        UseItem(4) }
Game.OnPress6 = function(){        UseItem(5) }
Game.OnPressQ = function(){        ExecuteAbility(COUNTER_INDEX, true) }
Game.OnPressE = function(){        ExecuteAbility(SPECIAL_ATTACK_INDEX, true) }
Game.OnPressR = function(){        ExecuteAbility(EX_ULTIMATE_INDEX, true) }
Game.OnPressF = function(){        ExecuteAbility(ULTIMATE_INDEX, true) }
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
		OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_STOP,
		QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
        ShowEffects : false,
        TargetIndex : heroIndex
    };
    
    Game.PrepareUnitOrders( order );
}