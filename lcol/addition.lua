-- lcol/addition.lua
-- https://github.com/notcl4y14/lCollision

-- This module contains extra functions for lcol library
-- Nevermind

local lcol_extra = {}

function lcol_extra.draw(collider, mode)
	local mode = mode or "line"
	love.graphics.rectangle(mode, collider.x, collider.y, collider.w, collider.h)
end

return lcol_extra