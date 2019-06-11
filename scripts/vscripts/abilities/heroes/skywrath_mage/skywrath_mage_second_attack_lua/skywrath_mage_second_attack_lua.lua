skywrath_mage_second_attack_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_second_attack_thinker_lua", "abilities/heroes/skywrath_mage/skywrath_mage_second_attack_lua/modifier_skywrath_mage_second_attack_thinker_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_second_attack_charges_lua", "abilities/heroes/skywrath_mage/skywrath_mage_second_attack_lua/modifier_skywrath_mage_second_attack_charges_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )


-- Set AOE indicator
--------------------------------------------------------------------------------
function skywrath_mage_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_second_attack_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
    self.point = self:GetCursorPosition()
	local cast_point = self:GetCastPoint()

    -- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

function skywrath_mage_second_attack_lua:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_skywrath_mage_second_attack_thinker_lua", --modifierName
		{}, --paramTable
		self.point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

--------------------------------------------------------------------------------
-- Passive Modifier
function skywrath_mage_second_attack_lua:GetIntrinsicModifierName()
	return "modifier_skywrath_mage_second_attack_charges_lua"
end

function skywrath_mage_second_attack_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_CAST_ABILITY_3, rate=1.1})
end