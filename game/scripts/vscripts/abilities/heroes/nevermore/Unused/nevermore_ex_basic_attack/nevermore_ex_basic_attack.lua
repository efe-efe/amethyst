nevermore_ex_basic_attack = class({})
LinkLuaModifier("modifier_nevermore_ex_basic_attack", "abilities/heroes/nevermore/nevermore_ex_basic_attack/modifier_nevermore_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function nevermore_ex_basic_attack:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local stacks = 0 

	local modifier = caster:FindModifierByNameAndCaster("modifier_nevermore_souls", caster)
	if modifier~=nil then
		stacks = stacks + modifier:GetStackCount()
		modifier:Destroy()
    end
    
    caster:AddNewModifier(
        caster,
        self,
        "modifier_nevermore_ex_basic_attack",
        { duration = duration, stacks = stacks }
   )

    caster:FindAbilityByName("nevermore_basic_attack"):EndCooldown()

    self:PlayEffects()
end


function nevermore_ex_basic_attack:PlayEffects()
    local caster = self:GetCaster()
	EmitSoundOn("DOTA_Item.SoulRing.Activate", caster)

    -- Create Particles
    local particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 3, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	nevermore_ex_basic_attack,
	{ activity = ACT_DOTA_RAZE_1, rate = 1.5 },
	{ movement_speed = 100 }
)