# lcol

(Formerly known as lCollision)

lcol is a simple collision library for love2D. Features included:
- Colliders
- Collision checking and separating
- That's kind of it

Colliders are NOT game objects. They are rather components of a game object that serves purpose of handling collisions. Therefore, they do NOT include other components such as images, scripts and physics handlers.

## How to use it properly

Suppose you have a game object class that has a bunch of components:
```lua
local GameObject = {
	.sprite = nil,
	.pos = {0, 0},
	.size = {0, 0},
	.update = nil,
	.draw = nil,
}
```

To put a collider into it, you need to put it like this:
```lua
local GameObject = {
	.sprite = nil,
	.collider = nil,
	.update = nil,
	.draw = nil,
}
```
As you can see here, .pos and .size components are replaced by a single collider. Because the collider object already provides these properties.

Now, the following example shows how NOT to use collider.
```lua
local collider = lcol.collider(10, 10, 20, 20)
collider.sprite = love.graphics.loadImage("char.png")
```
Again, collider is a separate component that provides a box that can handle collisions. Not a sprite.

Now, all of that said is up to you to choose. These are advices, not rules. You can even use single colliders as game objects if you don't need other components.

## Example

```lua
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
```

## API

```lua
-- --------------------------------
-- lcol (module) functions
-- --------------------------------

-- Creates a new collider
-- @param x number
-- @param y number
-- @param w number
-- @param h number
-- @return boolean
function lcol.collider (x, y, w, h)

-- Checks if both colliders are currently colliding
-- @param c1 lcollider
-- @param c2 lcollider
-- @return boolean
function lcol.collides(c1, c2)

-- Checks collider A collides with collider B
-- at specific offset of collider A position
-- @param c1 lcollider
-- @param c2 lcollider
-- @param ox number
-- @param oy number
-- @return boolean
function lcol.collidesAt(c1, c2, ox, oy)

-- Pushes collider A from collider B
-- to the closest side of collider B
-- @param c1 lcollider
-- @param c2 lcollider
-- @return boolean
function lcol.separate(c1, c2)

-- Draws collider
-- Parameter mode is "line" by default. ("line"|"fill")
-- @param collider lcollider
-- @param mode string?
function lcol.draw(collider, mode)

-- --------------------------------
-- lcollider methods
-- --------------------------------

-- Checks if collider is currently colliding
-- with another collider
-- @param collider lcollider
-- @return boolean
function lcollider:collides (collider)

-- Checks if collider collides
-- with another collider at specific offset
-- @param collider lcollider
-- @param ox number
-- @param oy number
-- @return boolean
function lcollider:collidesAt (collider, ox, oy)

-- Pushes collider A from collider B
-- to the closest side of collider B
-- @param collider lcollider
-- @return boolean
function lcollider:separate (collider)

-- Draws collider
-- Parameter mode is "line" by default. ("line"|"fill")
-- @param mode string?
-- @return boolean
function lcollider:draw (mode)
```