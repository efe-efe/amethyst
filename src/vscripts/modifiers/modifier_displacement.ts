import { CustomAbility, CustomItem } from "../abilities/framework/custom_ability";
import { CustomModifier, CustomModifierMotionBoth } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { findUnitsInRadius } from "../util";

export type Collision = "wall" | "unit" | "tree";

export type OnCollisionEvent = { collision: "tree" | "wall" } | { collision: "unit"; units: CDOTA_BaseNPC[] };

export type DisplacementParams = {
    distance?: number; //@Refactor (delete this comment after everything is TSfied) Used to be "r"
    speed: number;
    peak?: number;
    offset?: number;
    radius?: number;
    x: number;
    y: number;
    teamFilter?: UnitTargetTeam;
    targetType?: UnitTargetType;
    flagFilter?: UnitTargetFlags;
};

@registerModifier()
class ModifierDisplacementHelper extends CustomModifier<undefined> {
    x!: number;
    y!: number;
    z!: number;

    IsHidden() {
        return true;
    }

    IsPermanent() {
        return true;
    }

    OnCreated(params: { x: number; y: number; z: number }) {
        if (IsServer()) {
            this.x = params.x;
            this.y = params.y;
            this.z = params.z;
            this.StartIntervalThink(0.03);
        }
    }

    OnIntervalThink() {
        FindClearSpaceForUnit(this.parent, Vector(this.x, this.y, this.z), true);
        this.Destroy();
    }
}

@registerModifier()
export class ModifierDisplacement<A extends CDOTABaseAbility | undefined = CustomAbility | CustomItem> extends CustomModifierMotionBoth<A> {
    distance!: number;
    speed!: number;
    peak!: number;
    direction!: Vector;
    origin!: Vector;
    duration!: number;
    gravity!: number;
    offset!: number;
    radius!: number;
    teamFilter!: UnitTargetTeam;
    targetType!: UnitTargetType;
    flagFilter!: UnitTargetFlags;
    horizontalSpeed!: number;
    verticalSpeed!: number;
    lastValidOrigin!: Vector;
    previousOrigin?: Vector;

    elapsedTime = 0;

    frame = 0;
    horizontalFrame = 0;
    verticalFrame = 0;

    IsHidden() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    OnCreated(params: DisplacementParams) {
        if (IsServer()) {
            this.distance = params.distance ?? 0;
            this.speed = params.speed == 0 ? 1 : params.speed;
            this.peak = params.peak ?? 0;
            this.direction = Vector(params.x, params.y, 0).Normalized();
            this.origin = this.parent.GetAbsOrigin();
            this.lastValidOrigin = this.origin;
            this.previousOrigin = undefined;
            this.duration = this.distance / this.speed;
            this.gravity = -this.peak / (this.duration * this.duration * 0.125);
            this.offset = params.offset ?? 80;
            this.radius = params.radius ?? 80;
            this.teamFilter = params.teamFilter ?? UnitTargetTeam.BOTH;
            this.targetType = params.targetType ?? UnitTargetType.HERO + UnitTargetType.BASIC;
            this.flagFilter = params.flagFilter ?? UnitTargetFlags.NONE;

            this.horizontalSpeed = this.speed;
            this.verticalSpeed = -0.5 * this.gravity * this.duration;

            if (this.ApplyVerticalMotionController() == false) {
                this.Destroy();
            }
            if (this.ApplyHorizontalMotionController() == false) {
                this.Destroy();
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.parent.InterruptMotionControllers(true);
            this.origin = this.lastValidOrigin;

            ModifierDisplacementHelper.apply(this.parent, this.parent, undefined, {
                x: this.origin.x,
                y: this.origin.y,
                z: this.origin.z
            });
        }
    }

    Synchronize(direction: "horizontal" | "vertical", dt: number) {
        if (this.horizontalFrame == this.verticalFrame) {
            this.frame++;
            this.elapsedTime = this.elapsedTime + dt;
        }

        if (direction == "horizontal") {
            this.horizontalFrame = this.frame;
        }

        if (direction == "vertical") {
            this.verticalFrame = this.frame;
        }

        if (this.elapsedTime > this.duration && this.horizontalFrame == this.verticalFrame) {
            this.Destroy();
        }

        const origin = Vector(this.direction.x, this.direction.y, 0).__mul(this.offset).__add(this.parent.GetAbsOrigin());
        const trees = GridNav.GetAllTreesAroundPoint(origin, this.radius / 2, true);
        const units = findUnitsInRadius(this.parent, origin, this.radius, this.teamFilter, this.targetType, this.flagFilter, FindOrder.ANY);
        const isValidOrigin = GridNav.FindPathLength(this.previousOrigin ?? origin, origin) != -1;

        if (isValidOrigin) {
            this.lastValidOrigin = origin;
        } else {
            this.OnCollide({
                collision: "wall"
            });
        }

        if (units.length > 0) {
            this.OnCollide({
                units: units,
                collision: "unit"
            });
        }

        if (trees.length > 0) {
            this.OnCollide({
                collision: "tree"
            });
        }

        this.previousOrigin = this.parent.GetAbsOrigin();
    }

    UpdateHorizontalMotion(me: CDOTA_BaseNPC, dt: number) {
        this.Synchronize("horizontal", dt);
        const target = this.direction.__mul(this.horizontalSpeed).__mul(this.elapsedTime);
        this.parent.SetAbsOrigin(this.origin.__add(target));
    }

    OnHorizontalMotionInterrupted() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    UpdateVerticalMotion(me: CDOTA_BaseNPC, dt: number) {
        this.Synchronize("vertical", dt);
        const target = this.verticalSpeed * this.elapsedTime + 0.5 * this.gravity * this.elapsedTime * this.elapsedTime;
        this.parent.SetAbsOrigin(Vector(this.parent.GetAbsOrigin().x, this.parent.GetAbsOrigin().y, this.origin.z + target));
    }

    OnVerticalMotionInterrupted() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    CheckState() {
        return { [ModifierState.COMMAND_RESTRICTED]: this.GetIsCommandRestricted() };
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    OnCollide(params: OnCollisionEvent) {}

    GetIsCommandRestricted() {
        return true;
    }
}
