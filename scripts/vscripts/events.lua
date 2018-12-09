--------------------------------------------------------------------------------


--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called if the player's hero is replaced with a new hero for any reason.  This function is useful for  initializing heroes, such as adding levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(keys)
  local npc = EntIndexToHScript(keys.entindex)
  
  if npc:IsRealHero() and npc.bFirstSpawnedPG == nil then
    npc.bFirstSpawnedPG = true
    --DebugPrint("[DOTARITE] Hero spawned in game for first time -- " .. npc:GetUnitName())

    local hero = npc

    --Set BaseMaxealth equal to MaxHealth
    local maxHealth = hero:GetMaxHealth()

    -- Set mana as 0
    Timers:CreateTimer(.01, function()
      hero:SetMana(0)
    end)

    -- Set aditional heroe variables
    --hero.fixedMaxHealth = maxHealth -- Original max health (before variations)

    -- Add "on damage reicived" modifier (to control the max health)
   
    --hero:AddNewModifier( hero,  nil, "modifier_health_buffer", { } )
    -- hero:AddAbility("healthBuffer")
    
    -- Level up 1 point to all spells
    for i = 0, 23 do
      local ability = hero:GetAbilityByIndex(i)
      if ability then
        if ability:GetAbilityType() ~= 2 then -- To not level up the talents
          ability:SetLevel(1)
        end
      end
    end

  end
end

