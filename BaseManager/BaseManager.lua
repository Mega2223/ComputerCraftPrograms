require("/.MAPI.MegAPI")

mon = peripheral.wrap("left")
x,y = mon.getSize()
mon.setBackgroundColor(colors.black)
mon.clear()
--o espaço horizontal deve ser 3/5, mas tira 2, 1 pra distância e outro pro quadrado
--coordenada do meio só precisa de 1 de diferença
current = window.create(mon,3,2,math.floor(x*(3.0/5.0))-2,y-3)
selector = window.create(mon,math.floor(x*(3.0/5.0))+2,3,x-2,y-3)

function updateSelector()
	term.redirect(mon)
	mon.clear()
	mon.setBackgroundColor(colors.white)
	paintutils.drawBox(2,2,math.floor(x*(3.0/5.0))-1,y-1)
	paintutils.drawBox(math.floor(x*(3.0/5.0))+1,2,x-1,y-1)
end

term.redirect(term.native())

function onMonitorTouch(ev,side,x,y)
	term.redirect(selector)
	print(x..":"..y)
	term.redirect(term.native())
end

function updateStats()
	term.redirect(selector)
	print("stats")
	term.redirect(term.native())
end

while true do 
	os.startTimer(0.1)
	local event, a1, a2, a3 = os.pullEvent()
	if event == 'monitor_touch' then
		onMonitorTouch(event,a1,a2,a3)
	else
		updateStats()
	end
end