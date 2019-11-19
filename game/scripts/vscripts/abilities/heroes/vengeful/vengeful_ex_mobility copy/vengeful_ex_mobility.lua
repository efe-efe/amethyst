vengeful_ex_second_attack = class({})
vengeful_ex_second_attack_ultimate = class({})
LinkLuaModifier( "modifier_vengeful_ex_second_attack_illusion", "abilities/heroes/vengeful/vengeful_ex_second_attack/modifier_vengeful_ex_second_attack_illusion", LUA_MODIFIER_MOTION_NONE )

-----------------------------------------------------------
-- Ability Start
function vengeful_ex_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	self.origin = caster:GetOrigin()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local name = caster:GetUnitName()

    self.ability = caster:FindAbilityByName("vengeful_ex_second_attack")
	local direction = (point - self.origin):Normalized()
	local distance = (point - self.origin):Length2D()
    local radius = self.ability:GetSpecialValueFor("radius")
    local heal = self.ability:GetSpecialValueFor("heal")
    local damage = self.ability:GetSpecialValueFor("ability_damage")

    local swap_name = string.ends(self:GetAbilityName(), "_ultimate") and "vengeful_ex_second_attack_swap_ultimate" or "vengeful_ex_second_attack_swap"
    local swap = caster:FindAbilityByName(swap_name)
    swap.illusion_index = self:IllusionLogic():GetEntityIndex()
    
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
            activity = ACT_DOTA_TELEPORT_END,
            rate = 1.0,
        } -- kv
    )

    local units = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        self.origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,unit in pairs(units) do
        if unit:GetTeamNumber() == caster:GetTeamNumber() then
            unit:Heal(heal, caster)
        else
            local damage_table = {
                victim = unit,
                attacker = caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_PURE,
            }
            ApplyDamage( damage_table )
        end

        if unit ~= self.parent then
            unit:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_generic_displacement", -- modifier name
                {
                    x = direction.x,
                    y = direction.y,
                    r = distance,
                    speed = 1800,
                    peak = 80,
                    colliding = 0,
                    activity = ACT_DOTA_FLAIL,
                    rate = 1.0,
                } -- kv
            )
        end
    end

    caster:SwapAbilities( 
        self:GetAbilityName(),
        swap_name,
        false,
        not self:IsHidden()
    )

    CreateRadiusMarker(caster, self.origin, {
        show_all = 1,
        radius = radius
    })
    self:PlayEffectsOnCast()
end

function vengeful_ex_second_attack:OnDisplacementEnd()
	local origin = self:GetCaster():GetOrigin()
    self:PlayEffectsOnDisplacementEnd( origin )

end

function vengeful_ex_second_attack:IllusionLogic()
    local caster = self:GetCaster()
    local illusion_duration = self.ability:GetSpecialValueFor("duration")

    local illusion = CreateIllusions( caster, caster, {
        duration = illusion_duration,
        outgoing_damage = -100, 
        incoming_damage = 0,
    }, 1, 0, false, true )


    --self:PlayEffectsIllusion( illusion[1] )
    illusion[1]:AddNewModifier(caster, self, "modifier_vengeful_ex_second_attack_illusion", {})

    return illusion[1]
end

function vengeful_ex_second_attack:OnSwapPress()
    return false
end

function vengeful_ex_second_attack:OnSwapRelease()
    return false
end

-----------------------------------------------------------
-- Graphics and sounds
function vengeful_ex_second_attack:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", caster)

    local effect_cast = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function vengeful_ex_second_attack:PlayEffectsOnDisplacementEnd( origin )
    -- Sound
    --EmitSoundOn( "Hero_PhantomAssassin.Strike.End", self:GetCaster())
    -- Play particle trail when moving
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
    ParticleManager:SetParticleControl(trail_pfx, 1, origin )
    ParticleManager:ReleaseParticleIndex(trail_pfx)
end

function vengeful_ex_second_attack:PlayEffectsIllusion( hTarget )
    local particle_cast = "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 3, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

vengeful_ex_second_attack_ultimate.OnCastPointEnd = vengeful_ex_second_attack.OnCastPointEnd
vengeful_ex_second_attack_ultimate.OnDisplacementEnd = vengeful_ex_second_attack.OnDisplacementEnd
vengeful_ex_second_attack_ultimate.IllusionLogic = vengeful_ex_second_attack.IllusionLogic
vengeful_ex_second_attack_ultimate.PlayEffectsOnCast = vengeful_ex_second_attack.PlayEffectsOnCast
vengeful_ex_second_attack_ultimate.PlayEffectsOnDisplacementEnd = vengeful_ex_second_attack.PlayEffectsOnDisplacementEnd
vengeful_ex_second_attack_ultimate.PlayEffectsIllusion = vengeful_ex_second_attack.PlayEffectsIllusion

function vengeful_ex_second_attack_ultimate:OnAdded()
    local ability = self:GetCaster():AddAbility( "vengeful_ex_second_attack_swap_ultimate" )
    ability:SetLevel( 1 )
end

function vengeful_ex_second_attack_ultimate:OnRemoved()
    local ability = self:GetCaster():FindAbilityByName("vengeful_ex_second_attack_swap_ultimate")
    if ability.illusion_index then
        self:GetCaster():SwapAbilities( 
            "vengeful_ex_second_attack_ultimate",
            "vengeful_ex_second_attack_swap_ultimate",
            false,
            not ability:IsHidden()
        )
    end
    ability.illusion_index = nil
    self:GetCaster():RemoveAbility( "vengeful_ex_second_attack_swap_ultimate" )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 0.8 },
	{ movement_speed = 10 }
)

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_second_attack_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 0.8 },
	{ movement_speed = 10 }
)