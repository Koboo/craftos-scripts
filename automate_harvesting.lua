-- Turtle Farming v3.1 by Koboo
 
-- variables
 
-- The smallest fuel level what the Turtle may reach
local minFuelLevel = 5
 
-- Torch inventory slot
local fuelSlot = 1
local saplingSlot = 2
 
-- Distance between the individual tunnels
local length = 17
 
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
 
function farmLine()
    for i=1,length do
        refuelSlot()
        if turtle.detectDown() then
            turtle.digDown()
        end
        turtle.forward()
    end
    for i=1,length - 1 do
        refuelSlot()
        turtle.back()
        local itemCount = turtle.getItemCount(saplingSlot)
        if itemCount >= 2 and not turtle.detectDown() then
            turtle.select(saplingSlot)
            turtle.placeDown()
        end
    end
end
 
-- main
 
-- intitial forward step
function main()
 
    -- First Line
    farmLine()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
 
    -- Second Line
    farmLine()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
 
    -- Third Line
    farmLine()
    turtle.turnRight()
    turtle.forward()
    turtle.forward()
 
    refuelSlot()
    for f=1,16 do
        if f > saplingSlot then
            turtle.select(f)
            turtle.drop()
        end
    end
    turtle.turnLeft()
 
    print("Ready to go!")
 
end
 
main()
