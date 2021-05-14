function Interpolate(value, min, max)
	return value * (max - min) + min
end

function ClampPosition(vOrigin, vPoint, iMaxRange, iMinRange)
	local direction = (vPoint - vOrigin):Normalized()
	local distance = (vPoint - vOrigin):Length2D()
	local output_point = vPoint
	
	if iMaxRange then
		if distance > iMaxRange then
			output_point = vOrigin + direction * iMaxRange
		end
	end

	if iMinRange then
		if distance < iMinRange then
			output_point = vOrigin + direction * iMinRange
		end
	end

	return output_point
end

function Clamp(iNumber, iMax, iMin)
	if iMax and (iNumber > iMax) then
		return iMax
	end
	if iMin and (iNumber < iMin) then
		return iMin
	end
	return iNumber
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

function Direction2D(vOrigin, vPoint)
	return Vector(
		vPoint.x - vOrigin.x, 
		vPoint.y - vOrigin.y, 
		0
	):Normalized()
end
