"use strict";

/*
    This implements "progress bars", which dangle beneath units, for example while they are interacting with an object
    A progress bar is invoked by a lua "progress_bar" call, which has the following parameters:
        - unitIndex : handle for a unit
        - modifierName: name for a modifier (the progress bar will be removed if the modifier vanishes)
        - progressBarType: "duration", "stacks", or "none"
            + "duration": the width of the progress bar will be currentDuration/maxDuration (read from the modifier properties)
            + "stacks": the width of the progress bar will be currentStacks/args.maxStacks (read from the parameters)
        - reversedProgress: bool. Progress will be 1-progress instead of progress. Good for counting up instead of down
        - style: string style applied to the parent (children can access through inheritance)
        - text: Label applied to the progress bar: this text is not localised by default
        - textSuffix: Suffix that will be added to the end of a progress bar: this text will be localised (so can be used for units of measure)

    A call for remove_progress_bar is also made available, that takes args for unitIndex and modifierName

    Progress bars are embedded into the core DoTA hud. This is to make them appear "under" other hud objects, such as the minimap

*/


var INTERVAL = 0.03;
var FAST_INTERVAL = 0.03;
var SLOW_INTERVAL = 0.03;

var activeBars = [] // list of active bars

var hud = null
var barContainerPanel = null

// ---------------------------------------------------------------------- //
// -------------- Table Synchronisation and Periodic Updates ------------ //
// ---------------------------------------------------------------------- //

// A key is a pair of unitID-_-modifierName,
// So if we want to delete a progress bar,
// We will have to extract this data from the key
// From nettable
function DeleteProgressBarFromKey(key)
{
    var pair = key.split("-_-"); // Magic string!
    var payload = {"unitIndex": pair[0], "modifierName": pair[1]}
    DeleteProgressBar(payload)
}

function OnProgressBarTableChange(table_name, key, data){

    if (isEmpty(data)) {
        //$.Msg("Progress Bar Panoramanager OnProgressBarTableChange | Empty data!")
        DeleteProgressBarFromKey(key)
    } else {
        ScheduledCreateBar(data)
    }

}

// There seems to be a race condition between the lua and js, although
// I have ~no~ idea how that should happen
function ScheduledCreateBar(args) {
    $.Schedule(0.03, function(){CreateProgressBar(args)})
}

function CreateProgressBar(args) {
    var newBar = {}

    newBar["text"] = args.text || "";
    newBar["unitIndex"] = args.unitIndex;
    newBar["modifierName"] = args.modifierName;
    newBar["progressBarType"] = args.progressBarType;
    newBar["reversedProgress"] = args.reversedProgress;
    newBar["style"] = args.style;
    newBar["maxStacks"] = args.maxStacks || 0;
    newBar["textSuffix"] = args.textSuffix || false;
    newBar["priority"] = args.priority || 100;
    newBar["ignorePriority"] = args.ignorePriority || false;

    var newPanel = CreateProgressBarPanel(newBar)

    newBar["parentPanel"] = newPanel;


    // Check to see if there already exists a progress bar for this modifier and unit
    var oldBarFound = false;
    
    for (var i = 0; i < activeBars.length; i++)
    {
        if (activeBars[i]["unitIndex"] == newBar["unitIndex"] && activeBars[i]["modifierName"] == newBar["modifierName"])
        {
            // This bar was already registered, but perhaps the parameters have updated. Overwrite the old one
            activeBars[i]["parentPanel"].DeleteAsync(0);
            activeBars[i] = newBar
            oldBarFound = true;
            break;
        }

    }

    if (!oldBarFound)
    {
        // This is a new bar, add it to the end of the active list
        activeBars.push(newBar)

        // If the length of activeBars is now 1,
        // then this was the only progress bar: start scheduling updates
        if (activeBars.length == 1)
        {
            $.Schedule(INTERVAL, SchedulePositionUpdates);
        }
    }

    // Render it once (automatic rendering will take over from there)
    UpdateProgressBar(newBar)
}

// From game event
function DeleteProgressBar(args)
{
    var unitIndex = args.unitIndex;
    var modifierName = args.modifierName;

    var i = activeBars.length
    while (i--) {
        if (activeBars[i]["unitIndex"] == unitIndex && activeBars[i]["modifierName"] == modifierName)
        {
            //$.Msg("Found a duplicate panel, deleting the old one!");
            activeBars[i]["parentPanel"].DeleteAsync(0);
            activeBars.splice(i, 1);
        }
    }
}


function CreateProgressBarPanel(params) {

    // Create the panel inside our hud so that it inherits the correct styles
    var newPanel = $.CreatePanel("Panel", $("#Inner"), "" );
    newPanel.BLoadLayoutSnippet("ProgressBar");
    // Move the panel to core hud so that it will render at the correct z-index
    newPanel.SetParent(barContainerPanel);

    var progressTotalPanel = newPanel.FindChildrenWithClassTraverse("ProgressBar")[0];
    var progressLabel = newPanel.FindChildrenWithClassTraverse("ProgressBarLabel")[0];

    if (params["style"]) {
        newPanel.AddClass(params["style"]);
    }

    var labelText = params["text"];
    if (params["textSuffix"]) {
        labelText = labelText + $.Localize(params["textSuffix"]);
    }

    if (labelText != "") {
        progressLabel.text = labelText;
        progressLabel.visible = true;
    } else {
        progressLabel.visible = false;
    }

    return newPanel
}

// Save marginal effort by only running updates if we need to
function SchedulePositionUpdates() {
    if (activeBars.length > 0) {
        UpdateBarPositions();
        $.Schedule(INTERVAL, SchedulePositionUpdates);
    }
}

function UpdateBarPositions() {
    var i = activeBars.length;
    var unitFound = false;
    var modifierFound = false;

    while (i--) {
        if (UpdateProgressBar(activeBars[i])) // This returns true if an update was successfully made
        {
            unitFound = true;
        } else {
            // We aren't aware of the unit
        }
    }

    if (unitFound)
    {
        INTERVAL = FAST_INTERVAL;
    } else {
        // All of the bars are attached to units that we can't see.
        // We can afford to wait a longer interval before the next update
        INTERVAL = SLOW_INTERVAL;
    }

}

// ---------------------------------------------------------------------- //
// --------------------------- Core Update Loop ------------------------- //
// ---------------------------------------------------------------------- //

// Takes a handle to a progress bar object
// Updates the panel
function UpdateProgressBar(progressBar)
{
    // Set Visibility
    var modifierIndex = GetProgressBarModifierIndex(progressBar)
    if (!modifierIndex) {
        progressBar.parentPanel.visible = false;
        return false
    } else {
        progressBar["lastIndex"] = modifierIndex;
        progressBar.parentPanel.visible = true;
    }

    SetProgressBarFilledness(progressBar, modifierIndex);
    PositionProgressBar(progressBar);

    var ownActiveBars = [];
    activeBars.forEach( function(bar){
        if(bar.unitIndex == progressBar.unitIndex){
            ownActiveBars.push(bar);
        }
    })

    // Check wich bar to show based on priority. (Lower number = higher priority)
    ownActiveBars.sort(function(a, b) {
        return a.priority - b.priority;
    });

    ownActiveBars.forEach( function(bar, i){

        if(bar["ignorePriority"]){
            bar["parentPanel"].visible = true;
        }
        else if( i == 0 ){
            bar["parentPanel"].visible = true;
        } else {
            bar["parentPanel"].visible = false;
        }
    })

    return true
}

// Returns an integer corresponding to the buffIndex that matches the progress bar
// Returns false if the entity or modifier corresponding to the progress bar was not found
function GetProgressBarModifierIndex(progressBar)
{

    var parentPanel = progressBar["parentPanel"];
    var unitIndex = progressBar["unitIndex"];

    // If the unit is dead (or we don't have knowledge of it) then hide the panel and sleep
    if (!Entities.IsAlive(unitIndex)) { 
        parentPanel.visible = false;
        return false
    }

    // Fetch the modifier of the unit
    // We check the last index at which we successfully found the modifier
    // There's a good chance that the unit's modifiers haven't fundamentally changed,
    // so the same index still works
    var lastIndex = progressBar["lastIndex"];
    var modifierIndex;

    if (lastIndex &&
        Buffs.GetName(unitIndex, lastIndex) == progressBar["modifierName"])
    {
        //$.Msg("progress_bars.js UpdateProgressBarr | Taking efficient branch")
        modifierIndex = lastIndex
    } else {
        //$.Msg("progress_bars.js UpdateProgressBarr | Taking inefficient branch")
        modifierIndex = FindModifierIndexByName( unitIndex, progressBar["modifierName"] );
    }

    // The unit is alive but doesn't have the modifier.
    // Hide the progress bar and give up for this frame.
    if (!modifierIndex) { 
        parentPanel.visible = false;
        return false
    }

    progressBar["lastIndex"] = modifierIndex;
    return modifierIndex
}

// How filled should the "progress made" panel be?
function SetProgressBarFilledness(progressBar, modifierIndex)
{

    var parentPanel = progressBar["parentPanel"];
    var unitIndex = progressBar["unitIndex"];
    var progressMadePanel = parentPanel.FindChildrenWithClassTraverse("ProgressBarProgress")[0];

    if (progressBar["progressBarType"] == "stacks")
    {
        var num = (Buffs.GetStackCount(unitIndex, modifierIndex)||0);
        var denom = progressBar["maxStacks"];
        var progressRatio = 1;
        if (denom) { progressRatio = num/denom};
        if (isNaN(progressRatio)) { progressRatio = 1; }
        if (progressBar["reversedProgress"]){progressRatio = 1 - progressRatio;}
    }
    else if (progressBar["progressBarType"] == "duration")
    {
        var num = Buffs.GetRemainingTime( unitIndex, modifierIndex);
        var denom = Buffs.GetDuration( unitIndex, modifierIndex);
        var progressRatio = 1;
        if (num && denom) {progressRatio = num/denom};
        if (isNaN(progressRatio)) { progressRatio = 1; }
        if (progressBar["reversedProgress"]) {progressRatio = 1 - progressRatio;}

    }

    progressMadePanel.style.width = ""+(progressRatio*100)+"%";
}


function PositionProgressBar(progressBar)
{
    var parentPanel = progressBar["parentPanel"];
    var unitIndex = progressBar["unitIndex"];

    var origin = Entities.GetAbsOrigin(unitIndex);
    
    // How high the healthbar is above the unit
    // TODO: Should this be optional?
    var hpOffset = Entities.GetHealthBarOffset(unitIndex);

    var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2]+hpOffset);
    var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2]+hpOffset);

    var check = Game.ScreenXYToWorld(wx, wy);


    if(check[1] != 0) {
        var sw = Game.GetScreenWidth();
        var sh = Game.GetScreenHeight();
        var scale = 1080 / sh;

        var x = scale * Math.min(sw - parentPanel.actuallayoutwidth,Math.max(0, wx - parentPanel.actuallayoutwidth/2));
        var y = scale * Math.min(sh - parentPanel.actuallayoutheight,Math.max(0, wy - parentPanel.actuallayoutheight));

        //$.Msg("Setting Position to: " + x + " px  " + y + " px");

        parentPanel.style.position = x + "px " + y + "px 0px;";
        parentPanel.visible = true;
    } else {
        parentPanel.style.position = "-1000px -1000px 0px;";
        parentPanel.visible = false;
    }

    // We succeeded in positioning the panel
    // Return true so that we know we have to update again very soon
    return true

}

// ---------------------------------------------------------------------- //
// --------------------------------- Utils ------------------------------ //
// ---------------------------------------------------------------------- //

// I don't know why this isn't a builtin
// returns false if the unit does not exist or has no buff of name name
// else returns the buffIndex, a handle to the index
function FindModifierIndexByName(unitIndex, name)
{
    //$.Msg("progress_bars FindModifierIndexByName || Searching for: "+name)
    // Check the unit exists
    if (!Entities.IsAlive(unitIndex)) {
        //$.Msg("Progress bars Panoramanager FindModifierIndexByName | In the unexpected branch")
        return false
    }

    for (var i = 0; i < Entities.GetNumBuffs(unitIndex); i++)
    {
        var buffName = Buffs.GetName(unitIndex, Entities.GetBuff(unitIndex, i))

        if (buffName == name)
        {
            //$.Msg("I'm returning true!");
            return Entities.GetBuff(unitIndex, i)
        }
    }

    return false

}

// Util, check if an object is empty
function isEmpty(obj){
    for (var key in obj)
    {
        if(obj.hasOwnProperty(key))
        {
            return false
        }
    }
    return true
}

// Assign variables for the necessary dota HUD elements
function HookIntoDotaHud() {

    $.Msg("Progress Bars Panoramanager | Hooking into HUD!")

    hud = $.GetContextPanel().GetParent();
    for(var i = 0; i < 100; i++) {
        // $.Msg("DEBUG: id = " + hud.id);
        if(hud.id != "Hud") {
            hud = hud.GetParent();
        } else {
            break;
        }
    }

    barContainerPanel = $.CreatePanel( "Panel", hud, "" );
    barContainerPanel.style.width = "100%";
    barContainerPanel.style.height = "100%";
    barContainerPanel.hittest = false;
    barContainerPanel.style.zIndex = "-1";

}

// ---------------------------------------------------------------------- //
// -------------------------------- IIFE -------------------------------- //
// ---------------------------------------------------------------------- //

( function () {

    // These game events should be obsoleted (progress bars should use the net tables)
    // But we'll leave them in just in case
    GameEvents.Subscribe( "progress_bar", ScheduledCreateBar);
    GameEvents.Subscribe( "remove_progress_bar", DeleteProgressBar);

    CustomNetTables.SubscribeNetTableListener("progress_bars", OnProgressBarTableChange);

    HookIntoDotaHud();
})();
