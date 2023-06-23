local constructors = {
    ["npc_dota_hero_sniper"] = function(hTarget)
        CustomEntitiesLegacy:AddCharges(hTarget, "modifier_sniper_basic_attack_charges")
    end,
    ["npc_dota_hero_juggernaut"] = function(hTarget)
        CustomEntitiesLegacy:AddStackbars(hTarget, "modifier_juggernaut_basic_attack_stacks")
    end,
    ["npc_dota_hero_phantom_assassin"] = function(hTarget)
        CustomEntitiesLegacy:AddStackbars(hTarget, "modifier_phantom_strike_stack")
        CustomEntitiesLegacy:AddCharges(hTarget, "modifier_phantom_special_attack_charges")
    end,
    ["npc_dota_hero_nevermore"] = function(hTarget)
        CustomEntitiesLegacy:AddStackbars(hTarget, "modifier_nevermore_souls")
        CustomEntitiesLegacy:AddCharges(hTarget, "modifier_nevermore_special_attack_charges")
    end,
    ["npc_dota_hero_puck"] = function(hTarget)
        CustomEntitiesLegacy:AddCooldown(hTarget, "modifier_puck_basic_attack_cooldown")
    end,
    ["npc_dota_hero_spectre"] = function(hTarget)
        CustomEntitiesLegacy:AddCooldown(hTarget, "modifier_spectre_basic_attack_cooldown")
    end,
    ["npc_dota_hero_mars"] = function(hTarget)
        CustomEntitiesLegacy:AddStackbars(hTarget, "modifier_mars_basic_attack_stacks")
        hTarget:SetHullRadius(90)
    end,
    ["npc_dota_hero_storm_spirit"] = function(hTarget)
        CustomEntitiesLegacy:AddCooldown(hTarget, "modifier_storm_basic_attack_cooldown")
    end,
    ["npc_dota_hero_invoker"] = function(hTarget)
        CustomEntitiesLegacy:AddCharges(hTarget, "modifier_invoker_helper")
        CustomEntitiesLegacy:SetEnergyPerCell(hTarget, 50)
    end,
    ["npc_dota_hero_centaur"] = function(hTarget)
        hTarget:SetHullRadius(100)
    end,
}

function ConstructHero(hTarget)
    if constructors[hTarget:GetName()] then
        constructors[hTarget:GetName()](hTarget)
    end
end