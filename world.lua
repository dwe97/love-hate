World = {
		gridWidth,
		gridHeight,
		entities = {}
	}

function World:new(o, _gridWidth, _gridHeight)

	if o ~= nil then
		o = o
	else
		o = {}
	end

	setmetatable(o, self)
	self.__index = self
	o.gridWidth = _gridWidth
	o.gridHeight = _gridHeight
	return o
end


function World:_updateEntities(dt)
	if self.entities == nil then
		return
	end

	for _,entity in ipairs(self.entities) do
		entity:update(dt, self.gridWidth, self.gridHeight)
	end
end

function World:update(dt)
	self:_updateEntities(dt)
end

function World:draw()
	self:_drawEntities()
end

function World:_drawEntities()

	if self.entities == nil then
		return
	end

	for _,entity in ipairs(self.entities) do
		entity:draw(self.gridWidth, self.gridHeight)
	end
end

function World:addEntity(e)
	if e == nil then
		return
	end

	table.insert(self.entities, e)
end
