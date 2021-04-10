const NO_DIRECTION =  -1;
const DIAGONAL_LEFT = 0;
const DIAGONAL_RIGHT = 1;
const HORIZONTAL = 2;
const VERTICAL = 3;

type HammerEvent = {
    activator: EntityIndex;
}

function OnStartTouchCollisionVertical(this: void, tEvent: HammerEvent): void{
    CustomEntities.SetCollisionDirection(tEvent.activator, VERTICAL);
}
function OnStartTouchCollisionHorizontal(this: void, tEvent: HammerEvent): void{
    CustomEntities.SetCollisionDirection(tEvent.activator, HORIZONTAL);
}
function OnStartTouchCollisionDiagonalLeft(this: void, tEvent: HammerEvent): void{
    CustomEntities.SetCollisionDirection(tEvent.activator, DIAGONAL_LEFT);
}
function OnStartTouchCollisionDiagonalRight(this: void, tEvent: HammerEvent): void{
    CustomEntities.SetCollisionDirection(tEvent.activator, DIAGONAL_RIGHT);
}