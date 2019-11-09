function FindAllianceByTeam( team ){
    switch( team ){
        case DOTATeam_t.DOTA_TEAM_GOODGUYS:
            return "DOTA_ALLIANCE_RADIANT";
            break;
        case DOTATeam_t.DOTA_TEAM_CUSTOM_1:
            return "DOTA_ALLIANCE_RADIANT";
            break;
        case DOTATeam_t.DOTA_TEAM_BADGUYS:
            return "DOTA_ALLIANCE_DIRE";
            break;
        case DOTATeam_t.DOTA_TEAM_CUSTOM_2:
            return "DOTA_ALLIANCE_DIRE";
            break;
        default:
            return "DOTA_NO_ALLIANCE"
            break
        }
}

function GetOppositeAlliance( alliance ){
    if( alliance == "DOTA_ALLIANCE_RADIANT" ){
        return "DOTA_ALLIANCE_DIRE"
    } else {
        return "DOTA_ALLIANCE_RADIANT"
    }
}