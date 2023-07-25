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
BROADCAST= 2224

require ("/.MAPI.MegAPI")
require ("/.MAPI.MegAPITurtle")

function clearSnow(sX,sZ,eX,eZ)
	print("Inicializando processo de limpeza, indo para " .. sX .. " : " .. sZ)
	walkTo(sX,sZ)
	dirX, dirZ = getDirectionAxis(sX,sZ,eX,eZ)
	turnToDirection(dirX)
	print("Virando para " .. directionString(dirX))
	
	cEX = eX
	toR = true
	while z ~= eZ or x ~= eX do
		print("Z " .. z .. " -> " .. eZ)
		while x ~= cEX do
			print("X " .. x .. " -> " .. cEX)
			clearForward()
			pushForward()
			--updateData()
		end
		if z == eZ and x == cEX then return true end
		print("Virando para eixo z = " .. directionString(dirZ))
		turnToDirection(dirZ)
		clearForward()
		pushForward()
		print("dirX " .. directionString(dirX) .. " -> " .. directionString(inverseDirection(dirX)))
		dirX = inverseDirection(dirX)
		turnToDirection(dirX)
		toR = not toR
		print(toR)
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

function getFunctionalID()
	return "SN-"..computerID()
end

function isClearable(block)
	return (block == "minecraft:snow" or block == "minecraft:snow_layer")
end

function interpretMessage(message)
	spl = splitString(message,":")
	if table.maxn(spl) < 2 then return false end

	type = string.sub(spl[1],1,3)
	order = splitString(spl[2],"=>")
	if type == "SNC" and order[1] == getFunctionalID do
		interpretOrder(order[1])
		return true
	end
	return false
end

function interpretOrder(order)
	ordtab = splitString(order,"->")
	if ordtab[1] == "CLR" do
		locs = splitString(order[2]," ")
		local tbX = tonumber(locs[1])
		local tbY = tonumber(locs[2])
		local teX = tonumber(locs[3])
		local teY = tonumber(locs[4])
		clearSnow(tbX,tbY,teX,teY)
	end
	if ordtab[2] == "FFF" do
		--todo
		return true
	end
end

function requestTask(channel, modem)
	modem.open(channel)
	modem.transmit(channel, channel, getFunctionalID()..":RQ->"..tostring(turtle.getFuelLevel/turtle.getFuelLimit))
	local hasReceivedOrder = false
	while not hasReceivedOrder do
		local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
		hasReceivedOrder = interpretMessage(message)
	end
	modem.close(channel)
end

function awaitBroadcast(channel)
	return os.pullEvent("modem_message")
end



--local instance variables
currentGoal = -1
currentDirection = nil
--initialization
x,y,z = gps.locate()

if x == nil then print("Could not locate :(, turning off") os.sleep(10) os.reboot() end

updateSoftware()
shell.run("delete startup.lua")

shell.run("wget https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/Turles/Shoveler.lua startup.lua")
print("Software da turtle atualizado :)")

print("Hello world :)\nThis turtle was coded by MegaIndustries Inc.\n\nCurrent Loc: " .. x .. ", " .. y .. ", " .. z)
print("Current direction: " .. directionString(getDirection()))
