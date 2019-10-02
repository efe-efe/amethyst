--[[
    Progress Bars
    v1.0.0
    by Almouse

    This manager is responsible for creating and tracking "progress bars".
    These are panorama panels that appear over the top of units, with a bar
    whose filledness scales with a modifier - either its duration or stack count

    The main jobs of this manager are:
        - Provide a simple API for creating progress bars
        - Automate some of the process of cleaning up "expired" progress bars
        - Maintain a nettable to communicate with the panorama

    "Public" Functions
        - AddProgressBar: Creates a new progress bar attached to a named modifier
        - RemoveProgressBar: Remove a progress bar attached to a named modifier

        - AddTimedProgressBar: Add a progress bar with an arbitrary timer
        - RemoveTimedProgressBar: Remove aforementioned time progress bar

        - AddStackProgressBar: Add a progress bar based on an arbitrary stack modifier,
                or update the stacks of an existing one
        - RemoveStackProgressBar: Remove an arbitrary stack-based modifier

    "Private" Functions
        - StartThinkLoop: Attempts to automatically prune progress bars if they have expired
                you should still try and clean them up yourself!

--]]


if not ProgressBars then
    ProgressBars = {}
end

ProgressBars.THINK_INTERVAL = 0.03 -- CHANGED FROM 1.0. ¿Performance ISSUES?

function ProgressBars:new( o )
  o = o or {}
  setmetatable( o, self )
  self.__index = self

  self.progressBars = {}

  self:StartThinkLoop()


  LinkLuaModifier("modifier_progress_bars_dummy", "libraries/modifiers/modifier_progress_bars_dummy", LUA_MODIFIER_MOTION_NONE)

  return o
end


function ProgressBars:AddProgressBar(unit, modifierName, configuration)

    local unitID = unit:GetEntityIndex()
    local payload = {}

    -- The pair unit+modifier should be unique, but each one is individually not
    -- We make a key from this
    local tableKey = tostring(unitID).."-_-"..modifierName

    table.insert(self.progressBars, {
        tableKey = tableKey,
        unit = unit,
        modifierName = modifierName,
        configuration = configuration
    })

    for k, v in pairs(configuration) do
        payload[k] = v
    end
    payload["unitIndex"] = unit:GetEntityIndex()
    payload["modifierName"] = modifierName

    CustomNetTables:SetTableValue("progress_bars", tableKey, payload)
end

function ProgressBars:RemoveProgressBar(unit, modifierName)

    -- The pair unit+modifier should be unique, but each one is individually not
    -- We make a key from this
    local tableKey = tostring(unit:entindex()).."-_-"..modifierName

    CustomNetTables:SetTableValue("progress_bars", tableKey, nil)

    for k, v in pairs(self.progressBars) do
        if v.tableKey == tableKey then
            table.remove(self.progressBars, k)
        end
    end

end

-- Add a timed progress bar to a unit.
-- Useful if you just want to show progress, but don't have a specific modifier to attach to it
-- Each unit can only have one simultaneous timed progress bar
function ProgressBars:AddTimedProgressBar(unit, duration, configuration)
    local modifier = "modifier_progress_bars_dummy" -- As far as I know, this modifier does nothing

    unit:AddNewModifier(unit, nil, modifier, {duration=duration})
    local config = configuration
    config.progressBarType = "duration"
    self:AddProgressBar(unit, modifier, config)

end

function ProgressBars:RemoveTimedProgressBar(unit)
    local modifier = "modifier_progress_bars_dummy"
    unit:RemoveModifierByName(modifier)

    self:RemoveProgressBar(unit, modifier)

end

-- Add or update a progress bar tied to stacks
-- Useful if you just want to show progress, but have no specific modifier
function ProgressBars:AddStackProgressBar(unit, stacks, configuration)
    local modifierName = "modifier_progress_bars_dummy"
    local modifier = nil

    -- Look to see if we already added one like this
    for k,v in pairs(self.progressBars) do
        if v["unit"] == unit and v["modifierName"] == modifierName then
            modifier = unit:FindModifierByName(modifierName)
            if modifier then
                modifier:SetStackCount(stacks)
                return true
            end
        end
    end

    -- Implicitly we did not find it
    modifier = unit:AddNewModifier(unit, nil, modifierName, {})
    modifier:SetStackCount(stacks)

    local config = configuration
    config.progressBarType = "stacks"

    self:AddProgressBar(unit, modifierName, config)

end

function ProgressBars:RemoveStackProgressBar(unit)
    local modifier = "modifier_progress_bars_dummy"
    unit:RemoveModifierByName(modifier)
    self:RemoveProgressBar(unit, modifier)
end

-- Periodically cleans up any progress bars
-- For example, if the unit died or the modifier somehow vanished
function ProgressBars:StartThinkLoop()

    Timers:CreateTimer(ProgressBars.THINK_INTERVAL, function()
        -- Loop over all bars
        for k, v in pairs(self.progressBars) do
            local unit = v["unit"]
            local modifierName = v["modifierName"]

            -- If the unit is dead or the modifier gone, remove the bar
            if unit:IsNull() or
                (not unit:IsAlive()) or
                (not unit:FindModifierByName(modifierName))
            then
                self:RemoveProgressBar(unit, modifierName)
            end
        end

        return ProgressBars.THINK_INTERVAL

    end)

end

-- Self creating
if not ProgressBars.progressBars then ProgressBars:new() end

