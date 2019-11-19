modifier_vengeful_second_attack = class({})

function modifier_vengeful_second_attack:OnCreated( params )

    if IsServer() then
        local ability = self:GetCaster():FindAbilityByName("vengeful_second_attack")
        self.extra_damage = ability:GetSpecialValueFor("extra_damage")

        self:GetParent():AddStatusBar({
            label = "vengance", modifier = self, priority = 2, stylename="Vengance"
        }) 
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_second_attack:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_vengeful_second_attack:GetModifierIncomingDamage_Percentage( params )
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
    
                ApplyDamage( damage_table )
                self:Destroy()
                self:PlayEffectsExplosion()
            end
        end
        return 0
	end
end

function modifier_vengeful_second_attack:PlayEffectsExplosion()
    local parent = self:GetParent()

	local particle_cast = "particles/econ/items/templar_assassin/templar_assassin_butterfly/templar_assassin_trap_explosion_shock_butterfly.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, parent )
	ParticleManager:SetParticleControl( effect_cast, 1, parent:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end