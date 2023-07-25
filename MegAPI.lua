
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

--table
return {
	updateSoftware = updateSoftware
}