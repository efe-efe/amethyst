// Hides a bunch of ugly dota hud elements that we don't want
function ModifyHotkeyBox( parent ) {
    // get topmost panel

    if(!ModifyText(parent, "Ability1", "L-Mouse")){ return false; }
    if(!ModifyText(parent, "Ability3", "R-Mouse")){ return false; }
    if(!ModifyText(parent, "Ability4", "R")){ return false; }
    if(!ModifyText(parent, "Ability5", "F")){ return false; }
    if(!ModifyText(parent, "Ability6", "Space")){ return false; }
    if(!ModifyText(parent, "Ability7", "Z")){ return false; }
    return true;
}

function ModifyText(parent, abilityName, text){
    var abilityPanel = parent.FindChildTraverse(abilityName);
    var hotkey = abilityPanel.FindChildTraverse("HotkeyText");

    if(hotkey){
        hotkey.text = text;
        hotkey.GetParent().visible = true;

        return true;
    } 

    return false;
}

function Iterate()
{
    var parent = $.GetContextPanel();
    while( parent.GetParent()!=null ) {
        parent = parent.GetParent();
    }

    (function tic()
    {
        if(!ModifyHotkeyBox(parent)){
            $.Schedule( 2.0, tic );
        }
    })();
}


(function() {
    Iterate();
})();

