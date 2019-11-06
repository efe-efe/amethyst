var mainPanel = $("#HeroBarsContainer");
var hero_overhead_bars = {}

var FRIENDLY_COLOR_DARK = "rgba(51, 162, 40, 1.0)"
var FRIENDLY_COLOR_LIGHT = "rgba(162, 249, 154, 1.0)"


var ENEMY_COLOR_DARK = "rgba(238, 53, 0, 1.0)"
var ENEMY_COLOR_LIGHT = "rgba(216, 134, 89, 1.0)"

var INTERVAL = 0.01;
/*
hero_overhead_bars = {
    heroIndex: {
        panel: BLoadLayoutSnippet("HeroBar"),
        status: {
           modifierIndex: {},
           modifierIndex: {},
           modifierIndex: {},
        }
    },
}
*/

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
    if(!Entities.IsAlive( heroIndex ) || !IsVisibleByLocal(heroIndex)){
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

    var hero_bar_status = heroBar.panel.FindChildrenWithClassTraverse("HeroBarStatus")[0];
    var hero_bar_player = heroBar.panel.FindChildrenWithClassTraverse("HeroBarPlayer")[0];

    if( status && modifierName ){
        var modifierIndex = FindModifierByName(heroIndex, modifierName)
        
        if(modifierIndex){
            var progressRatio = GetProgressRatio( heroIndex, modifierIndex, status.reversed, status.type, status.maxStacks );
            var progress_bar_inner = heroBar.panel.FindChildrenWithClassTraverse("HeroBarStatusProgressInner")[0];
            progress_bar_inner.style.width = "" + (progressRatio * 100) + "%";
        
            var progress_bar_text = heroBar.panel.FindChildrenWithClassTraverse("HeroBarStatusText")[0];
            progress_bar_text.text = status.label;

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

    var hero_bar_recast = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarRecast")[0];
    if( recast && abilityName ){
        var modifierIndex = FindModifierByName(heroIndex, recast.modifierName)

        if(modifierIndex){
            var hero_bar_recast_key = heroBar.panel.FindChildrenWithClassTraverse("HeroBarRecastKeyText")[0];
            var hero_bar_recast_image =  heroBar.panel.FindChildrenWithClassTraverse("HeroBarRecastSpellImage")[0];
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

    var heroIndex = data.heroIndex;
    var teamID = data.teamID;
    var playerID = data.playerID;

    hero_overhead_bars[heroIndex] = {}
    var heroBar = hero_overhead_bars[heroIndex]

    heroBar.panel = $.CreatePanel("Panel", mainPanel, "");
    heroBar.panel.BLoadLayoutSnippet("HeroBar");
    heroBar.status = {};
    heroBar.recast = {};

    var color_gradient = null;
    var color = null;

    if(localPlayerTeam == teamID){
        color_gradient = "gradient( linear, 0% 0%, 100% 0%, from(" +  FRIENDLY_COLOR_DARK + "), to(" +  FRIENDLY_COLOR_LIGHT + ") )";
        color = FRIENDLY_COLOR_LIGHT;
    } else {
        color_gradient = "gradient( linear, 0% 0%, 100% 0%, from(" +  ENEMY_COLOR_DARK + "), to(" +  ENEMY_COLOR_LIGHT + ") )";
        color = ENEMY_COLOR_LIGHT;
        var mana_bar = heroBar.panel.FindChildrenWithClassTraverse("HeroBarMana")[0];
        mana_bar.style.opacity = "0.0";
    }

    var health_bar_inner = heroBar.panel.FindChildrenWithClassTraverse("HeroBarHealthInner")[0];
    var health_bar_inner_2 = heroBar.panel.FindChildrenWithClassTraverse("HeroBarHealthInner")[1];
    health_bar_inner.style.backgroundColor = color_gradient;
    health_bar_inner_2.style.backgroundColor = color_gradient;
    
    var hero_bar_stacks = heroBar.panel.FindChildrenWithClassTraverse("HeroBarStacks")[0];
    hero_bar_stacks.GetChild(hero_bar_stacks.GetChildCount() - 1).style.margin = "0px";

    var hero_bar_charges = heroBar.panel.FindChildrenWithClassTraverse("HeroBarCharges")[0];
    hero_bar_charges.style.opacity = "0.0";

    var hero_bar_player = heroBar.panel.FindChildrenWithClassTraverse("HeroBarPlayerText")[0];
    hero_bar_player.text = Players.GetPlayerName( playerID );
    hero_bar_player.style.color = color;

    UpdateStacks({ heroIndex: heroIndex, stacks: 0 })
    MainCycle(heroIndex);
}

function AddStatus( data ){
    var heroIndex = data.heroIndex;
    var label = data.label || "";
    var name = data.modifierName;
    var barColor = data.barColor || "#FAFAFA";
    var labelColor = data.labelColor || "#FAFAFA";
    var backgroundColor = data.backgroundColor;
    var priority = data.priority || 0;
    var reversed = data.reversed || null;
    var type = data.type || "duration";
    var maxStacks = data.maxStacks || null;
    var local_only = data.local_only || null;

    if(local_only){
        if( heroIndex == Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )){
            hero_overhead_bars[heroIndex].status[name] = {
                label: label,
                barColor: barColor,
                labelColor: labelColor,
                backgroundColor: backgroundColor,
                priority: priority,
                reversed: reversed,
                type: type,
                maxStacks: maxStacks
            }
        }
    } else {
        hero_overhead_bars[heroIndex].status[name] = {
            label: label,
            barColor: barColor,
            labelColor: labelColor,
            backgroundColor: backgroundColor,
            priority: priority,
            reversed: reversed,
            type: type,
            maxStacks: maxStacks
        }
    }
}

function AddRecast( data ){
    var heroIndex = data.heroIndex;
    var abilityName = data.abilityName;
    var key = data.key || "NO KEY";
    var modifierName = data.modifierName;

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
        health_bar_hidden = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("NoShield")[0];
        health_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("WithShield")[0];
    } else {
        health_bar_hidden = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("WithShield")[0];
        health_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("NoShield")[0];
    }

    health_bar_hidden.style.visibility = "collapse";
    health_bar.style.visibility = "visible";

    var shield_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarShield")[0];
    var health_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarHealthInner")[0];
    var health_bar_inner_2 = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarHealthInner")[1];
    var health_bar_inner_back = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarHealthInnerBack")[0];

    health_bar.style.width = shown_bar_width.toString() + "%";
    
    health_bar_inner.style.width = health_width.toString() + "%";
    health_bar_inner_2.style.width = health_width.toString() + "%";

    health_bar_inner_back.style.width = health_width.toString() + "%";
    shield_bar.style.width = shield_width.toString() + "%";
}

function UpdateManaBar( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }

    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var mana_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarManaInner")[0];
    mana_bar_inner.style.width = percentage.toString() + "%";
}

function UpdateStacks( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var stacks = data.stacks;
    var hero_bar_stacks = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarStacks")[0];

    for(i = 0; i < 3; i++){
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
        var cooldown_bar_circle = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCooldownCircle")[0];
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

    var cooldown_bar_circle = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCooldownCircle")[0];
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

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCastPointInner")[0];
    
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
        var cast_point_bar = hero_overhead_bars[data.heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCastPoint")[0];
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
    
    var hero_bar_charge_text = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarChargeText")[1];
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
    var hero_bar_charges = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCharges")[0];

    hero_bar_charges.style.opacity = "1.0";

    var hero_bar_charge_text = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarChargeText")[1];
    hero_bar_charge_text.text = charges;
}

function InitializeCastPoint( data ){
    var heroIndex = data.heroIndex;

    //Restart status (from previous cast-points)
    var cast_point_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCastPoint")[0];
    cast_point_bar.style.opacity = "1.0";

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCastPointInner")[0];
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

    var cooldown_bar = hero_overhead_bars[heroIndex].panel.FindChildrenWithClassTraverse("HeroBarCooldown")[0];
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

(function(){
    GameEvents.Subscribe( "add_player", AddPlayer );
    GameEvents.Subscribe( "add_status", AddStatus );
    GameEvents.Subscribe( "add_recast", AddRecast );
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_hero_mana_bar", UpdateManaBar );
    GameEvents.Subscribe( "update_hero_stacks", UpdateStacks );
    GameEvents.Subscribe( "update_hero_charges", UpdateCharges );
    GameEvents.Subscribe( "initialize_hero_charges", InitializeCharges );
    GameEvents.Subscribe( "initialize_cast_point", InitializeCastPoint );
    GameEvents.Subscribe( "initialize_hero_cooldown", InitializeCooldown );
})();
