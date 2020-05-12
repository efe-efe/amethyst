var main_panel = $("#TopBar");
var team_bars = {};

function UpdateHealthBar( data ){
    team_bars[data.alliance].health_panel.style.width = data.health_pct.toString() + "%";
    team_bars[data.alliance].health_panel_back.style.width = data.health_pct.toString() + "%";
}

function UpdateAmethysts( data ){
    team_bars[data.alliance].amethysts_label.text = "X" + data.amethysts;
}

function UpdateScore( data ){
    main_panel.FindChildTraverse("TopScoreTextLeft").text = data.good_guys;
    main_panel.FindChildTraverse("TopScoreTextRight").text = data.bad_guys;
}

function UpdateTime( data ){
    $( "#ClockText" ).text = data.timer_minute_10.toString() + data.timer_minute_01.toString() + ":" + data.timer_second_10.toString() + data.timer_second_01.toString();
}

function Initialize(){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );
    
    var counter = 0;
    var order = [1, 2, 0, 3]

    for (var alliance in GameUI.CustomUIConfig().Alliances.alliances ){
        var color = null;

        if(localPlayerAlliance == alliance){
            color = "LOCAL";
        } else {
            color = GameUI.CustomUIConfig().Alliances.alliances[alliance].color;
        }
        
        team_bars[alliance] = {
            main_panel: main_panel.FindChildrenWithClassTraverse("TeamBarContainer")[order[counter]],
            health_panel: main_panel.FindChildrenWithClassTraverse("TeamBarContainer")[order[counter]].FindChildTraverse("TeamHealthBarInner"),
            health_panel_back: main_panel.FindChildrenWithClassTraverse("TeamBarContainer")[order[counter]].FindChildTraverse("TeamHealthBarInnerBack"),
            amethysts_label: main_panel.FindChildrenWithClassTraverse("TeamBarContainer")[order[counter]].FindChildTraverse("TeamAmethystsText")
        }
        team_bars[alliance].health_panel.style.backgroundColor = Colors.Gradient(color);

        counter++;
    }
}

function ActivateBar( data ){
    var teamID = data.teamID;
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( teamID );
    team_bars[alliance].main_panel.style.visibility = "visible";
}

(function Start(){
    Initialize();
    GameEvents.Subscribe( "add_hero", ActivateBar );
    GameEvents.Subscribe( "update_alliance_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_score", UpdateScore );
    GameEvents.Subscribe( "update_amethysts", UpdateAmethysts );
    GameEvents.Subscribe( "countdown", UpdateTime );
}());