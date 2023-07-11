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
	print("Virando para " .. directionString(dirX))
	
	cEX = eX
	toR = true
	while z ~= eZ do
		print("Z " .. z .. " -> " .. eZ)
		while x ~= cEX do
			print("X " .. x .. " -> " .. cEX)
			clearForward()
			pushForward()
			--updateData()
		end
		print("Virando para eixo z = " .. directionString(dirZ))
		turnToDirection(dirZ)
		clearForward()
		pushForward()
		print("dirX " .. directionString(dirX) .. " -> " directionString(inverseDirection(dirX)))
		dirX = inverseDirection(dirX)
		turnToDirection(dirX)
		toR = not toR
		print("Var toEnd = " .. toR)
		if not toR then cEX = sX else cEX = eX end
	end
end

function clearForward()
	gotoGround()
	local hasBlock, data = turtle.inspect()
	while hasBlock do
		if(isClearable(data["name"])) then
			turtle.dig()
		end
		pushAbove(SHOVEL_HAND)
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

function getFunctionalID()
	return "SN-"..computerID()
end

--initialization
x,y,z = gps.locate()
currentDirection = nil
currentGoal = -1

if x == nil then print("Could not locate :(, turning off") os.shutdown() end

updateSoftware()
shell.run("delete startup.lua")
shell.run("wget https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/Shoveler.lua startup.lua")
print("Software da turtle atualizado :)")

print("Hello world :)\nThis turtle was coded by MegaIndustries Inc.\n\nCurrent Loc: " .. x .. ", " .. y .. ", " .. z)
print("Current direction: " .. directionString(getDirection()))

clearSnow(-1013, 1257, -1015, 1254)
--walkTo(-1017,92,1259)