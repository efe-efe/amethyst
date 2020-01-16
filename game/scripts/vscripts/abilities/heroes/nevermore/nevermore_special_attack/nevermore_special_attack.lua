nevermore_special_attack = class({})
LinkLuaModifier( "modifier_nevermore_special_attack", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function nevermore_special_attack:GetIntrinsicModifierName()
	return "modifier_nevermore_special_attack"
end

function nevermore_special_attack:GetCastRange( vLocation, hTarget )
	local stacks = 0
	local range_per_stack = self:GetSpecialValueFor("range_per_stack")
		
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", self:GetCaster() )
	if modifier~=nil then
		stacks = stacks + modifier:GetStackCount()
	end

    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + stacks * range_per_stack
end

function nevermore_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	local duration_per_stack = self:GetSpecialValueFor("duration_per_stack")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local stacks = 0
		
	local modifier = caster:FindModifierByNameAndCaster( "modifier_nevermore_souls", caster )
	if modifier~=nil then
		stacks = stacks + modifier:GetStackCount()
		modifier:Destroy()
	end

    local enemies = caster:FindUnitsInRadius(
        point, 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
	)
	
	local damage_table = {
		attacker = caster,
		damage = ( damage + damage_per_stack * stacks ),
		damage_type = DAMAGE_TYPE_PURE,
	}
    
    for _,enemy in pairs(enemies) do
		damage_table.victim = enemy
		ApplyDamage( damage_table )

		enemy:AddNewModifier(caster, self, "modifier_generic_stunned", { duration = ( duration + duration_per_stack * stacks ) })
	end

	CreateRadiusMarker(caster, point, {
		show_all = 1,
		radius = radius
	})

	self:PlayEffectsOnCast( point, radius )
end

function nevermore_special_attack:PlayEffectsOnCast( point, radius )
	EmitSoundOn( "Hero_Nevermore.Shadowraze.Arcana", self:GetCaster() )

	local particle_cast = "particles/nevermore_e.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local particle_cast_b = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	
	ParticleManager:SetParticleControl( effect_cast_b, 0, point )
	ParticleManager:SetParticleControl( effect_cast_b, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_special_attack,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.3 },
	{ movement_speed = 80, public = 1 }
)