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

function lcollider:collides (collider)
	return lcol.collides(self, collider)
end

function lcollider:separate (collider)
	lcol.separate(self, collider)
end

function lcollider:draw ()
	lcol.draw(self)
end

local function collision (x1,y1,w1,h1, x2,y2,w2,h2)
	-- https://love2d.org/wiki/BoundingBox.lua
	return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

local function colliderCollision (c1, c2)
	return c1.x < c2.x + c2.w
	   and c2.x < c1.x + c1.w
	   and c1.y < c2.y + c2.h
	   and c2.y < c1.y + c1.h
end

function lcol.collides(c1, c2)
	return collision(
		c1.x, c1.y,
		c1.w, c1.h,
		c2.x, c2.y,
		c2.w, c2.h)
end

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

function lcol.collider (x, y, w, h)
	return setmetatable({
		x = x,
		y = y,
		w = w,
		h = h}, lcollider)
end

function lcol.draw(collider, mode)
	local mode = mode or "line"
	love.graphics.rectangle(mode, collider.x, collider.y, collider.w, collider.h)
end

return lcol