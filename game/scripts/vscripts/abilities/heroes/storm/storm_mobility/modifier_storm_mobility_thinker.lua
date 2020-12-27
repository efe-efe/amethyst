modifier_storm_mobility_thinker = class({})

function modifier_storm_mobility_thinker:OnCreated(params)
    if IsServer() then
        self.parent = self:GetParent()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.origin = self.parent:GetAbsOrigin()
        self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")

		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}

        self:StartIntervalThink(0.03)

        CreateRadiusMarker(self:GetCaster(), self.origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
        self:PlayEffectsOnCreated()
	end
end

function modifier_storm_mobility_thinker:OnIntervalThink()
    local enemies = self:GetCaster():FindUnitsInRadius(
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    local give_mana = false

    for _,enemy in pairs(enemies) do
        self.damage_table.victim = enemy
        ApplyDamage(self.damage_table)

        
        if enemy:ProvidesMana() then
            give_mana = true
        end
    end

    if give_mana then
        self:GetCaster():GiveManaAndEnergyPercent(self.mana_gain_pct, true)
        if self:GetCaster():HasModifier('modifier_storm_ultimate') then
            local extra_mana_pct = self.mana_gain_pct * (self:GetCaster():FindModifierByName('modifier_storm_ultimate'):GetManaMultiplier() - 1)
            self:GetCaster():GiveManaPercent(extra_mana_pct, true, true)
        end
    end

    if #enemies > 0 then
        self:Destroy()
    end
end

function modifier_storm_mobility_thinker:OnDestroy()
    if IsServer() then
        EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", self.parent)
        DEFX(self.efx)

        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end

        UTIL_Remove(self.parent)
	end
end

function modifier_storm_mobility_thinker:PlayEffectsOnCreated()
    self.efx = ParticleManager:CreateParticle('particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf', PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.efx, 0, self.origin)

    --[[
    self.efx = EFX('particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf', PATTACH_WORLDORIGIN, self:GetCaster(), {
        cp0 = self.origin,
        cp2 = Vector(RandomInt(37, 52), 1, 100),
        cp11 = self.origin,
    })
    ]]

    ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self.origin, true)
    ParticleManager:SetParticleControl(self.efx, 2, Vector(RandomInt(37, 52), 1, 100) )
    ParticleManager:SetParticleControl(self.efx, 11, self.origin)
    
	ParticleManager:SetParticleControlForward(self.efx, 0, self:GetCaster():GetForwardVector())
end