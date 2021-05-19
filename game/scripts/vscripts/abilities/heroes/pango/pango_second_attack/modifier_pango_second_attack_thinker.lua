modifier_pango_second_attack_thinker = class({})

function modifier_pango_second_attack_thinker:OnCreated(params)
    if IsServer() then
        self.point = Vector(params.x, params.y)
        self.attacks = 4
        self.efxs = {}
        self.pango_basic_attack = self:GetCaster():FindAbilityByName("pango_basic_attack")

        self.damage_table = {
            attacker = self:GetCaster(),
            damage = 5,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        }

        self:OnIntervalThink()
        self:StartIntervalThink(0.1)
        
        EmitSoundOn("Hero_Pangolier.Swashbuckle", self:GetCaster())
    end
end

function modifier_pango_second_attack_thinker:OnDestroy()
    if IsServer() then
        for _,efx in pairs(self.efxs) do
            ParticleManager:DestroyParticle(efx, false)
            ParticleManager:ReleaseParticleIndex(efx)
        end

        UTIL_Remove(self:GetParent())
    end
end

function modifier_pango_second_attack_thinker:OnIntervalThink()
    local enemies = self:GetCaster():FindUnitsInLine(
		self:GetParent():GetAbsOrigin(), 
		self.point, 
		150, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
    )

    for _,enemy in pairs(enemies) do
        self.pango_basic_attack:TryProc(enemy)
        if not enemy:IsObstacle() then
            self:GetCaster():AddNewModifier(self:GetCaster(), self.pango_basic_attack, "modifier_pango_basic_attack_stacks", {}) 
        end
        self.damage_table.victim = enemy
        ApplyDamage(self.damage_table)
        EmitSoundOn("Hero_Pangolier.Swashbuckle.Attack", enemy)
        EmitSoundOn("Hero_Pangolier.Attack", enemy)
    end

    self.attacks = self.attacks - 1

    local direction = (self.point - self:GetParent():GetAbsOrigin()):Normalized()
    local range = (self.point - self:GetParent():GetAbsOrigin()):Length2D()

    self.efxs[self.attacks] = EFX("particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_WORLDORIGIN, nil, { 
        cp0 = self:GetParent():GetAbsOrigin(),
        cp1 = direction * range,
    })

    if self.attacks <= 0 then
        self:Destroy()
    end
end