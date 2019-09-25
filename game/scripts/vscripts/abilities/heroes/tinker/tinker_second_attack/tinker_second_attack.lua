
tinker_second_attack = class({})
LinkLuaModifier( "modifier_tinker_second_attack", "abilities/heroes/tinker/tinker_second_attack/modifier_tinker_second_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_second_attack_thinker", "abilities/heroes/tinker/tinker_second_attack/modifier_tinker_second_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function tinker_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("tinker_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_second_attack:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_VICTORY, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", {
		duration = cast_point,
		fixed_range = 1,
	})
end

function tinker_second_attack:OnCastPointEnd( pos )
	local caster = self:GetCaster()
	local direction = (pos - caster:GetOrigin()):Normalized()
	local duration = 0.9

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_tinker_second_attack_thinker", --modifierName
		{
			duration = duration,
			x = direction.x,
			y = direction.y,
			z = direction.z

		}, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_ex_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
-- Projectile
function tinker_second_attack:OnProjectileHit_ExtraData( target, location, extraData )
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	local stacks_duration = self:GetSpecialValueFor("stacks_duration")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local caster = self:GetCaster()
	local stacks = 0

	if target ~=nil then
		if target:TriggerSpellAbsorb( self ) then return end
		stacks = SafeGetModifierStacks("modifier_tinker_second_attack", target, caster)
	
		-- Apply damage
		local damage = {
			victim = target,
			attacker = caster,
			damage = extraData.damage + (damage_per_stack * stacks),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}
		ApplyDamage( damage )

		target:AddNewModifier(
			caster,
			self,
			"modifier_tinker_second_attack",
			{ duration = stacks_duration }
		)
		
		-- Give Mana
		local mana_gain_final = caster:GetMaxMana() * mana_gain
		caster:GiveMana(mana_gain_final)    

		-- effects
		self:PlayEffects( target )
	end
end

--------------------------------------------------------------------------------
-- Effects
function tinker_second_attack:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf"
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile.Impact"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, target )
end

