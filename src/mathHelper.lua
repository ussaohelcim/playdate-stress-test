local cos <const> = math.cos
local abs <const> = math.abs
local atan <const> = math.atan

---@param angle number in radians
function AngleToNormalizedVector(angle)
	return { 
		x = math.cos(angle),
		y = math.sin(angle)
	}
end

function CheckCollisionCircleRect(center,rec)
	local collision = false

	local recCenterX = (rec.x + rec.w/2);
	local recCenterY = (rec.y + rec.h/2);

	local dx = abs(center.x - recCenterX);
	local dy = abs(center.y - recCenterY);

	if (dx > (rec.w/2 + center.r)) then
		return false
	end 

	if (dy > (rec.h/2 + center.r)) then
		return false
	end 

	if (dx <= (rec.w/2)) then
		return true
	end 
	if (dy <= (rec.h/2)) then
		return true
	end 

	local cornerDistanceSq = (dx - rec.w/2)*(dx - rec.w/2) +
														(dy - rec.h/2)*(dy - rec.h/2);

	collision = (cornerDistanceSq <= (center.r*center.r));

	return collision;
end