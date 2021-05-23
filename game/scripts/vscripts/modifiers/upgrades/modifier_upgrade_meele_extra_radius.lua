modifier_upgrade_meele_extra_radius = class({})

function modifier_upgrade_meele_extra_radius:RemoveOnDeath() return false end
function modifier_upgrade_meele_extra_radius:IsPurgable() return false end

function modifier_upgrade_meele_extra_radius:GetExtraRadius()
    return 95
end