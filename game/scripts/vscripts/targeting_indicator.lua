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

    CustomNetTables:SetTableValue("main", "targetingIndicators", targetingIndicators)
end

TargetingIndicator:Load()