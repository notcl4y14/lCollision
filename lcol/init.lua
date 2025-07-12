-- lcol/init.lua
-- https://github.com/notcl4y14/lCollision

-- Thanks to darkfrei for the code fix!
-- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=145963

local lcol = {}

local lcollider = {
	x = 0, y = 0,
	w = 0, h = 0,
};
lcollider.__index = lcollider;

-- --------------------------------
-- lcollider methods
-- --------------------------------

-- Checks if collider is currently colliding
-- with another collider
-- @param collider lcollider
-- @return boolean
function lcollider:collides (collider)
	return lcol.collides(self, collider)
end

-- Checks if collider collides
-- with another collider at specific offset
-- @param collider lcollider
-- @param ox number
-- @param oy number
-- @return boolean
function lcollider:collidesAt (collider, ox, oy)
	return lcol.collidesAt(self, collider, ox, oy)
end

-- Pushes collider A from collider B
-- to the closest side of collider B
-- @param collider lcollider
-- @return boolean
function lcollider:separate (collider)
	lcol.separate(self, collider)
end

-- Draws collider
-- Parameter mode is "line" by default. ("line"|"fill")
-- @param mode string?
-- @return boolean
function lcollider:draw (mode)
	lcol.draw(self, mode)
end

-- --------------------------------
-- Local functions
-- --------------------------------

local function collision (x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2
	   and x2 < x1 + w1
	   and y1 < y2 + h2
	   and y2 < y1 + h1
end

local function colliderCollision (c1, c2)
	return c1.x < c2.x + c2.w
	   and c2.x < c1.x + c1.w
	   and c1.y < c2.y + c2.h
	   and c2.y < c1.y + c1.h
end

-- --------------------------------
-- lcol (module) functions
-- --------------------------------

-- Checks if both colliders are currently colliding
-- @param c1 lcollider
-- @param c2 lcollider
-- @return boolean
function lcol.collides(c1, c2)
	return collision(
		c1.x, c1.y,
		c1.w, c1.h,
		c2.x, c2.y,
		c2.w, c2.h)
end


-- Checks collider A collides with collider B
-- at specific offset of collider A position
-- @param c1 lcollider
-- @param c2 lcollider
-- @param ox number
-- @param oy number
-- @return boolean
function lcol.collidesAt(c1, c2, ox, oy)
	return collision(
		c1.x + ox, c1.y + oy,
		c1.w, c1.h,
		c2.x, c2.y,
		c2.w, c2.h)
end

-- Pushes collider A from collider B
-- to the closest side of collider B
-- @param c1 lcollider
-- @param c2 lcollider
-- @return boolean
function lcol.separate(c1, c2)
	-- (dx, dy) will be orthogonal separation vector
	local dx = c2.x - c1.x
	local dy = c2.y - c1.y

	if c1.x + (c1.w / 2) < c2.x + (c2.w / 2) then
		-- middle point of agent is more left than by the box
		dx = dx - c1.w
	else
		dx = dx + c2.w
	end
	
	if c1.y + (c1.h / 2) < c2.y + (c2.h / 2) then
		-- middle point of agent is higher than by the box
		dy = dy - c1.h
	else
		dy = dy + c2.h
	end
	
	-- making the separation vector orthogonal:
	if math.abs (dx) > math.abs (dy) then
		dx = 0 -- dx was longer than dy
	else
		dy = 0
	end
	
	-- moving the c1
	c1.x = c1.x + dx
	c1.y = c1.y + dy
end

-- Creates a new collider
-- @param x number
-- @param y number
-- @param w number
-- @param h number
-- @return boolean
function lcol.collider (x, y, w, h)
	return setmetatable({
		x = x,
		y = y,
		w = w,
		h = h}, lcollider)
end

-- Draws collider
-- Parameter mode is "line" by default. ("line"|"fill")
-- @param collider lcollider
-- @param mode string?
function lcol.draw(collider, mode)
	local mode = mode or "line"
	love.graphics.rectangle(mode, collider.x, collider.y, collider.w, collider.h)
end

return lcol