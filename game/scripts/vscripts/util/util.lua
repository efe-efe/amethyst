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

RADIUS_SCOPE_PUBLIC = 1
RADIUS_SCOPE_LOCAL = 2

local RED = Vector(255, 1, 1)
local GREEN = Vector(1, 255, 1)

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

function LinkAbilityCooldowns(hCaster, sLinkedSpell, tUnlinkLevels)
	local bStartCooldown = true
	local hLinkedSpell = hCaster:FindAbilityByName(sLinkedSpell)

	if not hLinkedSpell then
		print('LinkAbilityCooldowns ERROR:', sLinkedSpell, ' NOT FOUND!')
		return
	end

	if hLinkedSpell:GetLevel() == 0 then
		return
	end

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

function CurveProjectile(hCaster, vPoint, nSpeed, fCallback)
	local nDistance = (hCaster:GetAbsOrigin() - vPoint):Length2D()
	local nTime = nDistance/nSpeed
    local hDummy = CreateModifierThinker(hCaster, nil, nil, {},	vPoint, hCaster:GetTeamNumber(), false)
    local hProjectile = {
        Target 				= hDummy,
        Source 				= hCaster,
        Ability 			= nil,
        EffectName 			= "particles/curve_projectile.vpcf",
        iMoveSpeed			= nSpeed,
        flExpireTime 		= GameRules:GetGameTime() + 20,
    }
    
	Timers:CreateTimer(nTime, function()
		fCallback(vPoint)
		hDummy:RemoveSelf()
	end)

    ProjectileManager:CreateTrackingProjectile(hProjectile)
end