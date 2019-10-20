vengeful_mobility_swap = class({})
vengeful_mobility_swap_ultimate = class({})

vengeful_mobility_swap_ultimate.illusion_index = nil
vengeful_mobility_swap.illusion_index = nil

function vengeful_mobility_swap:OnCastPointEnd()
    -- unit identifier
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor( "radius" )
    local illusion = EntIndexToHScript( self.illusion_index )
	
	local ability_name = string.ends(self:GetAbilityName(), "_ultimate") and "vengeful_mobility_ultimate" or "vengeful_mobility"
	local ability = caster:FindAbilityByName(ability_name)
	ability:StartCooldown(ability:GetCooldown(0))

    if illusion then
        self:PlayEffectsOnCast(illusion)
        FindClearSpaceForUnit( caster, illusion:GetOrigin() , true )
        FindClearSpaceForUnit( illusion, origin , true )
        
        Timers:CreateTimer(0.001, function()
            local modifier = illusion:FindModifierByName("modifier_vengeful_mobility_illusion")
            if modifier ~= nil then
                if not modifier:IsNull() then
                    modifier:Destroy()
                    return
                end
            end
        end)
    end
end

function vengeful_mobility_swap:PlayEffectsOnCast( hTarget )
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

vengeful_mobility_swap_ultimate.OnCastPointEnd = vengeful_mobility_swap.OnCastPointEnd
vengeful_mobility_swap_ultimate.PlayEffectsOnCast = vengeful_mobility_swap.PlayEffectsOnCast

if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_mobility_swap,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)

if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_mobility_swap_ultimate,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)