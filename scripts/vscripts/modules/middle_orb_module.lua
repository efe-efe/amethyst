--============================================================================================
-- INSTANTIATE MIDDLE ORB
--============================================================================================
if MiddleOrb == nil then
    DebugPrint( '[RITE] creating MiddleOrb module' )
    _G.MiddleOrb = class({})
end

function MiddleOrb:Create()
    DebugPrint("[RITE] Creating Middle Orb")

	local orb_spawn = Entities:FindByName(nil, "orb_spawn")
    local orb_position = orb_spawn:GetOrigin()

    self.instance = CreateUnitByName(
        "npc_dota_creature_middle_orb", --szUnitName
        orb_position, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    )
    self.instance:Attribute_SetIntValue("middle_orb", 1)

    -- Orb Spawn Effects
    local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
    
    local sound_cast = "Hero_Oracle.FortunesEnd.Target"
    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
    
    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
    EmitSoundOn( sound_cast, middle_orb )
end



function MiddleOrb:Destroy()
    if self.instance ~= nil then
        self.instance:Kill(nil, self.instance)
    end
end