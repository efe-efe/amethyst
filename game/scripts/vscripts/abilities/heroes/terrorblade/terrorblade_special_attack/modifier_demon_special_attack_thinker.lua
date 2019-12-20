modifier_demon_special_attack_thinker = class({})

function modifier_demon_special_attack_thinker:OnCreated()
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        
        self:PlayEffectsOnCast()
        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_demon_special_attack_thinker:OnDestroy()
    if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_demon_special_attack_thinker:OnIntervalThink()
    local caster = self:GetCaster()

    local enemies = caster:FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self:GetAbility(), "modifier_generic_confused", { duration = self.duration })

        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage( damage )

        self:PlayEffects(enemy)
    end

    self:Destroy()
end


function modifier_demon_special_attack_thinker:PlayEffects(hTarget)
    local caster = self:GetCaster()
    EmitSoundOn("Hero_Terrorblade.Reflection", hTarget)

    local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_reflection_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		caster:GetOrigin(), 
		true 
	);
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		1, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
    );
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_demon_special_attack_thinker:PlayEffectsOnCast()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_disruption_refract.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex(effect_cast)
    
    particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 2, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(self.radius, 0, 0) )
    ParticleManager:ReleaseParticleIndex(effect_cast)
end