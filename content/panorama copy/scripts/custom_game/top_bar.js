var INTERVAL = 0.01;
var alliance_bars = [];
var all_alliances_data = {}

var ROUNDS_TO_WIN = 5
var ROUNDS_DIFFERENCE_TO_WIN = 3

function AddAllianceBar(alliance_name){
    var local_player_team =         Players.GetTeam(Game.GetLocalPlayerID());
    var local_player_alliance =     GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam(local_player_team);

    var color = "LOCAL";
    var alliance_panel_name = "";
    
    if(local_player_alliance != alliance_name){
        color = GameUI.CustomUIConfig().Alliances.alliances[alliance_name].color;
    }

    if(alliance_name == "DOTA_ALLIANCE_RADIANT"){
        alliance_panel_name = "TopBar__Radiant"; 
    }
    if(alliance_name == "DOTA_ALLIANCE_DIRE"){
        alliance_panel_name = "TopBar__Dire"; 
    }
    if(alliance_name == "DOTA_ALLIANCE_LEGION"){
        alliance_panel_name = "TopBar__Legion"; 
    }
    if(alliance_name == "DOTA_ALLIANCE_VOID"){
        alliance_panel_name = "TopBar__Void"; 
    }

    var alliance_bar = new AllianceBar(alliance_name, alliance_panel_name)
    alliance_bar.AddComponent(new AllianceHealth(color))
    alliance_bar.AddComponent(new AllianceScore(color))
    alliance_bars.push(alliance_bar);
}

function AllianceBar(alliance_name, alliance_panel_name){
    this.components =               [];
    this.panel =                    null;
    this.alliance_name =            alliance_name;
    
    this.panel = $.CreatePanel("Panel", $("#TopBar__Container").FindChildTraverse(alliance_panel_name), "");
    this.panel.BLoadLayoutSnippet("AllianceBar");
}
AllianceBar.prototype.Update = function(){
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


    var alliance = null;
    for (let key in all_alliances_data){
        let data = all_alliances_data[key];
        
        if(data.name == this.alliance_name){
            alliance = data;
        }
    }

    this.panel.FindChildTraverse("AllianceBar__Amethysts_Text").text = "X" + alliance.amethysts;
}
AllianceBar.prototype.AddComponent = function(component){
    component.SetAlliance(this.alliance_name)
    component.OnCreated(this.panel)
    this.components.push(component)
}
AllianceBar.prototype.GetComponents = function(){
    return this.components
}

function AllianceScore(color){
    Component.call(this)

    this.color = color;
}
AllianceScore.prototype = Object.create(Component.prototype);
AllianceScore.prototype.constructor = Health;
AllianceScore.prototype.Update = function(){
    for(var i = 0; i < ROUNDS_DIFFERENCE_TO_WIN; i++){
        this.panel.GetChild(i).SetHasClass("AllianceBar__Score_Point--disabled", false);
        this.panel.GetChild(i).SetHasClass("AllianceBar__Score_Point--inactive", true);
    }
    
    var alliance = null;
    for (let key in all_alliances_data){
        let data = all_alliances_data[key];
        
        if(data.name == this.alliance){
            alliance = data;
        }
    }

    for(var i = 0; i < alliance.score ; i++){
        this.panel.GetChild(i).SetHasClass("AllianceBar__Score_Point--inactive", false);
        this.panel.GetChild(i).SetHasClass("AllianceBar__Score_Point--active", true);
    }
}
AllianceScore.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("AllianceBar__Score_Points");
    for(var i = 0; i < ROUNDS_TO_WIN; i++){
        var point_panel = $.CreatePanel("Panel", this.panel, "");
        point_panel.BLoadLayoutSnippet("AllianceBar__Score_Point")
        point_panel.SetHasClass("AllianceBar__Score_Point--disabled", true);
        point_panel.style.backgroundColor = Colors.Gradient(this.color);
    }
}

function AllianceHealth(color){
    Component.call(this)

    this.color = color
    this.health = 0;
    this.max_health = 0;
    this.shield = 0;
    this.potential_health = 0;
    this.health_per_cell = 30;
    this.panel = null;
    this.progress_panel_health = null;
    this.progress_panel_shield = null;
}
AllianceHealth.prototype = Object.create(Component.prototype);
AllianceHealth.prototype.constructor = Health;
AllianceHealth.prototype.Update = function(){
    var alliance = null;
    for (let key in all_alliances_data){
        let data = all_alliances_data[key];
        
        if(data.name == this.alliance){
            alliance = data;
        }
    }

    this.health = alliance.health
    this.max_health = alliance.max_health
    this.shield = alliance.shield

    var health_panel_width;
    var health_progress;
    var health_total_width;

    if(this.shield <= 0){
        this.progress_panel_shield.SetVisibility("collapse");
        this.progress_panel_health.SetBorder({ right: "1" });
        health_panel_width = 100;

        health_progress = 100 * this.health/(this.max_health);
        health_total_width = 100;
    } else {
        this.progress_panel_shield.SetVisibility("visible");
        this.progress_panel_health.SetBorder({ right: "0" });
        this.progress_panel_shield.SetBorder({ left: "0" });

        health_total_width = 100 * (this.health)/(this.max_health + this.shield);
        health_panel_width = 100;
        health_progress = 100;
        
        var shield_total_width = 100 * (this.max_health + this.shield - this.health)/(this.max_health + this.shield);
        var shield_panel_width = 100
        var shield_progress =  100 * (this.shield)/(this.max_health + this.shield - this.health);
  
/*
[    health     |  shield   |XX]
                [              ]
[      max_health + shield     ]
*/

        this.progress_panel_shield.SetTotalWidth(shield_total_width);
        this.progress_panel_shield.SetPanelWidth(shield_panel_width);
        this.progress_panel_shield.SetProgress(shield_progress);
    }
    
    this.progress_panel_health.SetTotalWidth(health_total_width);
    this.progress_panel_health.SetPanelWidth(health_panel_width);
    this.progress_panel_health.SetProgress(health_progress);

    var parsed_health_progress = Math.floor(health_progress)
    this.progress_panel_health.SetValue(parsed_health_progress + "%");
}
AllianceHealth.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("AllianceBar__Health");
    this.progress_panel_health = new ProgressBar("Health", this.panel, { foreground_color: Colors.Gradient(this.color), delayed: true, show_value: true, font_size: "14px" });
    this.progress_panel_shield = new ProgressBar("Shield", this.panel, { foreground_color: Colors.Gradient("GRAY") });
}

function Update(){
    alliance_bars.forEach(function(alliance_bar){
        alliance_bar.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

/* Initialization */
var table_data = CustomNetTables.GetAllTableValues("alliances");

table_data.forEach(object => {
    all_alliances_data[object.key] = object.value;
    AddAllianceBar(all_alliances_data[object.key].name);
})

CustomNetTables.SubscribeNetTableListener("alliances", function(table, key, data){
    if(!all_alliances_data[key]){
        AddAllianceBar(data.name);
    }
    all_alliances_data[key] = data;
});

function UpdateTime(data){
    $("#TopBar__Clock_Text").text = data.timer_minute_10.toString() + data.timer_minute_01.toString() + ":" + data.timer_second_10.toString() + data.timer_second_01.toString();
}

Update();
(function Start(){
    GameEvents.Subscribe("countdown", UpdateTime);
}());