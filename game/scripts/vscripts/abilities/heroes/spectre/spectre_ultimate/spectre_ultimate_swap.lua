spectre_ultimate_swap = class({})
spectre_ultimate_swap.illusions = {}

--------------------------------------------------------------------------------
function spectre_ultimate_swap:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()

    local allies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        point, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        FIND_UNITS_EVERYWHERE, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
        DOTA_UNIT_TARGET_HERO,	-- int, type filter
        0, -- int, flag filter
        FIND_CLOSEST, -- int, order filter
        false -- bool, can grow cache
    )
    
    local found = nil
    for _,ally in pairs(allies) do
        if found == nil then
            for _,illu in pairs(self.illusions) do
                if found == nil then
                    if illu == ally then
                        found = ally
                    end
                end
            end
        end
    end

    if found ~= nil then
        print(found:IsIllusion() and "true" or "false")
        FindClearSpaceForUnit( caster, found:GetOrigin() , true )
        FindClearSpaceForUnit( found, origin , true )
        self:PlayEffects()
    end
end

function spectre_ultimate_swap:AddIllusion( illusion_index )
    self.illusions[illusion_index] = EntIndexToHScript( illusion_index )
end

function spectre_ultimate_swap:CleanIllusions( illusion_index )
    self.illusions = {}
end

function spectre_ultimate_swap:PlayEffects()
    -- Get Resources
    EmitSoundOn( "Hero_Spectre.Reality", self:GetCaster() )

    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_ultimate_swap,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)