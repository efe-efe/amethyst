terrorblade_counter = class({})

function terrorblade_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            activity = ACT_DOTA_CAST_ABILITY_3,
            rate = 0.2,
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
        }
   )
end

function terrorblade_counter:OnTrigger()
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local debuff_duration = self:GetSpecialValueFor("debuff_duration")
    local base = caster:FindModifierByName("modifier_terrorblade_base")
    

    local enemies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )
    
    for _,enemy in pairs(enemies) do
        if base:GetState() == "NORMAL" then
            enemy:AddNewModifier(caster, self, "modifier_generic_hypnotize", { 
                duration = debuff_duration
            })
        else
            local x =  - (caster:GetOrigin() - enemy:GetOrigin()):Normalized().x
            local y =  - (caster:GetOrigin() - enemy:GetOrigin()):Normalized().y
        
            enemy:AddNewModifier(caster, self, "modifier_generic_fear", { 
                duration = debuff_duration, 
                x = x ,
                y = y
            })
        end
    end
    self:PlayEffectsOnTrigger(radius)
end

function terrorblade_counter:PlayEffectsOnTrigger(radius)
    EmitSoundOn("Hero_Terrorblade.Metamorphosis.Scepter", self:GetCaster())

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius,radius,radius))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius,radius,radius))
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
    terrorblade_counter,
    nil, 
	{ movement_speed = 100 }
)