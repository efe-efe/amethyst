import { tables, math, modifiers } from "./util";
import { TargetingIndicator } from "./types";
import CustomAbilities from "./customAbilities";

(function () {
    const customAbilities = CustomAbilities.GetInstance();

    const playerId = Players.GetLocalPlayer();
    let heroIndex: EntityIndex | undefined = undefined;
    let particleLine: ParticleID | undefined = undefined;
    let particleAoe: ParticleID | undefined = undefined;
    let particleHalfCircle: ParticleID | undefined = undefined;

    const targetIndicatorModifiers = [
        "modifier_sniper_ultimate_channeling",
        "modifier_phantom_counter_banish",
        "modifier_nevermore_counter_banish",
        "modifier_mars_counter_countering",
        "modifier_spectre_counter_countering"
    ];

    function DEFX(efx: ParticleID) {
        Particles.DestroyParticleEffect(efx, false);
        Particles.ReleaseParticleIndex(efx);
    }

    function GetActiveAbility(heroIndex: EntityIndex): AbilityEntityIndex | undefined {
        let activeAbility: undefined | AbilityEntityIndex = undefined;

        for (let i = 0; i < 10; i++) {
            const abilityIndex = Entities.GetAbility(heroIndex, i);
            if (Abilities.IsInAbilityPhase(abilityIndex)) {
                activeAbility = abilityIndex;
            }
        }

        let activeModifier: boolean | BuffID = false;
        targetIndicatorModifiers.forEach(modifier => {
            const tempModifier = modifiers.findModifierByName(heroIndex as EntityIndex, modifier);

            if (tempModifier) {
                activeModifier = tempModifier;
            }
        });

        if (activeModifier) {
            activeAbility = Buffs.GetAbility(heroIndex, activeModifier);
        }

        return activeAbility;
    }

    function UpdateTargetIndicator() {
        if (Game.IsInToolsMode()) {
            heroIndex = Players.GetSelectedEntities(playerId)[0];
        }

        if (!heroIndex || heroIndex == -1) {
            heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
            if (Game.IsInToolsMode()) {
                heroIndex = Players.GetSelectedEntities(playerId)[0];
            }
            $.Schedule(1 / 144, UpdateTargetIndicator);
            return;
        }

        const active = GetActiveAbility(heroIndex);
        if (active) {
            const data: TargetingIndicator | undefined = customAbilities.GetTargetingIndicator(active);

            if (data) {
                const heroOrigin = Entities.GetAbsOrigin(heroIndex);
                const mousePositionScreen = GameUI.GetCursorPosition();
                const mousePosition = Game.ScreenXYToWorld(mousePositionScreen[0], mousePositionScreen[1]);
                const direction = Game.Normalized([
                    mousePosition[0] - heroOrigin[0],
                    mousePosition[1] - heroOrigin[1],
                    mousePosition[2] - heroOrigin[2]
                ]);
                const maxRange = Abilities.GetCastRange(active);
                const minRange = Abilities.GetSpecialValueFor(active, "min_range");
                const radius = Abilities.GetSpecialValueFor(active, "radius");
                let target: [number, number, number] | undefined = undefined;
                let length = 0;
                let type = data.Type;

                if (data.Fixed == 1) {
                    length = maxRange;
                } else {
                    length = math.clamp(Game.Length2D(mousePosition, heroOrigin), minRange, maxRange);
                }

                if (data.ModifierName && modifiers.findModifierByName(heroIndex, data.ModifierName)) {
                    const modifierIndex = modifiers.findModifierByName(heroIndex, data.ModifierName);

                    if (modifierIndex) {
                        if (data.ModifierStacks) {
                            const stacks = Buffs.GetStackCount(heroIndex, modifierIndex as BuffID);
                            if (stacks == data.ModifierStacks) {
                                type = data.ModifierType!;

                                if (data.ModifierLength !== undefined) {
                                    length = data.ModifierLength;
                                }
                            }
                        }
                    }
                }

                if (type == "TARGETING_INDICATOR_AOE") {
                    if (!particleAoe) {
                        particleAoe = Particles.CreateParticle(
                            "particles/ui_mouseactions/range_finder_aoe.vpcf",
                            ParticleAttachment_t.PATTACH_WORLDORIGIN,
                            heroIndex
                        );
                    }

                    target = [
                        heroOrigin[0] + direction[0] * length,
                        heroOrigin[1] + direction[1] * length,
                        heroOrigin[2] + direction[2] * length
                    ];

                    Particles.SetParticleControl(particleAoe, 0, target);
                    Particles.SetParticleControl(particleAoe, 2, target);
                    Particles.SetParticleControl(particleAoe, 3, [radius, 0, 0]);
                }
                if (type == "TARGETING_INDICATOR_LINE" || (type == "TARGETING_INDICATOR_AOE" && data.DisplayRange == 1)) {
                    if (!particleLine) {
                        particleLine = Particles.CreateParticle(
                            "particles/targeting/line.vpcf",
                            ParticleAttachment_t.PATTACH_WORLDORIGIN,
                            heroIndex
                        );
                    }

                    length = length - radius;

                    target = [
                        heroOrigin[0] + direction[0] * length,
                        heroOrigin[1] + direction[1] * length,
                        heroOrigin[2] + direction[2] * length
                    ];

                    const target_offset: [number, number, number] = [
                        target[0] + direction[0] * 150,
                        target[1] + direction[1] * 150,
                        target[2] + direction[2] * 150
                    ];

                    Particles.SetParticleControl(particleLine, 0, heroOrigin);
                    Particles.SetParticleControl(particleLine, 1, target);
                    Particles.SetParticleControl(particleLine, 2, target_offset);
                }
                if (type == "TARGETING_INDICATOR_HALF_CIRCLE") {
                    if (!particleHalfCircle) {
                        particleHalfCircle = Particles.CreateParticle(
                            "particles/targeting/half_circle.vpcf",
                            ParticleAttachment_t.PATTACH_WORLDORIGIN,
                            heroIndex
                        );
                    }

                    target = [
                        heroOrigin[0] + direction[0] * length,
                        heroOrigin[1] + direction[1] * length,
                        heroOrigin[2] + direction[2] * length
                    ];

                    Particles.SetParticleControl(particleHalfCircle, 0, heroOrigin);
                    Particles.SetParticleControl(particleHalfCircle, 1, target);
                    Particles.SetParticleControl(particleHalfCircle, 2, [radius, 0, 0]);
                }
            }
        } else {
            if (particleLine) {
                DEFX(particleLine);
                particleLine = undefined;
            }

            if (particleAoe) {
                DEFX(particleAoe);
                particleAoe = undefined;
            }

            if (particleHalfCircle) {
                DEFX(particleHalfCircle);
                particleHalfCircle = undefined;
            }
        }

        $.Schedule(1 / 144, UpdateTargetIndicator);
    }

    UpdateTargetIndicator();
})();
