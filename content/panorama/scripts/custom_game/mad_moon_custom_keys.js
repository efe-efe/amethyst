"use strict";

//Custom key bindings

var EX_ABILITY_ONE_INDEX = 6; 
var EX_ABILITY_TWO_INDEX = 7; 
var MOBILITY_ABILITY_INDEX = 8;

function ExecuteAbility(index)
{
    var playerId = Players.GetLocalPlayer();

    if( Players.IsValidPlayerID( playerId )){
        var selectedEntities = Players.GetSelectedEntities(playerId);
        var mainSelected = selectedEntities[0];

        if(!mainSelected){
            $.Msg("[Custom Bindings] Invalid selection, no hero to cast ability");
        }
        else{
            var abilityIndex = Entities.GetAbility( mainSelected, index );
            if(!abilityIndex){
                $.Msg("[Custom Bindings] Invalid ability: The ability doesn't exist");
            }
            else{
                var abilityName = Abilities.GetAbilityName(abilityIndex);
                if(!Abilities.CanBeExecuted(abilityIndex)){
                    $.Msg("[Custom Bindings] Ability can't be executed: ", abilityName);
                }
                else{
                    Abilities.ExecuteAbility( abilityIndex, mainSelected, true );	
                }
            }
        }
    }
    else{
        $.Msg("[Custom Bindings] Not valid entity");
    }
}

function OnExecuteAbility1ButtonPressed()
{
    ExecuteAbility(MOBILITY_ABILITY_INDEX);
}

function OnExecuteAbility2ButtonPressed()
{
    ExecuteAbility(EX_ABILITY_ONE_INDEX);
}

function OnExecuteAbility3ButtonPressed()
{
    ExecuteAbility(EX_ABILITY_TWO_INDEX);
}

(function() {
    Game.AddCommand( "-CustomGameExecuteAbility1", OnExecuteAbility1ButtonPressed, "", 0 );
    Game.AddCommand( "-CustomGameExecuteAbility2", OnExecuteAbility2ButtonPressed, "", 0 );
    Game.AddCommand( "-CustomGameExecuteAbility3", OnExecuteAbility3ButtonPressed, "", 0 );
})();