Amethyst = Amethyst or class({}, nil, UnitEntity)

function Amethyst:constructor(origin)
    getbase(Amethyst).constructor(self, origin, "npc_dota_creature_amethyst")
    
    self.mana_bounty = 40
    self.heal_bounty = 20

    local unit = self:GetUnit()
    local data = { unitIndex = unit:GetEntityIndex() }

    CustomGameEventManager:Send_ServerToAllClients("add_unit", data)    
    self:PlayEffectsOnSpawn()
end

function Amethyst:OnDeath(params)
    local killer = params.killer

    if IsServer() then
		local units = killer:FindUnitsInRadius(
			self:GetUnit():GetOrigin(), 
			FIND_UNITS_EVERYWHERE, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
			DOTA_UNIT_TARGET_HERO, 
			DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
			FIND_ANY_ORDER
		)

		local final_heal = self.heal_bounty / #units
		local final_mana = self.mana_bounty / #units

		for _,unit in pairs(units) do
			if unit:IsRealHero() then 
				TrueHeal(unit:GetHealth(), final_heal, unit)
				unit:GiveMana(final_mana)
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, unit, final_mana, nil)
                
                self:PlayEffectsOnTarget(unit)
			end
		end

        self:PlayEffectsOnDeath()
        self:GetUnit():AddNoDraw()

        killer:GetAlliance().amethysts = killer:GetAlliance().amethysts + 1
	end
    
    local data = {
        alliance = params.killer:GetAlliance().name,
        amethysts = params.killer:GetAlliance().amethysts
    }
    CustomGameEventManager:Send_ServerToAllClients("update_amethysts", data)

    self:Destroy()
end

function Amethyst:PlayEffectsOnSpawn()
    EmitSoundOn("Hero_Oracle.FortunesEnd.Target", self:GetUnit())

    local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
    local particle_cast_c = "particles/generic_gameplay/rune_arcane.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit())
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit())
    local effect_cast_c = ParticleManager:CreateParticle(particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit())

    ParticleManager:ReleaseParticleIndex(effect_cast_a)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
    ParticleManager:ReleaseParticleIndex(effect_cast_c)
end

function Amethyst:PlayEffectsOnDeath()
    local parent = self:GetUnit()
    local origin = parent:GetAbsOrigin()

    EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", parent)

    -- Cast particles
    local particle_cast_a = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_WORLDORIGIN, nil)
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, nil)
    
    ParticleManager:SetParticleControl(effect_cast_a, 0, origin)
    ParticleManager:SetParticleControl(effect_cast_a, 2, Vector(255, 80, 230))

    ParticleManager:SetParticleControl(effect_cast_b, 0, origin)
    ParticleManager:SetParticleControl(effect_cast_b, 5, origin)

    ParticleManager:ReleaseParticleIndex(effect_cast_a)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

function Amethyst:PlayEffectsOnTarget(hTarget)
    EmitSoundOn("DOTA_Item.ArcaneBoots.Activate", hTarget)

    local particle_cast_a = "particles/items_fx/arcane_boots_recipient.vpcf"
    local particle_cast_b = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"
    local particle_cast_c = "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    local effect_cast_c = ParticleManager:CreateParticle(particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    
    ParticleManager:ReleaseParticleIndex(effect_cast_a)

    ParticleManager:SetParticleControl(effect_cast_b, 3, hTarget:GetOrigin())
    ParticleManager:SetParticleControl(effect_cast_b, 15, Vector(115, 248, 255))
    ParticleManager:SetParticleControl(effect_cast_b, 16, Vector(1,0,0))
    ParticleManager:ReleaseParticleIndex(effect_cast_b)

    ParticleManager:SetParticleControl(effect_cast_c, 1, hTarget:GetOrigin())
    ParticleManager:SetParticleControl(effect_cast_c, 3, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast_c)
end

    