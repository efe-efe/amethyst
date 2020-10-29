
function WrapFunction(name) {
    return function() {
        Game[name]();
    };
}

Game.EmptyCallback = function() {};

(function() {
    Game.AddCommand("+ZKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("+CKey", WrapFunction("OnPressC"), "", 0);
    Game.AddCommand("+SpaceKey", WrapFunction("OnPressSpace"), "", 0);
    Game.AddCommand("+1Key", WrapFunction("OnPress1"), "", 0);
    Game.AddCommand("+2Key", WrapFunction("OnPress2"), "", 0);
    Game.AddCommand("+3Key", WrapFunction("OnPress3"), "", 0);
    Game.AddCommand("+4Key", WrapFunction("OnPress4"), "", 0);
    Game.AddCommand("+5Key", WrapFunction("OnPress5"), "", 0);
    Game.AddCommand("+6Key", WrapFunction("OnPress6"), "", 0);
    Game.AddCommand("+QKey", WrapFunction("OnPressQ"), "", 0);
    Game.AddCommand("+EKey", WrapFunction("OnPressE"), "", 0);
    Game.AddCommand("+FKey", WrapFunction("OnPressF"), "", 0);
    Game.AddCommand("+RKey", WrapFunction("OnPressR"), "", 0);

    Game.AddCommand("-ZKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-CKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-SpaceKey", WrapFunction("OnReleaseSpace"), "", 0);
    Game.AddCommand("-1Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-2Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-3Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-4Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-5Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-6Key", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-QKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-EKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-FKey", WrapFunction("EmptyCallback"), "", 0);
    Game.AddCommand("-RKey", WrapFunction("EmptyCallback"), "", 0);

    Game.AddCommand("+WKey", WrapFunction("OnPressW"), "", 0);
    Game.AddCommand("+AKey", WrapFunction("OnPressA"), "", 0);
    Game.AddCommand("+SKey", WrapFunction("OnPressS"), "", 0);
    Game.AddCommand("+DKey", WrapFunction("OnPressD"), "", 0);

    Game.AddCommand("-WKey", WrapFunction("OnReleaseW"), "", 0);
    Game.AddCommand("-AKey", WrapFunction("OnReleaseA"), "", 0);
    Game.AddCommand("-SKey", WrapFunction("OnReleaseS"), "", 0);
    Game.AddCommand("-DKey", WrapFunction("OnReleaseD"), "", 0);
})();