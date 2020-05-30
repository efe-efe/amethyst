nevermore_ex_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )

function nevermore_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("nevermore_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local radius = self:GetSpecialValueFor("radius")
	self.point = self:GetCursorPosition() -- Only to get the z 

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.7, activity=ACT_DOTA_RAZE_2, rate=1.1})
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { 
		duration = cast_point,
		movement_speed = 10,
		radius = radius
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_second_attack:OnCastPointEnd( pos )
	-- unit identifier
	local caster = self:GetCaster()
	
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetAbilityDamage()
	local souls = self:GetSpecialValueFor("souls")

	-- get affected enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
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
		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = this,
		}
		ApplyDamage( damageTable )
	end

	if #enemies > 0 then

		if enemies[1]:IsRealHero() then 
			for i=0, souls - 1 do
				caster:AddNewModifier(
					caster,
					caster:FindAbilityByName("nevermore_basic_attack"),
					"modifier_nevermore_souls",
					{}
				)
				self:PlayEffects_b(enemies[1])
			end
		end
	end

	-- Effects
	self:PlayEffects( pos, radius )    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))

end

function nevermore_ex_second_attack:PlayEffects( position, radius )
	local caster = self:GetCaster()
	local new_position = Vector(position.x, position.y, self.point.z)
	
	-- get resources
	local particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf"
	local sound_cast = "Hero_Nevermore.Shadowraze"

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, new_position )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	-- create sound
	EmitSoundOnLocationWithCaster( new_position, sound_cast, caster )
end

function nevermore_ex_second_attack:PlayEffects_b( target )
	-- Get Resources
	local projectile_name = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf"

	-- CreateProjectile
	local info = {
		Target = self:GetCaster(),
		Source = target,
		EffectName = projectile_name,
		iMoveSpeed = 400,
		vSourceLoc= target:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end