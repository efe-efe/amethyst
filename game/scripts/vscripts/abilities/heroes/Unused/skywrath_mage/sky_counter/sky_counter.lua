sky_counter = class({})
LinkLuaModifier("modifier_sky_counter_movement", "abilities/heroes/skywrath_mage/sky_counter/modifier_sky_counter_movement", LUA_MODIFIER_MOTION_HORIZONTAL)

--------------------------------------------------------------------------------
-- Ability Start
function sky_counter:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, { 
        duration = cast_point + self:GetDuration() + 0.1, 
        activity = ACT_DOTA_TELEPORT, 
        rate = 1.0
    })
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_cast_point_old", 
        {
            duration = cast_point,
            can_walk = 0,
            no_target = 1,
        }
   )
end


--------------------------------------------------------------------------------
-- Ability Start
function sky_counter:OnCastPointEnd(point)
    
    --load data
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
            activity = ACT_DOTA_SPAWN,
            rate = 0.1
        } -- kv
   )
end


function sky_counter:OnTrigger(params)
    local caster = self:GetCaster()
    local buff_duration = self:GetSpecialValueFor("buff_duration")
    local heal_amount = self:GetSpecialValueFor("heal_amount")
    local knockback_radius = self:GetSpecialValueFor("knockback_radius")
    local damage = self:GetAbilityDamage()
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")


    if IsServer() then
    
        caster:Heal(heal_amount, caster)

         -- Find enemies
         local enemies = FindUnitsInRadius(
            caster:GetTeamNumber(), -- int, your team number
            caster:GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            knockback_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
       )

        for _,enemy in pairs(enemies) do
            --Knockback

            local x = enemy:GetOrigin().x - caster:GetOrigin().x
            local y = enemy:GetOrigin().y - caster:GetOrigin().y
            local distance = knockback_distance
            local movement_modifier = enemy:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_sky_counter_movement", -- modifier name
                {
                    x = x,
                    y = y,
                    r = distance,
                } -- kv
           )

            --Damage
            local damageTable = {
                victim = enemy,
                attacker = caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self --Optional.
            }
            
            ApplyDamage(damageTable)
        end

        self:PlayEffectsOnTrigger()
    end
end

function sky_counter:OnStartCounter()
    self:PlayEffectsOnCounterStart()
end

function sky_counter:OnEndCounter()
    self:StopEffectsOnCounterStart()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
--On casted
function sky_counter:PlayEffectsOnCounterStart()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
    local sound_cast = "Hero_SkywrathMage.AncientSeal.Target"

    -- Create Sound
    EmitSoundOn(sound_cast, self:GetCaster())

    -- Create Particles
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
end


function sky_counter:StopEffectsOnCounterStart()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

-- On activated
function sky_counter:PlayEffectsOnTrigger()
    local knockback_radius = self:GetSpecialValueFor("knockback_radius")
    -- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
    local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"
    
    -- Create Sound
    EmitSoundOn(sound_cast, self:GetCaster())
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle(
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
       )
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(knockback_radius, 0.4 , 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end