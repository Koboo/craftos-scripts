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
 
function checkInventory()
    if turtle.getItemCount(2) == 64 then
        turtle.select(2)
        while not turtle.dropUp() do
            print("My chest is full, so I'm waiting for clear up!")
            sleep(10)
        end
    end
end
 
function farmCobble()
    local blocks = 0
    while true do
        checkFuel()
        checkInventory()
        while not turtle.detect() do
            sleep(0.5)
        end
        turtle.dig()
        blocks = blocks + 1
        if blocks % 100 == 0 then
            print("Farmed "..tostring(blocks).." cobble..")
        end
    end
end
 
farmCobble()
