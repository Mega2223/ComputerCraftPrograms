while true do

laser = peripheral.wrap("left")
sensor = peripheral.wrap("right")

function fire(x,y,z)
    local pitch = -math.atan2(y, math.sqrt(x * x + z * z))
    local yaw = math.atan2(-x, z)
    
    for i = 0, 10, 1 do
        laser.fire(math.deg(yaw), math.deg(pitch), 5)
    end
end

i = 1

mobs = sensor.sense()


while mobs[i] ~= nil do
    x = mobs[i]['x']
    y = mobs[i]['y']
    z = mobs[i]['z']
    local name = mobs[i]['name']
    print(name)
    if  name == 'Mega2223' or name == 'Item' then
        print('amig')
    else
        fire(x,y,z)
    end
    i = i + 1
end

os.sleep(2)
end
