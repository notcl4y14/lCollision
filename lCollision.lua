local lCollision = {}

local function range(x1, y1, width1, height1, x2, y2, width2, height2)
  if x1 >= x2 and x1 + width1 <= x2 + width2 and y1 >= y2 and y1 + height1 <= y2 + height2 then
    return true
  end
  
  return false
end

local function rangeWhole(x1, y1, width1, height1, x2, y2, width2, height2)
  --if x1 >= x2 and x1 + width1 <= x2 + width2 + width1 and y1 >= y2 and y1 + height1 <= y2 + height2 + height1 then
  if x1 + width1 >= x2 and x1 <= x2 + width2 and y1 + height1 >= y2 and y1 <= y2 + width2 then
    return true
  end
  
  return false
end

lCollision.Collider = {}
lCollision.Collider.__index = lCollision.Collider

function lCollision.Collider:new(x, y, width, height)
  local collider = setmetatable({}, self)
  
  collider.x = x
  collider.y = y
  collider.width = width
  collider.height = height
  
  return collider
end

function lCollision.Collider:draw()
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

-- This function used to be called collider:collides(collider) until it showed that it can detect if a collider is INSIDE of another one
function lCollision.Collider:insideOf(collider)
  if range(self.x, self.y, self.width, self.height, collider.x, collider.y, collider.width, collider.height) then
    return true
  end
  
  return false
end

function lCollision.Collider:collides(collider)
  if rangeWhole(self.x, self.y, self.width, self.height, collider.x, collider.y, collider.width, collider.height) then
    return true
  end
  
  return false
end

return lCollision