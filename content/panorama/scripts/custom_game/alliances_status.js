var INTERVAL = 0.01;
var all_heroes_data = {};
var all_hero_status = [];

function Component(){
    this.hero_index = null;
    this.remove = false;
    this.alliance = "DOTA_NO_ALLIANCE";
}
Component.prototype.Update = function(){}
Component.prototype.OnCreated = function(){}
Component.prototype.SetHeroIndex = function(hero_index){
    this.hero_index = hero_index
}
Component.prototype.ScheduleRemove = function(){
    this.remove = true
}
Component.prototype.ShouldRemove = function(){
    return this.remove
}
Component.prototype.SetAlliance = function(alliance){
    this.alliance = alliance
}

function AddHeroStatus(data){
    var hero_index = data.heroIndex;
    var team_id = data.teamID;
    var hero_name = data.heroName;

    var hero_status = new HeroStatus(hero_index, team_id, hero_name)
    var health = new Health()
    var mana = new Mana()
    var hero_items = new HeroItems() 

    hero_status.AddComponent(mana)
    hero_status.AddComponent(health)
    hero_status.AddComponent(hero_items)

    /*
    for(var i = 0; i < 7; i++){
        $.Msg("KEYBIND: ", Game.GetKeybindForAbility( i ) )
    }
    for(var i = 0; i < 6; i++){
        $.Msg("KEYBIND: ", Game.GetKeybindForInventorySlot( i )	)
    }
    */

    all_hero_status.push(hero_status);
}

function HeroStatus(hero_index, team_id, hero_name){
    this.hero_index = hero_index
    this.components = []
    this.hero_name = hero_name
    this.alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( team_id );
    this.close_when_shop_open = this.alliance.toString() == "DOTA_ALLIANCE_DIRE" || this.alliance.toString() == "DOTA_ALLIANCE_VOID"

    var container = null;

    if(this.alliance.toString() == "DOTA_ALLIANCE_RADIANT"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Radiant");
    }
    if(this.alliance.toString() == "DOTA_ALLIANCE_DIRE"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Dire");
    }
    if(this.alliance.toString() == "DOTA_ALLIANCE_LEGION"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Legion");
    }
    if(this.alliance.toString() == "DOTA_ALLIANCE_VOID"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Void");
    }

    this.panel = $.CreatePanel("Panel", container, "");
    this.panel.BLoadLayoutSnippet("HeroStatus");
    this.panel.FindChildTraverse("HeroStatus__Avatar").heroname = this.hero_name;
}
HeroStatus.prototype.Update = function(){
    if(this.close_when_shop_open){
        if(Game.IsShopOpen()){
            this.panel.style.visibility = "collapse";
            this.panel.style.opacity = "0.0";
        } else {
            this.panel.style.visibility = "visible";
            this.panel.style.opacity = "0.97";
        }
    }


    var filtered_components = this.components.filter(function(component){
        if(component.ShouldRemove()){
            return false;
        }
        return true;
    })

    this.components = filtered_components;
    
    this.components.forEach(function(component){
        component.Update();
    })
}
HeroStatus.prototype.AddComponent = function(component){
    component.SetHeroIndex(this.hero_index)
    component.SetAlliance(this.alliance)
    component.OnCreated(this.panel)
    this.components.push(component)
}

function HeroItems(){
    Component.call(this)

    this.panel = null;
}
HeroItems.prototype = Object.create(Component.prototype);
HeroItems.prototype.constructor = HeroItems;
HeroItems.prototype.Update = function(){
    var counter = 0;

    for(var i = 0; i < 6; i++){
        if(i == 3){
            counter = 0;
        }
        var item_index = Entities.GetItemInSlot( this.hero_index, i );
        var item_name = "item_" + Items.GetAbilityTextureSF( item_index );

        var row;

        if(i < 3){
            row = this.panel.FindChildrenWithClassTraverse("Items__Row")[0]
        } else {
            row = this.panel.FindChildrenWithClassTraverse("Items__Row")[1]
        }
        row.FindChildrenWithClassTraverse("Items__Item")[counter].itemname = item_name;
        counter++;
    }
}
HeroItems.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Items");
}

function Health(){
    Component.call(this)

    this.health = 0;
    this.max_health = 0;
    this.shield = 0;
    this.potential_health = 0;
    this.health_per_cell = 30;
    this.panel = null;
    this.progress_panel_health = null;
    this.progress_panel_shield = null;
}
Health.prototype =                  Object.create(Component.prototype);
Health.prototype.constructor =      Health;
Health.prototype.Update = function(){
    var net_table = CustomNetTables.GetTableValue( "heroes", this.hero_index.toString() )

    this.health = net_table.health
    this.treshold = net_table.treshold
    this.max_health = net_table.max_health
    this.potential_health = this.health + (30 - this.treshold)

    var modifier_index = Modifiers.FindModifierByName(this.hero_index, "modifier_shield")

    if(modifier_index){
        this.shield = Buffs.GetStackCount(this.hero_index, modifier_index)
    } else {
        this.shield = 0
    }

    var health_width;
    var health_progress;
    var helath_total_width;

    //var cell_width = 100 * this.health_per_cell/(this.potential_health);
    
    if(this.shield <= 0){
        this.progress_panel_shield.SetVisibility("collapse");
        this.progress_panel_health.SetBorder({right: "1"});

        health_width = 100 * ( this.potential_health )/(this.max_health);
        health_progress = 100 * this.health/(this.potential_health);
        helath_total_width = 100;
    } else {
        this.progress_panel_shield.SetVisibility("visible");
        this.progress_panel_health.SetBorder({right: "0"});
        this.progress_panel_shield.SetBorder({left: "0"});

        helath_total_width = 100 * ( this.health )/(this.max_health + this.shield);
        health_width = 100;
        health_progress = 100;
        
        var shield_total_width = 100 * (this.max_health + this.shield - this.health)/(this.max_health + this.shield)
        var shield_width = 100 * ( this.shield + (30 - this.treshold) )/(this.max_health + this.shield - this.health);
        var shield_progress = 100 * this.shield/(this.shield + (30 - this.treshold));
        
        this.progress_panel_shield.SetTotalWidth(shield_total_width);
        this.progress_panel_shield.SetPanelWidth(shield_width);
        this.progress_panel_shield.SetProgress(shield_progress);
    }

    this.progress_panel_health.SetTotalWidth(helath_total_width);
    this.progress_panel_health.SetPanelWidth(health_width);
    this.progress_panel_health.SetProgress(health_progress);
    this.progress_panel_health.SetValue(this.health);
    //this.progress_panel_health.SetCellWidth(cell_width);
}
Health.prototype.SetShield = function(shield){
    this.shield = shield
}
Health.prototype.SetPotentialHealth = function(potential_health){
    this.potential_health = potential_health
}
Health.prototype.OnCreated = function(panel){
    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );

    var color = "LOCAL"
    if(local_player_alliance != this.alliance){
        color = GameUI.CustomUIConfig().Alliances.alliances[this.alliance].color;
    }
    this.panel = panel.FindChildTraverse("HeroStatus__Health");
    this.progress_panel_health = new ProgressBar("Health", this.panel, { foreground_color: Colors.Gradient(color), delayed: true, show_value: true} )
    this.progress_panel_shield = new ProgressBar("Shield", this.panel, { foreground_color: Colors.Gradient("GRAY"), borderLeft: 0 })
}

function Mana(){
    Component.call(this)

    this.max_mana = 0;
    this.mana = 0;
    this.mana_per_cell = 25
    this.panel = null
    this.progress_panels = []
}
Mana.prototype =                    Object.create(Component.prototype);
Mana.prototype.constructor =        Mana;
Mana.prototype.Update = function(){
    var net_table = CustomNetTables.GetTableValue( "heroes", this.hero_index.toString() )
    this.mana = net_table.mana
    this.max_mana = net_table.max_mana

    var cells = this.max_mana/this.mana_per_cell
    var iterator = 0;

    while(this.progress_panels.length < cells){
        var progress_panel = new ProgressBar("Mana_" + iterator , this.panel, { foreground_color: Colors.Gradient("BLUE") });
        this.progress_panels.push(progress_panel);

        iterator++;
    }

    while(this.progress_panels.length > cells ){
        this.progress_panels[this.progress_panels.length - 1].SetVisibility("collapse")
        this.progress_panels.pop();
    }
    for(var i = 0; i < this.progress_panels.length; i++){
        var width = (100 * this.mana_per_cell)/this.max_mana
        this.progress_panels[i].SetTotalWidth(width);
        if(i > 0){
            this.progress_panels[i].SetBorder({left: 0});
        }
    }

    var panel_iterator = 0;
    var mana_tmp = 0;

    for(var i = 0; i <= this.mana; i ++){
        if(mana_tmp == this.mana_per_cell ){
            this.progress_panels[panel_iterator].SetProgress(100);
            this.progress_panels[panel_iterator].SetForegroundColor(Colors.Gradient("BLUE"));
            mana_tmp = 0;
            panel_iterator++;
        }
        if(mana_tmp < this.mana_per_cell && i == this.mana && i != this.max_mana){
            this.progress_panels[panel_iterator].SetProgress(mana_tmp * 4);
            this.progress_panels[panel_iterator].SetForegroundColor(Colors.Gradient("GRAY"));

            for(j = panel_iterator + 1; j < this.progress_panels.length; j ++){
                this.progress_panels[j].SetProgress(0);
            }
        }

        mana_tmp++;
    }
}
Mana.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("HeroStatus__Mana");
    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );
    
    if(local_player_alliance != this.alliance){
        this.panel.style.visibility = "collapse";
        this.ScheduleRemove();
    }
}

function Update(){
    all_hero_status.forEach(function(hero_status){
        hero_status.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

(function() {
    all_heroes_data = CustomNetTables.GetAllTableValues("heroes");

    for (let hero_index in all_heroes_data) {
        let data = all_heroes_data[hero_index];

        AddHeroOverhead({
            heroIndex: parseInt(hero_index, 10),
            teamID: data.teamID,
            playerID: data.playerID,
        })
    }

    CustomNetTables.SubscribeNetTableListener("heroes", function(table, key, data){
        if(!all_heroes_data[key]){
            AddHeroStatus({
                heroIndex: parseInt(key, 10),
                teamID: data.teamID,
                heroName: data.name,
            })
        }
        all_heroes_data[key] = data;
    });

    Update();
})();
