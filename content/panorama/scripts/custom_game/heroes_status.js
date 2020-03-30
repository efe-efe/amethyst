var main_panel = $("#HeroesStatusContainer");
var teams_status = {};

function AddPlayer( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );

    var teamID = data.teamID;
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( teamID );

    teams_status[alliance].hero_panels[data.heroIndex] = $.CreatePanel("Panel", teams_status[alliance].main_panel, "");
    teams_status[alliance].hero_panels[data.heroIndex].BLoadLayoutSnippet("HeroStatus");
    teams_status[alliance].hero_panels[data.heroIndex].FindChildTraverse("HeroStatusAvatarImage").heroname = data.heroName;
    var health_bar_inner = teams_status[alliance].hero_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInner")[0]

    var color = null;
    if(localPlayerAlliance == alliance){
        color = "LOCAL";
    } else {
        color = GameUI.CustomUIConfig().Alliances.alliances[alliance].color;
        var health_bar = teams_status[alliance].hero_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroHealthBar")[0];
        health_bar.style.height = "100%";
        var mana_bar = teams_status[alliance].hero_panels[data.heroIndex].FindChildrenWithClassTraverse("HeroManaBar")[0];
        mana_bar.style.visibility = "collapse";
    }
    health_bar_inner.style.backgroundColor = Colors.Gradient(color);;
}

function UpdateHealthBar( data ){
    var teamID = data.teamID;
    var heroIndex = data.heroIndex;
    var current_health = data.current_health
    var max_health = data.max_health
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( teamID );

    var health_with = 100 * current_health/max_health

    var health_bar_inner = teams_status[alliance].hero_panels[heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInner")[0];
    var health_bar_inner_back = teams_status[alliance].hero_panels[heroIndex].FindChildrenWithClassTraverse("HeroHealthBarInnerBack")[0];
    health_bar_inner.style.width = health_with.toString() + "%";
    health_bar_inner_back.style.width = health_with.toString() + "%";
    health_bar_inner_back.style.margin = "0 0 0 -100%";
}

function UpdateManaBar( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );

    var teamID = data.teamID;
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( teamID );

    if(localPlayerAlliance != alliance){
        return false;
    }

    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var mana_bar_inner = teams_status[alliance].hero_panels[heroIndex].FindChildrenWithClassTraverse("HeroManaBarInner")[0];
    mana_bar_inner.style.width = percentage.toString() + "%";
}

function Initialize(){    
    var counter = 0;
    var order = [0, 2, 1, 3]

    for (var alliance in GameUI.CustomUIConfig().Alliances.alliances ){
        teams_status[alliance] = {
            main_panel: main_panel.FindChildrenWithClassTraverse("TeamStatusContainer")[order[counter]],
            hero_panels: {},
        }
        counter++;
    }
}

(function() {
    Initialize();
    GameEvents.Subscribe( "add_player", AddPlayer );
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_hero_mana_bar", UpdateManaBar );

    var shopButton = $.GetContextPanel()
        .GetParent()
        .GetParent() // HUD root
        .GetParent() // Custom UI root
        .GetParent() // Game HUD
        .FindChildTraverse('ShopButton')
    
    $.RegisterEventHandler('DOTAHUDToggleShop', shopButton, function () {
        var pannel = $.GetContextPanel().FindChildrenWithClassTraverse("MainPanel")[0];

        if(!Game.IsShopOpen()){
            pannel.style.transitionDuration = "0.0s";
            pannel.style.width = "67.5%;";
        }else{
            pannel.style.transitionDuration = "0.2s";
            pannel.style.width = "100%;";
        }
    })
})();
