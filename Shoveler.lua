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

require ("MAPI.MegAPI")
require ("MAPI.MegAPITurtle")

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
	local hasBlock, data = turtle.inspect()
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

if x == nil then print("Could not locate :(, turning off") os.shutdown() end

print("Hello world :)\nThis turtle was coded by MegaIndustries Inc.\n\nCurrent Loc: " .. x .. ", " .. y .. ", " .. z)
print("Current direction: " .. directionString(getDirection()))

clearSnow(-947, 1297, -935, 1285)
walkTo(-1017,92,1259)