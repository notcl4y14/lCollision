-- lCollision.lua
-- https://github.com/notcl4y14/lCollision/blob/main/lCollision.lua

-- Thanks to darkfrei for the code fix!
-- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=145963

local lCollision = {}
lCollision.__index = lCollision


local function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
-- from https://love2d.org/wiki/BoundingBox.lua
	return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end


function lCollision:collides(collider)
	if checkCollision(self.x, self.y, self.width, self.height, collider.x, collider.y, collider.width, collider.height) then
		return true
	end
	return false
end


function lCollision:insideOf(collider)
	if checkCollision(
		self.x, self.y, self.width, self.height, 
		collider.x+self.width, collider.y+self.height, collider.width-2*self.width, collider.height-2*self.height
		) then
		return true
	end
	
	return false
end

function lCollision:onBorder(collider)
	if self:collides(collider) and not self:insideOf(collider) then
		return true
	end
	return false
end

function lCollision:separate(collider)
	if not checkCollision(self.x,self.y,self.width,self.height, collider.x,collider.y,collider.width,collider.height) then
		-- no collision: nothing to do
		return
	end
	
	-- (dx, dy) will be orthogonal separation vector
	local dx = collider.x - self.x
	local dy = collider.y - self.y
	if self.x + self.width / 2 < collider.x + collider.width / 2 then
		-- middle point of agent is more left than by the box
		dx = dx - self.width
	else
		dx = dx + collider.width
	end
	
	if self.y + self.height / 2 < collider.y + collider.height / 2 then
		-- middle point of agent is higher than by the box
		dy = dy - self.height
	else
		dy = dy + collider.height
	end
	
	-- making the separation vector orthogonal:
	if math.abs (dx) > math.abs (dy) then
		dx = 0 -- dx was longer than dy
	else
		dy = 0
	end
	
	-- moving the self
	self.x = self.x + dx
	self.y = self.y + dy
end


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

function lCollision:new(x, y, width, height)
	local collider = setmetatable({x=x, y=y, width=width, height=height}, self)
	return collider
end


function lCollision:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end


return lCollision

-- Old code
--[[local lCollision = {}

local function range(x1, y1, width1, height1, x2, y2, width2, height2)
	if x1 >= x2 and x1 + width1 <= x2 + width2 and y1 >= y2 and y1 + height1 <= y2 + height2 then
		return true
	end
	
	return false
end

local function rangeWhole(x1, y1, width1, height1, x2, y2, width2, height2)
	if x1 + width1 >= x2 and x1 <= x2 + width2 and y1 + height1 >= y2 and y1 <= y2 + width2 then
		return true
	end
	
	return false
end

lCollision.Collider = {}
lCollision.Collider.__index = lCollision.Collider

function lCollision.Collider:new(x, y, width, height, class)
	local collider = setmetatable({}, self)
	
	collider.x = x
	collider.y = y
	collider.class = class or {}
	collider.width = width
	collider.height = height
	
	return collider
end

function lCollision.Collider:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

-- This function used to be called collider:collides(collider) until it showed that it can detect if a collider is INSIDE of another one
function lCollision.Collider:insideOf(collider)
	local isThatClass = false

	if class then
		for i, value in pairs(collider.class) do
			if value == class then
				isThatClass = true
				break
			end
		end

		if not isThatClass then
			return false
		end
	end
	
	if range(self.x, self.y, self.width, self.height, collider.x, collider.y, collider.width, collider.height) then
		return true
	end
	
	return false
end

function lCollision.Collider:collides(collider, class)
	local isThatClass = false

	if class then
		for i, value in pairs(collider.class) do
			if value == class then
				isThatClass = true
				break
			end
		end

		if not isThatClass then
			return false
		end
	end

	if rangeWhole(self.x, self.y, self.width, self.height, collider.x, collider.y, collider.width, collider.height) then
		return true
	end
	
	return false
end

function lCollision.Collider:getCenter()
	local x = self.x + self.width / 2
	local y = self.y + self.height / 2
	
	return x, y
end

return lCollision]]

