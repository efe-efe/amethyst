modifier_spectre_special_attack_thinker = class({})
LinkLuaModifier( "modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_thinker:OnCreated( kv )
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
	self.path_radius = 100

    if IsServer() then
        self.start_pos = self:GetParent():GetOrigin()
        self.end_pos = Vector(kv.x, kv.y, kv.z)

        self:StartIntervalThink( 0.1 )
        ----local variables
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_special_attack_thinker:OnIntervalThink()
    -- DEBUG
    --self:PlayEffects(self.start_pos)
    --self:PlayEffects(self.end_pos)

    local units = FindUnitsInLine(
        self:GetCaster():GetTeamNumber(),
		self.start_pos,
		self.end_pos,
		nil,
		self.path_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
    )

    for _,unit in pairs(units) do
        if unit == self:GetCaster() then
            unit:AddNewModifier(
                self:GetCaster(), 
                self:GetAbility(), 
                "modifier_spectre_special_attack_buff", 
                {duration =  self.buff_duration}
            )
        end
    end
end

function modifier_spectre_special_attack_thinker:PlayEffects(pos)
	-- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end