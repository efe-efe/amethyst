var INTERVAL = 0.01;
var all_heroes_data = {};
var all_hero_status = [];

function AddHeroStatus(data){
    var entity_index = data.entity_index;
    var hero_name = data.hero_name;
    var alliance_name = data.alliance_name;
    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam(local_player_id);
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam(local_player_team);

    var color = "LOCAL";
    if(local_player_alliance != alliance_name){
        color = GameUI.CustomUIConfig().Alliances.alliances[alliance_name].color;
    }

    var hero_status = new HeroStatus(entity_index, hero_name, alliance_name);

    if(local_player_alliance == alliance_name){
        hero_status.AddComponent(new Mana("HeroStatus__Mana"));
    }

    hero_status.AddComponent(new Health("HeroStatus__Health", color, true));
    hero_status.AddComponent(new HeroItems());

    all_hero_status.push(hero_status);
}

function HeroStatus(entity_index, hero_name, alliance_name){
    this.entity_index = entity_index
    this.components = []
    this.hero_name = hero_name
    this.alliance_name = alliance_name;
    this.close_when_shop_open = this.alliance_name.toString() == "DOTA_ALLIANCE_DIRE" || this.alliance_name.toString() == "DOTA_ALLIANCE_VOID"

    var container = null;

    if(this.alliance_name.toString() == "DOTA_ALLIANCE_RADIANT"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Radiant");
    }
    if(this.alliance_name.toString() == "DOTA_ALLIANCE_DIRE"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Dire");
    }
    if(this.alliance_name.toString() == "DOTA_ALLIANCE_LEGION"){
        container = $("#AlliancesStatus__Container").FindChildTraverse("AlliancesStatus__Legion");
    }
    if(this.alliance_name.toString() == "DOTA_ALLIANCE_VOID"){
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
    component.SetType(OVERHEAD_TYPE_HERO)
    component.SetEntityIndex(this.entity_index)
    component.SetAlliance(this.alliance_name)
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
        var item_index = Entities.GetItemInSlot( this.entity_index, i );
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

function Update(){
    all_hero_status.forEach(function(hero_status){
        hero_status.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

function PrepareData(data){
    return {
        entity_index: data.entity_index,
        alliance_name: data.alliance_name,
        hero_name: data.name,
    }
}
 
/* Initialization */
all_heroes_data = CustomNetTables.GetAllTableValues("heroes");

for (let key in all_heroes_data) {
    let data = all_heroes_data[key];
    AddHeroStatus(PrepareData(data))
}

CustomNetTables.SubscribeNetTableListener("heroes", function(table, key, data){
    if(!all_heroes_data[key]){
        AddHeroStatus(PrepareData(data))
    }
    all_heroes_data[key] = data;
});

Update();
