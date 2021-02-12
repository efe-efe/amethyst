GenericGem = GenericGem or class({}, nil, UnitEntity)
Amethyst = Amethyst or class({}, nil, GenericGem)
Sapphire = Sapphire or class({}, nil, GenericGem)
Ruby = Ruby or class({}, nil, GenericGem)
Emerald = Emerald or class({}, nil, GenericGem)
GemGenerator = GemGenerator or class({})

GemTypes = {
    NO_TYPE = -1,
    AMETHYST = 0,
    SAPPHIRE = 1,
    RUBY = 2,
    EMERALD = 3,
}

local GEM_LIGHT_PARTICLE = {
    [GemTypes.AMETHYST] = "particles/generic_gameplay/rune_arcane.vpcf",
    [GemTypes.SAPPHIRE] = "particles/generic_gameplay/rune_doubledamage.vpcf",
    [GemTypes.RUBY] = "particles/generic_gameplay/rune_haste.vpcf",
    [GemTypes.EMERALD] = "particles/generic_gameplay/rune_regeneration.vpcf",
}

local GEM_COLOR = {
    [GemTypes.AMETHYST] = Vector(255, 26, 243),
    [GemTypes.SAPPHIRE] = Vector(0, 101, 255),
    [GemTypes.RUBY] = Vector(255, 26, 0),
    [GemTypes.EMERALD] = Vector(26, 255, 0),
}

function GenericGem:constructor(vOrigin)
    getbase(GenericGem).constructor(self, vOrigin, "npc_dota_creature_amethyst")
    self.max_health = 100
    self.type = -1

    local unit = self:GetUnit()
    unit:SetModel(self.model)
    unit:SetModelScale(self.scale)
    unit:SetMaxHealth(self.max_health)
    unit:SetBaseMaxHealth(self.max_health)
    unit:SetHealth(self.max_health)
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

function GenericGem:GetUnits(hSearcher, iTeamFlags)
    return CustomEntities:FindUnitsInRadius(
        hSearcher,
        self:GetUnit():GetAbsOrigin(), 
        FIND_UNITS_EVERYWHERE, 
        iTeamFlags, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
        FIND_ANY_ORDER
    )
end

function GenericGem:GetAllies(hSearcher)
    return self:GetUnits(hSearcher, DOTA_UNIT_TARGET_TEAM_FRIENDLY)
end

function GenericGem:GetHeroes()
    return self:GetUnits(self:GetUnit(), DOTA_UNIT_TARGET_TEAM_BOTH)
end

function GenericGem:ProcessValue(tAllies, tHeroes, fValue)
    return math.ceil(#tHeroes * fValue/#tAllies)
end

function Ruby:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_haste.vpcf"
    self.model = "models/items/furion/dark_staff/bulb.vmdl" --"models/heroes/oracle/weapon.vmdl" DIAMOND?
    self.scale = 0.5
    self.duration = 10.0
    self.energy_bounty = 25
    self.damage = 3
    self.type = GemTypes.RUBY

    getbase(Ruby).constructor(self, vOrigin)
end

function Ruby:Effect(hKiller)
    local allies = self:GetAllies(hKiller)
    local heroes = self:GetHeroes()
    local final_damage = self:ProcessValue(allies, heroes, self.damage)
    local final_energy = self:ProcessValue(allies, heroes, self.energy_bounty)

    for _,unit in pairs(allies) do
        if unit:IsRealHero() then
            unit:AddNewModifier(unit, nil, "modifier_ruby", { 
                duration = self.duration,
                damage = final_damage 
            })
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

function Sapphire:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_doubledamage.vpcf"
    self.model = "models/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_sphere.vmdl"
    self.scale = 4.0

    getbase(Sapphire).constructor(self, vOrigin)

    self.shield = 20
    self.duration = 10.0
    self.type = GemTypes.SAPPHIRE
end

function Sapphire:Effect(hKiller)
    local allies = self:GetAllies(hKiller)
    local heroes = self:GetHeroes()
    local final_shield = self:ProcessValue(allies, heroes, self.shield)

    for _,unit in pairs(allies) do
        if unit:IsRealHero() then
            unit:AddNewModifier(unit, nil, "modifier_sapphire", { 
                duration = self.duration, 
                damage_block = final_shield
            })
        end
    end
end

function Amethyst:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_arcane.vpcf"
    self.model = "models/heroes/oracle/crystal_ball.vmdl"
    self.scale = 3.0

    getbase(Amethyst).constructor(self, vOrigin)
    
    self.mana_bounty = 25
    self.heal_bounty = 5
    self.type = GemTypes.AMETHYST
end

function Amethyst:Effect(hKiller)
    local allies = self:GetAllies(hKiller)
    local heroes = self:GetHeroes()

    local final_mana = self:ProcessValue(allies, heroes, self.mana_bounty)
    local final_heal = self:ProcessValue(allies, heroes, self.heal_bounty)


    for _,unit in pairs(allies) do
        if unit:IsRealHero() then
            CustomEntities:RefreshCooldowns(unit)
            CustomEntities:TrueHeal(unit, final_heal)
            CustomEntities:GiveManaCustom(unit, final_mana, true, true)
            self:PlayEffectsOnTarget(unit)
        end
    end
end

function Amethyst:PlayEffectsOnTarget(hTarget)
    EmitSoundOn("DOTA_Item.Refresher.Activate", hTarget)
    EFX("particles/items_fx/arcane_boots_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget, { release = true })
    EFX("particles/gems/amethyst.vpcf", PATTACH_CUSTOMORIGIN, hTarget, {
		cp0 = {
			ent = hTarget,
			point = 'attach_hitloc'
		},
        release = true 
    })
    EFX("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget, { 
        cp1 = hTarget:GetAbsOrigin(),
        cp3 = hTarget:GetAbsOrigin(),
        release = true 
    })
end

function Emerald:constructor(vOrigin)
    self.particle = "particles/generic_gameplay/rune_regeneration.vpcf"
    self.model = "models/items/rubick/rubick_arcana/rubick_arcana_cube.vmdl"
    self.scale = 0.45

    getbase(Emerald).constructor(self, vOrigin + Vector(0, 0, 64))

    self.heal_per_second = 2
    self.true_heal = 10
    self.duration = 8.0
    self.type = GemTypes.EMERALD
end

function Emerald:Effect(hKiller)
    local allies = self:GetAllies(hKiller)
    local heroes = self:GetHeroes()
    local final_true_heal = self:ProcessValue(allies, heroes, self.true_heal)
    local final_heal_per_second = self:ProcessValue(allies, heroes, self.heal_per_second)

    for _,unit in pairs(allies) do
        if unit:IsRealHero() then
            CustomEntities:TrueHeal(unit, final_true_heal)
            
            unit:AddNewModifier(unit, nil, "modifier_emerald", { 
                duration = self.duration, 
                heal_per_second = final_heal_per_second
            })

            EFX('particles/gems/emerald.vpcf', PATTACH_ABSORIGIN_FOLLOW, unit, {
                cp3 = {
                    ent = unit,
                    point = 'attach_hitloc'
                },
                release = true,
            })
        end
    end
end

function GemGenerator:constructor(fDelayTime, vOrigin, iType)
    self.delay_time = fDelayTime * 30
    self.current_time = fDelayTime * 30
    self.light_delay_time = self.delay_time / 5

    if iType == nil then
        self.type = RandomInt(GemTypes.AMETHYST, GemTypes.EMERALD)
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
        if self.type == GemTypes.SAPPHIRE then
            self.entity = Sapphire(self.origin)
        end
        if self.type == GemTypes.RUBY then
            self.entity = Ruby(self.origin)
        end
        if self.type == GemTypes.EMERALD then
            self.entity = Emerald(self.origin)
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

function GemGenerator:GetColor()
    return GEM_COLOR[self.type]
end