--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["4"] = 3,["5"] = 4,["6"] = 5,["7"] = 6,["8"] = 12,["9"] = 13,["10"] = 12,["11"] = 15,["12"] = 16,["13"] = 15,["14"] = 18,["15"] = 19,["16"] = 18,["17"] = 21,["18"] = 22,["19"] = 21});
DIAGONAL_LEFT = 0
DIAGONAL_RIGHT = 1
HORIZONTAL = 2
VERTICAL = 3
function OnStartTouchCollisionVertical(tEvent)
    CustomEntities:SetCollisionDirection(tEvent.activator, VERTICAL)
end
function OnStartTouchCollisionHorizontal(tEvent)
    CustomEntities:SetCollisionDirection(tEvent.activator, HORIZONTAL)
end
function OnStartTouchCollisionDiagonalLeft(tEvent)
    CustomEntities:SetCollisionDirection(tEvent.activator, DIAGONAL_LEFT)
end
function OnStartTouchCollisionDiagonalRight(tEvent)
    CustomEntities:SetCollisionDirection(tEvent.activator, DIAGONAL_RIGHT)
end
