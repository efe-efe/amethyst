
function PrintTable(t, indent, done)
	--print (string.format ('PrintTable type %s', type(keys)))
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
	--print(t)
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

	--CustomGameEventManager:Send_ServerToAllClients("countdown", broadcast_gametimer)
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

	DebugDrawCircle(vStartPos, Vector(255,0,0), 5, fStartRadius, false, 1.0)
	DebugDrawCircle(vEndPos, Vector(255,255,0), 5, fEndRadius, false, 1.0)

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
		local fInterpRadius = Interpolate((fProjection/distance), fEndRadius, fStartRadius)
		
		-- if unit is within distance, add them
		if fUnitRadius <= fInterpRadius then
			table.insert(targets, unit)
		end
	end

	return targets
end

function Interpolate(value, min, max)
	return value * (max - min) + min
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

function ClampPosition(origin, point, max_range, min_range)
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

function Clamp(iNumber, iMax, iMin)
	if iNumber > iMax then
		return iMax
	end
	if iNumber < iMin then
		return iMin
	end
	return iNumber
end


RADIUS_SCOPE_PUBLIC = 1
RADIUS_SCOPE_LOCAL = 2

local RED = Vector(255, 1, 1)
local GREEN = Vector(1, 255, 1)

function GetCurrentLevelValue(ability, key)
	local ability_key_values = ability:GetAbilityKeyValues()
	local value = nil

	if ability_key_values then
		local m_value = ability_key_values[key]

		if m_value then
			if type(m_value) == 'number' then
				value = m_value
			else
				value = tonumber(string.split(m_value, ' ')[ability:GetLevel()])
			end
		end
	end

	return value
end

function SendOverheadDamageMessage(unit, value)
	local word_length = string.len(tostring(math.floor(value)))
	local color =  Vector(250, 70, 70)

	OverheadMessageEFX(unit, value, word_length, color, 0)
end

function SendOverheadHealMessage(unit, value)
	local word_length = string.len(tostring(math.floor(value))) + 1
	local color =  Vector(70, 250, 70)

	OverheadMessageEFX(unit, value, word_length, color, 0)
end

function SendOverheadManaMessage(unit, value)
	local word_length = string.len(tostring(math.floor(value))) + 1
	local color =  Vector(27, 113, 230)

	OverheadMessageEFX(unit, value, word_length, color, 0)
end

function SendOverheadShieldMessage(unit, value)
	local word_length = string.len(tostring(math.floor(value))) + 1
	local color =  Vector(255, 255, 255)

	OverheadMessageEFX(unit, value, word_length, color, 7)
end

function SendOverheadEnergyMessage(unit, value)
	local word_length = string.len(tostring(math.floor(value))) + 1
	local color =  Vector(255, 243, 140)

	OverheadMessageEFX(unit, value, word_length, color, 0)
end

function OverheadMessageEFX(unit, value, word_length, color, shield)
	local duration = math.max(1, value / 10)

	EFX('particles/msg_damage.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = unit:GetAbsOrigin(),
		cp1 = Vector(0, value, shield),
		cp2 = Vector(duration, word_length, 0),
		cp3 = color,
		release = true,
	})
end

function CreateTimedRadiusMarker(caster, origin, radius, delay, duration, scope)
	return CreateModifierThinker(
        caster, --hCaster
        nil, --hAbility
        "radius_marker_thinker", --modifierName
        { 
			afterDelay = duration,
			radius = radius,
			delay = delay,
			scope = scope,
		},
        origin, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   	)
end

function CreateRadiusMarker(caster, origin, radius, scope, duration)
	local effect_cast
	local color = GREEN
	local particle_cast = "particles/aoe_marker.vpcf"
	
	if scope == RADIUS_SCOPE_PUBLIC then
		for _,alliance in pairs(GameRules.GameMode.alliances) do
			for _,team in pairs(alliance.teams) do
				if caster:GetTeam() == team then
					color = GREEN
				else
					color = RED
				end
				effect_cast = ParticleManager:CreateParticleForTeam(particle_cast, PATTACH_WORLDORIGIN, nil, team)
				RadiusMarkerEfx(effect_cast, origin, radius, color, duration)
			end
		end
	else
		effect_cast = ParticleManager:CreateParticleForPlayer(particle_cast, PATTACH_WORLDORIGIN, nil, caster:GetPlayerOwner())
		color = GREEN
		RadiusMarkerEfx(effect_cast, origin, radius, color, duration)
	end
end

function RadiusMarkerEfx(effect_cast, origin, radius, color, duration)
	ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 1 , 1))
	ParticleManager:SetParticleControl(effect_cast, 2, color)
    ParticleManager:SetParticleControl(effect_cast, 3, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function EFX(path, attach, parent, options)
    if parent and parent.GetUnit then
        parent = parent:GetUnit()
    end

    local index = ParticleManager:CreateParticle(path, attach, parent)

    for i = 0, 16 do
        local cp = options["cp"..tostring(i)]
        local cpf = options["cp"..tostring(i).."f"]

        if cp then
            -- Probably vector
            if type(cp) == "userdata" then
                ParticleManager:SetParticleControl(index, i, cp)
            end

            -- Entity
            if type(cp) == "table" then
                if cp.ent and cp.ent.GetUnit then
                    cp.ent = cp.ent:GetUnit()
                end

                cp.ent = cp.ent or parent

                if not cp.attach then
                    cp.attach = PATTACH_POINT_FOLLOW
                end

                ParticleManager:SetParticleControlEnt(index, i, cp.ent, cp.attach, cp.point, cp.ent:GetAbsOrigin(), true)
            end
        end

        if cpf then
            ParticleManager:SetParticleControlForward(index, i, cpf)
        end
    end

    if options.release then
        ParticleManager:ReleaseParticleIndex(index)
    else
        return index
    end
end

function DEFX(index, force)
    force = force ~= nil

    ParticleManager:DestroyParticle(index, force)
    ParticleManager:ReleaseParticleIndex(index)
end

function ReplenishEFX(parent)
	local particle_cast = "particles/units/heroes/hero_wisp/wisp_death.vpcf"
    local origin = parent:GetAbsOrigin()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, parent)
	ParticleManager:SetParticleControlEnt(
		effect_cast, 
		0, 
		parent, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function ApplyCallbackForUnitsInArea(caster, origin, radius, team, callback)
	local enemies = CustomEntities:FindUnitsInRadius(
		caster,
		origin, 
		radius, 
		team, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)

	for _, enemy in pairs(enemies) do 
		callback(enemy)
	end

	return enemies
end

function TrueHeal(base, heal, unit)
    CustomEntities:SetHealthCustom(unit, base + heal)

    local new_treshold = CustomEntities:GetTreshold(unit) + heal
	if new_treshold > GameRules.GameMode.max_treshold then
		CustomEntities:SetTreshold(unit, GameRules.GameMode.max_treshold)
	else
		CustomEntities:SetTreshold(unit, new_treshold)
    end

    SendOverheadHealMessage(unit, heal)
end

function LinkAbilityCooldowns(hCaster, sLinkedSpell, tUnlinkLevels)
	local bStartCooldown = true
	local hLinkedSpell = hCaster:FindAbilityByName(sLinkedSpell)

	if tUnlinkLevels then
		for _,unlinkLevel in pairs(tUnlinkLevels) do
			local hAbility = type(unlinkLevel.ability) == "table" and unlinkLevel.ability or hCaster:FindAbilityByName(unlinkLevel.ability)

			if hAbility:GetLevel() >= unlinkLevel.level then
				bStartCooldown = false
			end
		end
	end
	
	if bStartCooldown then
		hLinkedSpell:StartCooldown(hLinkedSpell:GetCooldown(0))
	end
end

function RotatePoint(vOrigin, vPoint, fAngle)
    local radians = (math.pi / 180) * fAngle
    local cos = math.cos(radians)
    local sin = math.sin(radians)
    local nx = (cos * (vPoint.x - vOrigin.x)) + (sin * (vPoint.y - vOrigin.y)) + vOrigin.x
    local ny = (cos * (vPoint.y - vOrigin.y)) - (sin * (vPoint.x - vOrigin.x)) + vOrigin.y
    
    return Vector(nx, ny)
end

function RandomIntWithExeption(iMinimum, iMaximum, iException)
	local number = RandomInt(iMinimum, iMaximum)
	if number == iException then
		number = number + 1

		if number > iMaximum then
			number = iMinimum
		end
	end

	return number
end