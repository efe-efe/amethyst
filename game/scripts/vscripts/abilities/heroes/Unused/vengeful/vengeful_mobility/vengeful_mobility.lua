vengeful_mobility = class({})
vengeful_mobility_ultimate = class({})
LinkLuaModifier( "modifier_vengeful_mobility_illusion", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_illusion", LUA_MODIFIER_MOTION_NONE )

-----------------------------------------------------------
-- Ability Start
function vengeful_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	self.origin = caster:GetOrigin()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local name = caster:GetUnitName()

    self.ability = caster:FindAbilityByName("vengeful_mobility")
	local direction = (point - self.origin):Normalized()
	local distance = (point - self.origin):Length2D()

    local swap_name = string.ends(self:GetAbilityName(), "_ultimate") and "vengeful_mobility_swap_ultimate" or "vengeful_mobility_swap"
    local swap = caster:FindAbilityByName(swap_name)
    swap.illusion_index = self:IllusionLogic():GetEntityIndex()
    
    caster:RemoveModifierByName("modifier_generic_displacement")
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = 2200,
            peak = 80,
            colliding = 0,
        } -- kv
    )

    caster:SwapAbilities( 
        self:GetAbilityName(),
        swap_name,
        false,
        not self:IsHidden()
    )
    self:PlayEffectsOnCast()
end

function vengeful_mobility:OnDisplacementEnd()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local radius = self.ability:GetSpecialValueFor("radius")

    -- find enemies
    local enemies = caster:FindUnitsInRadius( 
        origin, 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    

    local charge = false

    for _, enemy in pairs(enemies) do 
        if not enemy:IsObstacle() then
            charge = true
        end
    end

    if charge == true then
        for i = 0, 3 do
            caster:AddNewModifier(
                caster, -- player source
                caster:FindAbilityByName("vengeful_basic_attack"), -- ability source
                "modifier_vengeful_basic_attack_stack", -- modifier name
                {} -- kv
            )
        end
    end

    self:PlayEffectsOnDisplacementEnd( origin, radius)
end

function vengeful_mobility:IllusionLogic()
    local caster = self:GetCaster()
    local illusion_duration = self.ability:GetSpecialValueFor("duration")

    local illusion = CreateIllusions( caster, caster, {
        duration = illusion_duration,
        outgoing_damage = -100, 
        incoming_damage = 0,
    }, 1, 0, false, true )


    --self:PlayEffectsIllusion( illusion[1] )
    illusion[1]:AddNewModifier(caster, self, "modifier_vengeful_mobility_illusion", {})

    return illusion[1]
end

-----------------------------------------------------------
-- Graphics and sounds
function vengeful_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())
end

function vengeful_mobility:PlayEffectsOnDisplacementEnd( origin, radius )
    local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self.origin)
    ParticleManager:SetParticleControl(effect_cast, 1, origin )
    ParticleManager:ReleaseParticleIndex(effect_cast)

    	
	local particle_cast_c = "particles/mod_units/dw_ti8_immortal_cursed_crown_marker.vpcf"
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end

function vengeful_mobility:PlayEffectsIllusion( hTarget )
    local particle_cast = "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 3, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

vengeful_mobility_ultimate.OnCastPointEnd = vengeful_mobility.OnCastPointEnd
vengeful_mobility_ultimate.OnDisplacementEnd = vengeful_mobility.OnDisplacementEnd
vengeful_mobility_ultimate.IllusionLogic = vengeful_mobility.IllusionLogic
vengeful_mobility_ultimate.PlayEffectsOnCast = vengeful_mobility.PlayEffectsOnCast
vengeful_mobility_ultimate.PlayEffectsOnDisplacementEnd = vengeful_mobility.PlayEffectsOnDisplacementEnd
vengeful_mobility_ultimate.PlayEffectsIllusion = vengeful_mobility.PlayEffectsIllusion

function vengeful_mobility_ultimate:OnAdded()
    local ability = self:GetCaster():AddAbility( "vengeful_mobility_swap_ultimate" )
    ability:SetLevel( 1 )
end

function vengeful_mobility_ultimate:OnRemoved()
    local ability = self:GetCaster():FindAbilityByName("vengeful_mobility_swap_ultimate")
    if ability.illusion_index then
        self:GetCaster():SwapAbilities( 
            "vengeful_mobility_ultimate",
            "vengeful_mobility_swap_ultimate",
            not ability:IsHidden(),
            false
        )
    end
    ability.illusion_index = nil
    self:GetCaster():RemoveAbility( "vengeful_mobility_swap_ultimate" )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 100 }
)
Abilities.Initialize( 
	vengeful_mobility_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 100 }
)