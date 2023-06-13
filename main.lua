local lCollision = require("lCollision")

local x = 10
local y = 10

-- Initializing colliders
playerCollider = lCollision:new(x, y, 50, 50)
lavaCollider = lCollision:new(500, 200, 200, 200)
wallCollider = lCollision:new(300, 10, 300, 50)

function love.load()
end

function love.update(dt)
	-- Player movement
	if love.keyboard.isDown("left") then
		playerCollider.x = playerCollider.x - 3
	elseif love.keyboard.isDown("right") then
		playerCollider.x = playerCollider.x + 3
	end
	
	if love.keyboard.isDown("up") then
		playerCollider.y = playerCollider.y - 3
	elseif love.keyboard.isDown("down") then
		playerCollider.y = playerCollider.y + 3
	end
	
	-- Collision detection
	if playerCollider:collides(lavaCollider) then
		playerCollider.x = x
		playerCollider.y = y
	end

	playerCollider:separate(wallCollider)
end

function love.draw()
	-- Draw the player as a white square
	love.graphics.setColor(1, 1, 1, 1)
	playerCollider:draw()
	
	-- Draw lava as a red square
	love.graphics.setColor(1, 0, 0, 1)
	lavaCollider:draw()

	-- Draw a wall as a white square
	love.graphics.setColor(1, 1, 1, 1)
	wallCollider:draw()
end