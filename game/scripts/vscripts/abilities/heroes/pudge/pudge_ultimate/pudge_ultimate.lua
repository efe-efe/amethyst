pudge_ultimate = class({})
LinkLuaModifier( "modifier_pudge_ultimate", "abilities/heroes/pudge/pudge_ultimate/modifier_pudge_ultimate", LUA_MODIFIER_MOTION_NONE )

function pudge_ultimate:OnSpellStart()
	
	local particle_cast = "particles/econ/items/grimstroke/ti9_immortal/gs_ti9_artistry_proj.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0,0,0) )
end

function pudge_ultimate:OnCastPointEnd()
	if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )   
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_pudge_ultimate", { duration = duration }) 
	self:PlayEffectsOnCast()

	caster:GiveMana(100)
end

function pudge_ultimate:PlayEffectsOnCast()
	EmitGlobalSound( "pudge_pud_arc_fresh_01" )

	local particle_cast = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_aftershock_v2.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 2, self:GetCaster():GetOrigin() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_ultimate,
	{ activity = ACT_DOTA_CHANNEL_ABILITY_4, rate = 0.4 },
	{ movement_speed = 10 }
)