local constructors = {
    ["npc_dota_hero_sniper"] = function(hTarget)
        CustomEntities:AddCharges(hTarget, "modifier_sniper_basic_attack_charges")
    end,
    ["npc_dota_hero_juggernaut"] = function(hTarget)
        CustomEntities:AddStackbars(hTarget, "modifier_juggernaut_basic_attack_stacks")
    end,
    ["npc_dota_hero_vengefulspirit"] = function(hTarget)
        CustomEntities:AddStackbars(hTarget, "modifier_vengeful_basic_attack")
    end,
    ["npc_dota_hero_phantom_assassin"] = function(hTarget)
        CustomEntities:AddStackbars(hTarget, "modifier_phantom_strike_stack")
        CustomEntities:AddCharges(hTarget, "modifier_phantom_special_attack_charges")
    end,
    ["npc_dota_hero_nevermore"] = function(hTarget)
        CustomEntities:AddStackbars(hTarget, "modifier_nevermore_souls")
        CustomEntities:AddCharges(hTarget, "modifier_nevermore_special_attack_charges")
    end,
    ["npc_dota_hero_puck"] = function(hTarget)
        CustomEntities:AddCooldown(hTarget, "modifier_puck_basic_attack_cooldown")
    end,
    ["npc_dota_hero_spectre"] = function(hTarget)
        CustomEntities:AddCooldown(hTarget, "modifier_spectre_basic_attack_cooldown")
    end,
    ["npc_dota_hero_mars"] = function(hTarget)
        CustomEntities:AddStackbars(hTarget, "modifier_mars_basic_attack_stacks")
        hTarget:SetHullRadius(90)
    end,
    ["npc_dota_hero_storm_spirit"] = function(hTarget)
        CustomEntities:AddCooldown(hTarget, "modifier_storm_basic_attack_cooldown")
    end,
    ["npc_dota_hero_invoker"] = function(hTarget)
        CustomEntities:AddCharges(hTarget, "modifier_invoker_helper")
    end,
}

function ConstructHero(hTarget)
    if constructors[hTarget:GetName()] then
        constructors[hTarget:GetName()](hTarget)
    end
end