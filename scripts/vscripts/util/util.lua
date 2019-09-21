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

function NearestValue(table, number)
    local smallestSoFar, smallestIndex
    for i, y in ipairs(table) do
        if not smallestSoFar or (math.abs(number-y) < smallestSoFar) then
            smallestSoFar = math.abs(number-y)
            smallestIndex = i
        end
    end
    return table[smallestIndex]
end

function FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function string.split(str, sep)
  local result = {}
  local regex = ("([^%s]+)"):format(sep)
  
  for each in str:gmatch(regex) do
     table.insert(result, each)
  end

  return result
end

function string.ends(str, ending)
  return ending == '' or string.sub(str, -string.len(ending)) == ending
end
