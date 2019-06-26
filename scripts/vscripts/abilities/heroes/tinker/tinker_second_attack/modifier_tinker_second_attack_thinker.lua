modifier_tinker_second_attack_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_second_attack_thinker:IsHidden()
	return true
end

function modifier_tinker_second_attack_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_tinker_second_attack_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.projectile_speed = 2000--self:GetAbility():GetSpecialValueFor("speed")
    local max_range = 2200--self:GetAbility():GetSpecialValueFor("range")
    
    local changes = 8
    self.range_interval = max_range/changes
    local think_interval = self:GetDuration()/changes 

    self.direction = Vector(kv.x, kv.y, kv.z)
    self.counter = 0
    self.targets = 3
    self.projectile_name = "particles/units/heroes/hero_tinker/tinker_missile.vpcf"


    if IsServer() then
        self.point = self:GetAbility():GetCursorPosition()
	    self.damage = self:GetAbility():GetAbilityDamage()	
        self.pos = self:GetParent():GetOrigin()
        
        self:StartIntervalThink(think_interval)
        self:OnIntervalThink()
    end
end


function modifier_tinker_second_attack_thinker:OnDestroy()
    if IsServer() then
    end
end

function modifier_tinker_second_attack_thinker:OnIntervalThink()
    self.pos = self.pos + self.direction * self.range_interval

    -- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self.pos,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
    )
    
    if #enemies > 0 then

        -- create projectile for each enemy
        local info = {
            Source = self:GetCaster(),
            -- Target = target,
            Ability = self:GetAbility(),
            EffectName = self.projectile_name,
            iMoveSpeed = self.projectile_speed,
            bDodgeable = false,
            flExpireTime = GameRules:GetGameTime() + 1.8, 
            ExtraData = {
                damage = self.damage,
            }
        }
        for i=1,math.min(self.targets,#enemies) do
            info.Target = enemies[i]
            ProjectileManager:CreateTrackingProjectile( info )
        end
        self:Destroy()
    end

    self:PlayEffects(self.pos)
end

function modifier_tinker_second_attack_thinker:PlayEffects( pos )
    EmitSoundOn("Hero_Techies.LandMine.Priming", self:GetCaster())
    local particle_cast = "particles/econ/events/darkmoon_2017/darkmoon_generic_aoe.vpcf"
	
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 1, 1 ) )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end