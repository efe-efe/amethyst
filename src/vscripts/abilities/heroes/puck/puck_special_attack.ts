import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierSilence } from "../../../modifiers/modifier_silence";
import { ModifierStun } from "../../../modifiers/modifier_stunned";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPuckFairyDust } from "./puck_basic_attack";

@registerAbility("puck_special_attack")
export class PuckSpecialAttack extends CustomAbility {
    GetCastAnimationCustom() {
        return GameActivity.DOTA_CAST_ABILITY_5;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierPuckSpecialAttack.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay"),
            radius: this.GetSpecialValueFor("radius"),
            damage: this.GetSpecialValueFor("damage"),
            stunDuration: this.GetSpecialValueFor("stun_duration"),
            fairyDustDuration: this.GetSpecialValueFor("fairy_dust_duration"),
            fairyDustSlowPct: this.GetSpecialValueFor("fairy_dust_slow_pct")
        });
        ModifierPuckSpecialAttack.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_small"),
            radius: this.GetSpecialValueFor("radius_small"),
            damage: this.GetSpecialValueFor("damage_small"),
            silenceDuration: this.GetSpecialValueFor("silence_duration"),
            stunDuration: this.GetSpecialValueFor("stun_duration_small")
        });
        EmitSoundOn("Hero_Puck.Dream_Coil", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_special_attack_thinker" })
class ModifierPuckSpecialAttack extends ModifierThinker {
    origin!: Vector;
    damage!: number;
    manaGainPct!: number;
    stunDuration!: number;
    fairyDustDuration?: number;
    fairyDustSlowPct?: number;
    silenceDuration?: number;
    particleId?: ParticleID;

    OnCreated(
        params: ModifierThinkerParams & {
            damage: number;
            silenceDuration?: number;
            stunDuration: number;
            fairyDustDuration?: number;
            fairyDustSlowPct?: number;
        }
    ) {
        super.OnCreated(params);

        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
            this.damage = params.damage;
            this.silenceDuration = params.silenceDuration;
            this.stunDuration = params.stunDuration;
            this.fairyDustDuration = params.fairyDustDuration;
            this.fairyDustSlowPct = params.fairyDustSlowPct;
            this.manaGainPct = this.ability.GetSpecialValueFor("mana_gain_pct");
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            StopSoundOn("Hero_Puck.Dream_Coil", this.caster);

            if (this.particleId) {
                DEFX(this.particleId, false);
            }
        }
    }

    OnReady() {
        let giveMana = false;

        this.ability.AoeAttack({
            origin: this.origin,
            radius: this.radius,
            effect: target => {
                if (this.ability.GetLevel() >= 2) {
                    ModifierStun.apply(target, this.caster, this.ability, { duration: this.stunDuration });
                }

                if (this.silenceDuration) {
                    ModifierSilence.apply(target, this.caster, this.ability, { duration: this.silenceDuration });
                }

                if (this.fairyDustDuration && this.fairyDustSlowPct) {
                    ModifierPuckFairyDust.apply(target, this.caster, this.ability, {
                        duration: this.fairyDustDuration,
                        slowPct: this.fairyDustSlowPct
                    });
                }

                EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", target);
                ApplyDamage({
                    victim: target,
                    attacker: this.caster,
                    damage: this.damage,
                    damage_type: DamageTypes.PURE
                });
                if (!isObstacle(target) && !isGem(target)) {
                    giveMana = true;
                }
            }
        });

        this.PlayEffectsExplode(this.radius, 0);

        if (giveMana) {
            giveManaAndEnergyPercent(this.caster, this.manaGainPct, true);
        }

        this.Destroy();
    }

    PlayEffectsExplode(radius: number, steam: 0 | 1) {
        EmitSoundOn("Hero_Puck.Dream_Coil_Snap", this.parent);
        EFX("particles/puck/puck_special_attack_radius.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: this.origin,
            cp2: Vector(radius),
            release: true
        });
        EFX("particles/puck/puck_special_attack.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp2: Vector(radius, 0, 0),
            cp6: Vector(steam, 0, 0),
            release: true
        });
    }
}
