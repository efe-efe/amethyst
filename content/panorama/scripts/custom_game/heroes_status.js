var main_panel = $("#HeroesStatus");
var heroes_status = {}
var FRIENDLY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(51, 162, 40, 1.0) ), to( rgba(162, 249, 154, 1.0) ) );";
var ENEMY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(238, 53, 0, 1.0) ), to( rgba(216, 134, 89, 1.0) ) );";

heroes_status[DOTATeam_t.DOTA_TEAM_GOODGUYS] = {
    parent_panel: main_panel.FindChildTraverse("HeroesStatusLeft"),
    heroe_panels: {},
}

heroes_status[DOTATeam_t.DOTA_TEAM_BADGUYS] = {
    parent_panel: main_panel.FindChildTraverse("HeroesStatusRight"),
    heroe_panels: {},
}

function AddPlayer( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    heroes_status[data.teamID].heroe_panels[data.heroIndex] = $.CreatePanel("Panel", heroes_status[data.teamID].parent_panel, "");
    heroes_status[data.teamID].heroe_panels[data.heroIndex].BLoadLayoutSnippet("HeroStatus");
    heroes_status[data.teamID].heroe_panels[data.heroIndex].FindChildTraverse("HeroStatusAvatarImage").heroname = data.heroName;
    var health_bar_inner = heroes_status[data.teamID].heroe_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInner")[0]
    //heroes_status[data.teamID].heroe_panels[data.heroIndex].FindChildTraverse("HeroStatusText").text = data.heroName;
    
    var color = null;
    if(localPlayerTeam == data.teamID){
        color = FRIENDLY_COLOR;
    } else {
        color = ENEMY_COLOR;
        var health_bar = heroes_status[data.teamID].heroe_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroHealthBar")[0];
        health_bar.style.height = "100%";

        var mana_bar = heroes_status[data.teamID].heroe_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroManaBar")[0];
        mana_bar.style.visibility = "collapse";
    }

    health_bar_inner.style.backgroundColor = color;
    UpdateHealthBar({ teamID: data.teamID, heroIndex: data.heroIndex, percentage: 100});
    UpdateManaBar({ teamID: data.teamID, heroIndex: data.heroIndex, percentage: 0});
}

function UpdateHealthBar( data ){
    var teamID = data.teamID;
    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var health_bar_inner = heroes_status[teamID].heroe_panels[heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInner")[0];
    var health_bar_inner_back = heroes_status[teamID].heroe_panels[heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInnerBack")[0];
    health_bar_inner.style.width = percentage.toString() + "%";
    health_bar_inner_back.style.width = percentage.toString() + "%";
}

function UpdateManaBar( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }

    var teamID = data.teamID;
    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var mana_bar_inner = heroes_status[teamID].heroe_panels[heroIndex].FindChildrenWithClassTraverse("HeroManaBarInner")[0];
    mana_bar_inner.style.width = percentage.toString() + "%";
}

(function() {
    GameEvents.Subscribe( "add_player", AddPlayer );
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_hero_mana_bar", UpdateManaBar );
})();
