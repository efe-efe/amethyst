var mainPanel = $("#HeroBarsContainer");
var heroBars = {};
var heroPanels = {};

$("#HeroBarsContainer").RemoveAndDeleteChildren();

function UpdateHeroBars()
{
    $.Schedule(1 / 120, UpdateHeroBars);

    var all_heroes = Entities.GetAllHeroEntities();

    var trulyOnScreen = [];
    var trulyNotOnScreen = [];
    for (var entityId of all_heroes) {

        if (Entities.IsOutOfGame(entityId) || !Entities.IsAlive(entityId)) {
            continue;
        }

        var abs = Entities.GetAbsOrigin(entityId);
        var offset = 0;

        var screenX = Game.WorldToScreenX(abs[0], abs[1], abs[2] + offset);
        var screenY = Game.WorldToScreenY(abs[0], abs[1], abs[2] + offset);

        if (screenX == -1 || screenY == -1) {
            continue
        }

        var isOnScreen = GameUI.GetScreenWorldPosition(screenX, screenY) != null;

        if (isOnScreen) {   
            if (ValidateAndUpdateOnScreenEntity(entityId, screenX, screenY)) {
                trulyOnScreen.push(entityId);
            } 
        } else {
            if (ValidateAndUpdateOffScreenEntity(entityId, screenX, screenY)) {
                trulyNotOnScreen.push(entityId);
            }
        } 
        $.Msg( isOnScreen, " ", entityId," ", screenX," ", screenY);
    }

    // Everything around there is crap code, but this is extra crap, unreadable!
    {
        var oldEntities = _.omit(heroBars, function(value, key) {
            return _.some(trulyOnScreen, function(entityId) { return entityId == key });
        });

        _.each(oldEntities, function(panel, key) {
            panel.DeleteAsync(0);
            delete heroBars[key];
        });
    }

    {
        var oldEntities = _.omit(heroPanels, function(value, key) {
            return _.some(trulyNotOnScreen, function(entityId) { return entityId == key });
        });

        _.each(oldEntities, function(panel, key) {
            panel.DeleteAsync(0);
            delete heroPanels[key];
        });
    }
}

function CreateBar(){
    var panel = $.CreatePanel("Panel", mainPanel, "");
    panel.BLoadLayoutSnippet("HealthBar") ;
    return panel;
}

function UpdateBar(entityId, screenX, screenY){
    var panel = heroBars[entityId];
    panel.style.x = (Math.floor(screenX) - 55) + "px";
    panel.style.y = (Math.floor(screenY)) + "px";
}

function UpdateHeroDetectorPanel(entityId, screenX, screenY) {
    var panel = heroPanels[entityId];
    var screenWidth = Game.GetScreenWidth();
    var screenHeight = Game.GetScreenHeight();
    var realW = Clamp(screenX, 0, screenWidth - panel.actuallayoutwidth) / screenWidth;
    var realH = Clamp(screenY, 0, screenHeight - panel.actuallayoutwidth) / screenHeight;

    if (isNaN(realW) || isNaN(realH)) {
        return;
    }

    panel.style.position = parseInt(realW * 100) + "% " + parseInt(realH * 100) + "% 0px";

    if (!panel.BHasClass("HeroMarkerTransition")) {
        panel.AddClass("HeroMarkerTransition");
    }
}


function ValidateAndUpdateOnScreenEntity(entityId, screenX, screenY) {
    if (!_.has(heroBars, entityId)) {
        heroBars[entityId] = CreateBar(entityId);
        $.Msg("Don't has bars");
    }         
    UpdateBar(entityId, screenX, screenY);
    return true;
}

function ValidateAndUpdateOffScreenEntity(entityId, screenX, screenY, isRealHero) {
    var isRealHero = !Entities.IsUnselectable(entityId);

    if (!isRealHero) {
        return false;
    }

    if (_.has(heroPanels, entityId)) {
        UpdateHeroDetectorPanel(entityId, screenX, screenY);
    } else {
        heroPanels[entityId] = CreateHeroDetectorPanel(entityId, specialLevel);

        UpdateHeroDetectorPanel(entityId, screenX, screenY);
    }

    return true;
}


UpdateHeroBars();

