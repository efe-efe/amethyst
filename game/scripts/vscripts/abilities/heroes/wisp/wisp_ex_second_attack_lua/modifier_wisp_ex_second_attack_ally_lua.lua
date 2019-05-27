modifier_wisp_ex_second_attack_ally_lua = class({})
LinkLuaModifier( "modifier_wisp_ex_second_attack_ally_visuals_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_ally_visuals_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_second_attack_ally_speed_buff_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_ally_speed_buff_lua", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
function modifier_wisp_ex_second_attack_ally_lua:IsDebuff()
	return false
end

function modifier_wisp_ex_second_attack_ally_lua:IsHidden()
	return true
end

function modifier_wisp_ex_second_attack_ally_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_second_attack_ally_lua:OnCreated( kv )
	if IsServer() then
        --load data

        ----local variables
        local caster = self:GetCaster()
        local ability = self:GetAbility()
        
        ----modifier variables
        self.max_range = ability:GetSpecialValueFor("max_range")
        self.buff_duration = ability:GetSpecialValueFor("buff_duration")
        self.hTarget = self:GetParent()


        --apply modifiers

        ----visual
        self.visual_modifier = self.hTarget:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_wisp_ex_second_attack_ally_visuals_lua", -- modifier name
            { duration = self.buff_duration }
        )

        ----self speed buff
        self.speed_buff = self.hTarget:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_wisp_ex_second_attack_ally_speed_buff_lua", -- modifier name
            { duration = self.buff_duration }
        )

        ----caster speed buff
        self.speed_buff_caster = caster:AddNewModifier(
            caster, -- player source
            ability, -- ability source
            "modifier_wisp_ex_second_attack_ally_speed_buff_lua", -- modifier name
            { duration = self.buff_duration }
        )
        

		-- start check distance 
        self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wisp_ex_second_attack_ally_lua:OnIntervalThink()
    if IsServer() then
        local target_origin = self.hTarget:GetOrigin()
        local caster_origin = self:GetCaster():GetOrigin()
        local direction = (caster_origin - target_origin)
        local distance = direction:Length2D()

        if distance > self.max_range then
		    if not self.visual_modifier:IsNull() then
                self.visual_modifier:Destroy()
            end
		    if not self.speed_buff:IsNull() then
                self.speed_buff:Destroy()
            end
		    if not self.speed_buff_caster:IsNull() then
                self.speed_buff_caster:Destroy()
            end
            self:Destroy()
        end
    end
end
