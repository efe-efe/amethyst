puck_special_attack_recast = class({})

function puck_special_attack_recast:GetCastPointSpeed()    return 0 end

function puck_special_attack_recast:OnSpellStart()
    FindClearSpaceForUnit(self:GetCaster(), self.projectile.current_position, true)
    EmitSoundOn("Hero_Puck.EtherealJaunt", self:GetCaster())
    
	StopSoundOn("Hero_Puck.Illusory_Orb", self:GetCaster())
    self.projectile:Destroy(false)
end

function puck_special_attack_recast:SetProjectile(projectile)
    if IsServer() then
        self.projectile = projectile
    end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_special_attack_recast)