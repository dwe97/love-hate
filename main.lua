-- main.lua
require 'map-functions'
require 'world'
require 'entity'
require 'AnAL'

world = World:new(nil, 32, 32)

function love.load()
	Player = Entity:new()
	Player:load(32, 42)
	world:addEntity(Player)

	loadMap('maps/core-dump.lua')
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	drawMap()
	world:draw()
end
