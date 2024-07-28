mon = peripheral.wrap('right')
motor = peripheral.find('electric_motor')
speaker = peripheral.find('speaker')
pax = ''
buttons = {}

function genButton(x,y,id)
    table.insert(buttons,{
        x=x,y=y,id=id,
        onPress = function(self,cx,cy)
            if cx == x and y == cy then
                pax = pax .. self.id
            end
        end,
        draw = function(self)
            mon.setCursorPos(self.x,self.y)
            mon.write(self.id)
        end
    })
end

function genPad()
    for i = 0, 8, 1 do
        genButton(
         2*(i%3)+2,
         2*math.floor(i/3) + 1
         ,i+1)
    end
    genButton(8,3,0)
end

function drawTextBox()
    mon.setCursorPos(11,3)
    mon.write(pax)
end

function writePad()
    for i = 1, 10, 1 do
        buttons[i]:draw()    
    end
    mon.setCursorPos(8,5)
    mon.write('ERS')
    mon.setCursorPos(8,1)
    mon.write('CON')
    drawTextBox()
end

function checkClearOrConfirm(x,y)
    ---8,3,0
    if x >= 8 and x <= 11 then
        if y == 1 and pax == '2223' then
            pax = ''
            motor.setSpeed(-16)
            mon.setBackgroundColor(colors.lime)
            mon.clear()
            for i = 0,10,1 do
                speaker.playNote('pling',2,1)
                os.sleep(1)
            end
            mon.setBackgroundColor(colors.black)
            motor.setSpeed(16)
            for i = 0, 5, 1 do
                speaker.playNote('pling',2,0)
                os.sleep(1)
            end
            motor.stop()
        end
        if y == 5 then
            ---pax = '         '
            ---writePad()
            pax = ''
        end
        writePad()
    end
end

genPad()
mon.clear()

while true do
    mon.clear()
    writePad()
    name,dir,x,y = os.pullEvent('monitor_touch')
    print(x,y)
    for i = 1,10,1 do
        buttons[i]:onPress(x,y)
    end
    checkClearOrConfirm(x,y)
end

