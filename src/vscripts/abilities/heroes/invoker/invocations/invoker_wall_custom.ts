import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { findUnitsInLine } from "../../../../util";
import { CustomAbility } from "../../../framework/custom_ability";
import { CustomModifier } from "../../../framework/custom_modifier";

@registerAbility("invoker_wall_custom")
class InvokerWall extends CustomAbility {
    OnSpellStart() {
        const direction = this.caster.GetForwardVector();

        ModifierInvokerWallThinker.createThinker(this.caster, this, this.caster.GetAbsOrigin(), {
            duration: this.GetSpecialValueFor("duration"),
            x: direction.x,
            y: direction.y
        });
        EmitSoundOn("Hero_Invoker.IceWall.Cast", this.caster);
    }
}

@registerModifier()
class ModifierInvokerWall extends CustomModifier {
    OnCreated() {
        if (IsServer()) {
            ApplyDamage({
                victim: this.parent,
                attacker: this.caster,
                damage: 3,
                damage_type: DamageTypes.PURE
            });
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -this.Value("ms_pct_debuff");
    }
}

@registerModifier()
class ModifierInvokerWallThinker extends CustomModifier {
    origin!: Vector;
    destination!: Vector;
    particleIds: ParticleID[] = [];

    OnCreated(params: { x: number; y: number }) {
        if (IsServer()) {
            const direction = Vector(params.x, params.y);
            const origin = this.parent.GetAbsOrigin();
            const offset = 150;
            const length = 1500;
            const point = origin.__add(direction.__mul(length).__div(Vector(2, 2, 2)));
            const zOffset = 90;

            this.origin = this.Rotate(origin, point, -90).__add(direction.__mul(offset)).__add(Vector(0, 0, zOffset));
            this.destination = this.Rotate(origin, point, 90).__add(direction.__mul(offset)).__add(Vector(0, 0, zOffset));

            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/units/heroes/hero_invoker/invoker_ice_wall.vpcf",
                    ParticleAttachment.ABSORIGIN,
                    this.caster
                )
            );
            ParticleManager.SetParticleControl(this.particleIds[0], 0, this.origin);
            ParticleManager.SetParticleControl(this.particleIds[0], 1, this.destination);

            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/units/heroes/hero_invoker/invoker_ice_wall_b.vpcf",
                    ParticleAttachment.ABSORIGIN,
                    this.caster
                )
            );
            ParticleManager.SetParticleControl(this.particleIds[1], 0, this.origin);
            ParticleManager.SetParticleControl(this.particleIds[1], 1, this.destination);
            this.StartIntervalThink(0.03);
        }
    }

    OnIntervalThink() {
        const enemies = findUnitsInLine(
            this.caster,
            this.origin,
            this.destination,
            100,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE
        );

        for (const enemy of enemies) {
            if (!ModifierInvokerWall.findOne(enemy)) {
                ModifierInvokerWall.apply(enemy, this.caster, this.ability, { duration: this.Value("duration_linger") });
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }
            UTIL_Remove(this.parent);
        }
    }

    Rotate(origin: Vector, target: Vector, angle: number) {
        const radians = (math.pi / 180) * angle;
        const cos = math.cos(radians);
        const sin = math.sin(radians);
        const nx = cos * (target.x - origin.x) + sin * (target.y - origin.y) + origin.x;
        const ny = cos * (target.y - origin.y) - sin * (target.x - origin.x) + origin.y;

        return Vector(nx, ny);
    }
}
