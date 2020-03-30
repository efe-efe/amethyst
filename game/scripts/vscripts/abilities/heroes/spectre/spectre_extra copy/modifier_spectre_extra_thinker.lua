modifier_spectre_extra_thinker = class({})
LinkLuaModifier( "modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_extra_recast", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_recast", LUA_MODIFIER_MOTION_NONE )

function modifier_spectre_extra_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
    self.recast_time = self:GetAbility():GetSpecialValueFor("recast_time")

    if IsServer() then
        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_spectre_extra_thinker:OnIntervalThink()
    local thinker_origin = self:GetParent():GetOrigin()

    local enemies = self:GetCaster():FindUnitsInRadius( 
        thinker_origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    local data =  { duration = self.recast_time }
    local counter = 0

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(
            self:GetCaster(),
            self:GetAbility(),
            "modifier_spectre_extra",
            { duration = self.recast_time }
        )
        data["enemy_" .. counter] = enemy:GetEntityIndex()
        counter = counter + 1
    end

    if #enemies > 0 then
        self:GetCaster():AddNewModifier(
            self:GetCaster(),
            self:GetAbility(),
            "modifier_spectre_extra_recast",
            data
        )
    end
    
    self:PlayEffects()
    self:Destroy()
end

function modifier_spectre_extra_thinker:PlayEffects()
    EmitSoundOn( "Hero_Spectre.Reality", self:GetParent() )
    local particle_cast = "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_marker.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( effect_cast, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


