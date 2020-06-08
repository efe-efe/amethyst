modifier_ancient_ex_special_attack_thinker = class({})
LinkLuaModifier("modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Initializations
function modifier_ancient_ex_special_attack_thinker:OnCreated(kv)
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
	self.radius = 100
    self.initialized = false

    if IsServer() then
        self:StartIntervalThink(0.05)
        self:PlayEffects()

        self.wall = CreateUnitByName(
            "npc_dota_creature_wall", --szUnitName
            self:GetParent():GetOrigin(), --vLocation
            false, --bFindClearSpace
            nil, --hNPCOwner
            nil, --hUnitOwner
            self:GetParent():GetTeamNumber()
       )
        self.wall:Attribute_SetIntValue("wall", 1)
        self.wall:SetHullRadius(65)
        self.wall:AddNewModifier(self:GetParent(), self:GetAbility(), "wall_base", { fow_blocker = nil, no_draw = 1, invulnerable = 1 })
    end
end

function modifier_ancient_ex_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self.wall)
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_ancient_ex_special_attack_thinker:OnIntervalThink()
    if not self.initialized then
        
        local units = self:GetCaster():FindUnitsInRadius(
            self:GetParent():GetOrigin(), 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_BOTH, 
            DOTA_UNIT_TARGET_HERO, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
       )

        for _,unit in pairs(units) do
            FindClearSpaceForUnit(unit, self:GetParent():GetOrigin(), true)
        end

        self.initialized = true
    end
end

function modifier_ancient_ex_special_attack_thinker:PlayEffects(pos)
    local pos = self:GetParent():GetOrigin()
    local particle_cast = "particles/econ/items/tuskarr/tusk_ti5_immortal/tusk_ice_shards_projectile_stout_model_swirls.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, pos)
    ParticleManager:SetParticleControl(self.effect_cast, 3, pos)
    
	-- Get Resources
	particle_cast = "particles/units/heroes/hero_jakiro/jakiro_ice_path_shards.vpcf"
	self.effect_cast_dark = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast_dark, 0, pos)
	ParticleManager:SetParticleControl(self.effect_cast_dark, 1, pos)
	ParticleManager:SetParticleControl(self.effect_cast_dark, 2, Vector(self:GetDuration(), 0,0))
end


function modifier_ancient_ex_special_attack_thinker:StopEffects()
    if self.effect_cast then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end

    if self.effect_cast_dark then
        ParticleManager:DestroyParticle(self.effect_cast_dark, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast_dark)
    end
end