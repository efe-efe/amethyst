nevermore_ultimate = class({})
LinkLuaModifier( "modifier_nevermore_ultimate", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_ultimate_attract", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate_attract", LUA_MODIFIER_MOTION_NONE )

function nevermore_ultimate:OnStopPseudoCastPoint()
	self:StopEffectsOnCastPoint( false )

end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ultimate:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local radius = self:GetSpecialValueFor("radius")

	caster:AddNewModifier(caster, self, "modifier_nevermore_ultimate_attract", { duration = self:GetSpecialValueFor("cast_point") })
	self:PlayEffectsOnCastPoint()
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ultimate:OnCastPointEnd()
	local lines = 5
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", self:GetCaster() )
	if modifier~=nil then
		lines = lines + modifier:GetStackCount()
		modifier:Destroy()
	end

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

	local counter = 0

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
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
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
				
				counter = counter + 1
				print(counter)
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
	self:StopEffectsOnCastPoint( true )
	self:PlayEffects2( lines )

	self:GetCaster():GiveMana(100)
end


--------------------------------------------------------------------------------
-- Effects
function nevermore_ultimate:PlayEffectsOnCastPoint()
	local particle_precast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	EmitGlobalSound("Hero_Nevermore.ROS.Arcana.Cast")
	self.effect_precast = ParticleManager:CreateParticle( particle_precast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )	
end

function nevermore_ultimate:StopEffectsOnCastPoint( success )
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

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_6, rate = 1.2 },
	{ movement_speed = 0 }
)