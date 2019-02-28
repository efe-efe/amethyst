--============================================================================================
-- INSTANTIATE MIDDLE ORB
--============================================================================================
if MiddleOrb == nil then
    DebugPrint( '[RITE] creating MiddleOrb module' )
    _G.MiddleOrb = class({})
end

function MiddleOrb:CreateMiddleOrb( spawnTime )
    DebugPrint("[RITE] Creating Middle Orb")

	local orb_spawn = Entities:FindByName(nil, "orb_spawn")
    local orb_position = orb_spawn:GetOrigin()

	local orb_timer1 = Entities:FindByName(nil, "orb_timer1"):GetOrigin()
	local orb_timer2 = Entities:FindByName(nil, "orb_timer2"):GetOrigin()
	local orb_timer3 = Entities:FindByName(nil, "orb_timer3"):GetOrigin()
	local orb_timer4 = Entities:FindByName(nil, "orb_timer4"):GetOrigin()
	local orb_timer5 = Entities:FindByName(nil, "orb_timer5"):GetOrigin()

    local visualTimerTime = spawnTime/6

    --Create the visual timers
    self:CreateMiddleOrbTimer(visualTimerTime, orb_timer1)
    self:CreateMiddleOrbTimer(visualTimerTime*2, orb_timer2)
    self:CreateMiddleOrbTimer(visualTimerTime*3, orb_timer3)
    self:CreateMiddleOrbTimer(visualTimerTime*4, orb_timer4)
    self:CreateMiddleOrbTimer(visualTimerTime*5, orb_timer5)

	Timers:CreateTimer(spawnTime,
        function()
            middle_orb = CreateUnitByName(
                "npc_dota_creature_middle_orb", --szUnitName
                orb_position, --vLocation
                true, --bFindClearSpace
                nil, --hNPCOwner
                nil, --hUnitOwner
                7
            )

            middle_orb:Attribute_SetIntValue("middle_orb", 1)
            middle_orb:SetOrigin(orb_position)

            -- Orb Spawn Effects
            local particle_cast = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
            local particle_cast2 = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
            
            local sound_cast = "Hero_Oracle.FortunesEnd.Target"
            local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
            local effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, middle_orb )
            
            ParticleManager:ReleaseParticleIndex( effect_cast )
            ParticleManager:ReleaseParticleIndex( effect_cast2 )
            EmitSoundOn( sound_cast, middle_orb )
		end
	)
end

function MiddleOrb:CreateMiddleOrbTimer(time, location)
    Timers:CreateTimer(time, 
        function() 
            local middle_orb_timer = CreateUnitByName(
                "npc_dota_creature_middle_orb_timer", --szUnitName
                location, --vLocation
                true, --bFindClearSpace
                nil, --hNPCOwner
                nil, --hUnitOwner
                7
            )
            middle_orb_timer:SetOrigin(location)
        end
    )
end
