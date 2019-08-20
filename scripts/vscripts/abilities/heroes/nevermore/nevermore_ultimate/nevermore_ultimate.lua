nevermore_ultimate = class({})
LinkLuaModifier( "modifier_nevermore_ultimate_scepter", "lua_abilities/nevermore_ultimate/modifier_nevermore_ultimate_scepter", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_ultimate", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate", LUA_MODIFIER_MOTION_NONE )


function nevermore_ultimate:OnStopPseudoCastPoint()
	self:StopEffects1( false )
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ultimate:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self:PlayEffects1()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=2.0, activity=ACT_DOTA_CAST_ABILITY_6, rate=1.2})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		can_walk = 0,
		no_target = 1
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ultimate:OnEndPseudoCastPoint()
	-- get number of souls
	local lines = 6
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", self:GetCaster() )
	if modifier~=nil then
		lines = lines + modifier:GetStackCount() * 6
		modifier:Destroy()
	end

	-- explode
	self:Explode( lines )
end

--------------------------------------------------------------------------------
-- Helper
function nevermore_ultimate:Explode( lines )
	self.duration = self:GetSpecialValueFor("slow_duration")
	self.damage = self:GetSpecialValueFor("damage_per_soul")

	-- get projectile
	local projectile_name = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf"
	local line_length = self:GetSpecialValueFor("radius")
	local width_start = self:GetSpecialValueFor("line_width_start")
	local width_end = self:GetSpecialValueFor("line_width_end")
	local line_speed = self:GetSpecialValueFor("line_speed")
	
	-- create linear projectile
	local initial_angle_deg = self:GetCaster():GetAnglesAsVector().y
	local delta_angle = 360/lines
	for i=0, lines-1 do
		-- Determine velocity
		local facing_angle_deg = initial_angle_deg + delta_angle * i
		if facing_angle_deg>360 then facing_angle_deg = facing_angle_deg - 360 end
		local facing_angle = math.rad(facing_angle_deg)
		local facing_vector = Vector( math.cos(facing_angle), math.sin(facing_angle), 0 ):Normalized()
		local velocity = facing_vector * line_speed

        local projectile = {
            EffectName = projectile_name,
            vSpawnOrigin = self:GetCaster():GetOrigin() + Vector(0, 0, 80),
            fDistance = line_length,
            fStartRadius = width_start,
            fEndRadius = width_end,
            Source = self:GetCaster(),
            fExpireTime = 15.0,
            vVelocity = velocity,
            UnitBehavior = PROJECTILES_NOTHING,
            bMultipleHits = false,
            bIgnoreSource = true,
            TreeBehavior = PROJECTILES_NOTHING,
            bCutTrees = true,
            bTreeFullCollision = false,
            WallBehavior = PROJECTILES_DESTROY,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 80,
            nChangeMax = 1,
            bRecreateOnChange = true,
            bZCheck = false,
            bGroundLock = true,
            bProvidesVision = true,
            iVisionRadius = 200,
            iVisionTeamNumber = self:GetCaster():GetTeam(),
            bFlyingVision = false,
            fVisionTickTime = .1,
            fVisionLingerDuration = 1,
            draw = false,
            fRehitDelay = 1.0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
            OnUnitHit = function(_self, unit) 
                -- damage target
                local damage = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = self.damage,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = self,
                }
                ApplyDamage( damage )
    
                -- apply modifier
                unit:AddNewModifier(
                    _self.Source,
                    self,
                    "modifier_nevermore_ultimate",
                    { duration = self.duration }
                )

                self:PlayEffects_b(_self.currentPosition)
            end,
            OnFinish = function(_self, pos)
               self:PlayEffects_b(pos)
            end,
        }
        Projectiles:CreateProjectile(projectile)
    end
    
	-- Play effects
	self:StopEffects1( true )
	self:PlayEffects2( lines )
end


--------------------------------------------------------------------------------
-- Effects
function nevermore_ultimate:PlayEffects1()
	-- Get Resources
	local particle_precast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	local sound_precast = "Hero_Nevermore.ROS.Arcana.Cast"

	-- Create Particles
	self.effect_precast = ParticleManager:CreateParticle( particle_precast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )	

	-- Play Sounds
	EmitGlobalSound(sound_precast)
end
function nevermore_ultimate:StopEffects1( success )
	-- Get Resources
	local sound_precast = "Hero_Nevermore.ROS.Arcana.Cast"

	-- Destroy Particles
	if not success then
		ParticleManager:DestroyParticle( self.effect_precast, true )
		StopGlobalSound(sound_precast)
	end

	ParticleManager:ReleaseParticleIndex( self.effect_precast )
end

function nevermore_ultimate:PlayEffects2( lines )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf"
	local sound_cast = "Hero_Nevermore.ROS.Arcana"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( lines, 0, 0 ) )	-- Lines
	ParticleManager:SetParticleControlForward( effect_cast, 2, self:GetCaster():GetForwardVector() )		-- initial direction
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Play Sounds
	EmitSoundOn(sound_cast, self:GetCaster())
end


-- On Projectile impacts
function nevermore_ultimate:PlayEffects_b( pos )
	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/sf_base_attack_desolation_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
