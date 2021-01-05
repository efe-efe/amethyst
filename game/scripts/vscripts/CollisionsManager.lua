local NO_DIRECTION =  -1
local DIAGONAL_LEFT = 0
local DIAGONAL_RIGHT = 1
local HORIZONTAL = 2
local VERTICAL = 3

function OnStartTouchCollisionVertical(tEvent)
    if tEvent.activator.SetCollisionDirection then
        tEvent.activator:SetCollisionDirection(VERTICAL)
    end
end
function OnStartTouchCollisionHorizontal(tEvent)
    if tEvent.activator.SetCollisionDirection then
        tEvent.activator:SetCollisionDirection(HORIZONTAL)
    end
end
function OnStartTouchCollisionDiagonalLeft(tEvent)
    if tEvent.activator.SetCollisionDirection then
        tEvent.activator:SetCollisionDirection(DIAGONAL_LEFT)
    end
end
function OnStartTouchCollisionDiagonalRight(tEvent)
    if tEvent.activator.SetCollisionDirection then
        tEvent.activator:SetCollisionDirection(DIAGONAL_RIGHT)
    end
end