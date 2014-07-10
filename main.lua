-- main.lua
require 'map-functions'
require 'world'
require 'entity'
require 'AnAL'

Player = {
		playerDirection = 'U',
		playerMoving = false,
		gridX = 1,
		gridY = 1,
		offsetX = 0,
		offsetY = 0
	}

World = {
		gridWidth = 32,
		gridHeight = 32
	}


function love.load()

	Player = Entity:new()

	Player:load(32, 42)

	loadMap('maps/core-dump.lua')

end

function love.update(dt)

	Player:update(dt)

end



function love.draw()
	drawMap()

	Player:draw()

end


