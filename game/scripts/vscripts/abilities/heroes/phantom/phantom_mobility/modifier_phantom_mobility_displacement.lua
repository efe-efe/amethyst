modifier_phantom_mobility_displacement = class({})

function modifier_phantom_mobility_displacement:OnCreated(params)
	if IsServer() then
		self.origin = self:GetParent():GetAbsOrigin()
        self.damage_table = {
            attacker = self:GetParent(),
            damage_type = DAMAGE_TYPE_PHYSICAL,
        }
	end
end

function modifier_phantom_mobility_displacement:OnDestroy()
	if IsServer() then 
		local trail_pfx = ParticleManager:CreateParticle("particles/phantom/mobility_trail.vpcf", PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
		ParticleManager:SetParticleControl(trail_pfx, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(trail_pfx, 60, Vector(188,7,229))
		ParticleManager:SetParticleControl(trail_pfx, 61, Vector(1,0,0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)
	end
end


function modifier_phantom_mobility_displacement:OnCollide(params)
	if IsServer() then
		local parent = self:GetParent()
		local ability = self:GetAbility()

		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				if not unit:HasModifier("modifier_phantom_mobility_debuff") then
					unit:AddNewModifier(parent, ability, "modifier_phantom_mobility_debuff", { duration = 0.5 })

					
    				local shard = CustomEntitiesLegacy:SafeGetModifier(parent, "modifier_upgrade_phantom_dash_damage")
					if shard then
						self.damage_table.damage = shard:GetDamage()
						self.damage_table.victim = unit
						ApplyDamage(self.damage_table)
					end

					local shield_modifier = CustomEntitiesLegacy:SafeGetModifier(parent, "modifier_upgrade_phantom_dash_shield")
					if shield_modifier then
						parent:AddNewModifier(parent, ability, "modifier_phantom_mobility_shield", { duration = 5.0, damage_block = shield_modifier:GetDamageBlock() })
					end
				end
			end
		end
	end
end

function modifier_phantom_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_phantom_mobility_displacement:GetOverrideAnimation() 		return ACT_DOTA_CAST_ABILITY_2 end
function modifier_phantom_mobility_displacement:GetOverrideAnimationRate() 	return 1.5 end

function modifier_phantom_mobility_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end


function modifier_phantom_mobility_displacement:GetCollisionRadius()
	return 120
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_phantom_mobility_displacement)
Modifiers.Animation(modifier_phantom_mobility_displacement)