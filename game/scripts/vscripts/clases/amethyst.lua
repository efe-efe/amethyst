FIRST_DELAY = 10.0
DELAY = 15.0

Amethyst = Amethyst or class({})

function Amethyst:constructor()
    self.entities = Entities:FindAllByName("orb_spawn")
    self.index = 1--self:GetSpawnIndex()
    self.origin = self.entities[self.index]:GetOrigin()
    self.mana_bounty = 40
    self.heal_bounty = 20

    self:SetUnit(CreateUnitByName(
        "npc_dota_creature_amethyst", --szUnitName
        self.origin, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    ))

    self:Hide()
    self:Spawn()

    --[[
    self:GetUnit():AddNewModifier(
        self:GetUnit(),
        nil,
        "modifier_amethyst_base",
        {
            mana = mana_bounty,
            heal = heal_bounty,
        }
    )
]]
end

function Amethyst:SetUnit(unit)
	self.unit = unit

    self.unit.GetParentEntity = function(unit)
        return self
    end
end

function Amethyst:GetUnit()
    return self.unit
end

function Amethyst:GetSpawnIndex()
    if GetMapName() == "forest_map" or GetMapName() == "free_for_all" then
        return 1 
    else
        return RandomInt(1, 3)
    end
end

function Amethyst:Hide()
    self:GetUnit():AddNoDraw()
    self:GetUnit():AddNewModifier(self:GetUnit(), nil, "modifier_hidden", {})
    self:GetUnit():SetAbsOrigin(Vector(0, 0, 10000))
end

function Amethyst:Unhide()
    self:GetUnit():RemoveNoDraw()
    self:GetUnit():RemoveModifierByName("modifier_hidden")
    self:GetUnit():SetAbsOrigin(Vector(self.origin.x, self.origin.y, self.origin.z ))
end

function Amethyst:Spawn()
    self:GetUnit():SetContextThink("Spawn", function()
        self:Unhide()

        local data = { unitIndex = self:GetUnit():GetEntityIndex() }
        CustomGameEventManager:Send_ServerToAllClients( "add_unit", data )    

        self:PlayEffectsOnSpawn()
    end, FIRST_DELAY)
end

function Amethyst:PlayEffectsOnSpawn()
    EmitSoundOn( "Hero_Oracle.FortunesEnd.Target", self:GetUnit() )

    local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
    local particle_cast_c = "particles/generic_gameplay/rune_arcane.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )
    local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )

    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
    ParticleManager:ReleaseParticleIndex( effect_cast_c )
end