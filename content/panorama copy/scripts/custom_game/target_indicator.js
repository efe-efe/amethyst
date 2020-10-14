var targetingIndicators = {};

var playerId = Players.GetLocalPlayer();
var heroIndex = null;
var mouse_position_screen = null;
var mouse_position = null;
var particle_line = null;
var particle_aoe = null;
var particle_half_circle = null;
var particle_arc = null;

let target_indicator_modifiers = [
    "modifier_sniper_ultimate_channeling",
    "modifier_phantom_counter_banish",
    "modifier_nevermore_counter_banish",
    "modifier_mars_counter_countering",
    "modifier_spectre_counter_countering",
]

function UpdateTargetIndicator(){
    var active = null;
 
    if(!heroIndex){
        heroIndex = Players.GetPlayerHeroEntityIndex(playerId);
        heroIndex = Players.GetSelectedEntities(playerId)[0]; //DEBUG
        $.Schedule(1/144, UpdateTargetIndicator);
        return
    }

    for(var i = 0; i < 10; i++){
        var abilityIndex = Entities.GetAbility(heroIndex, i);
        if(Abilities.IsInAbilityPhase(abilityIndex)){
            active = abilityIndex;
        }
    }

    if(!active){
        for(var i = 0; i < 6; i++){
            var item_index = Entities.GetItemInSlot(heroIndex, i);

            if(Abilities.IsInAbilityPhase(item_index)){
                active = item_index;
                break;
            }
        }
    }

    if(!active){
        var mModifier = null;
        target_indicator_modifiers.forEach((modifier) => {
            var temp_modifier = Modifiers.FindModifierByName(heroIndex, modifier);

            if(temp_modifier){
                mModifier = temp_modifier
            }
        })


        if(mModifier){
            active = Buffs.GetAbility(heroIndex, mModifier)
        }
    }

    if(active){
        var data = targetingIndicators[Abilities.GetAbilityName(active)];

        if(data){
            var heroOrigin = Entities.GetAbsOrigin(heroIndex)
            mouse_position_screen = GameUI.GetCursorPosition();
            mouse_position = Game.ScreenXYToWorld(mouse_position_screen[0], mouse_position_screen[1])
            var direction = Game.Normalized([
                (mouse_position[0] - heroOrigin[0]),
                (mouse_position[1] - heroOrigin[1]),
                (mouse_position[2] - heroOrigin[2])
            ])	

            if(data.Type == "TARGETING_INDICATOR_AOE"){
                if(!particle_aoe){
                    particle_aoe = Particles.CreateParticle("particles/ui_mouseactions/range_finder_aoe.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                }
                var max_range = Abilities.GetCastRange(active)
                var min_range = Abilities.GetSpecialValueFor(active, "min_range")
                var radius = Abilities.GetSpecialValueFor(active, "radius")
                var length = 0;
                
                if(data.Fixed == "1"){
                    length = max_range;
                } else {
                    length = Clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
                }

                var target = [
                    heroOrigin[0] + (direction[0] * length),
                    heroOrigin[1] + (direction[1] * length),
                    heroOrigin[2] + (direction[2] * length)
                ]
                
                Particles.SetParticleControl(particle_aoe, 0, target)
                Particles.SetParticleControl(particle_aoe, 2, target)
                Particles.SetParticleControl(particle_aoe, 3, [radius, 0, 0]);
            }
            if(data.Type == "TARGETING_INDICATOR_LINE" || (data.Type == "TARGETING_INDICATOR_AOE" && data.DisplayRange == 1)){
                if(!particle_line){
                    particle_line = Particles.CreateParticle("particles/targeting/line.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                }

                var max_range = Abilities.GetCastRange(active);
                var min_range = Abilities.GetSpecialValueFor(active, "min_range");
                var radius = Abilities.GetSpecialValueFor(active, "radius");
                var length = 0;
                var target = [];
                
                if(data.Fixed == "1"){
                    length = max_range;
                } else {
                    length = Clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
                }

                length = length - radius;

                var target = [
                    heroOrigin[0] + (direction[0] * length),
                    heroOrigin[1] + (direction[1] * length),
                    heroOrigin[2] + (direction[2] * length)
                ]

                var target_offset = [
                    target[0] + (direction[0] * 150),
                    target[1] + (direction[1] * 150),
                    target[2] + (direction[2] * 150)
                ]	

                Particles.SetParticleControl(particle_line, 0, heroOrigin)
                Particles.SetParticleControl(particle_line, 1, target);
                Particles.SetParticleControl(particle_line, 2, target_offset);
            }
            if(data.Type == "TARGETING_INDICATOR_ARC"){
                if(!particle_arc){
                    particle_arc = Particles.CreateParticle("particles/targeting/half_circle.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                }

                var max_range = Abilities.GetCastRange(active);
                var min_range = Abilities.GetSpecialValueFor(active, "min_range");
                var radius = Abilities.GetSpecialValueFor(active, "radius");
                var length = 0;
                var target = [];
                
                if(data.Fixed == "1"){
                    length = max_range;
                } else {
                    length = Clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
                }

                var target = [
                    heroOrigin[0] + (direction[0] * length),
                    heroOrigin[1] + (direction[1] * length),
                    heroOrigin[2] + (direction[2] * length)
                ]

                Particles.SetParticleControl(particle_half_circle, 0, heroOrigin)
                Particles.SetParticleControl(particle_half_circle, 1, target)
                Particles.SetParticleControl(particle_half_circle, 2, [radius, 0, 0])
            }
            if(data.Type == "TARGETING_INDICATOR_HALF_CIRCLE"){
                if(!particle_half_circle){
                    particle_half_circle = Particles.CreateParticle("particles/targeting/half_circle.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                }

                var max_range = Abilities.GetCastRange(active);
                var min_range = Abilities.GetSpecialValueFor(active, "min_range");
                var radius = Abilities.GetSpecialValueFor(active, "radius");
                var length = 0;
                var target = [];
                
                if(data.Fixed == "1"){
                    length = max_range;
                } else {
                    length = Clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
                }

                var target = [
                    heroOrigin[0] + (direction[0] * length),
                    heroOrigin[1] + (direction[1] * length),
                    heroOrigin[2] + (direction[2] * length)
                ]

                Particles.SetParticleControl(particle_half_circle, 0, heroOrigin)
                Particles.SetParticleControl(particle_half_circle, 1, target)
                Particles.SetParticleControl(particle_half_circle, 2, [radius, 0, 0])
            }
        }
    } else {
        if(particle_line){
            Particles.DestroyParticleEffect(particle_line, false)
            Particles.ReleaseParticleIndex(particle_line)
            particle_line = null
        }
        
        if(particle_aoe){
            Particles.DestroyParticleEffect(particle_aoe, false)
            Particles.ReleaseParticleIndex(particle_aoe)
            particle_aoe = null
        }

        if(particle_half_circle){
            Particles.DestroyParticleEffect(particle_half_circle, false)
            Particles.ReleaseParticleIndex(particle_half_circle)
            particle_half_circle = null
        }
    }
    
    $.Schedule(1/144, UpdateTargetIndicator);
}

UpdateTargetIndicator();

SubscribeToNetTableKey("main", "targetingIndicators", true, function(data){
    targetingIndicators = data;
});
