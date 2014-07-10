-- main.lua
require 'map-functions'
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
	Player.playerMoving = false

	upImage, rightImage, downImage, leftImage =
		love.graphics.newImage("stueyarg_up.png"),
		love.graphics.newImage("stueyarg_right.png"),
		love.graphics.newImage("stueyarg_down.png"),
		love.graphics.newImage("stueyarg_left.png");

	local playerSpriteWidth, playerSpriteHeight = 32, 42;

	PlayerAnimations = {
		{'U', newAnimation(upImage, playerSpriteWidth, playerSpriteHeight, 0.2, 0)},
		{'R', newAnimation(rightImage, playerSpriteWidth, playerSpriteHeight, 0.2, 0)},
		{'D', newAnimation(downImage, playerSpriteWidth, playerSpriteHeight, 0.2, 0)},
		{'L', newAnimation(leftImage, playerSpriteWidth, playerSpriteHeight, 0.2, 0)},
		{'S', love.graphics.newQuad( 0, 0, playerSpriteWidth, playerSpriteHeight, playerSpriteWidth, playerSpriteHeight)},
	};

	loadMap('maps/core-dump.lua')

end

function love.update(dt)
	-- Updates the animation. (Enables frame changes)

	MovementVector = {
		{'U',  0, -1},	-- up
		{'R',  1,  0},	-- right
		{'D',  0,  1},	-- down
		{'L', -1,  0}	-- left
	}

	if Player.playerMoving == false then

		if love.keyboard.isDown("up") then
			Player.playerDirection = 'U'
			Player.playerMoving = true
		end

		if love.keyboard.isDown("right") then
			Player.playerDirection = 'R'
			Player.playerMoving = true
		end

		if love.keyboard.isDown("down") then
			Player.playerDirection = 'D'
			Player.playerMoving = true
		end

		if love.keyboard.isDown("left") then
			Player.playerDirection = 'L'
			Player.playerMoving = true
		end

	end

	for _,anim in ipairs(PlayerAnimations) do
		-- anim[1] = U,R,D, or L; anim[2] = newAnimation
		if (anim[1] == Player.playerDirection) and (anim[1] ~= 'S') then
			if Player.playerMoving then
				anim[2]:update(dt)
			else
				anim[2]:reset()
			end
		end
	end


	if Player.playerMoving == true then

		currentMovement = {0, 0}

		for _,movement in ipairs(MovementVector) do
			-- movement[1] = U,R,D, or L;
			-- [2] = x movement
			-- [3] = y movement
			if movement[1] == Player.playerDirection then
				Player.offsetX = Player.offsetX + movement[2]
				Player.offsetY = Player.offsetY + movement[3]
				currentMovement[1] = movement[2]
				currentMovement[2] = movement[3]
			end
		end

		if (Player.offsetX ~= 0) and (math.abs(Player.offsetX) % World.gridWidth) == 0 then
			Player.playerMoving = false
			Player.gridX = Player.gridX + currentMovement[1]
			Player.offsetX = 0
		end

		if (Player.offsetY ~= 0) and (math.abs(Player.offsetY) % World.gridHeight) == 0 then
			Player.playerMoving = false
			Player.gridY = Player.gridY + currentMovement[2]
			Player.offsetY = 0
		end


	end


end



function love.draw()
	drawMap()


	for _,anim in ipairs(PlayerAnimations) do
		-- anim[1] = U,R,D, or L; anim[2] = newAnimation
			if (anim[1] == Player.playerDirection) then
					anim[2]:draw(
						(Player.gridX * World.gridWidth) + Player.offsetX,
						(Player.gridY * World.gridHeight) - (42 - 32) + Player.offsetY
					)
				end
			end
		end


