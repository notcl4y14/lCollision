local lcol = require("lcol")

local spawn_x = 10
local spawn_y = 10

function love.load()
	-- Initializing colliders
	playerCollider = lcol.collider(spawn_x, spawn_y, 50, 50)
	lavaCollider = lcol.collider(500, 200, 200, 200)
	wallCollider1 = lcol.collider(300, 10, 300, 50)
	wallCollider2 = lcol.collider(605, 65, 50, 100)
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

	if playerCollider:collides(wallCollider1) then
		playerCollider:separate(wallCollider1)
	end

	if playerCollider:collides(wallCollider2) then
		playerCollider:separate(wallCollider2)
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
	wallCollider1:draw()
	wallCollider2:draw()
end