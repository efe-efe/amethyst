import { tables, modifiers, math } from './shared/util';

(function(){
    let targetingIndicators: any = {};
    const playerId = Players.GetLocalPlayer();
    let heroIndex: EntityIndex | undefined = undefined;
    let mouse_position_screen: [number, number] | undefined  = undefined;
    let mouse_position: [number, number, number] | undefined  = undefined;
    let particle_line: ParticleID | undefined = undefined;
    let particle_aoe: ParticleID | undefined  = undefined;
    let particle_half_circle: ParticleID | undefined  = undefined;
    
    const target_indicator_modifiers = [
        'modifier_sniper_ultimate_channeling',
        'modifier_phantom_counter_banish',
        'modifier_nevermore_counter_banish',
        'modifier_mars_counter_countering',
        'modifier_spectre_counter_countering',
    ];
    
    function UpdateTargetIndicator(){
        let active = null;
     
        if(!heroIndex){
            heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
            $.Schedule(1/144, UpdateTargetIndicator);
            return;
        }
    
        for(let i = 0; i < 10; i++){
            const abilityIndex = Entities.GetAbility(heroIndex, i);
            if(Abilities.IsInAbilityPhase(abilityIndex)){
                active = abilityIndex;
            }
        }
    
        if(!active){
            let mModifier = null;
            target_indicator_modifiers.forEach((modifier) => {
                const temp_modifier = modifiers.findModifierByName(heroIndex!, modifier);
    
                if(temp_modifier){
                    mModifier = temp_modifier;
                }
            });
    
            if(mModifier){
                active = Buffs.GetAbility(heroIndex, mModifier);
            }
        }
    
        if(active){
            const data = targetingIndicators[Abilities.GetAbilityName(active)];
    
            if(data){
                const heroOrigin = Entities.GetAbsOrigin(heroIndex);
                mouse_position_screen = GameUI.GetCursorPosition();
                mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1]);
                const direction = Game.Normalized([
                    (mouse_position[0] - heroOrigin[0]),
                    (mouse_position[1] - heroOrigin[1]),
                    (mouse_position[2] - heroOrigin[2])
                ]);
                
                const max_range = Abilities.GetCastRange(active);
                const min_range = Abilities.GetSpecialValueFor(active, 'min_range');
                const radius = Abilities.GetSpecialValueFor(active, 'radius');
                let length = (data.Fixed == '1') ? max_range : math.clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
    
                if(data.Type == 'TARGETING_INDICATOR_AOE'){
                    if(!particle_aoe){
                        particle_aoe = Particles.CreateParticle('particles/ui_mouseactions/range_finder_aoe.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                    }
    
                    const target: [number, number, number]  = [
                        heroOrigin[0] + (direction[0] * length),
                        heroOrigin[1] + (direction[1] * length),
                        heroOrigin[2] + (direction[2] * length)
                    ];
                    
                    Particles.SetParticleControl(particle_aoe, 0, target);
                    Particles.SetParticleControl(particle_aoe, 2, target);
                    Particles.SetParticleControl(particle_aoe, 3, [radius, 0, 0]);
                }
                if(data.Type == 'TARGETING_INDICATOR_LINE' || (data.Type == 'TARGETING_INDICATOR_AOE' && data.DisplayRange == 1)){
                    length = length - radius;
    
                    if(length > 0){
                        if(!particle_line){
                            particle_line = Particles.CreateParticle('particles/targeting/line.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                        }
    
                        const target: [number, number, number] = [
                            heroOrigin[0] + (direction[0] * length),
                            heroOrigin[1] + (direction[1] * length),
                            heroOrigin[2] + (direction[2] * length)
                        ];
        
                        const target_offset: [number, number, number]  = [
                            target[0] + (direction[0] * 150),
                            target[1] + (direction[1] * 150),
                            target[2] + (direction[2] * 150)
                        ];	
        
                        Particles.SetParticleControl(particle_line, 0, heroOrigin);
                        Particles.SetParticleControl(particle_line, 1, target);
                        Particles.SetParticleControl(particle_line, 2, target_offset);
                    }
                }
                if(data.Type == 'TARGETING_INDICATOR_HALF_CIRCLE'){
                    if(!particle_half_circle){
                        particle_half_circle = Particles.CreateParticle('particles/targeting/half_circle.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                    }
    
                    const target: [number, number, number]  = [
                        heroOrigin[0] + (direction[0] * length),
                        heroOrigin[1] + (direction[1] * length),
                        heroOrigin[2] + (direction[2] * length)
                    ];
    
                    Particles.SetParticleControl(particle_half_circle, 0, heroOrigin);
                    Particles.SetParticleControl(particle_half_circle, 1, target);
                    Particles.SetParticleControl(particle_half_circle, 2, [radius, 0, 0]);
                }
            }
        } else {
            if(particle_line){
                Particles.DestroyParticleEffect(particle_line, false);
                Particles.ReleaseParticleIndex(particle_line);
                particle_line = undefined;
            }
            
            if(particle_aoe){
                Particles.DestroyParticleEffect(particle_aoe, false);
                Particles.ReleaseParticleIndex(particle_aoe);
                particle_aoe = undefined;
            }
    
            if(particle_half_circle){
                Particles.DestroyParticleEffect(particle_half_circle, false);
                Particles.ReleaseParticleIndex(particle_half_circle);
                particle_half_circle = undefined;
            }
        }
        
        $.Schedule(1/144, UpdateTargetIndicator);
    }

    function UpdateTargetIndicatorTools(){
        let active = null;
     
        heroIndex = Players.GetSelectedEntities(playerId)[0];

        if(!heroIndex){
            $.Schedule(1/144, UpdateTargetIndicatorTools);
            return;
        }
    
        for(let i = 0; i < 10; i++){
            const abilityIndex = Entities.GetAbility(heroIndex, i);
            if(Abilities.IsInAbilityPhase(abilityIndex)){
                active = abilityIndex;
            }
        }
    
        if(!active){
            let mModifier = null;
            target_indicator_modifiers.forEach((modifier) => {
                const temp_modifier = modifiers.findModifierByName(heroIndex!, modifier);
    
                if(temp_modifier){
                    mModifier = temp_modifier;
                }
            });
    
            if(mModifier){
                active = Buffs.GetAbility(heroIndex, mModifier);
            }
        }
    
        if(active){
            const data = targetingIndicators[Abilities.GetAbilityName(active)];
    
            if(data){
                const heroOrigin = Entities.GetAbsOrigin(heroIndex);
                mouse_position_screen = GameUI.GetCursorPosition();
                mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1]);
                const direction = Game.Normalized([
                    (mouse_position[0] - heroOrigin[0]),
                    (mouse_position[1] - heroOrigin[1]),
                    (mouse_position[2] - heroOrigin[2])
                ]);
                
                const max_range = Abilities.GetCastRange(active);
                const min_range = Abilities.GetSpecialValueFor(active, 'min_range');
                const radius = Abilities.GetSpecialValueFor(active, 'radius');
                let length = (data.Fixed == '1') ? max_range : math.clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
    
                if(data.Type == 'TARGETING_INDICATOR_AOE'){
                    if(!particle_aoe){
                        particle_aoe = Particles.CreateParticle('particles/ui_mouseactions/range_finder_aoe.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                    }
    
                    const target: [number, number, number]  = [
                        heroOrigin[0] + (direction[0] * length),
                        heroOrigin[1] + (direction[1] * length),
                        heroOrigin[2] + (direction[2] * length)
                    ];
                    
                    Particles.SetParticleControl(particle_aoe, 0, target);
                    Particles.SetParticleControl(particle_aoe, 2, target);
                    Particles.SetParticleControl(particle_aoe, 3, [radius, 0, 0]);
                }
                if(data.Type == 'TARGETING_INDICATOR_LINE' || (data.Type == 'TARGETING_INDICATOR_AOE' && data.DisplayRange == 1)){
                    length = length - radius;
    
                    if(length > 0){
                        if(!particle_line){
                            particle_line = Particles.CreateParticle('particles/targeting/line.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                        }
    
                        const target: [number, number, number] = [
                            heroOrigin[0] + (direction[0] * length),
                            heroOrigin[1] + (direction[1] * length),
                            heroOrigin[2] + (direction[2] * length)
                        ];
        
                        const target_offset: [number, number, number]  = [
                            target[0] + (direction[0] * 150),
                            target[1] + (direction[1] * 150),
                            target[2] + (direction[2] * 150)
                        ];	
        
                        Particles.SetParticleControl(particle_line, 0, heroOrigin);
                        Particles.SetParticleControl(particle_line, 1, target);
                        Particles.SetParticleControl(particle_line, 2, target_offset);
                    }
                }
                if(data.Type == 'TARGETING_INDICATOR_HALF_CIRCLE'){
                    if(!particle_half_circle){
                        particle_half_circle = Particles.CreateParticle('particles/targeting/half_circle.vpcf', ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                    }
    
                    const target: [number, number, number]  = [
                        heroOrigin[0] + (direction[0] * length),
                        heroOrigin[1] + (direction[1] * length),
                        heroOrigin[2] + (direction[2] * length)
                    ];
    
                    Particles.SetParticleControl(particle_half_circle, 0, heroOrigin);
                    Particles.SetParticleControl(particle_half_circle, 1, target);
                    Particles.SetParticleControl(particle_half_circle, 2, [radius, 0, 0]);
                }
            }
        } else {
            if(particle_line){
                Particles.DestroyParticleEffect(particle_line, false);
                Particles.ReleaseParticleIndex(particle_line);
                particle_line = undefined;
            }
            
            if(particle_aoe){
                Particles.DestroyParticleEffect(particle_aoe, false);
                Particles.ReleaseParticleIndex(particle_aoe);
                particle_aoe = undefined;
            }
    
            if(particle_half_circle){
                Particles.DestroyParticleEffect(particle_half_circle, false);
                Particles.ReleaseParticleIndex(particle_half_circle);
                particle_half_circle = undefined;
            }
        }
        
        $.Schedule(1/144, UpdateTargetIndicatorTools);
    }
    
    const tableName = 'main' as never;
    tables.subscribeToNetTableKey(tableName, 'targetingIndicators', true, function(data: any){
        $.Msg('UPDATING');
        targetingIndicators = data;
    });

    $.Msg(targetingIndicators);
    
    if(Game.IsInToolsMode()){
        UpdateTargetIndicatorTools();
    } else {
        UpdateTargetIndicator();
    }
})();