var main_panel = $("#TopBar");
var team_bars = {};
var FRIENDLY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(51, 162, 40, 1.0) ), to( rgba(162, 249, 154, 1.0) ) );";
var ENEMY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(238, 53, 0, 1.0) ), to( rgba(216, 134, 89, 1.0) ) );";

team_bars["DOTA_ALLIANCE_RADIANT"] = {
    panel: null,
    inner_panel: null,
    inner_panel_back: null,
    score: null
};

team_bars["DOTA_ALLIANCE_DIRE"] = {
    panel: null,
    inner_panel: null,
    inner_panel_back: null,
    score: null
};

function UpdateBars( data ){
    team_bars["DOTA_ALLIANCE_RADIANT"].inner_panel.style.width = data.good_guys.toString() + "%";
    team_bars["DOTA_ALLIANCE_DIRE"].inner_panel.style.width = data.bad_guys.toString() + "%";
    
    team_bars["DOTA_ALLIANCE_RADIANT"].inner_panel_back.style.width = data.good_guys.toString() + "%";
    team_bars["DOTA_ALLIANCE_DIRE"].inner_panel_back.style.width = data.bad_guys.toString() + "%";
}

function UpdateAmethysts( data ){
    team_bars["DOTA_ALLIANCE_RADIANT"].panel.FindChildTraverse("TeamAmethystsText").text = "X" + data.good_guys;
    team_bars["DOTA_ALLIANCE_DIRE"].panel.FindChildTraverse("TeamAmethystsText").text = "X" + data.bad_guys;
}

function UpdateScore( data ){
    main_panel.FindChildTraverse("TopScoreTextLeft").text = data.good_guys;
    main_panel.FindChildTraverse("TopScoreTextRight").text = data.bad_guys;
}

function UpdateTime( data ){
    $( "#ClockText" ).text = data.timer_minute_10.toString() + data.timer_minute_01.toString() + ":" + data.timer_second_10.toString() + data.timer_second_01.toString();
}

(function Start(){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = FindAllianceByTeam( localPlayerTeam );
    
    team_bars["DOTA_ALLIANCE_RADIANT"].panel = $.CreatePanel("Panel", $("#TopBarLeft"), "");
    team_bars["DOTA_ALLIANCE_RADIANT"].panel.BLoadLayoutSnippet("TeamHealthBar");
    team_bars["DOTA_ALLIANCE_RADIANT"].inner_panel = team_bars["DOTA_ALLIANCE_RADIANT"].panel.FindChildrenWithClassTraverse("TeamHealthBarInner")[0];
    team_bars["DOTA_ALLIANCE_RADIANT"].inner_panel_back = team_bars["DOTA_ALLIANCE_RADIANT"].panel.FindChildrenWithClassTraverse("TeamHealthBarInnerBack")[0];

    team_bars["DOTA_ALLIANCE_DIRE"].panel = $.CreatePanel("Panel", $("#TopBarRight"), "");
    team_bars["DOTA_ALLIANCE_DIRE"].panel.BLoadLayoutSnippet("TeamHealthBar");
    team_bars["DOTA_ALLIANCE_DIRE"].inner_panel = team_bars["DOTA_ALLIANCE_DIRE"].panel.FindChildrenWithClassTraverse("TeamHealthBarInner")[0];
    team_bars["DOTA_ALLIANCE_DIRE"].inner_panel_back = team_bars["DOTA_ALLIANCE_DIRE"].panel.FindChildrenWithClassTraverse("TeamHealthBarInnerBack")[0];
    
    team_bars[localPlayerAlliance].inner_panel.style.backgroundColor = FRIENDLY_COLOR;
    team_bars[GetOppositeAlliance(localPlayerAlliance)].inner_panel.style.backgroundColor = ENEMY_COLOR;

    GameEvents.Subscribe( "update_team_health_bars", UpdateBars );
    GameEvents.Subscribe( "update_score", UpdateScore );
    GameEvents.Subscribe( "update_amethysts", UpdateAmethysts );
    GameEvents.Subscribe( "countdown", UpdateTime );
}());