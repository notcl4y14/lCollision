# lCollision

lCollision is a simple (I guess) collision library for love2D! It's still under development but it still has some things! (But only the rectangle collider right now)
Here's an example code:

```lua
local lCollision = require("lCollision")

local x = 10
local y = 10

-- Initializing colliders
playerCollider = lCollision:new(x, y, 50, 50)
lavaCollider = lCollision:new(200, 100, 100, 100)
wallCollider = lCollision:new(100, 10, 100, 50)

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
```

## API or something

`class Collider - An object for detecting collisions (hitbox)`
`Collider lCollision:new(x: number, y: number, width: number, height: number) - Creates a new Collider instance`
`void Collider:draw() - Draws a line rectangle at the collider's position`
`boolean Collider:collides(collider: Collider) - Check if the collider collides with another given one and returns true if so`
`boolean Collider:insideOf(collider: Collider) - Check if the collider is INSIDE of the given collider and returns true if so`
`boolean Collider:onBorder(collider: Collider) - Check if the collider is on given collider's borders and NOT inside of it (collides() and not insideOf()`
`void Collider:separate(collider: Collider) - Separates a collider from another on when they collide`