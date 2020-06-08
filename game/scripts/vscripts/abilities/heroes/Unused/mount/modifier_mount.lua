modifier_mount = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mount:IsHidden() return false
end

function modifier_mount:IsDebuff() return false
end

function modifier_mount:IsPurgable()
	return true
end

function modifier_mount:RandomModel()
    local mounts = LoadKeyValues("scripts/npc/mounts.txt")

	--[[
    for _, data in pairs(mounts) do
        PrecacheResource("model", data.model, context)
	end
	]]

    local random_number = RandomInt(1, 100)
    local model 
    if random_number <= 5 then
		model = "models/items/hex/sheep_hex/sheep_hex_gold.vmdl"
	elseif random_number > 5 and random_number <= 10 then
		model = "models/items/courier/nexon_turtle_09_blue/nexon_turtle_09_blue.vmdl"
    elseif random_number > 10 and random_number <= 15 then
		model = "models/items/courier/mighty_chicken/mighty_chicken.vmdl"
    elseif random_number > 15 and random_number <= 20 then
        model = "models/items/undying/idol_of_ruination/ruin_wight_minion.vmdl"
    elseif random_number > 20 and random_number <= 25 then
        model = "models/items/courier/mok/mok.vmdl"
    elseif random_number > 25 and random_number <= 30 then
        model = "models/courier/baby_rosh/babyroshan_alt.vmdl"
    elseif random_number > 30 and random_number <= 35 then
        model = "models/items/courier/royal_griffin_cub/royal_griffin_cub.vmdl"
    elseif random_number > 35 and random_number <= 40 then
        model = "models/courier/beetlejaws/mesh/beetlejaws.vmdl"
    elseif random_number > 40 and random_number <= 45 then
        model = "models/items/courier/snaggletooth_red_panda/snaggletooth_red_panda.vmdl"
    elseif random_number > 45 and random_number <= 50 then
        model = "models/courier/juggernaut_dog/juggernaut_dog.vmdl"
    elseif random_number > 50 and random_number <= 55 then
        model = "models/items/courier/tory_the_sky_guardian/tory_the_sky_guardian.vmdl"
    elseif random_number > 55 and random_number <= 60 then
        model = "models/courier/mech_donkey/mech_donkey.vmdl"
    elseif random_number > 60 and random_number <= 65 then
        model = "models/items/courier/virtus_werebear_t1/virtus_werebear_t1.vmdl"
    elseif random_number > 65 and random_number <= 70 then
        model = "models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl"
    elseif random_number > 70 and random_number <= 75 then
        model = "models/items/courier/amaterasu/amaterasu.vmdl"
    elseif random_number > 75 and random_number <= 80 then
        model = "models/items/courier/axolotl/axolotl.vmdl"
    elseif random_number > 80 and random_number <= 85 then
        model = "models/items/courier/carty/carty.vmdl"
    elseif random_number > 85 and random_number <= 90 then
        model = "models/items/courier/atrophic_skitterwing/atrophic_skitterwing.vmdl"
    elseif random_number > 90 and random_number <= 95 then
        model = "models/items/courier/chocobo/chocobo.vmdl"
    elseif random_number > 95 and random_number <= 100 then
        model = "models/items/courier/livery_llama_courier/livery_llama_courier.vmdl"
	end

    return model
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mount:OnCreated(kv)
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.model = self:RandomModel()

	if IsServer() then
		-- play effects
		self:PlayEffects()
	end
end

function modifier_mount:OnRefresh(kv)
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	self.model = self:RandomModel()
	if IsServer() then
		-- play effects
		self:PlayEffects()
	end
end

function modifier_mount:OnDestroy(kv)
	if IsServer() then
		local caster = self:GetCaster()
		-- play effects
		-- Swap abilities back to be able to stop

		--[[
		caster:SwapAbilities(
			"mount",
			"charge",
			true,
			false
		)

		SafeDestroyModifier("modifier_charge_buff", caster, caster)
		]]
		self:PlayEffects()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mount:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs
end

function modifier_mount:OnTakeDamage(params)
	if IsServer() then
        if params.unit~=self:GetCaster() then return end

		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_fading_slow", { duration = self.slow_duration })
		self:Destroy()
	end
end

function modifier_mount:GetModifierMoveSpeedOverride()
	return self.base_speed
end

function modifier_mount:GetModifierModelChange()
	return self.model
end

function modifier_mount:OnAbilityExecuted(params)
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		if 	params.ability:GetName() == "item_death_orb" or
			params.ability:GetName() == "item_mana_orb" or
			params.ability:GetName() == "item_health_orb" or
			params.ability:GetName() == "item_shield_orb" or
			params.ability:GetName() == "charge"
		then
			return
		end
		self:Destroy()
	end
end

function modifier_mount:OnAttack(params)
	if IsServer() then
		if params.attacker~=self:GetParent() then return end

		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mount:PlayEffects(bStart)
	local sound_cast = "DOTA_Item.Sheepstick.Activate"
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)

    EmitSoundOn(sound_cast, self:GetParent())
end