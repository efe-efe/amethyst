modifier_spectre_special_attack_thinker_lua = class({})
LinkLuaModifier( "modifier_spectre_special_attack_buff_lua", "abilities/heroes/spectre/spectre_special_attack_lua/modifier_spectre_special_attack_buff_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_special_attack_debuff_lua", "abilities/heroes/spectre/spectre_special_attack_lua/modifier_spectre_special_attack_debuff_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_thinker_lua:OnCreated( kv )
	if IsServer() then
        --load data
        self.distance = self:GetAbility():GetSpecialValueFor("projectile_range")
        self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
        self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
        
        ----local variables
        local caster = self:GetCaster()
        local point = self:GetAbility():GetCursorPosition()
        local origin = caster:GetOrigin()
        self.direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
        
        self:StartIntervalThink( 0.1 )
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_special_attack_thinker_lua:OnIntervalThink()

    local caster = self:GetCaster()
    local start_pos = self:GetParent():GetOrigin()
    local path_vector = self.direction * self.distance
	local end_pos = start_pos + path_vector
	local path_radius = 100
    
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
                "modifier_spectre_special_attack_buff_lua", 
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
            "modifier_spectre_special_attack_debuff_lua", 
            {duration =  self.debuff_duration}
        )
    end
    
end