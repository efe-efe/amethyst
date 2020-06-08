modifier_sniper_ultimate_channeling = class({})

function modifier_sniper_ultimate_channeling:OnCreated(params)
    if IsServer() then
	    self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.aoe_damage = self:GetAbility():GetSpecialValueFor("aoe_damage")
        self.projectile_distance = self:GetAbility():GetCastRange(Vector(0,0,0), nil)
        self.hitbox = self:GetAbility():GetSpecialValueFor("hitbox")
        self.projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")

        self:OnIntervalThink()
        self:StartIntervalThink(0.45)
    end
end

function modifier_sniper_ultimate_channeling:OnIntervalThink()
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)

    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetAbility():GetCursorPosition()
    local ability = self:GetAbility()

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	-- Extra data
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_sniper/sniper_assassinate.vpcf",
		vSpawnOrigin = origin + Vector(0,0, 96),
		fDistance = self.projectile_distance,
		fUniqueRadius = self.hitbox,
		fEndRadius = projectile_end_radius,
		Source = caster,
		vVelocity = projectile_direction * self.projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			ApplyDamage(damage_table)
			
            unit:AddNewModifier(_self.Source, ability, "modifier_sniper_ultimate_hit", { duration = 0.1 }) -- Avoid dealing hit and aoe damage at the same time
			self:PlayEffectsTarget(_self.Source, unit, _self.current_position)
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
                local damage = {
                    victim = enemy,
                    attacker = caster,
                    damage = self.aoe_damage,
                    damage_type = DAMAGE_TYPE_PURE,
                }
            
                if not enemy:HasModifier("modifier_sniper_ultimate_hit") then
                    ApplyDamage(damage)
                end
                
                local x = enemy:GetOrigin().x - pos.x
                local y = enemy:GetOrigin().y - pos.y
        
                enemy:AddNewModifier(
                    caster,
                    self,
                    "modifier_sniper_ultimate_displacement",
                    {
                        x = x,
                        y = y,
                        r = self.radius,
                        speed = (self.radius/0.15),
                        peak = 0,
                    }
               )
            end
        
            CreateRadiusMarker(caster, pos, {
                show_all = 1,
                radius = self.radius
            })
            self:PlayEffectsExplosion(pos)
			self:PlayEffectsProjectileImpact(_self.Source, pos)
		end,
	}

    caster:FaceTowardsCustom(projectile_direction)
    Projectiles:CreateProjectile(projectile)
    EmitSoundOn("Ability.Assassinate", self:GetCaster())
end

function modifier_sniper_ultimate_channeling:OnDestroy()
    if IsServer() then
        self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)

        local effect_cast = ParticleManager:CreateParticle(
            "particles/mod_units/heroes/hero_sniper/techies_base_attack_smokeburst.vpcf", 
            PATTACH_CUSTOMORIGIN, 
            nil
       )
        ParticleManager:SetParticleControlEnt(
            effect_cast, 
            7, 
            self:GetCaster(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            self:GetCaster():GetOrigin() + Vector(0, 0, 96), 
            true 
       )
        ParticleManager:ReleaseParticleIndex(effect_cast)

        effect_cast = ParticleManager:CreateParticle(
            "particles/mod_units/heroes/hero_sniper/techies_base_attack_explosion.vpcf", 
            PATTACH_CUSTOMORIGIN, 
            nil
       )
        ParticleManager:SetParticleControlEnt(
            effect_cast, 
            0, 
            self:GetCaster(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            self:GetCaster():GetOrigin() + Vector(0, 0, 96), 
            true 
       )
        ParticleManager:SetParticleControlEnt(
            effect_cast, 
            3, 
            self:GetCaster(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            self:GetCaster():GetOrigin() + Vector(0, 0, 96), 
            true 
       )
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end

function modifier_sniper_ultimate_channeling:PlayEffectsProjectileImpact(source, pos)
	local caster = source
	EmitSoundOn("Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)

end

function modifier_sniper_ultimate_channeling:PlayEffectsTarget(source, hTarget, pos)
	local caster = source
	EmitSoundOnLocationWithCaster(pos, "Hero_Sniper.AssassinateDamage", caster)

	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)

	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end


function modifier_sniper_ultimate_channeling:PlayEffectsExplosion(pos)
    local particle_cast = "particles/econ/items/techies/techies_arcana/techies_suicide_arcana.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, pos)
    ParticleManager:SetParticleControl(effect_cast, 3, pos)
    ParticleManager:ReleaseParticleIndex(effect_cast)    
end

function modifier_sniper_ultimate_channeling:GetStatusLabel() return "Ultimate" end
function modifier_sniper_ultimate_channeling:GetStatusPriority() return 5 end
function modifier_sniper_ultimate_channeling:GetStatusStyle() return "Ultimate" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Channeling(modifier_sniper_ultimate_channeling)
Modifiers.Status(modifier_sniper_ultimate_channeling)
