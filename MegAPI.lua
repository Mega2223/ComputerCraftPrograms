
SNOW_CLEANER_COMM_CH = 2224

function updateSoftware()
	local API = "https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/MegAPI.lua"
	local APIT = "https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/MegAPITurtle.lua"
	
	shell.run("cd /")
	shell.run("delete MAPI")
	shell.run("mkdir MAPI")
	shell.run("cd MAPI")
	shell.run("wget " .. API .. " MegAPI.lua")
	shell.run("wget " .. APIT .. " MegAPITurtle.lua")
	
	shell.run("mkdir Turtles")
	shell.run("cd Turtles")
	shell.run("wget https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/Turtles/Shoveler.lua Shoveler.lua")
	shell.run("cd /")
	print("Todos os arquivos da MAPI estão seguros")
end

function splitString(str,s)
	tab = {}
	for str in string.gmatch(str, s) do
		table.insert(s)
	end
	return tab;
end

function broadcastAndWait(channel, toBroadcast, waitTime, limit, modem)
	modem.open(channel)
	while true do
		os.startTimer(waitTime)
		local event, side, channel, replyChannel, message, distance = os.pullEvent()
		if event == "modem_message" then
			return event, side, channel, replyChannel, message, distance
		end
		if event == "timer" then
			modem.transmit(channel,channel,toBroadcast)
			limit = limit - 1
		end
		if limit = 0 then
			return false
		end
	end
end

--table
return {
	updateSoftware = updateSoftware
}