import "mathHelper"

local screen = {
	x = 0,
	y = 0,
	w = 400,
	h = 240
}

local gfx <const> = playdate.graphics
local col <const> = CheckCollisionCircleRect

local circle = gfx.image.new(10,10)
gfx.pushContext(circle)
gfx.fillRect(0,0,10,10)
gfx.popContext()

local img = gfx.image.new(screen.w, screen.h)

local particles = {}

function addParticles(position,r)
	particles[#particles + 1] = {
		x = position.x,
		y = position.y,
		a = math.random() * (math.pi *2),
		s = math.random(5, 20),
		r = r
	}
end

function particlesCount()
	return #particles
end

function deleteParticle()
	particles[#particles] = nil
end

function updateParticles()
	for i = 1, #particles do

		local particle = particles[i]

		if not col(particle,screen) then
			particle.a = particle.a + math.rad(180)
		end

		-- these lines makes the game crash after some seconds
		-- local d = AngleToNormalizedVector(particle.a)
		-- particle.x = particle.x + (d.x * particle.s )
		-- particle.y = particle.y + (d.y * particle.s)

		particle.x = particle.x + (math.cos(particle.a) * particle.s )
		particle.y = particle.y + (math.sin(particle.a) * particle.s)
		
		gfx.fillRect(particle.x, particle.y, particle.r,particle.r)
	end
end
