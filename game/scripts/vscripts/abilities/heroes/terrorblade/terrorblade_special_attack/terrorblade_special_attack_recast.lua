terrorblade_special_attack_recast = class({})
terrorblade_special_attack_recast.blade_index = nil
LinkLuaModifier( "modifier_terrorblade_special_attack_thinker", "abilities/heroes/terrorblade/terrorblade_special_attack/modifier_terrorblade_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

function terrorblade_special_attack_recast:SetBladeIndex( blade_index )
	self.blade_index = blade_index
end

function terrorblade_special_attack_recast:GetBladeIndex()
	return self.blade_index
end

function terrorblade_special_attack_recast:OnCastPointEnd()
    local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("terrorblade_special_attack")
    local delay_time = ability:GetSpecialValueFor("delay_time")
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    -- Spawn the Healing Ward
    self.blade = CreateUnitByName(
        "npc_dota_creature_terrorblade_blade", 
        point, 
        true, 
        caster, 
        caster, 
        caster:GetTeam()
    )

	self.blade:SetControllableByPlayer(caster:GetPlayerID(), true)
	-- Prevent nearby units from getting stuck
	ResolveNPCPositions(self.blade:GetAbsOrigin(), self.blade:GetHullRadius() + self.blade:GetCollisionPadding())
	self.blade:AddNewModifier(caster, self, "terrorblade_special_attack_blade", { duration = 0.5 })
	
	self.previous_blade = EntIndexToHScript(self:GetBladeIndex())
	local distance = (self.previous_blade:GetOrigin() - self.blade:GetOrigin()):Length2D()
	local direction = (self.previous_blade:GetOrigin() - self.blade:GetOrigin()):Normalized()
	local middle_point = self.blade:GetOrigin() + direction * distance/2

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_terrorblade_special_attack_thinker",
			show_all = 1,
			radius = distance/2,
			delay_time = delay_time,
			draw_clock = 1
		}, --paramTable
		middle_point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

function terrorblade_special_attack_recast:OnDelayEnds()
    local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("terrorblade_special_attack")
    local damage = ability:GetSpecialValueFor("ability_damage")
	local stun_duration = ability:GetSpecialValueFor("stun_duration")
	local enemies = caster:FindUnitsInLine( 
		self.blade:GetOrigin(), 
		self.previous_blade:GetOrigin(), 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
	)

	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
		}
		ApplyDamage( damage_table )
		enemy:AddNewModifier(caster, ability, "modifier_generic_stunned", { duration = stun_duration })
	end
    self:PlayEffectsOnDelayEnds(self.blade, self.previous_blade)
end

function terrorblade_special_attack_recast:PlayEffectsOnDelayEnds( hTarget, previous_blade )
    local caster = self:GetCaster()
    EmitSoundOn("Hero_Terrorblade.Sunder.Target", hTarget)
	local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, nil )
    
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		previous_blade, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		previous_blade:GetOrigin(), 
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
	ParticleManager:SetParticleControl( effect_cast, 16, Vector(0,0,0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn("Hero_Terrorblade.Metamorphosis", caster)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    terrorblade_special_attack_recast,
	{ activity = ACT_DOTA_CAST_ABILITY_4, rate = 1.2 },
	{ movement_speed = 10 },
	{ modifier_name = "modifier_terrorblade_special_attack_recast" }
)
