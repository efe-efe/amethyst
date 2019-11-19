spectre_ultimate_recast = class({})
spectre_ultimate_recast.illusions = {}

--------------------------------------------------------------------------------
function spectre_ultimate_recast:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()

    local allies = self:GetCaster():FindUnitsInRadius( 
        point, 
        FIND_UNITS_EVERYWHERE, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_ALL, 
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        FIND_CLOSEST
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
        FindClearSpaceForUnit( caster, found:GetOrigin() , true )
        FindClearSpaceForUnit( found, origin , true )
        self:PlayEffects()
    end
end

function spectre_ultimate_recast:AddIllusion( illusion_index )
    self.illusions[illusion_index] = EntIndexToHScript( illusion_index )
end

function spectre_ultimate_recast:CleanIllusions( illusion_index )
    self.illusions = {}
end

function spectre_ultimate_recast:PlayEffects()
    -- Get Resources
    EmitSoundOn( "Hero_Spectre.Reality", self:GetCaster() )

    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_ultimate_recast,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)