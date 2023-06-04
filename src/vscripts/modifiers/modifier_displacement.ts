import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifierMotionBoth } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

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
export class ModifierDisplacement<A extends CDOTABaseAbility | undefined = CustomAbility> extends CustomModifierMotionBoth<A> {
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

    previousOrigin?: Vector;

    elapsedTime = 0;
    motionTick: number[] = [0, 0, 0];

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
            if (this.GetFindClearSpace()) {
                FindClearSpaceForUnit(this.parent, this.parent.GetAbsOrigin(), true);
            }
        }
    }

    SyncTime(tickIndex: number, dt: number) {
        // Check if already synced
        if (this.motionTick[1] == this.motionTick[2]) {
            this.motionTick[0] = this.motionTick[0] + 1;
            this.elapsedTime = this.elapsedTime + dt;
        }

        // Sync time
        this.motionTick[tickIndex] = this.motionTick[0];

        // End motion
        if (this.elapsedTime > this.duration && this.motionTick[1] == this.motionTick[2]) {
            this.Destroy();
        }

        const origin = Vector(this.direction.x, this.direction.y, 0).__mul(this.offset).__add(this.parent.GetAbsOrigin());
        const trees = GridNav.GetAllTreesAroundPoint(origin, this.radius / 2, true);
        const units = CustomEntitiesLegacy.FindUnitsInRadius(
            this.parent,
            origin,
            this.radius,
            this.teamFilter,
            this.targetType,
            this.flagFilter,
            FindOrder.ANY
        );

        const zLeft = GetGroundPosition(origin.__add(Vector(-1, 0, 0)), this.parent).z;
        const zRight = GetGroundPosition(origin.__add(Vector(1, 0, 0)), this.parent).z;
        const zUp = GetGroundPosition(origin.__add(Vector(0, 1, 0)), this.parent).z;
        const zDown = GetGroundPosition(origin.__add(Vector(0, -1, 0)), this.parent).z;
        const normal = Vector(zLeft - zRight, zDown - zUp, 2).Normalized();
        const ground = GetGroundPosition(origin, this.parent);
        const groundConnect = this.previousOrigin ? ground.z > this.previousOrigin.z : true;

        if (normal.z < 0.8 && groundConnect) {
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
        // if self.GetOnThinkCallback then
        //     self:GetOnThinkCallback()
        // end
    }

    UpdateHorizontalMotion(me: CDOTA_BaseNPC, dt: number) {
        this.SyncTime(1, dt);
        const target = this.direction.__mul(this.horizontalSpeed).__mul(this.elapsedTime);
        this.parent.SetAbsOrigin(this.origin.__add(target));
    }

    OnHorizontalMotionInterrupted() {
        if (IsServer()) {
            this.Destroy();
        }
    }

    UpdateVerticalMotion(me: CDOTA_BaseNPC, dt: number) {
        this.SyncTime(2, dt);
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

    //     function modifier:GetDirection()
    //         return self.direction
    //     end

    GetIsCommandRestricted() {
        return true;
    }

    GetFindClearSpace() {
        return true;
    }
}
