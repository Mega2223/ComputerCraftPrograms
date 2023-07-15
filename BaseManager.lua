require("/.MAPI.MegAPI")

mon = peripheral.wrap("left")
x,y = mon.getSize()
--o espaço horizontal deve ser 3/5, mas tira 2, 1 pra distância e outro pro quadrado
--coordenada do meio só precisa de 1 de diferença
current = window.create(mon,2,2,math.floor(x*(3.0/5.0))-2,y-2)
selector = window.create(mon,math.floor(x*(3.0/5.0))+2,2,x-2,y-2)

function updateSelector()
	term.redirect(mon)
	mon.clear()
	mon.setBackgroundColor(color.white)
	paintutils.drawBox(3,3,math.floor(x*(3.0/5.0))-1,y-2)
	paintutils.drawBox(math.floor(x*(3.0/5.0)),3,x-2,y-2)
end