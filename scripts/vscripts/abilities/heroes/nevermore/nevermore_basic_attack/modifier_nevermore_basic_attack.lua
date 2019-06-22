modifier_nevermore_basic_attack = class({})
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_basic_attack:IsHidden()
	return true
end

function modifier_nevermore_basic_attack:IsDebuff()
	return false
end

function modifier_nevermore_basic_attack:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_basic_attack:OnCreated()
    self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

function modifier_nevermore_basic_attack:OnAttackLanded( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		if params.attacker:GetTeamNumber()==params.target:GetTeamNumber() then return end

	    self:GetParent():AddNewModifier(
            self:GetParent(),
            self:GetAbility(),
            "modifier_nevermore_souls",
            { duration = self.duration }
        )

        self:PlayEffects(params.target)
	end
end

function modifier_nevermore_basic_attack:PlayEffects( target )
	-- Get Resources
	local projectile_name = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf"

	-- CreateProjectile
	local info = {
		Target = self:GetParent(),
		Source = target,
		EffectName = projectile_name,
		iMoveSpeed = 400,
		vSourceLoc= target:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end