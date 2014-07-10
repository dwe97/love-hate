-- ======================== MIT LICENSE =========================
-- 
-- Copyright (c) 2010 Enrique García Cota
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
-- 
-- ==================== END OF MIT LICENSE =================


local tileW, tileH, tileset, quads, tileTable

function loadMap(path)
  love.filesystem.load(path)() -- attention! extra parenthesis
end

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
	tileW = tileWidth
	tileH = tileHeight

	tileset = love.graphics.newImage(tilesetPath)

	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	quads = {};
	for _,info in ipairs(quadInfo) do
		-- info[1] = character, info[2] = x, info[3] = y
		quads[info[1]] = love.graphics.newQuad( info[2], info[3], tileW, tileH, tilesetW, tilesetH)
	end

	tileTable = {}

	local width = #(tileString:match("[^\n]+"))

	for x = 1,width,1 do tileTable[x] = {} end

	local x,y = 1,1
	for row in tileString:gmatch("[^\n]+") do
		x = 1
		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(y) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
		for character in row:gmatch(".") do
			tileTable[x][y] = character
			x = x + 1
		end
		y = y +1
	end
end

function drawMap()
	for columnIndex,column in ipairs(tileTable) do
		for rowIndex,char in ipairs(column) do
			local x = (columnIndex-1)*tileW
			local y = (rowIndex-1)*tileH
			love.graphics.draw(tileset, quads[char], x, y)
		end
	end
end