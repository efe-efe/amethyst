modifier_vengeful_second_attack = class({})

function modifier_vengeful_second_attack:OnCreated(params)
    if IsServer() then
        self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")
    end
end

function modifier_vengeful_second_attack:DeclareFunctions()
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end

function modifier_vengeful_second_attack:GetModifierIncomingDamage_Percentage(params)
    if IsServer() then
        if params.attacker ~= self:GetCaster() then return 0 end
        if params.inflictor then
            if params.inflictor:GetName() ~= "vengeful_basic_attack" then
                local damage_table = {
                    victim = self:GetParent(),
                    attacker = self:GetCaster(),
                    damage = self.extra_damage,
                    damage_type = DAMAGE_TYPE_PURE,
                }
    
                ApplyDamage(damage_table)
                self:PlayEffectsExplosion()
                self:Destroy()
            end
        end
        return 0
	end
end

function modifier_vengeful_second_attack:PlayEffectsExplosion()
	local efx = ParticleManager:CreateParticle("particles/econ/items/templar_assassin/templar_assassin_butterfly/templar_assassin_trap_explosion_shock_butterfly.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(efx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(efx)
end

function modifier_vengeful_second_attack:GetStatusLabel() return "Revenge" end
function modifier_vengeful_second_attack:GetStatusPriority() return 4 end
function modifier_vengeful_second_attack:GetStatusStyle() return "Revenge" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_vengeful_second_attack)