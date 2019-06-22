nevermore_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_second_attack", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_second_attack_cooldown", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_cooldown", LUA_MODIFIER_MOTION_NONE )

-- Set AOE indicator
--------------------------------------------------------------------------------
function nevermore_second_attack:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local damage_per_stack = self:GetSpecialValueFor("damage")
	local stack_duration = self:GetSpecialValueFor("stack_duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

	-- get affected enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- for each affected enemies
	for _,enemy in pairs(enemies) do
		-- Get Stack
		local modifier = enemy:FindModifierByNameAndCaster("modifier_nevermore_second_attack", caster)
		local stacks = 0
		if modifier~=nil then
			stacks = modifier:GetStackCount()
		end

		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = caster,
			damage = damage + stacks * damage_per_stack,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = this,
		}
		ApplyDamage( damageTable )

		--Add stack
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_nevermore_second_attack",
			{ duration = stack_duration }
		)
	end

	if #enemies > 0 then
		-- Give Mana
				
		local mana_gain_final = caster:GetMaxMana() * mana_gain
		caster:GiveMana(mana_gain_final)   

		-- Refresh if posible
		local cooldownModifier = caster:AddNewModifier(
			caster,
			self,
			"modifier_nevermore_second_attack_cooldown",
			{ duration = stack_duration }
		)
		local cooldownStacks = cooldownModifier:GetStackCount()
		
		if cooldownStacks < 3 then
			self:EndCooldown()
		else
			SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
		end
 
	else
		SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
	end

	-- Effects
	self:PlayEffects( point, radius )
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_ex_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function nevermore_second_attack:PlayEffects( position, radius )
	local caster = self:GetCaster()
	
	-- get resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local sound_cast = "Hero_Nevermore.Shadowraze"

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, position )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	-- create sound
	EmitSoundOnLocationWithCaster( position, sound_cast, caster )
end
