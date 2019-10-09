spectre_counter = class({})

--------------------------------------------------------------------------------
-- Ability Start
function spectre_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetDuration()
    local movement_speed = 100 - self:GetSpecialValueFor("speed_debuff")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            movement_speed = movement_speed,
            duration = duration, 
            destroy_on_trigger = 0,
            disable = 0,
            sound = "Hero_Spectre.HauntCast"
        } -- kv
    )

    caster:AddNewModifier(
        caster,
        self,
        "modifier_generic_projectile_reflector_lua",
        { duration = duration }
    )
end

function spectre_counter:OnTrigger()
    local caster = self:GetCaster()

    local modifier = caster:FindModifierByName("modifier_spectre_basic_attack")
    modifier:IncrementStackCount()
    modifier:StartIntervalThink(-1)
    modifier:CalculateCharge()

    self:PlayEffectsOnTrigger()
end

function spectre_counter:OnStartCounter()
	local particle_cast = "particles/items3_fx/lotus_orb_shield.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
end

function spectre_counter:OnEndCounter()
	ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function spectre_counter:PlayEffectsOnTrigger()
	local sound_cast = "Item.LotusOrb.Activate"
	EmitSoundOn( sound_cast, self:GetCaster() )

	local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start.vpcf"
	
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    spectre_counter,
    nil, 
	{ movement_speed = 100 }
)