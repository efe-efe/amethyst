if not AbilitiesMeta then
    AbilitiesMeta = class({})
end

function AbilitiesMeta:Load()
    local abilities_kv = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
    local meta = {}

    for key, ability in pairs(abilities_kv) do
        meta[key] = {
            targetingIndicator = ability.TargetingIndicator or {},
            energyCost = ability.AbilityEnergyCost or 0,
        }
    end
    PrintTable(meta)

    CustomNetTables:SetTableValue("main", "abilities", meta)
end

AbilitiesMeta:Load()