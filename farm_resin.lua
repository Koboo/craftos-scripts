-- Turtle Resin Farm v4.1 by Koboo
 
-- variables
local minFuelLevel = 6
local woodSlot = 2
 
-- inventory
 
function refuelTurtle() 
    -- Check if Fuel Level is below our minimum level
    if turtle.getFuelLevel() <= minFuelLevel then
        
        print("Waiting for fuel..")
        -- check if we got something to refuel
        local useableFuelSlot = findFuelSlot()
        while useableFuelSlot == nil do
            os.pullEvent("turtle_inventory")
            useableFuelSlot = findFuelSlot()
        end
        local fuelCount = turtle.getItemCount(useableFuelSlot)
        turtle.select(useableFuelSlot)
        turtle.refuel(fuelCount)
        print("Hmm, that was tasty!")
    end
end
 
function findFuelSlot()
    local useableFuelSlot = nil
    for f=1,16 do
        turtle.select(f)
        local isFuel = turtle.refuel(0)
        if isFuel then
            local itemCount = turtle.getItemCount(f)
            if itemCount >= 1 then
                useableFuelSlot = f
                break
            end
        end
    end
    return useableFuelSlot
end
 
-- main
 
 
 function findItemSlot(itemName)
    local useableWoodSlot = nil
    for f=1,16 do
        local data = turtle.getItemDetail(f)
        if data then
            --print(textutils.serialize(data))
            local isRubberWood = data.name == itemName;
            --print("Wood: "..tostring(isRubberWood))
            if isRubberWood then
                useableWoodSlot = f;
                break
            end
        end
    end
    return useableWoodSlot
end
 
function farmResin()
    local woodName = "ic2:blockrubwood"
    local woodSlot = findItemSlot(woodName)
    while woodSlot == nil do
        print("Waiting for rubber wood")
        os.pullEvent("turtle_inventory")
        woodSlot = findItemSlot(woodName)
    end
    while turtle.detectDown() do
        refuelTurtle()
        turtle.digDown()
        turtle.select(woodSlot)
        turtle.placeDown()
        sleep(1)
    end
end
 
farmResin()
