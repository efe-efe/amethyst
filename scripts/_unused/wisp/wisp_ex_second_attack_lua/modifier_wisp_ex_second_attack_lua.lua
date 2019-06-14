modifier_wisp_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_generic_fading_slow_lua", "abilities/generic/modifier_generic_fading_slow_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_silenced_lua", "abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_second_attack_visuals_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_second_attack_aspd_buff_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_aspd_buff_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function modifier_wisp_ex_second_attack_lua:IsDebuff()
	return false
end

function modifier_wisp_ex_second_attack_lua:IsHidden()
	return true
end

function modifier_wisp_ex_second_attack_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_second_attack_lua:OnCreated( kv )
	if IsServer() then
        --load data

        ----local variables
        local caster = self:GetCaster()
        local ability = self:GetAbility()
        
        ----modifier variables
        self.max_range = ability:GetSpecialValueFor("max_range")
        self.debuff_duration = ability:GetSpecialValueFor("debuff_duration")
        self.hTarget = self:GetParent()

        --apply modifiers

        ----visual
        self.visual_modifier = self.hTarget:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_wisp_ex_second_attack_visuals_lua", -- modifier name
            { duration = self.debuff_duration }
        )

        ----slow
        self.fading_slow_modifier = caster:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_generic_fading_slow_lua", -- modifier name
            { duration = self.debuff_duration }
        )

        ----aspd
        self.aspd_buff_modifier = caster:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_wisp_ex_second_attack_aspd_buff_lua", -- modifier name
            { duration = self.debuff_duration }
        )

        ----silence
        self.silence_modifier = self.hTarget:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_generic_silenced_lua", -- modifier name
            { duration = self.debuff_duration }
		)

		-- start check distance 
        self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wisp_ex_second_attack_lua:OnIntervalThink()
    if IsServer() then
        local target_origin = self.hTarget:GetOrigin()
        local caster_origin = self:GetCaster():GetOrigin()
        local direction = (caster_origin - target_origin)
        local distance = direction:Length2D()

        if distance > self.max_range then
		    if not self.fading_slow_modifier:IsNull() then
                self.fading_slow_modifier:Destroy()
            end
		    if not self.visual_modifier:IsNull() then
                self.visual_modifier:Destroy()
            end
		    if not self.silence_modifier:IsNull() then
                self.silence_modifier:Destroy()
            end
		    if not self.aspd_buff_modifier:IsNull() then
                self.aspd_buff_modifier:Destroy()
            end
            self:Destroy()
        end
    end
end