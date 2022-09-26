function checkFuel() 
    if turtle.getFuelLevel() < 5 then
        if turtle.getItemCount(1) < 1 then
            print("Waiting for fuel in slot 1..")
            while not turtle.refuel(0) do
                turtle.select(1)
                if turtle.getItemCount(1) > 0 then
                    print("I can't use item in slot 1 as fuel!")
                end
                sleep(2.5)
            end
        end
        turtle.refuel(1)
        print("Mhh.. tasty fuel! (level="..tostring(turtle.getFuelLevel())..")")
    end
end
 
function checkItem(itemName, slot)
    local data = turtle.getItemDetail()
    if turtle.getItemCount(slot) == 0 and not (data and data.name == itemName) then
        print("Waiting for "..tostring(itemName).." in slot "..tostring(slot).."..")
        turtle.select(slot)
        while not (data and data.name == itemName) do
            data = turtle.getItemDetail()
            sleep(2.5)
        end
    end
end
 
function farmFlint()
    local woodName = "minecraft:gravel"
    checkItem(woodName, 2)
    local blocks = 0
    while not turtle.detectDown() do
        checkFuel()
        turtle.select(2)
        turtle.placeDown()
        turtle.digDown()
        sleep(1)
    end
end
 
farmFlint()
