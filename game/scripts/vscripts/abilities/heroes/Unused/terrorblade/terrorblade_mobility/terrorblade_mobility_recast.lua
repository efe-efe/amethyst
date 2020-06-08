terrorblade_mobility_recast = class({})
terrorblade_mobility_recast.illusion_index = nil

function terrorblade_mobility_recast:SetIllusionIndex(illusion_index)
	self.illusion_index = illusion_index
end

function terrorblade_mobility_recast:GetIllusionIndex()
	return self.illusion_index
end

function terrorblade_mobility_recast:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local ability = caster:FindAbilityByName("terrorblade_mobility")
	local damage = ability:GetSpecialValueFor("ability_damage")
    local illusion = EntIndexToHScript(self:GetIllusionIndex())
	
    if illusion then
		local counter = 0
		local enemies = caster:FindUnitsInLine(
			origin, 
			illusion:GetOrigin(), 
			100, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE
		)
		caster:FindModifierByName("modifier_terrorblade_base"):SwapState()
		
		for _,enemy in pairs(enemies) do
			local damage_table = {
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage_table)
		end

		self:PlayEffectsOnCast(illusion)
		Timers:CreateTimer(0.001, function()
			if illusion then
				local modifier = illusion:FindModifierByName("modifier_terrorblade_mobility_illusion")
				if modifier ~= nil then
					if not modifier:IsNull() then
						modifier:Destroy()
						return
					end
				end
			end
        end)
	end
	
end

function terrorblade_mobility_recast:PlayEffectsProjectile(pos, vel)
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_orig.vpcf"
	self.effect_cast_projectile = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast_projectile, 0, pos)
	ParticleManager:SetParticleControl(self.effect_cast_projectile, 1, vel)
	ParticleManager:SetParticleControlForward(self.effect_cast_projectile, 0, vel:Normalized())

end

function terrorblade_mobility_recast:StopEffectsProjectile()
	if self.effect_cast_projectile then
		ParticleManager:DestroyParticle(self.effect_cast_projectile, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast_projectile)
	end
end











function terrorblade_mobility_recast:PlayEffectsOnCast(hTarget)
    local caster = self:GetCaster()
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		caster:GetOrigin(), 
		true 
	);
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		1, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
   );
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		2, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
   );
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		3, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
   );
	ParticleManager:SetParticleControl(effect_cast, 16, Vector(0,0,0))

    ParticleManager:ReleaseParticleIndex(effect_cast)

    EmitSoundOn("Hero_Terrorblade.Metamorphosis", caster)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	terrorblade_mobility_recast,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 0.9 },
	{ movement_speed = 100 },
	{ modifier_name = "modifier_terrorblade_mobility_recast" }
)