vengeful_ultimate = class({})
LinkLuaModifier( "modifier_vengeful_ultimate", "abilities/heroes/vengeful/vengeful_ultimate/modifier_vengeful_ultimate", LUA_MODIFIER_MOTION_NONE )

vengeful_ultimate.current_ability = nil

--------------------------------------------------------------------------------
-- Passive Modifier
function vengeful_ultimate:GetIntrinsicModifierName()
	return "modifier_vengeful_ultimate"
end

-----------------------------------------------------------
-- Ability Start
function vengeful_ultimate:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local name = caster:GetUnitName()
end

-----------------------------------------------------------
-- Graphics and sounds
function vengeful_ultimate:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_ultimate,
    nil,
	{ movement_speed = 100 }
)