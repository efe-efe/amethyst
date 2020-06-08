var INTERVAL = 0.01;
var hero_overheads = [];
var all_heroes_data = {}
var all_units_data = {}

var STATUS_TRIGGER_DURATION = 1
var STATUS_TRIGGER_STACKS = 2

var STATUS_CONTENT_CLEAROUT = 1
var STATUS_CONTENT_FILLUP = 2

var STATUS_SCOPE_PUBLIC = 1
var STATUS_SCOPE_LOCAL = 2

function AddOverhead(data, settings){
    var entity_index = data.entity_index;
    var team_id = data.teamID;
    var player_id = data.playerID;
    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam(local_player_id);
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam(local_player_team);
    var stackbars = data.stackbars;
    var charges = data.charges;
    var cooldown = data.cooldown;
    var alliance_name = data.alliance_name

    var color = "LOCAL";
    if(local_player_alliance != alliance_name){
        color = GameUI.CustomUIConfig().Alliances.alliances[alliance_name].color;
    }

    var overhead = new Overhead(entity_index, player_id, settings.type, color)

    if(local_player_alliance == alliance_name){
        if(settings.type == OVERHEAD_TYPE_HERO){
            overhead.AddComponent(new Mana("Resources__Mana"));
        }
    }

    overhead.AddComponent(new Health("Resources__Health", color, false))
    overhead.AddComponent(new CastPoint())
    overhead.AddComponent(new Status(team_id))

    if(local_player_team === team_id){
        overhead.AddComponent(new Recast(team_id))

        if(stackbars){
            overhead.AddComponent(new Stacks(stackbars, team_id))
        }
        if(charges){
            overhead.AddComponent(new Charges(charges, team_id))
        }
        if(cooldown){
            overhead.AddComponent(new Cooldown(cooldown, team_id))
        }
    }
    hero_overheads.push(overhead);
}

function Overhead(entity_index, player_id, type, color){
    this.entity_index =             entity_index
    this.type =                     type
    this.components =               []
    this.panel =                    $.CreatePanel("Panel", $("#Overhead__Container"), "");
    this.color =                    color;

    this.panel.BLoadLayoutSnippet("OverHero");
    this.panel.FindChildTraverse("Player__Text").text = Players.GetPlayerName(player_id);
    this.panel.FindChildTraverse("Player__Text").style.color = Colors.Gradient(color);
}
Overhead.prototype.Update = function(){
    this.UpdateVisibility();
    this.UpdatePosition();

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
Overhead.prototype.UpdatePosition = function(){
    if(!IsVisibleByLocal(this.entity_index)){
        return false;
    }

    var origin = Entities.GetAbsOrigin(this.entity_index);
    var offset = Entities.GetHealthBarOffset(this.entity_index);

    var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offset);
    var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offset);

    var check = Game.ScreenXYToWorld(wx, wy);

    if(check[1] != 0) {
        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();
        var scale = 1080 / sh;

        var x = scale * Math.min(sw - this.panel.actuallayoutwidth, Math.max(0, wx - this.panel.actuallayoutwidth/2));
        var y = scale * Math.min(sh - this.panel.actuallayoutheight, Math.max(0, wy - this.panel.actuallayoutheight));

        this.panel.style.position = x + "px " + y + "px 0px;";
        if(
            this.panel.actuallayoutwidth ==  0 &&
            this.panel.actuallayoutheight ==  0
       ){
            this.panel.style.position = "-1000px -1000px 0px;";
            return true;
        }
    } else {
        this.panel.style.position = "-1000px -1000px 0px;";
        return false;
    }
    return true
}
Overhead.prototype.UpdateVisibility = function(){
    var hide = Modifiers.FindModifierByName(this.entity_index, "modifier_hide_bar")

    if(!Entities.IsAlive(this.entity_index) || !IsVisibleByLocal(this.entity_index) || hide != false){
        this.panel.style.opacity = "0.0";
    } else {
        this.panel.style.opacity = "1.0";
    }
}
Overhead.prototype.AddComponent = function(component){
    component.SetType(this.type)
    component.SetEntityIndex(this.entity_index)
    component.SetAlliance(this.alliance_name)
    component.OnCreated(this.panel)
    this.components.push(component)
}
Overhead.prototype.GetComponents = function(){
    return this.components
}
Overhead.prototype.GetHeroIndex = function(){
    return this.entity_index
}

function Stacks(modifier_name, team_id){
    this.modifier_name = modifier_name
    this.panel = null
    this.team_id = team_id;
}
Stacks.prototype = Object.create(Component.prototype);
Stacks.prototype.constructor = Stacks;
Stacks.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.entity_index, this.modifier_name)
    if(modifier_index){
        var ammount = Buffs.GetStackCount(this.entity_index, modifier_index)
        for(i = 0; i < ammount; i++){
            this.panel.GetChild(i).style.opacity = "1.0";
        }
    } else {
        for(i = 0; i < 4; i++){
            this.panel.GetChild(i).style.opacity = "0.0";
        }
    }
}
Stacks.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Stacks");
    this.panel.style.visibility = "visible";
    panel.FindChildTraverse("Cooldown").style.visibility = "collapse";
}

function Cooldown(modifier_name, team_id){
    this.modifier_name = modifier_name;
    this.panel = null;
    this.team_id = team_id;
}
Cooldown.prototype = Object.create(Component.prototype);
Cooldown.prototype.constructor = Cooldown;
Cooldown.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.entity_index, this.modifier_name)
    var duration = Buffs.GetDuration(this.entity_index, modifier_index);
    var foreground_panel = this.panel.FindChildTraverse("Cooldown__Foreground");

    if(duration == -1){
        foreground_panel.style.clip = "radial(50% 50%, 0deg, " + 360 + "deg)";
        foreground_panel.style.backgroundColor = "rgb(162, 249, 154)";
        return;
    }

    var remaining = Buffs.GetRemainingTime(this.entity_index, modifier_index);
    var progress_ratio = 1;
    if (remaining && duration) {progress_ratio = remaining/duration};
    if (isNaN(progress_ratio)) { progress_ratio = 1; }
    progress_ratio = 1 - progress_ratio;
    var degree = 360 * progress_ratio

    foreground_panel.style.clip = "radial(50% 50%, 0deg, " + degree + "deg)";
    foreground_panel.style.backgroundColor = "rgb(238, 53, 0)";
    
    if(degree == 360){
        foreground_panel.style.backgroundColor = "rgb(162, 249, 154)";
    }
}
Cooldown.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Cooldown");
    this.panel.style.visibility = "visible";
    panel.FindChildTraverse("Stacks").style.visibility = "collapse";
}

function CastPoint(){
    Component.call(this)
    
    this.modifier_name = "modifier_casting";
    this.panel = null
    this.progress_panel = null;
}
CastPoint.prototype = Object.create(Component.prototype);
CastPoint.prototype.constructor = CastPoint;
CastPoint.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.entity_index, this.modifier_name)

    if(modifier_index){
        var duration = Buffs.GetDuration(this.entity_index, modifier_index);
        var remaining = Buffs.GetRemainingTime(this.entity_index, modifier_index);

        var progress_ratio = 1;
        if (remaining && duration) {progress_ratio = remaining/duration};
        if (isNaN(progress_ratio)) { progress_ratio = 1; }
        progress_ratio = 1 - progress_ratio;

        this.progress_panel.SetProgress(progress_ratio * 100)
        this.progress_panel.SetForegroundColor("#FAFAFA")

        this.panel.style.opacity = "1.0";
    } else {
        var fillness = this.progress_panel.GetProgress()
        if(fillness < 100){     
            this.progress_panel.SetForegroundColor("rgb(238, 53, 0)")
        } else {
            this.progress_panel.SetForegroundColor("rgb(51, 162, 40)")
        }
        this.panel.style.opacity = "0.0";
    }
}
CastPoint.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Resources__CastPoint");
    this.progress_panel = new ProgressBar("CastPoint", this.panel, {})
}

function Status(team_id){
    Component.call(this)
    
    this.panel = null;
    this.player_panel = null;
    this.progress_panel = null;
    this.team_id = team_id
}
Status.prototype = Object.create(Component.prototype);
Status.prototype.constructor = Status;
Status.prototype.Update = function(){
    var current_status = null;        
    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam(local_player_id);

    var all_data = {};
    
    if(this.type == OVERHEAD_TYPE_UNIT){
        all_data = all_units_data
    }
    if(this.type == OVERHEAD_TYPE_HERO){
        all_data = all_heroes_data
    }

    for(let modifier_name in all_data["index_" + this.entity_index].status){
        let status = all_data["index_" + this.entity_index].status[modifier_name];
        var scope = status.scope;

        if(!current_status || (status.priority > current_status.priority)){
            if(scope == STATUS_SCOPE_LOCAL){
                if(local_player_team == this.team_id){
                    current_status = status
                }
            } else {
                current_status = status
            }
        }
    }

    if(!current_status){ 
        this.panel.style.opacity = "0.0";
        this.player_panel.style.opacity = "1.0";
        return 
    }

    var text = current_status.label;
    var style_name = current_status.style_name;
    var content = current_status.content;
    var trigger = current_status.trigger;
    var max_stacks = current_status.max_stacks;
    var modifier_name = current_status.modifier_name;
    var modifier_index = Modifiers.FindModifierByName(this.entity_index, modifier_name)
    
    if(modifier_index){
        var progress_ratio = GetProgressRatio(this.entity_index, modifier_index, content, trigger, max_stacks);
        
        var text_panel = this.panel.FindChildTraverse("Status__Text--Normal");
        var text_panel_glow = this.panel.FindChildTraverse("Status__Text--Glow");
        
        this.progress_panel.SetProgress(progress_ratio * 100)
        text_panel.text = text;
        text_panel_glow.text = text;

        var style = styles[style_name] && styles[style_name] || styles["Generic"];

        this.progress_panel.SetForegroundColor(style.backgroundColor || "#FAFAFA")
        text_panel_glow.style.textShadow = style.textShadow || "none";
        text_panel.style.color = style.color || "#FAFAFA";

        this.panel.style.opacity = "1.0";
        this.player_panel.style.opacity = "0.0";
    }
}
Status.prototype.OnCreated = function(panel){
    this.player_panel = panel.FindChildTraverse("Player");
    this.panel = panel.FindChildTraverse("Status");
    this.progress_panel = new ProgressBar("Status", this.panel.FindChildTraverse("Status__Bottom"), {})
}

function Charges(modifier_name, team_id){
    Component.call(this)

    this.modifier_name = modifier_name
    this.team_id = team_id
    this.panel = null;
}
Charges.prototype = Object.create(Component.prototype);
Charges.prototype.constructor = Charges;
Charges.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.entity_index, this.modifier_name)

    if(modifier_index){
        var ammount = Buffs.GetStackCount(this.entity_index, modifier_index)
        var text_panel = this.panel.FindChildTraverse("Charge__Text--Number");
        text_panel.text = ammount;
        text_panel.style.color = "#FAFAFA";

        if(ammount == 0){
            text_panel.style.color = "rgba(238, 53, 0, 1.0)";
        }

        this.panel.style.opacity = 1.0
    } else {
        this.panel.style.opacity = 0.0
    }
}
Charges.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Charges");
}

function Recast(team_id){
    Component.call(this)

    this.panel = null;
    this.team_id = team_id
}
Recast.prototype = Object.create(Component.prototype);
Recast.prototype.constructor = Recast;
Recast.prototype.Update = function(){
    var current_recast = null; 

    var all_data = {};
    
    if(this.type == OVERHEAD_TYPE_UNIT){
        all_data = all_units_data
    }
    if(this.type == OVERHEAD_TYPE_HERO){
        all_data = all_heroes_data
    }

    for(let modifier_name in all_data["index_" + this.entity_index].recast){
        let recast = all_data["index_" + this.entity_index].recast[modifier_name];
        current_recast = recast;
        break;
    }

    if(!current_recast){ 
        this.panel.style.opacity = "0.0";
        return 
    }

    var modifier_index = Modifiers.FindModifierByName(this.entity_index, current_recast.modifier_name)
    
    if(modifier_index){
        this.panel.FindChildTraverse("Recast__Text").text = current_recast.key;
        this.panel.FindChildTraverse("Recast__Image").abilityname = current_recast.ability_name;
        
        this.panel.style.opacity = "1.0";
    }
}
Recast.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Recast");
}

function Update(){
    hero_overheads.forEach(function(overhead){
        overhead.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

function GetProgressRatio(entity_index, modifier_index, content, trigger, max_stacks){
    var progress_ratio = 1;
    var content = content;
    var trigger = trigger;

    if(trigger == STATUS_TRIGGER_DURATION){
        var duration = Buffs.GetDuration(entity_index, modifier_index);
        var remaining = Buffs.GetRemainingTime(entity_index, modifier_index);
        if (remaining && duration){ progress_ratio = remaining/duration };
        if (isNaN(progress_ratio)){ progress_ratio = 1; }
        if (content == STATUS_CONTENT_FILLUP){progress_ratio = 1 - progress_ratio;}
    } else if (trigger == STATUS_TRIGGER_STACKS) {
        var stacks = (Buffs.GetStackCount(entity_index, modifier_index)||0);
        var max_stacks = max_stacks;
        var progress_ratio = 1;
        if (max_stacks) { progress_ratio = stacks/max_stacks};
        if (isNaN(progress_ratio)) { progress_ratio = 1; }
        if (content == STATUS_CONTENT_FILLUP){progress_ratio = 1 - progress_ratio;}
    }
    
    return progress_ratio;
}

/* Initialization */
all_heroes_data = CustomNetTables.GetAllTableValues("heroes");

for (let key in all_heroes_data) {
    let data = all_heroes_data[key];
    let settings = { type: OVERHEAD_TYPE_HERO };

    AddOverhead(data, settings);
}

CustomNetTables.SubscribeNetTableListener("heroes", function(table, key, data){
    if(!all_heroes_data[key]){
        let settings = { type: OVERHEAD_TYPE_HERO };
        AddOverhead(data, settings);
    }
    all_heroes_data[key] = data;
});

Update();



