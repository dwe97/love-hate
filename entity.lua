Entity = {
		direction = 'U',
		moving = false,
		gridX = 1,
		gridY = 1,
		offsetX = 0,
		offsetY = 0
	}

function Entity:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Entity:update(dt)
function love.update(dt)
	-- Updates the animation. (Enables frame changes)

	MovementVector = {
		{'U',  0, -1},	-- up
		{'R',  1,  0},	-- right
		{'D',  0,  1},	-- down
		{'L', -1,  0}	-- left
	}

	if self.moving == false then

		if love.keyboard.isDown("up") then
			self.direction = 'U'
			self.moving = true
		end

		if love.keyboard.isDown("right") then
			self.direction = 'R'
			self.moving = true
		end

		if love.keyboard.isDown("down") then
			self.direction = 'D'
			self.moving = true
		end

		if love.keyboard.isDown("left") then
			self.direction = 'L'
			self.moving = true
		end

	end

	for _,anim in ipairs(PlayerAnimations) do
		-- anim[1] = U,R,D, or L; anim[2] = newAnimation
		if (anim[1] == self.direction) and (anim[1] ~= 'S') then
			if self.moving then
				anim[2]:update(dt)
			else
				anim[2]:reset()
			end
		end
	end


	if self.moving == true then

		currentMovement = {0, 0}

		for _,movement in ipairs(MovementVector) do
			-- movement[1] = U,R,D, or L;
			-- [2] = x movement
			-- [3] = y movement
			if movement[1] == self.direction then
				self.offsetX = self.offsetX + movement[2]
				self.offsetY = self.offsetY + movement[3]
				currentMovement[1] = movement[2]
				currentMovement[2] = movement[3]
			end
		end

		if (self.offsetX ~= 0) and (math.abs(self.offsetX) % World.gridWidth) == 0 then
			self.moving = false
			self.gridX = self.gridX + currentMovement[1]
			self.offsetX = 0
		end

		if (self.offsetY ~= 0) and (math.abs(self.offsetY) % World.gridHeight) == 0 then
			self.moving = false
			self.gridY = self.gridY + currentMovement[2]
			self.offsetY = 0
		end


	end


end
end
