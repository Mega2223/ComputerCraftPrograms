
function updateSoftware()
	local API = "https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/MegAPI.lua"
	local APIT = "https://raw.githubusercontent.com/Mega2223/ComputerCraftPrograms/main/MegAPITurtle.lua"
	
	shell.run("cd /")
	shell.run("delete MAPI")
	shell.run("mkdir MAPI")
	shell.run("cd MAPI")
	shell.run("wget " .. API .. " MegAPI.lua")
	shell.run("wget " .. APIT .. " MegAPITurtle.lua")
	shell.run("cd /")
	print("Todos os arquivos da MAPI estão seguros")
end

function getFiles()
	
end

--table
return {
	updateSoftware = updateSoftware
}