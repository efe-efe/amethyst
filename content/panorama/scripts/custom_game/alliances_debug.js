function RefreshAlliances(){
    var string = ""

    for (var property in GameUI.CustomUIConfig().Alliances.alliances ){
        string = string + " | ALLIANCE: " + property + " | "
    }

    $('#AlliancesDebugText').text = string;
}

function RefreshTeams(){
    var string = " -- "

    for (var property in GameUI.CustomUIConfig().Alliances.alliances ){
        string = string + "[" + property + "]";
        for (var team in GameUI.CustomUIConfig().Alliances.alliances[property].teams ){
            string = string + "| TEAM: " + GameUI.CustomUIConfig().Alliances.alliances[property].teams[team] + " | "
        }
    }

    $('#TeamsDebugText').text = string;
}



(function () {
    RefreshAlliances();
    RefreshTeams();
})();