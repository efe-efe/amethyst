Amethyst = Amethyst or class({}, nil, HScriptEntity)

function Amethyst:constructor(origin)
    print("[CLASS=AMETHYST] CREATING AMETHYST")

    self.origin = origin
    self.mana_bounty = 40
    self.heal_bounty = 20
    self.destroyed = false

    self:SetUnit(CreateUnitByName(
        "npc_dota_creature_amethyst", --szUnitName
        self.origin, --vLocation
        true, --bFindClearSpace
        nil, --hNPCOwner
        nil, --hUnitOwner
        DOTA_TEAM_NOTEAM
    ))

    local unit = self:GetUnit()
    unit:SetAbsOrigin(Vector(self.origin.x, self.origin.y, self.origin.z))
    unit:AddNewModifier(unit, nil, "modifier_generic_magic_immune", {})
    local data = { unitIndex = self:GetUnit():GetEntityIndex() }
    CustomGameEventManager:Send_ServerToAllClients( "add_unit", data )    
    self:PlayEffectsOnSpawn()
end

function Amethyst:SetUnit(unit)
	self.unit = unit

    self.unit.GetParentEntity = function(unit)
        return self
    end
end

function Amethyst:GetUnit()
    return self.unit
end

function Amethyst:Alive()
    return not self.destroyed
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
				PseudoHeal(unit:GetHealth(), final_heal, unit)
				unit:GiveMana(final_mana)
                SendOverheadEventMessage( nil, OVERHEAD_ALERT_MANA_ADD, unit, final_mana, nil )
                
                self:PlayEffectsOnTarget(unit)
			end
		end

        self:PlayEffectsOnDeath(self:GetUnit())
        self:GetUnit():AddNoDraw()
	end
    
    self.destroyed = true
end

function Amethyst:PlayEffectsOnSpawn()
    EmitSoundOn( "Hero_Oracle.FortunesEnd.Target", self:GetUnit() )

    local particle_cast_a = "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf"
    local particle_cast_c = "particles/generic_gameplay/rune_arcane.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )
    local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetUnit() )

    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
    ParticleManager:ReleaseParticleIndex( effect_cast_c )
end

function Amethyst:PlayEffectsOnDeath()
    local parent = self:GetUnit()

    EmitSoundOn( "Hero_Magnataur.ReversePolarity.Cast", parent )

    -- Cast particles
    local particle_cast_a = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
    local particle_cast_b = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, parent )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, parent )
    
    ParticleManager:SetParticleControl( effect_cast_a, 0, self.origin )
    ParticleManager:SetParticleControl( effect_cast_a, 2, Vector(255, 80, 230) )

    ParticleManager:SetParticleControl( effect_cast_b, 0, self.origin)
    ParticleManager:SetParticleControl( effect_cast_b, 5, self.origin)

    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

function Amethyst:PlayEffectsOnTarget( hTarget )
    EmitSoundOn( "DOTA_Item.ArcaneBoots.Activate", hTarget )

    local particle_cast_a = "particles/items_fx/arcane_boots_recipient.vpcf"
    local particle_cast_b = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"
    local particle_cast_c = "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_godray.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    
    ParticleManager:ReleaseParticleIndex( effect_cast_a )

    ParticleManager:SetParticleControl( effect_cast_b, 3, hTarget:GetOrigin())
    ParticleManager:SetParticleControl( effect_cast_b, 15, Vector(115, 248, 255))
    ParticleManager:SetParticleControl( effect_cast_b, 16, Vector(1,0,0))
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

    ParticleManager:SetParticleControl( effect_cast_c, 1, hTarget:GetOrigin())
    ParticleManager:SetParticleControl( effect_cast_c, 3, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex( effect_cast_c )
end

    