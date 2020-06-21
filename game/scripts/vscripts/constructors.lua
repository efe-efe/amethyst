local constructors = {
    ["npc_dota_hero_sniper"] = function(hTarget)
        hTarget:AddCharges("modifier_sniper_basic_attack_charges")
    end,
    ["npc_dota_hero_juggernaut"] = function(hTarget)
        hTarget:AddStackbars("modifier_juggernaut_basic_attack_stacks")
    end,
    ["npc_dota_hero_phantom_assassin"] = function(hTarget)
        hTarget:AddStackbars("modifier_phantom_strike_stack")
    end,
    ["npc_dota_hero_nevermore"] = function(hTarget)
        hTarget:AddStackbars("modifier_nevermore_souls")
    end,
    ["npc_dota_hero_puck"] = function(hTarget)
        hTarget:AddCooldown("modifier_puck_basic_attack_cooldown")
    end,
    ["npc_dota_hero_spectre"] = function(hTarget)
        hTarget:AddCooldown("modifier_spectre_basic_attack_cooldown")
    end,
    ["npc_dota_hero_mars"] = function(hTarget)
        hTarget:AddStackbars("modifier_mars_basic_attack_stacks")
    end
}

function ConstructHero(hTarget)
    if constructors[hTarget:GetName()] then
        constructors[hTarget:GetName()](hTarget)
    end
end