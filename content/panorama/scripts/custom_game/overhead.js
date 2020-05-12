var INTERVAL = 0.01;
var hero_overheads = [];
var all_heroes_data = {}

var STATUS_TRIGGER_DURATION = 1
var STATUS_TRIGGER_STACKS = 2

var STATUS_CONTENT_CLEAROUT = 1
var STATUS_CONTENT_FILLUP = 2

var STATUS_SCOPE_PUBLIC = 1
var STATUS_SCOPE_LOCAL = 2


function Component(){
    this.hero_index = null;
    this.remove = false;
    this.alliance = "DOTA_NO_ALLIANCE";
}
Component.prototype.Update = function(){}
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

function AddHeroOverhead(data){
    var hero_index = data.heroIndex;
    var team_id = data.teamID;
    var player_id = data.playerID;

    var overhead = new HeroOverhead(hero_index, team_id, player_id)
    var health = new Health()
    var mana = new Mana()
    var cast_point = new CastPoint()
    var status = new Status(team_id)

    overhead.AddComponent(mana)
    overhead.AddComponent(health)
    overhead.AddComponent(cast_point)
    overhead.AddComponent(status)

    hero_overheads.push(overhead);
}

function AddRecast(data){
    var hero_index = data.heroIndex;
    var key = data.key || "NO KEY";
    var ability_name = data.abilityName;
    var modifier_name = data.modifierName;
    var team_id = data.teamID;
    var overhead = null;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var recast = new Recast(ability_name, modifier_name, key, team_id)
    overhead.AddComponent(recast)
}

function AddCharges(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;
    var team_id = data.teamID;
    var overhead = null;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var charges = new Charges(modifier_name, team_id)
    overhead.AddComponent(charges)
}

function AddStacks(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;
    var team_id = data.teamID;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var stacks = new Stacks(modifier_name, team_id)
    overhead.AddComponent(stacks)
}

function AddCooldown(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;
    var team_id = data.teamID;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var cooldown = new Cooldown(modifier_name, team_id)
    overhead.AddComponent(cooldown)
}

function HeroOverhead(hero_index, team_id, player_id){
    this.hero_index = hero_index
    this.components = []
    this.panel = $.CreatePanel("Panel", $("#Overhead__Container"), "");
    this.alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( team_id );

    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );

    var color = "LOCAL"
    if(local_player_alliance != this.alliance){
        color = GameUI.CustomUIConfig().Alliances.alliances[this.alliance].color;
    }

    this.panel.BLoadLayoutSnippet("OverHero");
    this.panel.FindChildTraverse("Player__Text").text = Players.GetPlayerName( player_id );
    this.panel.FindChildTraverse("Player__Text").style.color = Colors.Gradient(color);
}
HeroOverhead.prototype.Update = function(){
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
HeroOverhead.prototype.UpdatePosition = function(){
    if(!IsVisibleByLocal(this.hero_index)){
        return false;
    }

    var origin = Entities.GetAbsOrigin(this.hero_index);
    var offset = Entities.GetHealthBarOffset(this.hero_index);

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
HeroOverhead.prototype.UpdateVisibility = function(){
    var hide = Modifiers.FindModifierByName(this.hero_index, "modifier_hide_bar")

    if(!Entities.IsAlive( this.hero_index ) || !IsVisibleByLocal(this.hero_index) || hide != false ){
        this.panel.style.opacity = "0.0";
    } else {
        this.panel.style.opacity = "1.0";
    }
}
HeroOverhead.prototype.AddComponent = function(component){
    component.SetHeroIndex(this.hero_index)
    component.SetAlliance(this.alliance)
    component.OnCreated(this.panel)
    this.components.push(component)
}
HeroOverhead.prototype.GetComponents = function(){
    return this.components
}
HeroOverhead.prototype.GetHeroIndex = function(){
    return this.hero_index
}

function Stacks(modifier_name, team_id){
    this.modifier_name = modifier_name
    this.panel = null
    this.team_id = team_id;
}
Stacks.prototype = Object.create(Component.prototype);
Stacks.prototype.constructor = Stacks;
Stacks.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, this.modifier_name)
    for(i = 0; i < 4; i++){
        this.panel.GetChild(i).style.opacity = "0.0";
    }

    if(modifier_index){
        var ammount = Buffs.GetStackCount( this.hero_index, modifier_index )
       
        for(i = 0; i < ammount; i++){
            this.panel.GetChild(i).style.opacity = "1.0";
        }
    } else {
        this.ScheduleRemove()
    }
}
Stacks.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Stacks");

    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam( local_player_id );

    if( local_player_team != this.team_id ){
        this.panel.opacity = 0.0;
        this.ScheduleRemove();
    }
}

function Cooldown(modifier_name, team_id){
    this.modifier_name = modifier_name;
    this.panel = null;
    this.team_id = team_id;
}
Cooldown.prototype = Object.create(Component.prototype);
Cooldown.prototype.constructor = Cooldown;
Cooldown.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, this.modifier_name)

    var duration = Buffs.GetDuration( this.hero_index, modifier_index );
    var foreground_panel = this.panel.FindChildTraverse("Cooldown__Foreground");

    if(duration == -1){
        foreground_panel.style.clip = "radial( 50% 50%, 0deg, " + 360 + "deg )";
        foreground_panel.style.backgroundColor = "rgb(162, 249, 154)";
        return;
    }

    var remaining = Buffs.GetRemainingTime( this.hero_index, modifier_index );
    var progress_ratio = 1;
    if (remaining && duration) {progress_ratio = remaining/duration};
    if (isNaN(progress_ratio)) { progress_ratio = 1; }
    progress_ratio = 1 - progress_ratio;
    var degree = 360 * progress_ratio

    foreground_panel.style.clip = "radial( 50% 50%, 0deg, " + degree + "deg )";
    foreground_panel.style.backgroundColor = "rgb(238, 53, 0)";
    
    if(degree == 360){
        foreground_panel.style.backgroundColor = "rgb(162, 249, 154)";
    }
}
Cooldown.prototype.OnCreated = function(panel){
    panel.FindChildTraverse("Stacks").style.visibility = "collapse";
    
    this.panel = panel.FindChildTraverse("Cooldown");
    this.panel.style.visibility = "visible";

    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam( local_player_id );

    if( local_player_team != this.team_id ){
        this.panel.style.opacity = 0.0;
        this.ScheduleRemove();
    }
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
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, this.modifier_name)

    if(modifier_index){
        var duration = Buffs.GetDuration( this.hero_index, modifier_index );
        var remaining = Buffs.GetRemainingTime( this.hero_index, modifier_index );

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
    $.Msg(all_heroes_data[this.hero_index]);

    var current_status = null;        
    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam( local_player_id );

    for(let modifier_name in all_heroes_data[this.hero_index].status){
        let status = all_heroes_data[this.hero_index].status[modifier_name];
        var scope = status.scope;

        if(scope == STATUS_SCOPE_LOCAL && local_player_team != this.team_id){
            return;
        }
        if(!current_status || (status.priority > current_status.priority)){
            current_status = status
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
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, modifier_name)
    
    if(modifier_index){
        var progress_ratio = GetProgressRatio( this.hero_index, modifier_index, content, trigger, max_stacks );
        
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
    } else {
        this.panel.style.opacity = "0.0";
        this.player_panel.style.opacity = "1.0";
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
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, this.modifier_name)

    if(modifier_index){
        var ammount = Buffs.GetStackCount( this.hero_index, modifier_index )
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
    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam( local_player_id );

    if( local_player_team != this.team_id ){
        this.panel.opacity = 0.0;
        this.ScheduleRemove();
    }
}

function Recast(ability_name, modifier_name, key, team_id){
    Component.call(this)

    this.panel = null;
    this.ability_name = ability_name
    this.modifier_name = modifier_name
    this.key = key
    this.team_id = team_id
}
Recast.prototype = Object.create(Component.prototype);
Recast.prototype.constructor = Recast;
Recast.prototype.Update = function(){
    var modifier_index = Modifiers.FindModifierByName(this.hero_index, this.modifier_name)
    
    if(modifier_index){
        this.panel.FindChildTraverse("Recast__Text").text = this.key;
        this.panel.FindChildTraverse("Recast__Image").abilityname = this.ability_name;
        
        this.panel.style.opacity = "1.0";
    } else {
        this.panel.style.opacity = "0.0";
        this.ScheduleRemove()
    }
}
Recast.prototype.OnCreated = function(panel){
    this.panel = panel.FindChildTraverse("Recast");

    var local_player_id = Game.GetLocalPlayerID();
    var local_player_team = Players.GetTeam( local_player_id );

    if( local_player_team != this.team_id ){
        this.panel.opacity = 0.0;
        this.ScheduleRemove();
    }
}

function Mana(){
    Component.call(this)

    this.max_mana = 0;
    this.mana = 0;
    this.mana_per_cell = 25
    this.panel = null
    this.progress_panels = []
}
Mana.prototype = Object.create(Component.prototype);
Mana.prototype.constructor = Mana;
Mana.prototype.Update = function(){
    if(!IsVisibleByLocal(this.hero_index)){
        return;
    }

    this.mana = Entities.GetMana( this.hero_index )
    this.max_mana = Entities.GetMaxMana( this.hero_index )

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
    this.panel = panel.FindChildTraverse("Resources__Mana");
    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );
    
    if(local_player_alliance != this.alliance){
        this.panel.style.visibility = "collapse";
        this.ScheduleRemove();
    }
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
Health.prototype = Object.create(Component.prototype);
Health.prototype.constructor = Health;
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
    this.panel = panel.FindChildTraverse("Resources__Health");
    this.progress_panel_health = new ProgressBar("Health", this.panel, { foreground_color: Colors.Gradient(color), delayed: true } )
    this.progress_panel_shield = new ProgressBar("Shield", this.panel, { foreground_color: Colors.Gradient("GRAY") })
}

function Update(){
    hero_overheads.forEach(function(overhead){
        overhead.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

function GetProgressRatio( hero_index, modifier_index, content, trigger, max_stacks ){
    var progress_ratio = 1;
    var content = content;
    var trigger = trigger;

    if(trigger == STATUS_TRIGGER_DURATION){
        var duration = Buffs.GetDuration( hero_index, modifier_index );
        var remaining = Buffs.GetRemainingTime( hero_index, modifier_index );
        if (remaining && duration){ progress_ratio = remaining/duration };
        if (isNaN(progress_ratio)){ progress_ratio = 1; }
        if (content == STATUS_CONTENT_FILLUP){progress_ratio = 1 - progress_ratio;}
    } else if (trigger == STATUS_TRIGGER_STACKS) {
        var stacks = (Buffs.GetStackCount(hero_index, modifier_index)||0);
        var max_stacks = max_stacks;
        var progress_ratio = 1;
        if (max_stacks) { progress_ratio = stacks/max_stacks};
        if (isNaN(progress_ratio)) { progress_ratio = 1; }
        if (content == STATUS_CONTENT_FILLUP){progress_ratio = 1 - progress_ratio;}
    }
    
    return progress_ratio;
}

function IsVisibleByLocal(unit_index)
{
    for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++)
    {
        var buff_name = Buffs.GetName(unit_index, Entities.GetBuff(unit_index, i))
        if (buff_name == "modifier_hero_base") {
            return true
        }
    }
    return false
}

(function(){
    GameEvents.Subscribe( "add_recast", AddRecast );
    GameEvents.Subscribe( "add_charges", AddCharges );
    GameEvents.Subscribe( "add_stacks", AddStacks );
    GameEvents.Subscribe( "add_cooldown", AddCooldown );
    
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
            AddHeroOverhead({
                heroIndex: parseInt(key, 10),
                teamID: data.teamID,
                playerID: data.playerID,
            })
        }
        all_heroes_data[key] = data;
    });

    Update();
})();



