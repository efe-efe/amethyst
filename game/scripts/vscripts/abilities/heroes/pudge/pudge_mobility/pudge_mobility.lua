pudge_mobility = class({})
--------------------------------------------------------------------------------
-- Ability Start
function pudge_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()

	self.radius = self:GetSpecialValueFor("radius")

	local peak_percentage = 1 - (distance)/self:GetCastRange(Vector(0,0,0), nil)

	caster:RemoveModifierByName("modifier_generic_displacement")
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.65),
            peak = (150 * peak_percentage) + 100,
			collide_with_ent = 1,
        } -- kv
	)
	
	self:PlayEffectsOnCast()
end

function pudge_mobility:OnDisplacementEnd()
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local fading_slow_pct =self:GetSpecialValueFor("fading_slow_pct")

	local enemies = self:GetCaster():FindUnitsInRadius(
        self:GetCaster():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do
        local damage_table = {
            victim = enemy,
            attacker = self:GetCaster(),
            damage = self:GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }
		ApplyDamage( damage_table )
		
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_generic_fading_slow_new", { 
			duration = fading_slow_duration,
			max_slow_pct = fading_slow_pct
		})
    end

	self:PlayEffectsOnDisplacementEnd()
end

function pudge_mobility:PlayEffectsOnDisplacementEnd()
	EmitSoundOn("Hero_EarthShaker.Fissure", self:GetCaster())

	local particle_cast = "particles/econ/events/ti8/blink_dagger_ti8_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	particle_cast = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_aftershock_v2.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 2, self:GetCaster():GetOrigin() )
	
	CreateRadiusMarker( self:GetCaster(), self:GetCaster():GetOrigin(), {
		show_all = 1,
		radius = self.radius
	})
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function pudge_mobility:PlayEffectsOnCast()
	EmitSoundOn( "Hero.Pudge.Arcana.Streak", self:GetCaster() )

	local particle_cast = "particles/red_blink/blink_dagger_ti8_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )

	self.effect_cast = ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_tassles_of_black_death/pudge_black_death_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(250,0,0) )

end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_mobility,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 2.0 },
	{ movement_speed = 0}
)