modifier_vengeful_special_attack_link = class({})
modifier_vengeful_special_attack_link_ultimate = class({})

function modifier_vengeful_special_attack_link:OnCreated()
    if IsServer() then
        self.ability = self:GetCaster():FindAbilityByName("vengeful_special_attack")
        self.max_range = self.ability:GetSpecialValueFor("link_range")
        self.extra_damage = self.ability:GetSpecialValueFor("extra_damage")
        self.root_duration = self.ability:GetSpecialValueFor("root_duration")
        self:StartIntervalThink(0.1)
        self:PlayEffects(self:GetParent())
    end
end

function modifier_vengeful_special_attack_link:OnRefresh()
    if IsServer() then
        self:StartIntervalThink(0.1)
        self:PlayEffects(self:GetParent())
    end
    
end

function modifier_vengeful_special_attack_link:OnDestroy()
    if IsServer() then
        self:StopEffects()

        if self:GetRemainingTime() < 0.05 then
            local damage_table = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.extra_damage,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility(),
			}

            ApplyDamage( damage_table )
            self:PlayEffectsOnDestroy(self:GetParent())
			self:GetParent():AddNewModifier(self:GetCaster(), self.ability , "modifier_generic_stunned", { duration = 0.1 })
            self:GetParent():AddNewModifier(self:GetCaster(), self.ability , "modifier_generic_rooted_lua", { duration = self.root_duration })
        end
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_vengeful_special_attack_link:OnIntervalThink()
    local target_origin = self:GetCaster():GetOrigin()
    local caster_origin = self:GetParent():GetOrigin()
    local direction = (caster_origin - target_origin)
    local distance = direction:Length2D()

    if distance > self.max_range then
        self:Destroy()
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_special_attack_link:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end


function modifier_vengeful_special_attack_link:OnDeath( params )
    if IsServer() then 
        if params.unit == self:GetCaster() then 
            self:Destroy()
        end
    end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_vengeful_special_attack_link:PlayEffects( hTarget )
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    local particle_cast = string.ends(self:GetAbility():GetAbilityName(), "_ultimate") and
        "particles/econ/items/razor/razor_punctured_crest_golden/razor_static_link_blade_golden.vpcf" or 
        "particles/econ/items/razor/razor_punctured_crest/razor_static_link_blade.vpcf"

    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, nil)

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        0, 
        caster, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin + Vector( 0, 0, 96 ), 
        true 
    );
    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        1, 
        hTarget, 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        hTarget:GetOrigin(), 
        true 
    );
end

function modifier_vengeful_special_attack_link:PlayEffectsOnDestroy(hTarget)
    EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", hTarget)
    local particle_cast = "particles/econ/items/storm_spirit/strom_spirit_ti8/storm_spirit_ti8_overload_active.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
end

function modifier_vengeful_special_attack_link:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

modifier_vengeful_special_attack_link_ultimate.OnCreated = modifier_vengeful_special_attack_link.OnCreated
modifier_vengeful_special_attack_link_ultimate.OnRefresh = modifier_vengeful_special_attack_link.OnRefresh
modifier_vengeful_special_attack_link_ultimate.OnDestroy = modifier_vengeful_special_attack_link.OnDestroy
modifier_vengeful_special_attack_link_ultimate.OnIntervalThink = modifier_vengeful_special_attack_link.OnIntervalThink
modifier_vengeful_special_attack_link_ultimate.PlayEffects = modifier_vengeful_special_attack_link.PlayEffects
modifier_vengeful_special_attack_link_ultimate.StopEffects = modifier_vengeful_special_attack_link.StopEffects
modifier_vengeful_special_attack_link_ultimate.PlayEffectsOnDestroy = modifier_vengeful_special_attack_link.PlayEffectsOnDestroy