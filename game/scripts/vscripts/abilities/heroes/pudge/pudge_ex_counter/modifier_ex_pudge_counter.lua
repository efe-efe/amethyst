modifier_ex_pudge_counter = class({})
LinkLuaModifier( "modifier_ex_pudge_counter_debuff", "abilities/heroes/pudge/pudge_ex_counter/modifier_ex_pudge_counter_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_ex_pudge_counter:OnCreated()
    if IsServer() then
        self.caster = self:GetCaster()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.ability = self:GetAbility()
        self.self_damage_per_tick = self:GetAbility():GetSpecialValueFor("self_damage_per_second")/2
        self.damage_per_tick = self:GetAbility():GetSpecialValueFor("damage_per_second")/2
        self.interval = 0.5
        self.origin =  self.caster:GetOrigin()
        self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")

        self:GetParent():AddStatusBar({
            label = "Putrefaction", modifier = self, priority = 3, stylename="Infection"
        })

        self:StartIntervalThink(self.interval)
        self:PlayEffectsOnCreated()
    end
end

function modifier_ex_pudge_counter:OnDestroy()
    if IsServer() then
        self:StopEffectsOnCreated()
    end
end

function modifier_ex_pudge_counter:OnIntervalThink()
    self.origin = self.caster:GetOrigin()

    local enemies = self.caster:FindUnitsInRadius( 
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(self.caster, self.ability, "modifier_ex_pudge_counter_debuff", { duration = self.interval } )
    end

    local current_health = self.caster:GetHealth()

    local damage_table = {
        victim = self.caster,
        attacker = self.caster,
        damage_type = DAMAGE_TYPE_PURE,
    }

    if current_health - self.self_damage_per_tick <= 0 then
        damage_table.damage = current_health - 1
    else
        damage_table.damage = self.self_damage_per_tick
    end

    ApplyDamage( damage_table )

    self:PlayEffectsAoe()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ex_pudge_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_ex_pudge_counter:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

function modifier_ex_pudge_counter:PlayEffectsOnCreated()
    EmitSoundOn( "Hero_Pudge.Rot", self.caster )
    local particle_cast = "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot.vpcf"
    self.effect_cast_self = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster )
    ParticleManager:SetParticleControl( self.effect_cast_self, 1, Vector(self.radius, 0,0) )

    particle_cast = "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot_gold.vpcf"
    self.effect_cast_self_b = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster )
    ParticleManager:SetParticleControl( self.effect_cast_self_b, 1, Vector(self.radius, 0,0) )
end

function modifier_ex_pudge_counter:StopEffectsOnCreated()
    ParticleManager:DestroyParticle(self.effect_cast_self, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_self)

    
    ParticleManager:DestroyParticle(self.effect_cast_self_b, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast_self_b)
    StopSoundOn( "Hero_Pudge.Rot", self.caster )
end

function modifier_ex_pudge_counter:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end
