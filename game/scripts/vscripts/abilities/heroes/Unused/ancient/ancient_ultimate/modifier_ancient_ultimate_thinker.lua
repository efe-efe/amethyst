modifier_ancient_ultimate_thinker = class({})

function modifier_ancient_ultimate_thinker:OnCreated( params )
    if IsServer() then 
        self.initialized = false

        local delay_time = self:GetAbility():GetCooldown(0)
        self.radius = self:GetAbility():GetSpecialValueFor("radius")

        AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, delay_time + 1.5, true )

        self:StartIntervalThink(delay_time)
    end
end

function modifier_ancient_ultimate_thinker:OnIntervalThink()
    if self.initialized == false then
        local caster = self:GetCaster()
        local origin = caster:GetOrigin()
        local ability = caster:FindAbilityByName("ancient_ultimate") -- Get special values from original
        local damage = ability:GetSpecialValueFor("ability_damage")
        local point = self:GetParent():GetOrigin()
        
        local projectile_distance = (point - origin):Length2D()
        local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
        local projectile_speed = 5000
        
        -- Extra data
        local projectile = {
            EffectName = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_initial_ti5.vpcf",
            vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
            fDistance = projectile_distance,
            fUniqueRadius = self:GetAbility():GetSpecialValueFor("hitbox"),
            fEndRadius = projectile_end_radius,
            Source = caster,
            vVelocity = projectile_direction * projectile_speed,
            UnitBehavior = PROJECTILES_NOTHING,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_NOTHING,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 80,
            fVisionLingerDuration = 2.0,
            iVisionRadius = self.radius,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
            OnUnitHit = function(_self, unit)
                --self:PlayEffectsTarget(unit, _self.current_position)
            end,
            OnFinish = function(_self, pos)
                local enemies = caster:FindUnitsInRadius(
                    pos, 
                    self.radius,
                    DOTA_UNIT_TARGET_TEAM_ENEMY, 
                    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
                    DOTA_UNIT_TARGET_FLAG_NONE,
                    FIND_ANY_ORDER
                )
        
                for _,enemy in pairs(enemies) do
                    local damage_table = {
                        victim = enemy,
                        attacker = caster,
                        damage = damage,
                        damage_type = DAMAGE_TYPE_PURE,
                    }
                    ApplyDamage( damage_table )
        
                end
        
                self:PlayEffectsProjectileImpact(pos)
                self:Destroy()
            end,
        }
        
        Projectiles:CreateProjectile(projectile)
        self.initialized = true
    end
end

function modifier_ancient_ultimate_thinker:PlayEffectsProjectileImpact( pos )
	local caster = self:GetCaster()

	-- Cast Sound
	EmitSoundOn( "Hero_Ancient_Apparition.IceBlast.Target", caster )

	-- Cast Particle
	local particle_cast = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_explode_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end