function DebugPrint(...)
    local spew = Convars:GetInt('barebones_spew') or -1
    if spew == -1 and RITE_DEBUG_SPEW then
      spew = 1
    end
  
    if spew == 1 then
      print(...)
    end
end

function DebugPrintTable(...)
  local spew = Convars:GetInt('barebones_spew') or -1
  if spew == -1 and BAREBONES_DEBUG_SPEW then
    spew = 1
  end

  if spew == 1 then
    PrintTable(...)
  end
end

function PrintTable(t, indent, done)
  --print ( string.format ('PrintTable type %s', type(keys)) )
  if type(t) ~= "table" then return end

  done = done or {}
  done[t] = true
  indent = indent or 0

  local l = {}
  for k, v in pairs(t) do
    table.insert(l, k)
  end

  table.sort(l)
  for k, v in ipairs(l) do
    -- Ignore FDesc
    if v ~= 'FDesc' then
      local value = t[v]

      if type(value) == "table" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..":")
        PrintTable (value, indent + 2, done)
      elseif type(value) == "userdata" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
      else
        if t.FDesc and t.FDesc[v] then
          print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
        else
          print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        end
      end
    end
  end
end

function CountdownTimer()
  nCOUNTDOWNTIMER = nCOUNTDOWNTIMER - 1
  local t = nCOUNTDOWNTIMER
  --print( t )
  local minutes = math.floor(t / 60)
  local seconds = t - (minutes * 60)
  local m10 = math.floor(minutes / 10)
  local m01 = minutes - (m10 * 10)
  local s10 = math.floor(seconds / 10)
  local s01 = seconds - (s10 * 10)
  local broadcast_gametimer = 
      {
          timer_minute_10 = m10,
          timer_minute_01 = m01,
          timer_second_10 = s10,
          timer_second_01 = s01,
      }

  CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
  --if t <= 120 then
  --    CustomGameEventManager:Send_ServerToAllClients( "time_remaining", broadcast_gametimer )
  --end
end

function array_sub(t1, t2)
  local t = {}
  for i = 1, #t1 do
    t[t1[i]] = true;
  end
  for i = #t2, 1, -1 do
    if t[t2[i]] then
      table.remove(t2, i);
    end
  end
end