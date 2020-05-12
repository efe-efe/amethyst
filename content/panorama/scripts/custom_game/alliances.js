(function(){
    GameUI.CustomUIConfig().Alliances = {
        alliances: {
            DOTA_ALLIANCE_RADIANT: {
                name: "DOTA_ALLIANCE_RADIANT",
                color: "LIGHTGREEN",
                teams: [DOTATeam_t.DOTA_TEAM_GOODGUYS, DOTATeam_t.DOTA_TEAM_BADGUYS],
            },
            DOTA_ALLIANCE_DIRE: {
                name: "DOTA_ALLIANCE_DIRE",
                color: "YELLOW",
                teams: [DOTATeam_t.DOTA_TEAM_CUSTOM_1, DOTATeam_t.DOTA_TEAM_CUSTOM_2]
            },
            DOTA_ALLIANCE_LEGION: {
                name: "DOTA_ALLIANCE_LEGION",
                color: "ORANGE",
                teams: [DOTATeam_t.DOTA_TEAM_CUSTOM_3, DOTATeam_t.DOTA_TEAM_CUSTOM_4]
            },
            DOTA_ALLIANCE_VOID: {
                name: "DOTA_ALLIANCE_VOID",
                color: "PINK",
                teams: [DOTATeam_t.DOTA_TEAM_CUSTOM_5, DOTATeam_t.DOTA_TEAM_CUSTOM_6]
            }
        },
        FindAllianceNameByTeam: function( team ){
            for (var property in GameUI.CustomUIConfig().Alliances.alliances ){
                for( var i = 0; i < GameUI.CustomUIConfig().Alliances.alliances[property].teams.length; i++){
                    if(GameUI.CustomUIConfig().Alliances.alliances[property].teams[i] == team){
                        return property;
                    }
                }
            }
        
            return "DOTA_NO_ALLIANCE"
        }
    }
}());