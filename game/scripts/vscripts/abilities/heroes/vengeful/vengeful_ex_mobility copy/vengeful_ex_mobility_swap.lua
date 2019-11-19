vengeful_ex_second_attack_swap = class({})
vengeful_ex_second_attack_swap_ultimate = class({})

vengeful_ex_second_attack_swap_ultimate.illusion_index = nil
vengeful_ex_second_attack_swap.illusion_index = nil

function vengeful_ex_second_attack_swap:OnCastPointEnd()
    -- unit identifier
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor( "radius" )
    local illusion = EntIndexToHScript( self.illusion_index )
	
	local ability_name = string.ends(self:GetAbilityName(), "_ultimate") and "vengeful_ex_second_attack_ultimate" or "vengeful_ex_second_attack"
	local ability = caster:FindAbilityByName(ability_name)

    if illusion then
        self:PlayEffectsOnCast(illusion)
        FindClearSpaceForUnit( caster, illusion:GetOrigin() , true )
        FindClearSpaceForUnit( illusion, origin , true )
        
		Timers:CreateTimer(0.001, function()
			if illusion then
				local modifier = illusion:FindModifierByName("modifier_vengeful_ex_second_attack_illusion")
				if modifier ~= nil then
					if not modifier:IsNull() then
						modifier:Destroy()
						return
					end
				end
			end
        end)
    end
end


function vengeful_ex_second_attack_swap:OnSwapPress()
    return false
end

function vengeful_ex_second_attack_swap:OnSwapRelease()
    return false
end

function vengeful_ex_second_attack_swap:PlayEffectsOnCast( hTarget )
    local caster = self:GetCaster()
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		caster:GetOrigin(), 
		true 
	);
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		1, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
    );
    
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", caster)
    EmitSoundOn("Hero_VengefulSpirit.NetherSwap", hTarget)
end

vengeful_ex_second_attack_swap_ultimate.OnCastPointEnd = vengeful_ex_second_attack_swap.OnCastPointEnd
vengeful_ex_second_attack_swap_ultimate.PlayEffectsOnCast = vengeful_ex_second_attack_swap.PlayEffectsOnCast

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_second_attack_swap,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_second_attack_swap_ultimate,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)