local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["4"] = 3,["5"] = 4,["6"] = 5,["7"] = 6,["8"] = 12,["9"] = 13,["10"] = 12,["11"] = 15,["12"] = 19,["13"] = 15,["14"] = 21,["15"] = 25,["16"] = 21,["17"] = 27,["18"] = 31,["19"] = 27});
DIAGONAL_LEFT = 0
DIAGONAL_RIGHT = 1
HORIZONTAL = 2
VERTICAL = 3
function OnStartTouchCollisionVertical(tEvent)
    CustomEntitiesLegacy:SetCollisionDirection(tEvent.activator, VERTICAL)
end
function OnStartTouchCollisionHorizontal(tEvent)
    CustomEntitiesLegacy:SetCollisionDirection(tEvent.activator, HORIZONTAL)
end
function OnStartTouchCollisionDiagonalLeft(tEvent)
    CustomEntitiesLegacy:SetCollisionDirection(tEvent.activator, DIAGONAL_LEFT)
end
function OnStartTouchCollisionDiagonalRight(tEvent)
    CustomEntitiesLegacy:SetCollisionDirection(tEvent.activator, DIAGONAL_RIGHT)
end
