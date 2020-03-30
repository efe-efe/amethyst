var mainPanel = $("#OverheadContainer");
var hero_overhead_bars = {}
var INTERVAL = 0.01;

function MainCycle( heroIndex ){
    UpdateBarCycle( heroIndex );
    $.Schedule(INTERVAL, function(){ MainCycle(heroIndex) });
}

function UpdateBarCycle( heroIndex )
{
    if(!UpdateBarVisibilityCycle( heroIndex )){ return; }
    UpdateBarPositionCycle( heroIndex );
    UpdateStatusBarCycle( heroIndex );
    if( heroIndex == Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) ){
        UpdateRecastCycle( heroIndex )
    }
}

function UpdateBarVisibilityCycle( heroIndex ){
    
    var hide = FindModifierByName(heroIndex, "modifier_hide_bar")

    if(!Entities.IsAlive( heroIndex ) || !IsVisibleByLocal(heroIndex) || hide != false ){
        hero_overhead_bars[heroIndex].panel.style.opacity = "0.0";
        return false;
    } else {
        hero_overhead_bars[heroIndex].panel.style.opacity = "1.0";
        return true;
    }
}

function UpdateBarPositionCycle( heroIndex ){
    var origin = Entities.GetAbsOrigin(heroIndex);
    var hpOffset = Entities.GetHealthBarOffset(heroIndex);

    var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + hpOffset);
    var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + hpOffset);

    var check = Game.ScreenXYToWorld(wx, wy);

    if(check[1] != 0) {
        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();
        var scale = 1080 / sh;

        var x = scale * Math.min(sw - hero_overhead_bars[heroIndex].panel.actuallayoutwidth,Math.max(0, wx - hero_overhead_bars[heroIndex].panel.actuallayoutwidth/2));
        var y = scale * Math.min(sh - hero_overhead_bars[heroIndex].panel.actuallayoutheight,Math.max(0, wy - hero_overhead_bars[heroIndex].panel.actuallayoutheight));

        hero_overhead_bars[heroIndex].panel.style.position = x + "px " + y + "px 0px;";
        if(
            hero_overhead_bars[heroIndex].panel.actuallayoutwidth ==  0 &&
            hero_overhead_bars[heroIndex].panel.actuallayoutheight ==  0
        ){
            hero_overhead_bars[heroIndex].panel.style.position = "-1000px -1000px 0px;";
            return true;
        }
    } else {
        hero_overhead_bars[heroIndex].panel.style.position = "-1000px -1000px 0px;";
        return false;
    }
    return true
}

function UpdateStatusBarCycle( heroIndex ){
    var heroBar = hero_overhead_bars[heroIndex]
    var status = null;
    var modifierName = null;

    for (var property in heroBar.status) {
        if (heroBar.status.hasOwnProperty(property)) {
            var temp_status = heroBar.status[property];

            if(!status || temp_status.priority >= status.priority){
                status = temp_status;
                modifierName = property;
            }
        }
    }

    var hero_bar_status = heroBar.panel.FindChildTraverse("Status");
    var hero_bar_player = heroBar.panel.FindChildTraverse("Player");

    if( status && modifierName ){
        var modifierIndex = FindModifierByName(heroIndex, modifierName)
        
        if(modifierIndex){
            var progressRatio = GetProgressRatio( heroIndex, modifierIndex, status.reversed, status.type, status.maxStacks );
            var progress_bar_inner = heroBar.panel.FindChildrenWithClassTraverse("Status__ProgressOuterInner")[0];
            progress_bar_inner.style.width = "" + (progressRatio * 100) + "%";
        
            var progress_bar_text = heroBar.panel.FindChildrenWithClassTraverse("Status__Text--Normal")[0];
            var progress_bar_text_glow = heroBar.panel.FindChildrenWithClassTraverse("Status__Text--Glow")[0];
            progress_bar_text.text = status.label;
            progress_bar_text_glow.text = status.label;

            if(status.stylename != ""){
                progress_bar_inner.style.backgroundColor = styles[status.stylename].backgroundColor || "#FAFAFA";
                progress_bar_text_glow.style.textShadow = styles[status.stylename].textShadow || "none";
                progress_bar_text.style.color = styles[status.stylename].color || "#FAFAFA";
            } else {
                progress_bar_inner.style.backgroundColor = "#FAFAFA";
                progress_bar_text_glow.style.textShadow = "none";
                progress_bar_text.style.color = "#FAFAFA";
            }

            hero_bar_status.style.opacity = "1.0";
            hero_bar_player.style.opacity = "0.0";
        } else {
            delete heroBar.status[modifierName];
        }
    } else {
        hero_bar_status.style.opacity = "0.0";
        hero_bar_player.style.opacity = "1.0";
    }
}

function GetProgressRatio( heroIndex, modifierIndex, reversed, type, maxStacks ){
    var progressRatio = 1;
    var reversed = reversed;
    var type = type;

    if(type == "duration"){
        var duration = Buffs.GetDuration( heroIndex, modifierIndex );
        var remaining = Buffs.GetRemainingTime( heroIndex, modifierIndex );
        if (remaining && duration){ progressRatio = remaining/duration };
        if (isNaN(progressRatio)){ progressRatio = 1; }
        if (reversed){progressRatio = 1 - progressRatio;}
    } else if (type == "stack") {
        var stacks = (Buffs.GetStackCount(heroIndex, modifierIndex)||0);
        var maxStacks = maxStacks;
        var progressRatio = 1;
        if (maxStacks) { progressRatio = stacks/maxStacks};
        if (isNaN(progressRatio)) { progressRatio = 1; }
        if (reversed){progressRatio = 1 - progressRatio;}

        $.Msg(stacks, " ", maxStacks);
    }
    
    return progressRatio;
}

function UpdateRecastCycle( heroIndex ){
    var heroBar = hero_overhead_bars[heroIndex]
    var recast = null;
    var abilityName = null;


    for (var property in heroBar.recast) {
        if (heroBar.recast.hasOwnProperty(property)) {
            var temp_recast = heroBar.recast[property];

            if(!recast || temp_recast.priority){
                recast = temp_recast;
                abilityName = property;
            }
        }
    }

    var hero_bar_recast = hero_overhead_bars[heroIndex].panel.FindChildTraverse("Recast");
    if( recast && abilityName ){
        var modifierIndex = FindModifierByName(heroIndex, recast.modifierName)

        if(modifierIndex){
            var hero_bar_recast_key = heroBar.panel.FindChildrenWithClassTraverse("Recast__Text")[0];
            var hero_bar_recast_image =  heroBar.panel.FindChildTraverse("Recast__Image");
            hero_bar_recast_key.text = recast.key;
            hero_bar_recast_image.abilityname = abilityName;
            hero_bar_recast.style.opacity = "1.0";

        } else {
            delete heroBar.recast[abilityName];
        }
    } else {
        hero_bar_recast.style.opacity = "0.0";
    }
}

function AddPlayer( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );

    var heroIndex = data.heroIndex;
    var teamID = data.teamID;
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( teamID );
    var playerID = data.playerID;

    hero_overhead_bars[heroIndex] = {}
    var heroBar = hero_overhead_bars[heroIndex]

    heroBar.panel = $.CreatePanel("Panel", mainPanel, "");
    heroBar.panel.BLoadLayoutSnippet("OverHero");
    heroBar.status = {};
    heroBar.recast = {};

    var color = null;
    if(localPlayerAlliance == alliance){
        color = "LOCAL";
    } else {
        color = GameUI.CustomUIConfig().Alliances.alliances[alliance].color;
        var mana_bar = heroBar.panel.FindChildTraverse("Mana");
        mana_bar.style.opacity = "0.0";
    }

    var health_bar_inner = heroBar.panel.FindChildrenWithClassTraverse("HealthInner")[0];
    var health_bar_inner_2 = heroBar.panel.FindChildrenWithClassTraverse("HealthInner")[1];
    health_bar_inner.style.backgroundColor = Colors.Gradient(color);
    health_bar_inner_2.style.backgroundColor = Colors.Gradient(color);
    
    var hero_bar_stacks = heroBar.panel.FindChildTraverse("Stacks");
    hero_bar_stacks.GetChild(hero_bar_stacks.GetChildCount() - 1).style.margin = "0px";

    var hero_bar_charges = heroBar.panel.FindChildTraverse("Charges");
    hero_bar_charges.style.opacity = "0.0";

    var hero_bar_player = heroBar.panel.FindChildrenWithClassTraverse("Player__Text")[0];
    hero_bar_player.text = Players.GetPlayerName( playerID );
    hero_bar_player.style.color = Colors.Gradient(color);

    UpdateStacks({ heroIndex: heroIndex, stacks: 0, teamID: data.teamID })
    MainCycle(heroIndex);
}

function AddStatus_( data ){
    var heroIndex = data.heroIndex;
    var label = data.label || "";
    var name = data.modifierName;
    var stylename = data.stylename || "";
    var priority = data.priority || 0;
    var reversed = data.reversed || null;
    var type = data.type || "duration";
    var maxStacks = data.maxStacks || null;
    var local_only = data.local_only || null;

    
    if(!hero_overhead_bars[heroIndex]){ return }

    if(local_only){
        if( heroIndex == Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )){
            hero_overhead_bars[heroIndex].status[name] = {
                label: label,
                stylename: stylename,
                priority: priority,
                reversed: reversed,
                type: type,
                maxStacks: maxStacks
            }
        }
    } else {
        hero_overhead_bars[heroIndex].status[name] = {
            label: label,
            stylename: stylename,
            priority: priority,
            reversed: reversed,
            type: type,
            maxStacks: maxStacks
        }
    }
}

function AddRecast_( data ){
    var heroIndex = data.heroIndex;
    var abilityName = data.abilityName;
    var modifierName = data.modifierName;
    var key = data.key || "NO KEY";

    hero_overhead_bars[heroIndex].recast[abilityName] = {
        key: key,
        modifierName: modifierName
    }

    $.Msg(hero_overhead_bars[heroIndex].recast);
}

function UpdateHealthBar( data ){
    var heroIndex = data.heroIndex;
    var shield = data.shield;
    var current_health = data.current_health;
    var max_health = data.max_health;
    var potential_health = data.potential_health;
    
    var shown_bar_width = 100 * ( potential_health + shield )/(max_health + shield);

    var shield_width = 100 * shield/(potential_health + shield);
    var health_width = 100 * current_health/(potential_health + shield);

    var health_bar = null;
    var health_bar_hidden = null;

    if(shield > 0){
        health_bar_hidden = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Health--NoShield")[0];
        health_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Health--WithShield")[0];
    } else {
        health_bar_hidden = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Health--WithShield")[0];
        health_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Health--NoShield")[0];
    }

    health_bar_hidden.style.visibility = "collapse";
    health_bar.style.visibility = "visible";

    var shield_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Shield")[0];
    var health_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HealthInner")[0];
    var health_bar_inner_2 = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HealthInner")[1];
    var health_bar_inner_back = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HealthInnerBack")[0];

    health_bar.style.width = shown_bar_width.toString() + "%";
    
    health_bar_inner.style.width = health_width.toString() + "%";
    health_bar_inner_2.style.width = health_width.toString() + "%";

    health_bar_inner_back.style.width = health_width.toString() + "%";
    shield_bar.style.width = shield_width.toString() + "%";
}

function UpdateManaBar( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( data.teamID );

    if( localPlayerAlliance != alliance ){ 
        return false;
    }

    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var mana_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("ManaInner")[0];
    mana_bar_inner.style.width = percentage.toString() + "%";
}

function UpdateStacks( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );
    var localPlayerAlliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( localPlayerTeam );
    var alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( data.teamID );

    if( localPlayerAlliance != alliance ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var stacks = data.stacks;
    var hero_bar_stacks = hero_overhead_bars[heroIndex].panel.FindChildTraverse("Stacks");

    for(i = 0; i < 4; i++){
        hero_bar_stacks.GetChild(i).style.opacity = "0.0";
    }

    for(i = 0; i < stacks; i++){
        hero_bar_stacks.GetChild(i).style.opacity = "1.0";
    }
}

function UpdateCooldown( data ){
    var heroIndex = data.heroIndex;
    var modifierName = data.modifierName;
    var modifierIndex = FindModifierByName(heroIndex, modifierName)

    if(!modifierIndex){
        $.Schedule(INTERVAL, function(){ 
            UpdateCooldown({ 
                heroIndex: heroIndex,
                modifierName: modifierName,
            }) 
        });
        return;
    } 

    var duration = Buffs.GetDuration( heroIndex, modifierIndex );
    if(duration == -1){
        var cooldown_bar_circle = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Cooldown__Circle")[0];
        cooldown_bar_circle.style.clip = "radial( 50% 50%, 0deg, " + 360 + "deg )";
        cooldown_bar_circle.style.backgroundColor = "rgb(162, 249, 154)";

        $.Schedule(INTERVAL, function(){ 
            UpdateCooldown({ 
                heroIndex: heroIndex,
                modifierName: modifierName,
            }) 
        });
        return;
    }

    var remaining = Buffs.GetRemainingTime( heroIndex, modifierIndex );
    var progressRatio = 1;
    if (remaining && duration) {progressRatio = remaining/duration};
    if (isNaN(progressRatio)) { progressRatio = 1; }
    progressRatio = 1 - progressRatio;
    var degree = 360 * progressRatio

    var cooldown_bar_circle = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Cooldown__Circle")[0];
    cooldown_bar_circle.style.clip = "radial( 50% 50%, 0deg, " + degree + "deg )";
    cooldown_bar_circle.style.backgroundColor = "rgb(238, 53, 0)";
    
    if(degree == 360){
        cooldown_bar_circle.style.backgroundColor = "rgb(162, 249, 154)";
    }

    $.Schedule(INTERVAL, function(){ 
        UpdateCooldown({ 
            heroIndex: heroIndex,
            modifierName: modifierName,
        }) 
    });
}

function UpdateCastPoint( data ){
    var heroIndex = data.heroIndex;
    var modifierIndex = FindModifierByName(heroIndex, "modifier_cast_point");

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("CastPointInner")[0];
    
    //Checking if castpoint has been overriden
    if(modifierIndex){
        var duration = Buffs.GetDuration( heroIndex, modifierIndex );
        var remaining = Buffs.GetRemainingTime( heroIndex, modifierIndex );

        var progressRatio = 1;
        if (remaining && duration) {progressRatio = remaining/duration};
        if (isNaN(progressRatio)) { progressRatio = 1; }
        progressRatio = 1 - progressRatio;
        cast_point_bar_inner.style.width = "" + (progressRatio * 100) + "%";

        $.Schedule(INTERVAL, function(){ 
            UpdateCastPoint({ 
                heroIndex: heroIndex,
            }) 
        });

    } else {

        var fill_percent = parseInt(cast_point_bar_inner.style.width.split("%")[0], 10)

        if(fill_percent < 100){     
            cast_point_bar_inner.style.backgroundColor = "rgb(238, 53, 0)";

        } else {
            cast_point_bar_inner.style.backgroundColor = "rgb(51, 162, 40)";
        }
        var cast_point_bar = hero_overhead_bars[data.heroIndex].panel.FindChildTraverse("CastPoint");
        cast_point_bar.style.opacity = "0.0";
        return;
    }
}

function UpdateCharges( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var charges = data.charges;
    
    var hero_bar_charge_text = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Charge__Text")[1];
    hero_bar_charge_text.text = charges;
    hero_bar_charge_text.style.color = "#FAFAFA";

    if(charges == 0){
        hero_bar_charge_text.style.color = "rgba(238, 53, 0, 1.0)";
    }
}

function InitializeCharges( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var charges = data.charges;

    if(!hero_overhead_bars[heroIndex] || !hero_overhead_bars[heroIndex].panel){
        $.Schedule(1.0, function(){ 
            InitializeCharges( data );
        })
        return;
    }
    var hero_bar_charges = hero_overhead_bars[heroIndex].panel.FindChildTraverse("Charges");

    hero_bar_charges.style.opacity = "1.0";

    var hero_bar_charge_text = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("Charge__Text")[1];
    hero_bar_charge_text.text = charges;
}

function InitializeCastPoint( data ){
    var heroIndex = data.heroIndex;

    //Restart status (from previous cast-points)
    var cast_point_bar = hero_overhead_bars[heroIndex].panel.FindChildTraverse("CastPoint");
    cast_point_bar.style.opacity = "1.0";

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("CastPointInner")[0];
    cast_point_bar_inner.style.backgroundColor = "#FAFAFA";

    //Prevent Race condition
    $.Schedule(0.05, function(){ 
        UpdateCastPoint({ 
            heroIndex: heroIndex,
            modifierIndex: null,
        })
    })
}

function InitializeCooldown( data ){
    var heroIndex = data.heroIndex;
    var modifierName = data.modifierName;

    if(!hero_overhead_bars[heroIndex] || !hero_overhead_bars[heroIndex].panel){
        $.Schedule(1.0, function(){ 
            InitializeCooldown( data );
        })
        return;
    }

    var cooldown_bar = hero_overhead_bars[heroIndex].panel.FindChildTraverse("Cooldown");
    cooldown_bar.style.opacity = "1.0";

    UpdateCooldown({ 
        heroIndex: heroIndex,
        modifierName: modifierName,
    })
}

function IsVisibleByLocal(unitIndex)
{
    for (var i = 0; i < Entities.GetNumBuffs(unitIndex); i++)
    {
        var buffName = Buffs.GetName(unitIndex, Entities.GetBuff(unitIndex, i))
        if (buffName == "modifier_generic_movement") {
            return true
        }
    }
    return false
}

function FindModifierByName(unitIndex, name)
{
    for (var i = 0; i < Entities.GetNumBuffs(unitIndex); i++)
    {
        var buffName = Buffs.GetName(unitIndex, Entities.GetBuff(unitIndex, i))
        if (buffName == name) {
            return Entities.GetBuff(unitIndex, i)
        }
    }
    return false
}

function ProgressBar(parent, foreground_color, background_color){
    this.panel = $.CreatePanel("Panel", parent, "");
    this.panel.BLoadLayoutSnippet("ProgressBar");

    this.background_panel = this.panel.FindChildTraverse("ProgressBar__Background");
    this.foreground_panel = this.panel.FindChildTraverse("ProgressBar__Foreground");
    this.foreground_panel.style.width = "0%";

    if(background_color){
        this.background_panel.style.backgroundColor = background_color;
    }
    if(foreground_color){
        this.foreground_panel.style.backgroundColor = foreground_color;
    }

    this.SetWidth = function(width){
        this.panel.style.width = width + "%";
    }

    this.SetProgress = function(progress){
        this.foreground_panel.style.width = progress.toString() + "%";
    }

    this.SetForegroundColor = function(color){
        this.foreground_panel.style.backgroundColor = color;
    }

    this.SetVisibility = function(visibility){
        this.panel.style.visibility = visibility;
    }

    this.GetProgress = function(){
        return parseInt(this.foreground_panel.style.width.split("%")[0], 10)
    }
}

function Component(){
    this.hero_index = null;
    this.panel = null;
    this.remove = false;
    this.alliance = "DOTA_NO_ALLIANCE";
}
Component.prototype.Update = function(){}
Component.prototype.SetHeroIndex = function(hero_index){
    this.hero_index = hero_index
}
Component.prototype.OnCreated = function(panel){
    this.panel = panel
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


var hero_overheads = [];

function AddHeroOverhead(data){
    var hero_index = data.heroIndex;
    var team_id = data.teamID;
    var player_id = data.playerID;


    var overhead = new HeroOverhead(hero_index, team_id, player_id)
    var mana = new Mana()
    var health = new Health()
    var cast_point = new CastPoint()

    overhead.AddComponent(mana)
    overhead.AddComponent(health)
    overhead.AddComponent(cast_point)

    hero_overheads.push(overhead);
}

function UpdateHealth(data){
    var hero_index = data.heroIndex;
    var overhead = null;
    var shield = data.shield;
    var potential_health = data.potential_health;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    if(overhead){
        overhead.GetComponents().forEach(function(component){
            if(component.SetShield){
                component.SetShield(shield)
            } 
            if(component.SetPotentialHealth){
                component.SetPotentialHealth(potential_health)
            }
        })
    }
}

function AddRecast(data){
    var hero_index = data.heroIndex;
    var key = data.key || "NO KEY";
    var ability_name = data.abilityName;
    var modifier_name = data.modifierName;
    var overhead = null;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var recast = new Recast(ability_name, modifier_name, key)
    overhead.AddComponent(recast)
}

function AddCharges(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;
    var overhead = null;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var charges = new Charges(modifier_name)
    overhead.AddComponent(charges)
}

function AddStatus(data){
    var hero_index = data.heroIndex;
    var text = data.label || "";
    var modifier_name = data.modifierName;
    var style_name = data.stylename || "Generic";
    var priority = data.priority || 0;
    var reversed = data.reversed || null;
    var type = data.type || "duration";
    var max_stacks = data.maxStacks || null;
    var overhead = null;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var status = new Status(text, style_name, priority, reversed, type, max_stacks, modifier_name)
    overhead.AddComponent(status)
}

function AddStacks(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var stacks = new Stacks(modifier_name)
    overhead.AddComponent(stacks)
}

function AddCooldown(data){
    var hero_index = data.heroIndex;
    var modifier_name = data.modifierName;

    hero_overheads.forEach(function(m_overhead){
        if(m_overhead.GetHeroIndex() == hero_index){
            overhead = m_overhead
        }
    })

    var cooldown = new Cooldown(modifier_name)
    overhead.AddComponent(cooldown)
}

function HeroOverhead(hero_index, team_id, player_id){
    this.hero_index = hero_index
    this.components = []
    this.panel = $.CreatePanel("Panel", $("#OverheadContainer"), "");
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

    this.Update = function(){
        this.UpdatePosition();
        this.UpdateVisibility();

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

    this.UpdatePosition = function(){
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

    this.UpdateVisibility = function(){
        var hide = FindModifierByName(this.hero_index, "modifier_hide_bar")

        if(!Entities.IsAlive( this.hero_index ) || !IsVisibleByLocal(this.hero_index) || hide != false ){
            this.panel.style.opacity = "0.0";
        } else {
            this.panel.style.opacity = "1.0";
        }
    }

    this.AddComponent = function(component){
        component.SetHeroIndex(this.hero_index)
        component.SetAlliance(this.alliance)
        component.OnCreated(this.panel)
        this.components.push(component)
    }

    this.GetComponents = function(){
        return this.components
    }

    this.GetHeroIndex = function(){
        return this.hero_index
    }
}

function Stacks(modifier_name){
    this.modifier_name = modifier_name
    this.stacks_panel = null
}
Stacks.prototype = Object.create(Component.prototype);
Stacks.prototype.constructor = Stacks;
Stacks.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)
    for(i = 0; i < 4; i++){
        this.stacks_panel.GetChild(i).style.opacity = "0.0";
    }

    if(modifier_index){
        var ammount = Buffs.GetStackCount( this.hero_index, modifier_index )
       
        for(i = 0; i < ammount; i++){
            this.stacks_panel.GetChild(i).style.opacity = "1.0";
        }
    } else {
        this.ScheduleRemove()
    }
}
Stacks.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.stacks_panel = this.panel.FindChildTraverse("Stacks");
}

function Cooldown(modifier_name){
    this.modifier_name = modifier_name;
    this.cooldown_panel = null;
}
Cooldown.prototype = Object.create(Component.prototype);
Cooldown.prototype.constructor = Cooldown;
Cooldown.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)

    var duration = Buffs.GetDuration( this.hero_index, modifier_index );
    var foreground_panel = this.cooldown_panel.FindChildTraverse("Cooldown__Foreground");

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
    Component.prototype.OnCreated.call(this, panel);
    this.cooldown_panel = this.panel.FindChildTraverse("Cooldown");
    this.stacks_panel = this.panel.FindChildTraverse("Stacks");

    this.stacks_panel.style.visibility = "collapse";
    this.cooldown_panel.style.visibility = "visible";
}


function CastPoint(){
    Component.call(this)
    
    this.modifier_name = "modifier_cast_point";
    this.cast_point_panel = null
    this.progress_panel = null;
}
CastPoint.prototype = Object.create(Component.prototype);
CastPoint.prototype.constructor = CastPoint;
CastPoint.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)

    if(modifier_index){
        var duration = Buffs.GetDuration( this.hero_index, modifier_index );
        var remaining = Buffs.GetRemainingTime( this.hero_index, modifier_index );

        var progressRatio = 1;
        if (remaining && duration) {progressRatio = remaining/duration};
        if (isNaN(progressRatio)) { progressRatio = 1; }
        progressRatio = 1 - progressRatio;

        this.progress_panel.SetProgress(progressRatio * 100)
        this.progress_panel.SetForegroundColor("#FAFAFA")

        this.cast_point_panel.style.opacity = "1.0";
    } else {
        var fillness = this.progress_panel.GetProgress()
        if(fillness < 100){     
            this.progress_panel.SetForegroundColor("rgb(238, 53, 0)")
        } else {
            this.progress_panel.SetForegroundColor("rgb(51, 162, 40)")
        }
        this.cast_point_panel.style.opacity = "0.0";
    }
}
CastPoint.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.cast_point_panel = this.panel.FindChildTraverse("Resources__CastPoint");
    this.progress_panel = new ProgressBar(this.cast_point_panel)
}


function Status(text, style_name, priority, reversed, type, max_stacks, modifier_name){
    Component.call(this)
    
    this.text = text; 
    this.style_name = style_name;
    this.priority = priority;
    this.reversed = reversed;
    this.type = type;
    this.max_stacks = max_stacks;
    this.modifier_name = modifier_name;
    this.status_panel = null;
    this.player_panel = null;
    this.progress_panel = null;
}
Status.prototype = Object.create(Component.prototype);
Status.prototype.constructor = Status;
Status.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)
    
    if(modifier_index){
        var progress_ratio = GetProgressRatio( this.hero_index, modifier_index, this.reversed, this.type, this.max_stacks );
        
        var text_panel = this.status_panel.FindChildTraverse("Status__Text--Normal");
        var text_panel_glow = this.status_panel.FindChildTraverse("Status__Text--Glow");
        
        this.progress_panel.SetProgress(progress_ratio * 100)
        text_panel.text = this.text;
        text_panel_glow.text = this.text;

        this.progress_panel.SetForegroundColor(styles[this.style_name].backgroundColor || "#FAFAFA")
        text_panel_glow.style.textShadow = styles[this.style_name].textShadow || "none";
        text_panel.style.color = styles[this.style_name].color || "#FAFAFA";

        this.status_panel.style.opacity = "1.0";
        this.player_panel.style.opacity = "0.0";
    } else {
        this.status_panel.style.opacity = "0.0";
        this.player_panel.style.opacity = "1.0";
        this.ScheduleRemove()
    }
}
Status.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.player_panel = this.panel.FindChildTraverse("Player");
    this.status_panel = this.panel.FindChildTraverse("Status");
    this.progress_panel = new ProgressBar(this.status_panel.FindChildTraverse("Status__Bottom"))
}


function Charges(modifier_name){
    Component.call(this)

    this.modifier_name = modifier_name
    this.charges_panel = null;
}
Charges.prototype = Object.create(Component.prototype);
Charges.prototype.constructor = Charges;
Charges.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)

    if(modifier_index){
        var ammount = Buffs.GetStackCount( this.hero_index, modifier_index )
        var text_panel = this.charges_panel.FindChildTraverse("Charge__Text--Number");
        text_panel.text = ammount;
        text_panel.style.color = "#FAFAFA";

        if(ammount == 0){
            text_panel.style.color = "rgba(238, 53, 0, 1.0)";
        }

        this.charges_panel.style.opacity = 1.0
    } else {
        this.charges_panel.style.opacity = 0.0
    }
}
Charges.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.charges_panel = this.panel.FindChildTraverse("Charges");
}

function Recast(ability_name, modifier_name, key){
    Component.call(this)

    this.recast_panel = null;
    this.ability_name = ability_name
    this.modifier_name = modifier_name
    this.key = key
}
Recast.prototype = Object.create(Component.prototype);
Recast.prototype.constructor = Recast;
Recast.prototype.Update = function(){
    var modifier_index = FindModifierByName(this.hero_index, this.modifier_name)
    
    if(modifier_index){
        this.recast_panel.FindChildTraverse("Recast__Text").text = this.key;
        this.recast_panel.FindChildTraverse("Recast__Image").abilityname = this.ability_name;
        
        this.recast_panel.style.opacity = "1.0";
    } else {
        this.recast_panel.style.opacity = "0.0";
        this.ScheduleRemove()
    }
}
Recast.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.recast_panel = this.panel.FindChildTraverse("Recast");
}

function Mana(){
    Component.call(this)

    this.max_mana = 0;
    this.mana = 0;
    this.mana_per_cell = 25

    this.progress_panels = []
}
Mana.prototype = Object.create(Component.prototype);
Mana.prototype.constructor = Mana;
Mana.prototype.Update = function(){
    this.mana = Entities.GetMana( this.hero_index )
    this.max_mana = Entities.GetMaxMana( this.hero_index )

    var cells = this.max_mana/this.mana_per_cell

    while(this.progress_panels.length < cells){
        var progress_panel = new ProgressBar(this.panel.FindChildTraverse("Resources__Mana"), Colors.Gradient("BLUE"));
        this.progress_panels.push(progress_panel);
    }
    while(this.progress_panels.length > cells ){
        this.progress_panels[this.progress_panels.length - 1].SetVisibility("collapse")
        this.progress_panels.pop();
    }
    for(var i = 0; i < this.progress_panels.length; i++){
        var width = (100 * this.mana_per_cell)/this.max_mana
        this.progress_panels[i].SetWidth(width);
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
    Component.prototype.OnCreated.call(this, panel);

    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );
    
    if(local_player_alliance != this.alliance){
        var panel_container = this.panel.FindChildTraverse("Resources__Mana");
        panel_container.style.visibility = "collapse";
    }
}

function Health(color){
    Component.call(this)

    this.health = 0;
    this.max_health = 0;
    this.shield = 0;
    this.potential_health = 0;

    this.panel_shield = null; 
    this.panel_no_shield = null;
    
    this.color = color
}
Health.prototype = Object.create(Component.prototype);
Health.prototype.constructor = Health;
Health.prototype.Update = function(){
    this.health = Entities.GetHealth( this.hero_index )
    this.max_health = Entities.GetMaxHealth( this.hero_index )

    var bar_width = 100 * ( this.potential_health + this.shield )/(this.max_health + this.shield);
    var shield_width = 100 * this.shield/(this.potential_health + this.shield);
    var health_width = 100 * this.health/(this.potential_health + this.shield);
    
    if(this.shield > 0){
        var foreground_panel = this.panel_shield.FindChildrenWithClassTraverse("Healthbar__Foreground")[0];

        this.panel_no_shield.style.visibility = "collapse";
        this.panel_shield.style.visibility = "visible";
        this.panel_shield.style.width = bar_width.toString() + "%";
        foreground_panel.style.width = health_width.toString() + "%";
        this.panel_shield.FindChildTraverse("Healthbar__Shield").width = shield_width.toString() + "%";
    } else {
        var background_panel = this.panel_no_shield.FindChildrenWithClassTraverse("Healthbar__Background")[0];
        var foreground_panel = this.panel_no_shield.FindChildrenWithClassTraverse("Healthbar__Foreground")[0];

        this.panel_shield.style.visibility = "collapse";
        this.panel_no_shield.style.visibility = "visible";
        this.panel_no_shield.style.width = bar_width.toString() + "%";
        foreground_panel.style.width = health_width.toString() + "%";
        background_panel.style.width = health_width.toString() + "%";
    }
}
Health.prototype.SetShield = function(shield){
    this.shield = shield
}
Health.prototype.SetPotentialHealth = function(potential_health){
    this.potential_health = potential_health
}
Health.prototype.OnCreated = function(panel){
    Component.prototype.OnCreated.call(this, panel);
    this.panel_shield = this.panel.FindChildTraverse("Healthbar__Container--WithShield");
    this.panel_no_shield =this.panel.FindChildTraverse("Healthbar__Container--NoShield");

    var foreground_panel_shield = this.panel_shield.FindChildrenWithClassTraverse("Healthbar__Foreground")[0];
    var foreground_panel_no_shield = this.panel_no_shield.FindChildrenWithClassTraverse("Healthbar__Foreground")[0];

    var local_player_team = Players.GetTeam( Game.GetLocalPlayerID() );
    var local_player_alliance = GameUI.CustomUIConfig().Alliances.FindAllianceNameByTeam( local_player_team );

    var color = "LOCAL"
    if(local_player_alliance != this.alliance){
        color = GameUI.CustomUIConfig().Alliances.alliances[this.alliance].color;
    }

    foreground_panel_shield.style.backgroundColor = Colors.Gradient(color);
    foreground_panel_no_shield.style.backgroundColor = Colors.Gradient(color);
}

function Update(){
    hero_overheads.forEach(function(overhead){
        overhead.Update();
    })

    $.Schedule(INTERVAL, function(){ Update(); });
}

(function(){
    /*GameEvents.Subscribe( "add_player", AddPlayer );
    GameEvents.Subscribe( "add_status", AddStatus_ );
    GameEvents.Subscribe( "add_recast", AddRecast_ );
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_hero_mana_bar", UpdateManaBar );
    GameEvents.Subscribe( "update_hero_stacks", UpdateStacks );
    GameEvents.Subscribe( "update_hero_charges", UpdateCharges );
    GameEvents.Subscribe( "initialize_hero_charges", InitializeCharges );
    GameEvents.Subscribe( "initialize_cast_point", InitializeCastPoint );
    GameEvents.Subscribe( "initialize_hero_cooldown", InitializeCooldown );
    */
    
    GameEvents.Subscribe( "add_player", AddHeroOverhead );
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealth );

    GameEvents.Subscribe( "add_recast", AddRecast );
    GameEvents.Subscribe( "add_charges", AddCharges );
    GameEvents.Subscribe( "add_status", AddStatus );
    GameEvents.Subscribe( "add_stacks", AddStacks );
    GameEvents.Subscribe( "add_cooldown", AddCooldown );
    
    Update();
})();



