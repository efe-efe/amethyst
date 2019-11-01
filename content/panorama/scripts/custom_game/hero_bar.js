var mainPanel = $("#HeroBarsContainer");
var hero_overhead_bars = {}

var FRIENDLY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(51, 162, 40, 1.0) ), to( rgba(162, 249, 154, 1.0) ) );";
var ENEMY_COLOR = "gradient( linear, 0% 0%, 100% 0%, from( rgba(238, 53, 0, 1.0) ), to( rgba(216, 134, 89, 1.0) ) );";
var INTERVAL = 0.01;

function MainCycle( heroIndex ){
    UpdateBar( heroIndex );
    $.Schedule(INTERVAL, function(){ MainCycle(heroIndex) });
}

function AddPlayer( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    hero_overhead_bars[data.heroIndex] = $.CreatePanel("Panel", mainPanel, "");
    hero_overhead_bars[data.heroIndex].BLoadLayoutSnippet("HeroBar");
    
    var color = null;

    if(localPlayerTeam == data.teamID){
        color = FRIENDLY_COLOR;
    } else {
        color = ENEMY_COLOR;

        var mana_bar = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarMana")[0];
        mana_bar.style.opacity = "0.0";
    }

    var health_bar_inner = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarHealthInner")[0];
    health_bar_inner.style.backgroundColor = color;

    var hero_bar_stacks = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarStacks")[0];
    hero_bar_stacks.GetChild(hero_bar_stacks.GetChildCount() - 1).style.margin = "0px";

    var hero_bar_charges = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarCharges")[0];
    hero_bar_charges.style.opacity = "0.0";

    MainCycle(data.heroIndex);
    UpdateStacks({ heroIndex: data.heroIndex, stacks: 0 })
}

function UpdateHealthBar( data ){
    var heroIndex = data.heroIndex;
    var percentage = data.percentage;
    var treshold = data.treshold;

    var health_bar = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarHealth")[0];
    var health_bar_inner = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarHealthInner")[0];
    var health_bar_inner_back = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarHealthInnerBack")[0];

    health_bar.style.width = treshold.toString() + "%";
    health_bar_inner.style.width = percentage.toString() + "%";
    health_bar_inner_back.style.width = percentage.toString() + "%";
}

function UpdateManaBar( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }

    var heroIndex = data.heroIndex;
    var percentage = data.percentage;

    var mana_bar_inner = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarManaInner")[0];
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
    var hero_bar_stacks = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarStacks")[0];

    for(i = 0; i < 3; i++){
        hero_bar_stacks.GetChild(i).style.opacity = "0.0";
    }

    for(i = 0; i < stacks; i++){
        hero_bar_stacks.GetChild(i).style.opacity = "1.0";
    }
}

function UpdateBar( heroIndex )
{
    if(!Entities.IsAlive( heroIndex ) || !IsVisibleByLocal(heroIndex)){
        hero_overhead_bars[heroIndex].style.opacity = "0.0";
        return;
    } else {
        hero_overhead_bars[heroIndex].style.opacity = "1.0";
    }

    var origin = Entities.GetAbsOrigin(heroIndex);
    var hpOffset = Entities.GetHealthBarOffset(heroIndex);

    var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + hpOffset);
    var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + hpOffset);

    var check = Game.ScreenXYToWorld(wx, wy);

    if(check[1] != 0) {
        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();
        var scale = 1080 / sh;

        var x = scale * Math.min(sw - hero_overhead_bars[heroIndex].actuallayoutwidth,Math.max(0, wx - hero_overhead_bars[heroIndex].actuallayoutwidth/2));
        var y = scale * Math.min(sh - hero_overhead_bars[heroIndex].actuallayoutheight,Math.max(0, wy - hero_overhead_bars[heroIndex].actuallayoutheight));


        hero_overhead_bars[heroIndex].style.position = x + "px " + y + "px 0px;";
        if(
            hero_overhead_bars[heroIndex].actuallayoutwidth ==  0 &&
            hero_overhead_bars[heroIndex].actuallayoutheight ==  0
        ){
            hero_overhead_bars[heroIndex].style.position = "-1000px -1000px 0px;";
            return true;
        }
    } else {
        hero_overhead_bars[heroIndex].style.position = "-1000px -1000px 0px;";
        return false;
    }
    return true
}

function InitializeCastPoint(data){
    var heroIndex = data.heroIndex;
    var duration = data.duration;

    var cast_point_bar = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCastPoint")[0];
    cast_point_bar.style.opacity = "1.0";

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCastPointInner")[0];
    cast_point_bar_inner.style.backgroundColor = "#FAFAFA";

    UpdateCastPoint({ 
        heroIndex: heroIndex,
        duration: duration,
        remaining: duration,
    })
}

function InitializeCooldown(data){
    var heroIndex = data.heroIndex;
    var modifierName = data.modifierName;

    if(!hero_overhead_bars[heroIndex]){
        $.Schedule(1.0, function(){ 
            InitializeCooldown(data);
        })
        return;
    }

    var cooldown_bar = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCooldown")[0];
    cooldown_bar.style.opacity = "1.0";

    UpdateCooldown({ 
        heroIndex: heroIndex,
        modifierName: modifierName,
    })
}

function UpdateCooldown(data){
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
        var cooldown_bar_circle = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCooldownCircle")[0];
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

    var cooldown_bar_circle = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCooldownCircle")[0];
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

function UpdateCastPoint(data){
    var heroIndex = data.heroIndex;
    var duration = data.duration;
    var remaining = data.remaining;

    var cast_point_bar_inner = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCastPointInner")[0];

    var num = remaining;
    var denom = duration;

    var progressRatio = 1;

    if (num && denom) {progressRatio = num/denom};

    if (isNaN(progressRatio)) { progressRatio = 1; }

    progressRatio = 1 - progressRatio;

    cast_point_bar_inner.style.width = "" + (progressRatio * 100) + "%";

    if( num >= 0.0 ){
        $.Schedule(INTERVAL, function(){ 
            UpdateCastPoint({ 
                heroIndex: heroIndex,
                duration: duration,
                remaining: remaining - (INTERVAL + 0.0225)
            }) 
        });
    } else {
        cast_point_bar_inner.style.backgroundColor = "rgb(51, 162, 40)";
        
        var cast_point_bar = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarCastPoint")[0];
        cast_point_bar.style.opacity = "0.0";
    }
}

function StopCastPoint(data){
    var cast_point_bar = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarCastPoint")[0];
    var cast_point_bar_inner = hero_overhead_bars[data.heroIndex].FindChildrenWithClassTraverse("HeroBarCastPointInner")[0];

    cast_point_bar_inner.style.backgroundColor = "rgb(238, 53, 0)";
    cast_point_bar.style.opacity = "0.0";
}

function InitializeCharges( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var charges = data.charges;

    if(!hero_overhead_bars[heroIndex]){
        $.Schedule(1.0, function(){ 
            InitializeCharges(data);
        })
        return;
    }
    var hero_bar_charges = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarCharges")[0];

    hero_bar_charges.style.opacity = "1.0";

    var hero_bar_charge_text = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarChargeText")[1];
    hero_bar_charge_text.text = charges;
}

function UpdateCharges( data ){
    var localPlayerId = Game.GetLocalPlayerID();
    var localPlayerTeam = Players.GetTeam( localPlayerId );

    if( localPlayerTeam != data.teamID ){ 
        return false;
    }
    
    var heroIndex = data.heroIndex;
    var charges = data.charges;
    
    var hero_bar_charge_text = hero_overhead_bars[heroIndex].FindChildrenWithClassTraverse("HeroBarChargeText")[1];
    hero_bar_charge_text.text = charges;
    hero_bar_charge_text.style.color = "#FAFAFA";

    if(charges == 0){
        hero_bar_charge_text.style.color = "rgba(238, 53, 0, 1.0)";
    }
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
    GameEvents.Subscribe( "update_hero_health_bar", UpdateHealthBar );
    GameEvents.Subscribe( "update_hero_mana_bar", UpdateManaBar );
    GameEvents.Subscribe( "update_hero_stacks", UpdateStacks );
    GameEvents.Subscribe( "update_hero_charges", UpdateCharges );
    GameEvents.Subscribe( "initialize_hero_charges", InitializeCharges );
    GameEvents.Subscribe( "initialize_cast_point", InitializeCastPoint );
    GameEvents.Subscribe( "initialize_hero_cooldown", InitializeCooldown );
    GameEvents.Subscribe( "stop_cast_point", StopCastPoint );


})();
