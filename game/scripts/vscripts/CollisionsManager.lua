local NO_DIRECTION =  -1
local DIAGONAL_LEFT = 0
local DIAGONAL_RIGHT = 1
local HORIZONTAL = 2
local VERTICAL = 3

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