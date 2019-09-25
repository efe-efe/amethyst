modifier_phoenix_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_basic_attack:IsHidden()
	return false
end

function modifier_phoenix_basic_attack:IsDebuff()
	return true
end

function modifier_phoenix_basic_attack:IsStunDebuff()
	return false
end

function modifier_phoenix_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_basic_attack:OnCreated()
    self.hp_per_second = self:GetAbility():GetSpecialValueFor( "hp_per_second" )
	self.radius = 350

	if IsServer() then
		self:StartIntervalThink( 1.0 )
		self:PlayEffects(self:GetParent())
	end
end


--------------------------------------------------------------------------------
-- Destroyer
function modifier_phoenix_basic_attack:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_basic_attack:OnIntervalThink()
	if IsServer() then
		local particle_cast = "particles/econ/events/darkmoon_2017/darkmoon_generic_aoe.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius, 1, 1) )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector(1, 1, 1) )
		ParticleManager:SetParticleControl( effect_cast, 3, Vector(255, 255, 255) )
		ParticleManager:SetParticleControl( effect_cast, 4, Vector(255, 250, 1) )
		ParticleManager:ReleaseParticleIndex( effect_cast )

		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.hp_per_second,
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )

		local units = FindUnitsInRadius( 
			self:GetCaster():GetTeamNumber(), -- int, your team number
			self:GetCaster():GetOrigin(), -- point, center point
			nil, -- handle, cacheUnit. (not known)
			self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0, -- int, flag filter
			0, -- int, order filter
			false -- bool, can grow cache
	   )
	
	   for _,unit in pairs(units) do
			unit:Heal(self.hp_per_second, self:GetCaster())
	   end
	end
end

function modifier_phoenix_basic_attack:PlayEffects( hTarget )
	-- get resources
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf"

	-- create particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:SetParticleControl( self.effect_cast, 0, hTarget:GetOrigin() )
end


function modifier_phoenix_basic_attack:StopEffects( )
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

