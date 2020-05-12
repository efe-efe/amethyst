var targetingIndicators = {};

var playerId = Players.GetLocalPlayer();
var heroIndex = null;
var mouse_position_screen = null;
var mouse_position = null;
var particle = null

let target_indicator_modifiers = [
    "modifier_sniper_ultimate_channeling"
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
            mModifier = Modifiers.FindModifierByName(heroIndex, modifier);
            return;
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
                if(!particle){
                    particle = Particles.CreateParticle("particles/ui_mouseactions/range_finder_aoe.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, heroIndex);
                }
                var max_range = Abilities.GetCastRange(active)
                var min_range = Abilities.GetSpecialValueFor(active, "min_range")
                var radius = Abilities.GetSpecialValueFor(active, "radius")
                var length = Clamp(Game.Length2D(mouse_position, heroOrigin), min_range, max_range);
                
                var target = [
                    heroOrigin[0] + (direction[0] * length),
                    heroOrigin[1] + (direction[1] * length),
                    heroOrigin[2] + (direction[2] * length)
                ]
                
                Particles.SetParticleControl( particle, 0, target)
                Particles.SetParticleControl( particle, 2, target)
                Particles.SetParticleControl( particle, 3, [radius, 0, 0]);
            }
            if(data.Type == "TARGETING_INDICATOR_LINE"){
                if(!particle){
                    particle = Particles.CreateParticle("particles/targeting/line.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, heroIndex);
                }

                var max_range = Abilities.GetCastRange(active);
                var min_range = Abilities.GetSpecialValueFor(active, "min_range");
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

                var target_offset = [
                    target[0] + (direction[0] * 150),
                    target[1] + (direction[1] * 150),
                    target[2] + (direction[2] * 150)
                ]	

                Particles.SetParticleControl(particle, 1, target);
                Particles.SetParticleControl(particle, 2, target_offset);
            }
        }
    } else {
        if(particle){
            Particles.DestroyParticleEffect(particle, false)
            Particles.ReleaseParticleIndex(particle)
            particle = null
        }
    }
    
    $.Schedule(1/144, UpdateTargetIndicator);
}

UpdateTargetIndicator();

SubscribeToNetTableKey("main", "targetingIndicators", true, function(data){
    targetingIndicators = data;
});
