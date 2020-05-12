if not TargetingIndicator then
    TargetingIndicator = class({})
end

function TargetingIndicator:Load()
    local abilities_kv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
    local targetingIndicators = {}
    local hoverIndicators = {}

    for key, ability in pairs(abilities_kv) do
        if ability.TargetingIndicator then
            targetingIndicators[key] = ability.TargetingIndicator
        end
    end

    
    local items_kv = LoadKeyValues("scripts/npc/npc_items_custom.txt")
    for key, item in pairs(items_kv) do
        if item.TargetingIndicator then
            targetingIndicators[key] = item.TargetingIndicator
        end
    end

    CustomNetTables:SetTableValue("main", "targetingIndicators", targetingIndicators)
end

TargetingIndicator:Load()