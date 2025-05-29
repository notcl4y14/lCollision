local lcol = require("lcol")

local spawn_x = 10
local spawn_y = 10

function love.load()
	-- Initializing colliders
	playerCollider = lcol.collider(spawn_x, spawn_y, 50, 50)
	lavaCollider = lcol.collider(500, 200, 200, 200)
	wallCollider = lcol.collider(300, 10, 300, 50)
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
		playerCollider.x = spawn_x
		playerCollider.y = spawn_y
	end

	if playerCollider:collides(wallCollider) then
		playerCollider:separate(wallCollider)
	end
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