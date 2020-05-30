var OVERHEAD_TYPE_HERO = 1
var OVERHEAD_TYPE_UNIT = 2

function Component(){
    this.entity_index = null;
    this.remove = false;
    this.alliance = "DOTA_NO_ALLIANCE";
}
Component.prototype.Update = function(){}
Component.prototype.SetEntityIndex = function(entity_index){
    this.entity_index = entity_index
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
Component.prototype.SetType = function(type){
    this.type = type
}

function Health(panel_name, color, show_value){
    Component.call(this)

    this.panel_name = panel_name
    this.show_value = show_value
    this.health = 0;
    this.max_health = 0;
    this.shield = 0;
    this.potential_health = 0;
    this.health_per_cell = 30;
    this.panel = null;
    this.progress_panel_health = null;
    this.progress_panel_shield = null;
    this.color = color;
}
Health.prototype = Object.create(Component.prototype);
Health.prototype.constructor = Health;
Health.prototype.Update = function(){
    var table_name = "";
    
    if(this.type == OVERHEAD_TYPE_UNIT){
        table_name = "units"
    }
    if(this.type == OVERHEAD_TYPE_HERO){
        table_name = "heroes"
    }

    var net_table = CustomNetTables.GetTableValue(table_name, "index_" + this.entity_index)

    this.health = net_table.health
    this.treshold = net_table.treshold
    this.max_health = net_table.max_health
    this.potential_health = this.health + (30 - this.treshold)
    this.shield = net_table.shield

    var health_panel_width;
    var health_progress;
    var health_total_width;

    //var cell_width = 100 * this.health_per_cell/(this.potential_health);
    
    if(this.shield <= 0){
        this.progress_panel_shield.SetVisibility("collapse");
        this.progress_panel_health.SetBorder({right: "1"});
        health_panel_width = 100 * (this.potential_health)/(this.max_health);

        if(this.potential_health == 0){
            health_progress = 0;
        } else {
            health_progress = 100 * this.health/(this.potential_health);
        }
        health_total_width = 100;
    } else {
        this.progress_panel_shield.SetVisibility("visible");
        this.progress_panel_health.SetBorder({right: "0"});
        this.progress_panel_shield.SetBorder({left: "0"});

        health_total_width = 100 * ( this.health )/(this.max_health + this.shield);
        health_panel_width = 100;
        health_progress = 100;
        
        var shield_total_width = 100 * (this.max_health + this.shield - this.health)/(this.max_health + this.shield)
        var shield_panel_width = 100 * ( this.shield + (30 - this.treshold) )/(this.max_health + this.shield - this.health);
        var shield_progress = 100 * this.shield/(this.shield + (30 - this.treshold));
        
        this.progress_panel_shield.SetTotalWidth(shield_total_width);
        this.progress_panel_shield.SetPanelWidth(shield_panel_width);
        this.progress_panel_shield.SetProgress(shield_progress);
    }

    this.progress_panel_health.SetTotalWidth(health_total_width);
    this.progress_panel_health.SetPanelWidth(health_panel_width);
    this.progress_panel_health.SetProgress(health_progress);
    this.progress_panel_health.SetValue(this.health);

    //this.progress_panel_health.SetCellWidth(cell_width);
}
Health.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse(this.panel_name);
    this.progress_panel_health = new ProgressBar("Health", this.panel, { foreground_color: Colors.Gradient(this.color), delayed: true, show_value: this.show_value } )
    this.progress_panel_shield = new ProgressBar("Shield", this.panel, { foreground_color: Colors.Gradient("GRAY") })
}

function Mana(panel_name){
    Component.call(this)
    
    this.panel_name = panel_name;
    this.max_mana = 0;
    this.mana = 0;
    this.mana_per_cell = 25
    this.panel = null
    this.progress_panels = []
}
Mana.prototype = Object.create(Component.prototype);
Mana.prototype.constructor = Mana;
Mana.prototype.Update = function(){
    if(!IsVisibleByLocal(this.entity_index)){
        return;
    }

    this.mana = Entities.GetMana( this.entity_index )
    this.max_mana = Entities.GetMaxMana( this.entity_index )

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
    this.panel = panel.FindChildTraverse(this.panel_name);
}

function IsVisibleByLocal(unit_index)
{
    for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++)
    {
        var buff_name = Buffs.GetName(unit_index, Entities.GetBuff(unit_index, i))
        if (buff_name == "modifier_visible") {
            return true
        }
    }
    return false
}

var COLORS_RGB = {}
COLORS_RGB["LOCAL"] = {
    light: [162, 249, 154],
    dark: [51, 162, 40]
}
COLORS_RGB["YELLOW"] = {
    light: [249, 246, 154],
    dark: [196, 192, 42]
}
COLORS_RGB["LIGHTGREEN"] = {
    light: [154, 249, 224],
    dark: [78, 128, 114]
}
COLORS_RGB["PINK"] = {
    light: [197, 77, 168],
    dark: [92, 15, 73]
}
COLORS_RGB["ORANGE"] = {
    light: [255, 108, 0],
    dark: [219, 99, 11]
}
COLORS_RGB["BLUE"] = {
    light: [27, 113, 230],
    dark: [120, 156, 210]
}
COLORS_RGB["GRAY"] = {
    light: [240, 240, 240],
    dark: [120, 120, 120]
}

var Colors = {
    Gradient: function(color, opacity){
        var m_opacity = opacity || "1.0";

        var color_a = "rgba(" + COLORS_RGB[color].light[0] + "," + COLORS_RGB[color].light[1] + "," + COLORS_RGB[color].light[2] + "," + m_opacity + ")";
        var color_b = "rgba(" + COLORS_RGB[color].dark[0] + "," + COLORS_RGB[color].dark[1] + "," + COLORS_RGB[color].dark[2] + "," + m_opacity + ")";
        return "gradient( linear, 0% 0%, 100% 0%, from( " + color_a + "), to( " + color_b + "));";
    }
}

var Modifiers = {
    FindModifierByName(unit_index, name)
    {
        for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++)
        {
            var buff_name = Buffs.GetName(unit_index, Entities.GetBuff(unit_index, i))
            if (buff_name == name) {
                return Entities.GetBuff(unit_index, i)
            }
        }
        return false
    }
}

function Clamp(num, min, max) {
    return num < min ? min : num > max ? max : num;
}

function SubscribeToNetTableKey(table, key, loadNow, callback){
    var listener = CustomNetTables.SubscribeNetTableListener(table, function(table, tableKey, data){
        if (key == tableKey){
            if (!data) {
                return;
            }

            callback(data, false);
        }
    });

    if (loadNow){
        var data = CustomNetTables.GetTableValue(table, key);

        if (data) {
            callback(data, true);
        }
    }

    return listener;
}