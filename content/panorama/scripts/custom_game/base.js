function ConfigureHud(){
    GameUI.CustomUIConfig().multiteam_top_scoreboard =
    {
        reorder_team_scores: true,
        LeftInjectXMLFile: "file://{resources}/layout/custom_game/overthrow_scoreboard_left.xml",
        TeamOverlayXMLFile: "file://{resources}/layout/custom_game/overthrow_scoreboard_team_overlay.xml"
    };

    GameUI.CustomUIConfig().team_logo_xml = "file://{resources}/layout/custom_game/overthrow_team_icon.xml";
    GameUI.CustomUIConfig().team_logo_large_xml = "file://{resources}/layout/custom_game/overthrow_team_icon_large.xml";
}

function SetTeamColors(){
    GameUI.CustomUIConfig().team_colors = {}
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "#ff6c00;"; // { 61, 210, 150 }	--		Teal
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_BADGUYS ] = "#ff6c00;"; // { 243, 201, 9 }		--		Yellow
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "#F3C909;"; // { 197, 77, 168 }	--		Teal
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "#F3C909;"; // { 255, 108, 0 }		--		Yellow
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "#c54da8;"; // { 197, 77, 168 }	--		Pink
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "#c54da8;"; // { 197, 77, 168 }	--		Pink
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "#ff6c00;"; // { 255, 108, 0 }		--		Orange
    GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "#ff6c00;"; // { 255, 108, 0 }		--		Orange
}

function SetTeamIcons(){
    GameUI.CustomUIConfig().team_icons = {}
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "file://{images}/custom_game/team_icons/team_icon_tiger_01.png";
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "file://{images}/custom_game/team_icons/team_icon_tiger_01.png";

    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_BADGUYS ] = "file://{images}/custom_game/team_icons/team_icon_monkey_01.png";
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "file://{images}/custom_game/team_icons/team_icon_monkey_01.png";

    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "file://{images}/custom_game/team_icons/team_icon_dragon_01.png";
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "file://{images}/custom_game/team_icons/team_icon_dragon_01.png";
    
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "file://{images}/custom_game/team_icons/team_icon_dog_01.png";
    GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "file://{images}/custom_game/team_icons/team_icon_dog_01.png";
}

function HideDefaults(){
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false );
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false );
    GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false );
    
}

function ModifyHotkeyBox(top_panel) {
    if(!ModifyHotkeyText(top_panel, "Ability0", "L-Mouse")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability1", "R-Mouse")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability2", "Space")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability3", "Q")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability4", "E")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability5", "R")){ return false; }
    if(!ModifyHotkeyText(top_panel, "Ability6", "F")){ return false; }
    return true;
}

function ModifyHotkeyText(top_panel, abilityName, text){
    var abilityPanel = top_panel.FindChildTraverse(abilityName);
    var hotkey = abilityPanel.FindChildTraverse("HotkeyText");

    if(hotkey){
        hotkey.text = text;
        hotkey.GetParent().visible = true;

        return true;
    } 

    return false;
}

function ModifyHotkeyBoxes(top_panel){
    (function tic()
    {
        if(!ModifyHotkeyBox(top_panel)){
            $.Schedule( 2.0, tic );
        }
    })();
}

function HideRest(top_panel){

    var tp_scroll = top_panel.FindChildTraverse("inventory_tpscroll_container");
    tp_scroll.style.visibility = "collapse";

    var neutral_item = top_panel.FindChildTraverse("inventory_neutral_slot_container");
    neutral_item.style.visibility = "collapse";

    var talents = top_panel.FindChildTraverse("StatBranch");
    talents.style.visibility = "collapse";

    var guides = top_panel.FindChildTraverse("GuideFlyout");
    guides.style.visibility = "collapse";


    var right_flare = top_panel.FindChildTraverse("right_flare");
    right_flare.style.width = "52px";
    right_flare.style.marginRight = "42px";

    /*
    var inventory_slot_0 = top_panel.FindChildTraverse("inventory_slot_0");
    inventory_slot_0.style.width = "150px";
    inventory_slot_0.style.height = "150px"; 

    var inventory_slot_2 = top_panel.FindChildTraverse("inventory_slot_2");
    inventory_slot_2.style.visibility = "collapse";
    
    var inventory_slot_3 = top_panel.FindChildTraverse("inventory_slot_3");
    inventory_slot_3.style.visibility = "collapse";
    
    var inventory_slot_4 = top_panel.FindChildTraverse("inventory_slot_4");
    inventory_slot_4.style.visibility = "collapse";
    
    var inventory_slot_5 = top_panel.FindChildTraverse("inventory_slot_5");
    inventory_slot_5.style.visibility = "collapse";
    */
}

(function() {
    var top_panel = $.GetContextPanel();
    while(top_panel.GetParent() != null){
        top_panel = top_panel.GetParent();
    }

    ConfigureHud();
    HideDefaults();
    SetTeamColors();
    SetTeamIcons();
    ModifyHotkeyBoxes(top_panel);
    HideRest(top_panel);
})();


