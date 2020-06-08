sky_second_attack = class({})
LinkLuaModifier("modifier_sky_second_attack_thinker", "abilities/heroes/skywrath_mage/sky_second_attack/modifier_sky_second_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sky_second_attack_charges", "abilities/heroes/skywrath_mage/sky_second_attack/modifier_sky_second_attack_charges", LUA_MODIFIER_MOTION_NONE)

function sky_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sky_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_second_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

    -- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_3, 
		rate = 1.0
	})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point_old", 
		{ 
			duration = cast_point,
			radius = self:GetSpecialValueFor("radius"),
			movement_speed = 10,
		}
	)
end

function sky_second_attack:OnCastPointEnd(point)
	local caster = self:GetCaster()

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_sky_second_attack_thinker", --modifierName
		{}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

end

function sky_second_attack:OnRemovePseudoCastPoint()
	local caster = self:GetCaster()
	local loop = true
	local charges = caster:FindModifierByNameAndCaster("modifier_sky_second_attack_charges", caster)
	
	while loop do
		-- find modifier
		local reducer = caster:FindModifierByNameAndCaster("modifier_sky_second_attack_reducer", caster)
		
		if reducer~=nil then
			if not reducer:IsNull() then
				charges.reduction = charges.reduction + 1.0
				if charges.reduction > self:GetCooldown(-1) then
					charges.reduction = self:GetCooldown(-1)
				end
				reducer:Destroy()
			end
		end

		if reducer==nil then
			charges.cooldowns[caster][charges:GetStackCount()] = charges.reduction
			charges.reduction = 0.0
			loop = false
		else
			if reducer:IsNull() then
				charges.cooldowns[caster][charges:GetStackCount()] = charges.reduction
				charges.reduction = 0.0
				loop = false
			end
		end
	end

	charges:DecrementStackCount()
	charges:CalculateCharge()
end

--------------------------------------------------------------------------------
-- Passive Modifier
function sky_second_attack:GetIntrinsicModifierName()
	return "modifier_sky_second_attack_charges"
end
