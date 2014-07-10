World = {
		gridWidth = 32,
		gridHeight = 32
	}

function World:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function World:update(dt)
end
