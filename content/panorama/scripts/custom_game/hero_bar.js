var mainPanel = $("#HeroBarsContainer");
var heroBars = {};
var heroPanels = {};

$("#HeroBarsContainer").RemoveAndDeleteChildren();

function UpdateHeroBars()
{
    $.Schedule(1 / 120, UpdateHeroBars);

    var all_heroes = Entities.GetAllHeroEntities();

    for (var entityId of all_heroes) {

        if (Entities.IsOutOfGame(entityId) || !Entities.IsAlive(entityId)) {
            continue;
        }

        var origin = Entities.GetAbsOrigin(entityId);
        var offset = 290;

        var screenX = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offset);
        var screenY = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offset);

        if (screenX == -1 || screenY == -1) {
            continue
        }

        var isOnScreen = GameUI.GetScreenWorldPosition(screenX, screenY) != null;

        if (isOnScreen) {   
            ValidateAndUpdateOnScreenEntity(entityId, screenX, screenY)
        } 
        $.Msg( isOnScreen, " ", entityId," ", screenX," ", screenY);
    }
}

function CreateBar(){
    var panel = $.CreatePanel("Panel", mainPanel, "");
    panel.BLoadLayoutSnippet("HealthBar") ;
    return panel;
}

function UpdateBar(entityId, screenX, screenY){
    var panel = heroBars[entityId];

    panel.style.x = (Math.floor(screenX) - 55 ) + "px";
    panel.style.y = (Math.floor(screenY) ) + "px";
}

function ValidateAndUpdateOnScreenEntity(entityId, screenX, screenY) {
    if (!_.has(heroBars, entityId)) {
        heroBars[entityId] = CreateBar(entityId);
    }         
    UpdateBar(entityId, screenX, screenY);
    return true;
}

//UpdateHeroBars();

