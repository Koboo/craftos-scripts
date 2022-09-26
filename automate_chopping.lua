-- Turtle Chopping v3 by Koboo
 
-- variables
 
-- The smallest fuel level what the Turtle may reach
local minFuelLevel = 5
 
-- Torch inventory slot
local fuelSlot = 1
local saplingSlot = 2
 
-- Distance between the individual tunnels
local length = 7
 
-- inventory
 
function refuelSlot() 
    -- Check if Fuel Level is below our minimum level
    if turtle.getFuelLevel() <= minFuelLevel then
 
        -- Check if we got fuel in our set fuelSlot
        print("Running out of fuel.. refueling..")
 
        -- If not, check if we got something other to refuel
        for f=1,16 do
            turtle.select(f)
            local isFuel = turtle.refuel(0)
            if isFuel then
                local itemCount = turtle.getItemCount(f)
                if itemCount >= 2 then
                    turtle.refuel(itemCount - 1)
                    break
                end
            end
        end
    end
end
 
-- farming
 
function forward()
    while not turtle.forward() do
        turtle.dig()
        turtle.attack()
    end
end
 
function chopTree()
    forward()
 
    turtle.dig()
    turtle.forward()
    turtle.digDown()
 
    local itemCount = turtle.getItemCount(saplingSlot)
    if itemCount >= 2 then
        turtle.select(saplingSlot)
        turtle.placeDown()
    end
 
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end
 
    while not turtle.detectDown() do
        turtle.down()
    end
end
 
function chopLine()
    for i=1,length do
        chopTree()
        print("Tree #"..tostring(i))
        if i == 7 then
            turtle.turnRight()
            turtle.forward()
            turtle.turnRight()
            for b=1,32 do
                forward()
            end
        else 
            forward()
            forward()
            forward()
        end
    end
end
 
-- main
 
-- intitial forward step
function main()
 
    for i=1,7 do
        chopLine()
 
        if i == 7 then
            turtle.back()
            turtle.turnRight()
            for b=1,31 do
                forward()
            end
 
            for f=1,16 do
                if f > torchSlot then
                    turtle.select(f)
                    turtle.drop()
                end
            end
 
            turtle.turnRight()
            turtle.back()
        else 
            turtle.turnLeft()
            forward()
            forward()
            forward()
            forward()
            turtle.turnLeft()
        end
    end
 
    print("Ready to go!")
 
end
 
main()
