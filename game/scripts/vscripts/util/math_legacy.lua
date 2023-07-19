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
