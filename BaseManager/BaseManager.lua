require("/.MAPI.MegAPI")

mon = peripheral.wrap("left")
x,y = mon.getSize()
mon.setBackgroundColor(colors.black)
mon.clear()
--o espaço horizontal deve ser 3/5, mas tira 2, 1 pra distância e outro pro quadrado
--coordenada do meio só precisa de 1 de diferença
local m = math.floor(x*(3.0/5.0))
local n = math.floor(x*(2.0/5.0))

current = window.create(mon,3,3,m-4,y-4)
selector = window.create(mon,m+2,3,n-2,y-3)

programs = {require("Teste"),require("Teste2")}

function updateSelector()
	term.redirect(mon)
	mon.clear()
	mon.setBackgroundColor(colors.white)
	paintutils.drawBox(2,2,math.floor(x*(3.0/5.0))-1,y-1)
	paintutils.drawBox(math.floor(x*(3.0/5.0))+1,2,x-1,y-1
	term.redirect()--parei aqui, falta desenhar os botões
end

term.redirect(term.native())

function onMonitorTouch(ev,side,lX,lY)
	term.redirect(selector)
	
	local tX, tY = selector.getPosition()
	tX = lX - tX
	tY = lY - tY
	
	local i = 1
	while programs[i] ~= nil do
		if tY == i then
			programs[i].draw(current)
		end
		i = i + 1
	end
	
	term.redirect(term.native())
end

function updateStats()
	term.redirect(current)
	term.redirect(term.native())
end

function drawModule(index)
	
end

while true do 
	os.startTimer(0.2)
	local event, a1, a2, a3 = os.pullEvent()
	if event == 'monitor_touch' then
		onMonitorTouch(event,a1,a2,a3)
	elseif event 'timer' == then
		updateSelector()
		updateStats()
	end
end