--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["4"] = 1,["5"] = 2,["6"] = 3,["7"] = 4,["8"] = 5,["9"] = 11,["10"] = 12,["11"] = 11,["12"] = 14,["13"] = 15,["14"] = 14,["15"] = 17,["16"] = 18,["17"] = 17,["18"] = 20,["19"] = 21,["20"] = 20});
NO_DIRECTION = -1
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
