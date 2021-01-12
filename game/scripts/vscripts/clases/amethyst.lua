GenericGem = GenericGem or class({}, nil, UnitEntity)
Amethyst = Amethyst or class({}, nil, GenericGem)
Zaphire = Zaphire or class({}, nil, GenericGem)
Ruby = Ruby or class({}, nil, GenericGem)
GemGenerator = GemGenerator or class({})

GemTypes = {
    AMETHYST = 0,
    ZAPHIRE = 1,
    RUBY = 2,
}

local GEM_LIGHT_PARTICLE = {
    [GemTypes.AMETHYST] = "particles/generic_gameplay/rune_arcane.vpcf",
    [GemTypes.ZAPHIRE] = "particles/generic_gameplay/rune_doubledamage.vpcf",
    [GemTypes.RUBY] = "particles/generic_gameplay/rune_haste.vpcf",
}

local GEM_COLOR = {
    [GemTypes.AMETHYST] = Vector(255, 26, 243),
    [GemTypes.ZAPHIRE] = Vector(26, 0, 255),
    [GemTypes.RUBY] = Vector(255, 26, 0),
}

function GenericGem:constructor(vOrigin)
    getbase(GenericGem).constructor(self, vOrigin, "npc_dota_creature_amethyst")

    local unit = self:GetUnit()
    unit:SetModel(self.model)
    unit:SetModelScale(self.scale)
    self:PlayEffectsOnSpawn()
end

function GenericGem:PlayEffectsOnSpawn()
    local unit = self:GetUnit()
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", unit)
    EFX("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, { release = true })
    EFX("particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit, { release = true })
    EFX(self.particle, PATTACH_ABSORIGIN_FOLLOW, unit, { release = true })
end

function GenericGem:OnDeath(params)
    local killer = params.killer

    if IsServer() then
        self:Effect(killer)
        self:PlayEffectsOnDeath()
        self:GetUnit():AddNoDraw()
        CustomEntities:GetAlliance(killer):AddAmethsyt()
	end

    self:Destroy()
end

function GenericGem:Effect()
    -- Override this method
end

function GenericGem:PlayEffectsOnDeath()
    local parent = self:GetUnit()
    local origin = parent:GetAbsOrigin()

    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", parent)
    
    EFX("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", PATTACH_WORLDORIGIN, nil, { 
        cp0 = origin,
        cp2 = Vector(255, 80, 230),
        release = true 
    })

    EFX("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", PATTACH_WORLDORIGIN, nil, { 
        cp0 = origin,
        cp5 = origin,
        release = true 
    })

    self:PlaySpecificEffectsOnDeath()
end

function GenericGem:PlaySpecificEffectsOnDeath()

end

function GenericGem:Update()
    local currentAngle = (GameRules:GetGameTime() % (math.pi * 2)) * 2.0

    if not CustomEntities:IsBanished(self:GetUnit()) then
        self:GetUnit():SetForwardVector(Vector(math.cos(currentAngle), math.sin(currentAngle)))
        self:GetUnit():SetModel(self.model)
        self:GetUnit():SetModelScale(self.scale)
    end
end

function Ruby:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_haste.vpcf"
    self.model = "models/items/furion/dark_staff/bulb.vmdl"
    self.scale = 0.5
    self.duration = 5.0
    self.energy_bounty = 70
    self.procs = 10

    getbase(Zaphire).constructor(self, vOrigin)
end

function Ruby:Effect(hKiller)
    local units = CustomEntities:FindUnitsInRadius(
        hKiller,
        self:GetUnit():GetAbsOrigin(), 
        FIND_UNITS_EVERYWHERE, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
        FIND_ANY_ORDER
    )

    local final_procs = math.ceil(self.procs / #units)
    local final_energy = math.ceil(self.energy_bounty / #units)

    for _,unit in pairs(units) do
        if unit:IsRealHero() then
            unit:AddNewModifier(unit, nil, "modifier_burning_attacks", { procs = final_procs })
            CustomEntities:GiveEnergy(unit, final_energy, true, true)
        end
    end
end

function Ruby:PlaySpecificEffectsOnDeath()
    EFX("particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = GetGroundPosition(self.origin, nil),
        release = true
    })
end

function Zaphire:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_doubledamage.vpcf"
    self.model = "models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl"
    self.scale = 4.0

    getbase(Zaphire).constructor(self, vOrigin)

    self.shield = 80
end

function Zaphire:Effect(hKiller)
    local units = CustomEntities:FindUnitsInRadius(
        hKiller,
        self:GetUnit():GetAbsOrigin(), 
        FIND_UNITS_EVERYWHERE, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
        FIND_ANY_ORDER
    )

    local final_shield = math.ceil(self.shield / #units)

    for _,unit in pairs(units) do
        if unit:IsRealHero() then
            unit:AddNewModifier(unit, nil, "modifier_shield", { duration = 10.0, damage_block = final_shield })
        end
    end
end

function Amethyst:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_arcane.vpcf"
    self.model = "models/heroes/oracle/crystal_ball.vmdl"
    self.scale = 3.0

    getbase(Amethyst).constructor(self, vOrigin)
    
    self.mana_bounty = 40
    self.heal_bounty = 20
end

function Amethyst:Effect(hKiller)
    local units = CustomEntities:FindUnitsInRadius(
        hKiller,
        self:GetUnit():GetAbsOrigin(), 
        FIND_UNITS_EVERYWHERE, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
        FIND_ANY_ORDER
    )

    local final_heal = self.heal_bounty / #units
    local final_mana = self.mana_bounty / #units

    for _,unit in pairs(units) do
        if unit:IsRealHero() then 
            TrueHeal(unit:GetHealth(), final_heal, unit)
            CustomEntities:GiveManaAndEnergy(unit, final_mana, true, true)
            self:PlayEffectsOnTarget(unit)
        end
    end
end

function Amethyst:PlayEffectsOnTarget(hTarget)
    EmitSoundOn("DOTA_Item.ArcaneBoots.Activate", hTarget)
    EFX("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget, { release = true })
    EFX("particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget, { 
        cp3 = hTarget:GetOrigin(),
        cp15 = Vector(115, 248, 255),
        cp16 = Vector(1, 0, 0),
        release = true 
    })
    EFX("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget, { 
        cp1 = hTarget:GetOrigin(),
        cp3 = hTarget:GetOrigin(),
        release = true 
    })
end

function GemGenerator:constructor(fDelayTime, vOrigin, iType)
    self.delay_time = fDelayTime * 30
    self.current_time = fDelayTime * 30
    self.light_delay_time = self.delay_time / 5

    if iType == nil then
        local index = RandomInt(0, 2)
        if index == 0 then
            self.type = GemTypes.AMETHYST
        end
        if index == 1 then
            self.type = GemTypes.ZAPHIRE
        end
        if index == 2 then
            self.type = GemTypes.RUBY
        end
    else
        self.type = iType
    end

    self.lights = {}
    self.origin = vOrigin
    self.progress_circle = nil
    self.entity = nil
    self.destroyed = false

    self:CreateLight() 
    self:CreateProgressCircle()
end

function GemGenerator:Alive()
    return not self.destroyed
end

function GemGenerator:Update()
    self.current_time = self.current_time - 1

    if self.current_time == 0 then
        if self.type == GemTypes.AMETHYST then
            self.entity = Amethyst(self.origin)
        end
        if self.type == GemTypes.ZAPHIRE then
            self.entity = Zaphire(self.origin)
        end
        if self.type == GemTypes.RUBY then
            self.entity = Ruby(self.origin)
        end
    end

    local percentage = (self.delay_time - self.current_time)/self.delay_time
    if percentage <= 1.0 then
        ParticleManager:SetParticleControl(self.progress_circle, 1, Vector(250, percentage, 0))
    end

    if math.fmod(self.current_time, self.light_delay_time) == 0 and #self.lights < 5 then
        self:CreateLight() 
    end

    if self.entity then
        if not self.entity:Alive() then
            self.entity = nil
            self.destroyed = true
            self:DestroyProgressCircle()
            self:CleanLights()
        else
            self.entity:Update()
        end
    end
end

function GemGenerator:CreateLight()
    local origin = self.origin + Vector(0, -1, 0) * 250
    origin = RotatePoint(self.origin, origin, 72 * #self.lights)

    local efx = EFX(GEM_LIGHT_PARTICLE[self.type], PATTACH_WORLDORIGIN, nil, {
        cp0 = GetGroundPosition(origin, nil),
        release = false
    })

    table.insert(self.lights, efx) 
end

function GemGenerator:CleanLights()
    for _,light in pairs(self.lights) do
        if light then
            ParticleManager:DestroyParticle(light, false)
            ParticleManager:ReleaseParticleIndex(light)
        end
    end
    self.lights = {}
end

function GemGenerator:CreateProgressCircle()
    self.progress_circle = EFX("particles/progress_circle/generic_progress_circle.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0f = Vector(0, -1, 0),
        cp0 = self.origin - Vector(0, 0, 120),
        cp1 = Vector(250, 0, 1),
        cp15 = GEM_COLOR[self.type],
        cp16 = Vector(1, 0, 0),
    })
end

function GemGenerator:Destroy(bRemove)
    if self.entity then
        self.entity:Destroy(bRemove)
    end
    self:DestroyProgressCircle()
    self:CleanLights()
end

function GemGenerator:DestroyProgressCircle()
    if self.progress_circle then
        ParticleManager:DestroyParticle(self.progress_circle, false)
        ParticleManager:ReleaseParticleIndex(self.progress_circle)
    end
end