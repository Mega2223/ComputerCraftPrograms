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
SHOVEL_HAND = "right"
BROADCAST_TO = 2224
BROADCAST_LISTEN = 2225

--movement related functions
function getCoords()
	return x,y,z
end

function updateData()
	x,y,z = gps.locate()
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
		could = turtle.forward()
		if not could then
			while not turtle.up() do
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
		turnToDirection(DIR_EAST)
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
	while not turtle.forward() do
		while not turtle.up() do
			acacac = getDirection()
			turnToDirection(inverseDirection(acacac)
			pushForward()
			turnToDirection(acacac)
		end
	end
	while not turtle.detectDown() do
		turtle.down()
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
		turtle.down()
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

function clearSnow(sX,sZ,eX,eZ)
	walkTo(sX,sZ)
	dirX, dirZ = getDirectionAxis(sX,sZ,eX,eZ)
	turnToDirection(dirX)
	print("Virando para" .. directionString(dirX))
	local xC, yC, sZ = getCoords()
	while not zC == zX do
		while not xC == eX do
			clearForward()
			updateData()
		end
		turnToDirection(dirZ)
		clearForward()
		dirX = inverseDirection(dirX)
		turnToDirection(dirX)
		local b = eX
		eX = xC
		xC = b
	end
end

function clearForward()
	gotoGround()
	local hasBlock, local data = turtle.inspect()
	while hasBlock do
		if(isClearable(data["name"])) then
			turtle.dig()
		end
		pushAbove()
		hasBlock, data = turtle.inspect()
		
	end
end


--AI related functions
function getBestGoal()
	if  turtle.getFuelLevel / turtle.getFuelLimit >= .25 then return GOAL_BASE end
	return GOAL_SEARCH
end

function isClearable(block)
	return (block == "minecraft:snow" or block == "minecraft:snow_layer")
end

function requestTask(channel)
	
end

function awaitBroadcast(channel)
	return os.pullEvent("modem_message")
end

function getFunctionID()
	return "SN-"..computerID()
end

--initialization
x,y,z = gps.locate()
currentDirection = nil
currentGoal = -1

print("Hello world :)\nThis turtle was coded by MegaIndustries Inc.\n\nCurrent Loc: " .. x .. ", " .. y .. ", " .. z)
print("Current direction: " .. directionString(getDirection()))

