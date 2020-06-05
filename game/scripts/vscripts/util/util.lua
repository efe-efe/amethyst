
function PrintTable(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )
	if type(t) ~= "table" then return end

	done = done or {}
	done[t] = true
	indent = indent or 0

	local l = {}
	local canCompare = true
	for k, v in pairs(t) do
		table.insert(l, k)
		if type(k) == "table" then
			canCompare = false
		end
	end

	if canCompare then
		table.sort(l)
	end
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

	--CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
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


--fMinProjection is a value from -1 to 1, 1 when the unit is aligned with vDirection, -1 is the vector opposite to vDirection
function FindUnitsInCone(nTeamNumber, vDirection, fMinProjection, vCenterPos, fRadius, hCacheUnit, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter, bCanGrowCache)
	local units = FindUnitsInRadius(
		nTeamNumber,	-- int, your team number
		vCenterPos,	-- point, center point
		hCacheUnit,	-- handle, cacheUnit. (not known)
		fRadius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		nTeamFilter,	-- int, team filter
		nTypeFilter,	-- int, type filter
		nFlagFilter,	-- int, flag filter
		nOrderFilter,	-- int, order filter
		bCanGrowCache	-- bool, can grow cache
	)

	-- Filter within cone
	local targets = {}
	for _,unit in pairs(units) do
		local direction = (unit:GetAbsOrigin() - vCenterPos):Normalized()
		local projection = direction.x * vDirection.x + direction.y * vDirection.y

		if projection >= fMinProjection then
			table.insert(targets, unit)
		end
	end

	return targets
end

function FindUnitsInCirclesProjection(nTeamNumber, vCenterPos, vStartPos, vEndPos, fStartRadius, fEndRadius, hCacheUnit, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter, bCanGrowCache)
	-- vCenterPos is used to determine searching center (FIND_CLOSEST will refer to units closest to vCenterPos)

	-- get cast direction and length distance
	local direction = vEndPos - vStartPos
	direction.z = 0

	local distance = direction:Length2D()
	direction = direction:Normalized()

	-- get max radius circle search
	local big_radius = distance + math.max(fStartRadius, fEndRadius)

	-- find enemies closest to primary target within max radius
	local units = FindUnitsInRadius(
		nTeamNumber,	-- int, your team number
		vCenterPos,	-- point, center point
		hCacheUnit,	-- handle, cacheUnit. (not known)
		big_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		nTeamFilter,	-- int, team filter
		nTypeFilter,	-- int, type filter
		nFlagFilter,	-- int, flag filter
		nOrderFilter,	-- int, order filter
		bCanGrowCache	-- bool, can grow cache
	)


	-- Filter within cone
	local targets = {}
	for _,unit in pairs(units) do
		-- get unit vector relative to vStartPos
		local vUnitPos = unit:GetAbsOrigin() - vStartPos

		-- get projection scalar of vUnitPos onto direction using dot-product
		local fProjection = vUnitPos.x * direction.x + vUnitPos.y * direction.y + vUnitPos.z * direction.z

		-- clamp projected scalar to [0,distance]
		fProjection = math.max(math.min(fProjection, distance),0)
		
		-- get projected vector of vUnitPos onto direction
		local vProjection = direction * fProjection

		-- calculate distance between vUnitPos and the projected vector
		local fUnitRadius = (vUnitPos - vProjection):Length2D()

		-- calculate interpolated search radius at projected vector
		local fInterpRadius = (fProjection/distance) * (fEndRadius - fStartRadius) + fStartRadius

		-- if unit is within distance, add them
		if fUnitRadius <= fInterpRadius then
			table.insert(targets, unit)
		end
	end

	return targets
end

function DuplicateTable(obj, seen)
	if type(obj) ~= 'table' then return obj end
	if seen and seen[obj] then return seen[obj] end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do res[DuplicateTable(k, s)] = DuplicateTable(v, s) end
	return res
end

function Clamp(origin, point, max_range, min_range)
	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()
	local output_point = point
	
	if max_range then
		if distance > max_range then
			output_point = origin + direction * max_range
		end
	end

	if min_range then
		if distance < min_range then
			output_point = origin + direction * min_range
		end
	end

	return output_point
end

function CreateRadiusMarker(caster, origin, params)
	local effect_cast

	local particle_cast_enemy = "particles/mod_units/instant_aoe_marker.vpcf"
	local particle_cast_ally = "particles/mod_units/heroes/hero_dark_willow/dw_ti8_immortal_cursed_crown_marker.vpcf"
	
	if params.show_all == 1 then
		for _,alliance in pairs(GameRules.GameMode.alliances) do
			for _,team in pairs(alliance.teams) do
				if caster:GetTeam() == team then
					effect_cast = ParticleManager:CreateParticleForTeam( particle_cast_ally, PATTACH_WORLDORIGIN, nil, team )
				else
					effect_cast = ParticleManager:CreateParticleForTeam( particle_cast_enemy, PATTACH_WORLDORIGIN, nil, team )
				end
					ParticleManager:SetParticleControl( effect_cast, 0, origin )
					ParticleManager:SetParticleControl( effect_cast, 2, Vector( params.radius, params.radius , params.radius ) )
					ParticleManager:SetParticleControl( effect_cast, 4, origin)
					ParticleManager:ReleaseParticleIndex( effect_cast )
			end
		end
	else
		effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast_ally, PATTACH_WORLDORIGIN, nil, caster:GetPlayerOwner() )
		ParticleManager:SetParticleControl( effect_cast, 0, origin )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( params.radius, params.radius , params.radius ) )
		ParticleManager:SetParticleControl( effect_cast, 4, origin)
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end