--this code is owned and licenced by Mega2223
--all rights apply, for more info seek this repo at github.com/Mega2223

--consts
GOAL_BASE = 0
GOAL_TO_CHUNK = 1
GOAL_SEARCH = 2
GOAL_CLEAR_CHUNK = 3
DIR_NORTH = 0
DIR_SOUTH = 1
DIR_EAST = 2
DIR_WEST = 3

--movement related functions
function getCoords()
	return x,y,z
end

function updateData()
	if gps.locate() ~= nil then 
		x,y,z = gps.locate()
	end
end

function moveForward()
	r = turtle.forward()
	if r and getDirection == DIR_NORTH then
		z = z - 1
	end
	if r and getDirection == DIR_SOUTH then
		z = z + 1
	end
	if r and getDirection == DIR_EAST then
		x = x + 1
	end
	if r and getDirection == DIR_WEST then
		x = x - 1
	end
	return r
end

function moveUp()
	r = turtle.up()
	if r then y = y + 1 end
	return r
end

function moveDown()
	r = turtle.down()
	if r then y = y - 1 end
	return r
end



function directionString(dir)
	if dir == DIR_NORTH then return "north" end
	if dir == DIR_SOUTH then return "south" end
	if dir == DIR_EAST then return "east" end
	if dir == DIR_WEST then return "west" end
	return "idk"
end

function getDirection()
	while currentDirection == nil do
		local cX = x
		local cY = y
		local cZ = z
		could = moveForward()
		if not could then
			while not moveUp() do
				turtle.digUp(SHOVEL_HAND)
			end
		else
			updateData()
			if x > cX then currentDirection = DIR_EAST
			elseif x < cX then currentDirection = DIR_WEST
			elseif z > cZ then currentDirection = DIR_SOUTH
			elseif z < cZ then currentDirection = DIR_NORTH end
		end
		
	end
	return currentDirection
end

function inverseDirection(dir)
	if dir == DIR_NORTH then return DIR_SOUTH end
	if dir == DIR_SOUTH then return DIR_SOUTH end
	if dir == DIR_EAST then return DIR_WEST end
	if dir == DIR_WEST then return DIR_EAST end
	return nil
end

function getDirectionRight(dir)
	if dir == DIR_NORTH then return DIR_EAST end
	if dir == DIR_EAST then return DIR_SOUTH end
	if dir == DIR_SOUTH then return DIR_WEST end
	if dir == DIR_WEST then return DIR_NORTH end
	return nil
end

function getDirectionLeft(dir)
	if dir == DIR_EAST then return DIR_NORTH end
	if dir == DIR_SOUTH then return DIR_EAST end
	if dir == DIR_WEST then return DIR_SOUTH end
	if dir == DIR_NORTH then return DIR_WEST end
	return nil
end

function turnToDirection(toDir)
	getDirection()
	while toDir ~= currentDirection do turtle.turnRight() currentDirection = getDirectionRight(currentDirection) end
end

function walkTo (toX, toZ)
	while x < toX do
		turnToDirection(DIR_EAST)
		pushForward()
	end
	while x > toX do
		turnToDirection(DIR_WEST)
		pushForward()
	end
	while z < toZ do
		turnToDirection(DIR_SOUTH)
		pushForward()
	end
	while z > toZ do
		turnToDirection(DIR_NORTH)
		pushForward()
	end
end

function pushForward()
	while not moveForward() do
		moveUp()
		--while not moveUp() do
		--	acacac = getDirection()
		--	turnToDirection(inverseDirection(acacac))
		--	pushForward()
		--	turnToDirection(acacac)
		--end
	end
	while not turtle.detectDown() do
		moveDown()
	end
	updateData()
end

function toY (yToY)
	updateData()
	while(y > yToY) do
		pushBelow()
		updateData()
	end
	while(y < yToY) do
		pushAbove()
		updateData()
	end
	
end

function gotoGround()
	while not turtle.detectDown() do
		moveDown()
	end
end

function pushBelow()
	while not down() do digDown(SHOVEL_HAND) end
end

function pushAbove()
	while not up() do digUp(SHOVEL_HAND) end
end
--North = -Z
--East = +X
function getDirectionAxis(sX,sZ,eX,eZ)
	zAxis = DIR_NORTH
	xAxis = DIR_EAST
	
	if eZ > sZ then
		zAxis = DIR_SOUTH
	end
	if eX < sX then
		xAxis = DIR_WEST
	end
	return xAxis, zAxis
end
