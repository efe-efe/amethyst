var main_panel = $("#TopBar");
var team_bars = {};
var FRIENDLY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(51, 162, 40, 1.0) ), to( rgba(162, 249, 154, 1.0) ) );";
var ENEMY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(238, 53, 0, 1.0) ), to( rgba(216, 134, 89, 1.0) ) );";

team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS] = {
    panel: null,
    inner_panel: null,
    inner_panel_back: null,
    score: null
};

team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS] = {
    panel: null,
    inner_panel: null,
    inner_panel_back: null,
    score: null
};

function UpdateBars( data ){
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].inner_panel.style.width = data.good_guys.toString() + "%";
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].inner_panel.style.width = data.bad_guys.toString() + "%";
    
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].inner_panel_back.style.width = data.good_guys.toString() + "%";
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].inner_panel_back.style.width = data.bad_guys.toString() + "%";
}

function GetOppositeTeam( team ){
    if( team == DOTATeam_t.DOTA_TEAM_GOODGUYS ){
        return DOTATeam_t.DOTA_TEAM_BADGUYS
    } else {
        return DOTATeam_t.DOTA_TEAM_GOODGUYS
    }
}

function UpdateScore( data ){
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].score.FindChildTraverse("ScoreText").text = data.good_guys;
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].score.FindChildTraverse("ScoreText").text = data.bad_guys;
}

function UpdateTime( data ){
    $( "#ClockText" ).text = data.timer_minute_10.toString() + data.timer_minute_01.toString() + ":" + data.timer_second_10.toString() + data.timer_second_01.toString();
}

(function Start(){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel = $.CreatePanel("Panel", main_panel, "");
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel.BLoadLayoutSnippet("TeamHealthBar");
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel.style.align = "left top";
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel.style.padding = "0px 0px 0px 25px";
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].inner_panel = team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel.FindChildrenWithClassTraverse("TeamHealthBarInner")[0];
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].inner_panel_back = team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].panel.FindChildrenWithClassTraverse("TeamHealthBarInnerBack")[0];

    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel = $.CreatePanel("Panel", main_panel, "");
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel.BLoadLayoutSnippet("TeamHealthBar");
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel.style.align = "right top";
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel.style.padding = "0px 25px 0px 0px";
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].inner_panel = team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel.FindChildrenWithClassTraverse("TeamHealthBarInner")[0];
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].inner_panel_back = team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].panel.FindChildrenWithClassTraverse("TeamHealthBarInnerBack")[0];
    
    team_bars[localPlayerTeam].inner_panel.style.backgroundColor = FRIENDLY_COLOR;
    team_bars[GetOppositeTeam(localPlayerTeam)].inner_panel.style.backgroundColor = ENEMY_COLOR;

    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].score = $.CreatePanel("Panel", main_panel, "");
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].score.BLoadLayoutSnippet("Score");
    team_bars[DOTATeam_t.DOTA_TEAM_GOODGUYS].score.style.align = "left top";

    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].score = $.CreatePanel("Panel", main_panel, "");
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].score.BLoadLayoutSnippet("Score");
    team_bars[DOTATeam_t.DOTA_TEAM_BADGUYS].score.style.align = "right top";

    GameEvents.Subscribe( "update_team_health_bars", UpdateBars );
    GameEvents.Subscribe( "update_score", UpdateScore );
    GameEvents.Subscribe( "countdown", UpdateTime );
}());