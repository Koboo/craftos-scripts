-- Turtle Farming v4.6 by Koboo
 
-- variables
 
-- Torch inventory slot
local seedSlot = 1

local minFuelLevel = 6

-- inventory
 
function refuelTurtle() 
    -- Check if Fuel Level is below our minimum level
    if turtle.getFuelLevel() <= minFuelLevel then
        
        print("Waiting for fuel..")
        -- check if we got something to refuel
        local useableFuelSlot = findFuelSlot()
        while useableFuelSlot == -1 do
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
    local useablefuelItemSlot = -1
    for f=1,16 do
        turtle.select(f)
        local isFuel = turtle.refuel(0)
        if isFuel then
            local itemCount = turtle.getItemCount(f)
            if itemCount >= 1 then
                useableItemSlot = f
                break
            end
        end
    end
    return useableItemSlot
end

-- movement

function moveForward()
    while not turtle.forward() do
        turtle.dig()
        turtle.attack()
        sleep(1)
    end
end
 
function moveUp()
    while not turtle.up() do
        turtle.digUp()
        turtle.attackUp()
        sleep(1)
    end
end
 
function moveDown()
    while not turtle.down() do
        turtle.digDown()
        turtle.attackDown()
        sleep(1)
    end
end
 
function moveBack()
    turtle.back()
end
 
function turnAround() 
    turtle.turnLeft() 
    turtle.turnLeft()
end
 
-- farming
 
function shouldHarvest(plantName, success, data)
    if success then
        local itemName = tostring(data.name)
        local itemData = data.metadata
        local isPlant = string.find(itemName, plantName)
        local isGrown = itemData == 7
        if isPlant and isGrown then
            return true
        end
    end
end
 
function harvestInFront(plantName)
    if shouldHarvest(plantName, turtle.inspect()) then
        turtle.dig()
        turtle.select(seedSlot)
        turtle.place()
    end
end
 
-- main
 
-- intitial forward step
function main()
    
    print("Which plant do I harvest? (e.g. \"potatoes\", \"carrots\" or \"wheat\"")
    local plantName = read()
    
    print("Harvesting "..plantName.."...")
    
    while true do
        refuelTurtle()
        
        harvestInFront(plantName)
        
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        
        harvestInFront(plantName)
        
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        
        harvestInFront(plantName)
        
        turtle.turnLeft()
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.turnRight()
        
        harvestInFront(plantName)
        
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        
        harvestInFront(plantName)
        
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
        
        print("Waiting for "..plantName.." to grow..")
        sleep(300)
    end
end
 
main()
