local lCollision = require("lCollision")

collider1 = lCollision.Collider:new(10, 10, 20, 20)
collider2 = lCollision.Collider:new(100, 100, 50, 50)
collider3 = lCollision.Collider:new(200, 100, 50, 50)
collider4 = lCollision.Collider:new(300, 100, 50, 50)

speed = 3

local function booleanToNumber(boolean)
  if boolean == true then
    return 1
  elseif boolean == false then
    return 0
  end
end

function love.load()
end

function love.update(dt)
  local directionX = booleanToNumber(love.keyboard.isDown("right")) - booleanToNumber(love.keyboard.isDown("left"))
  local directionY = booleanToNumber(love.keyboard.isDown("down")) - booleanToNumber(love.keyboard.isDown("up"))
  
  collider1.x = collider1.x + directionX * speed
  collider1.y = collider1.y + directionY * speed
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  
  love.graphics.print("Arrow keys - Move", 500, 200)
  
  collider1:draw()
  
  -- collides()
  love.graphics.print("collides()", collider2.x, collider2.y - 20)
  
  if collider1:collides(collider2) then
    love.graphics.setColor(1, 0, 0, 1)
  end
  
  collider2:draw()
  
  -- insideOf()
  love.graphics.setColor(1, 1, 1, 1)
  
  love.graphics.print("insideOf()", collider3.x, collider3.y - 20)
  
  if collider1:insideOf(collider3) then
    love.graphics.setColor(1, 0, 0, 1)
  end
  
  collider3:draw()
  
  -- collides() and not insideOf()
  love.graphics.setColor(1, 1, 1, 1)
  
  love.graphics.print("collides() and not insideOf()", collider4.x, collider4.y - 20)
  
  if collider1:collides(collider4) and not collider1:insideOf(collider4) then
    love.graphics.setColor(1, 0, 0, 1)
  end
  
  collider4:draw()
end