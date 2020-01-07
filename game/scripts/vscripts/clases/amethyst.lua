Amethyst = Amethyst or class({})

function Amethyst:constructor( index, delay_time )
    self.entities = Entities:FindAllByName("orb_spawn")
    self.origin = self.entities[index]:GetOrigin()
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
    self:Spawn( delay_time )

    self:GetUnit():AddNewModifier(
        self:GetUnit(),
        nil,
        "modifier_amethyst_base",
        {
            mana = mana_bounty,
            heal = heal_bounty,
        }
    )
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

function Amethyst:Hide()
    self:GetUnit():AddNoDraw()
    self:GetUnit():AddNewModifier(self:GetUnit(), nil, "modifier_hidden", {})
    self:GetUnit():SetAbsOrigin(Vector(0, 0, 10000))
end

function Amethyst:Unhide()
    self:GetUnit():RemoveNoDraw()
    self:GetUnit():RemoveModifierByName("modifier_hidden")
    self:GetUnit():SetAbsOrigin(Vector(self.origin.x, self.origin.y, self.origin.z))
end

function Amethyst:Spawn( delay_time )
    self:GetUnit():SetContextThink("Spawn", function()
        self:Unhide()

        local data = { unitIndex = self:GetUnit():GetEntityIndex() }
        CustomGameEventManager:Send_ServerToAllClients( "add_unit", data )    

        self:PlayEffectsOnSpawn()
    end, delay_time)
end

function Amethyst:Remove()
    self:GetUnit():AddNoDraw()
    UTIL_Remove(self:GetUnit())
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