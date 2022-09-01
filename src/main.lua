import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "party"

local lastDT = playdate.getCurrentTimeMilliseconds()
local bg = playdate.graphics.image.new(400,240)

local screen = {
	x = 0,
	y = 0,
	w = 400,
	h = 240
}

playdate.display.setRefreshRate(50)

playdate.graphics.pushContext(bg)
playdate.graphics.drawRect(0,0,400,240)
playdate.graphics.popContext()

playdate.graphics.sprite.setBackgroundDrawingCallback(
	function( x, y, width, height )
		bg:draw( 0, 0 )
	end
)
local down = false
playdate.AButtonDown = function ()
	-- createCircles()
	down = true
end
playdate.AButtonUp = function ()
	down = false
end

local shakeTime = 0

playdate.BButtonDown = function ()
	deleteParticle()
	shakeTime = 10
end

local lessThan30 = 0
local greaterThan30 = 0


playdate.update = function()

	if shakeTime > 0 then
		shakeTime = shakeTime - 1
		playdate.graphics.setDrawOffset(
			math.random() * 5,math.random() * 5
		)
	end

	local now = playdate.getCurrentTimeMilliseconds()
	local dt = now - lastDT

	if dt >= 30 then
		greaterThan30 = greaterThan30 + 1
	elseif dt <= 30 then
		lessThan30 = lessThan30 + 1
	end

	lastDT = now

	playdate.graphics.sprite.update()

	updateParticles()

	playdate.graphics.drawText(
		"Rectangles: " .. particlesCount() ..
		"\nFrame time: " .. dt..
		"\n>30?: " ..((dt > 30) and "true" or "false") .. 
		"\n>30: "..greaterThan30,		
		10, 10)

	if down then
		createCircles()
	end
	
end

function createCircles()
	addParticles({
		x = screen.w / 2,
		y = screen.h / 2
	},20)
end