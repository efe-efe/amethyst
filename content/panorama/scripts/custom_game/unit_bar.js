var mainPanel = $("#UnitBarsContainer");
var unit_overhead_bars = {}

var INTERVAL = 0.01;

function MainCycle( unitIndex ){
    if(!unit_overhead_bars[unitIndex]){ return }
    UpdateBarCycle( unitIndex );
    $.Schedule(INTERVAL, function(){ MainCycle(unitIndex) });
}

function UpdateBarCycle( unitIndex )
{
    if(!UpdateBarVisibilityCycle( unitIndex )){ return; }
    UpdateBarPositionCycle( unitIndex );
}

function UpdateBarVisibilityCycle( unitIndex ){
    if(!Entities.IsAlive( unitIndex )){
        unit_overhead_bars[unitIndex].panel.style.opacity = "0.0";
        return false;
    } else {
        unit_overhead_bars[unitIndex].panel.style.opacity = "1.0";
        return true;
    }
}

function UpdateBarPositionCycle( unitIndex ){
    var origin = Entities.GetAbsOrigin(unitIndex);
    var hpOffset = Entities.GetHealthBarOffset(unitIndex);

    var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + hpOffset);
    var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + hpOffset);

    var check = Game.ScreenXYToWorld(wx, wy);

    if(check[1] != 0) {
        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();
        var scale = 1080 / sh;

        var x = scale * Math.min(sw - unit_overhead_bars[unitIndex].panel.actuallayoutwidth,Math.max(0, wx - unit_overhead_bars[unitIndex].panel.actuallayoutwidth/2));
        var y = scale * Math.min(sh - unit_overhead_bars[unitIndex].panel.actuallayoutheight,Math.max(0, wy - unit_overhead_bars[unitIndex].panel.actuallayoutheight));

        unit_overhead_bars[unitIndex].panel.style.position = x + "px " + y + "px 0px;";
        if(
            unit_overhead_bars[unitIndex].panel.actuallayoutwidth ==  0 &&
            unit_overhead_bars[unitIndex].panel.actuallayoutheight ==  0
        ){
            unit_overhead_bars[unitIndex].panel.style.position = "-1000px -1000px 0px;";
            return true;
        }
    } else {
        unit_overhead_bars[unitIndex].panel.style.position = "-1000px -1000px 0px;";
        return false;
    }
    return true
}

function AddUnit( data ){
    var unitIndex = data.unitIndex;
    
    unit_overhead_bars[unitIndex] = {}
    var unitBar = unit_overhead_bars[unitIndex]

    unitBar.panel = $.CreatePanel("Panel", mainPanel, "");
    unitBar.panel.BLoadLayoutSnippet("UnitBar");

    MainCycle(unitIndex);
}

function UpdateHealthBar( data ){
    var unitIndex = data.unitIndex;
    var current_health = data.current_health;
    var max_health = data.max_health;
    var show_max_health = data.show_max_health; 

    if(current_health <= 0){
        unit_overhead_bars[unitIndex].panel.DeleteAsync(0);
        delete unit_overhead_bars[unitIndex];
    } else {
        var health_bar_text = unit_overhead_bars[unitIndex].panel.FindChildrenWithClassTraverse("UnitBarHealthText")[0];

        if(show_max_health){
            health_bar_text.text = current_health + "/" + max_health;
        } else {
            health_bar_text.text = current_health;
        }
    }
}

(function(){
    GameEvents.Subscribe( "add_unit", AddUnit );
    GameEvents.Subscribe( "update_unit_health_bar", UpdateHealthBar );
})();



