modifier_spectre_special_attack_thinker = class({})
LinkLuaModifier( "modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_special_attack_debuff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_thinker:OnCreated( kv )
    --load data
    self.max_distance = self:GetAbility():GetSpecialValueFor("projectile_range")
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
    self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
    self.distance = 0.0
    self.point = Vector(kv.x, kv.y, kv.z)

	if IsServer() then
        self:StartIntervalThink( 0.1 )
        ----local variables
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_special_attack_thinker:OnIntervalThink()

    self.distance = self.distance + (self.max_distance/10)

    if self.distance > self.max_distance then
        self.distance = self.max_distance
    end
    	
    local caster = self:GetCaster()
    local start_pos = self:GetParent():GetOrigin()
    local direction = Vector( self.point.x - start_pos.x, self.point.y - start_pos.y, 0 ):Normalized()
    local path_vector = direction * self.distance
	local end_pos = start_pos + path_vector
	local path_radius = 100
    
    -- DEBUG
    --self:PlayEffects(start_pos)
    --self:PlayEffects(end_pos)

    local allies = FindUnitsInLine(
		caster:GetTeamNumber(),
		start_pos,
		end_pos,
		nil,
		path_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
    )

    for _,ally in pairs(allies) do
        if ally == self:GetCaster() then
            ally:AddNewModifier(
                self:GetCaster(), 
                self:GetAbility(), 
                "modifier_spectre_special_attack_buff", 
                {duration =  self.buff_duration}
            )
        end
    end

    local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		start_pos,
		end_pos,
		nil,
		path_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
    )

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(
            self:GetCaster(), 
            self:GetAbility(), 
            "modifier_spectre_special_attack_debuff", 
            {duration =  self.debuff_duration}
        )
    end
    
end

function modifier_spectre_special_attack_thinker:PlayEffects(pos)
	-- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end