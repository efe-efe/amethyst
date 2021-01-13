modifier_phantom_bleed = class({})

function modifier_phantom_bleed:OnCreated(params)
    if IsServer() then
        self.bleed_damage_per_stack = 1
		self.max_stacks = 3
		self.parent = self:GetParent()
		local interval_time = 1.0
		
		self.damage_table = {
            victim = self.parent,
			attacker = self:GetCaster(),
			damage_type = DAMAGE_TYPE_PURE,
		}

        self:SetStackCount(1)
        self:OnIntervalThink()
		self:StartIntervalThink(interval_time)
		
		self.efx = EFX("particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
		})
	end
end

function modifier_phantom_bleed:OnRefresh(params)
	if IsServer() then
		if self:GetStackCount() < self.max_stacks then
			self:IncrementStackCount()
		end
	end
end

function modifier_phantom_bleed:OnDestroy()
	if IsServer() then
		ParticleManager:DestroyParticle(self.efx, false)
		ParticleManager:ReleaseParticleIndex(self.efx)
	end
end

function modifier_phantom_bleed:OnIntervalThink()
    self.damage_table.damage = self.bleed_damage_per_stack * self:GetStackCount()
	ApplyDamage(self.damage_table)
	
	EFX("particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok_ribbon.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
		release = true
	})	
	EFX("particles/econ/items/dazzle/dazzle_darkclaw/dazzle_darkclaw_poison_touch_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
		cp3 = self.parent:GetAbsOrigin(),
		release = true
	})
	
	EmitSoundOn("Hero_PhantomAssassin.Attack", self.parent)
	EmitSoundOn("Hero_PhantomAssassin.Dagger.Target", self.parent)
	EmitSoundOn("Hero_PhantomAssassin.Spatter", self.parent)
end

function modifier_phantom_bleed:GetStatusLabel() return "Bleeding" end
function modifier_phantom_bleed:GetStatusPriority() return 3 end
function modifier_phantom_bleed:GetStatusStyle() return "Bleeding" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_bleed)