-- Turtle Mining v3 by Koboo
 
-- variables
 
-- The smallest fuel level what the Turtle may reach
local minFuelLevel = 5
 
-- Torch inventory slot
local fuelSlot = 1
local torchSlot = 2
 
-- Distance between the individual tunnels
local space = 3
 
-- Length of the side tunnels
local length = 10
 
-- Total number of tunnels
local tunnels = 20
 
 
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
 
function emptyTurtle() 
    for f=1,16 do
        if f > torchSlot then
            turtle.select(f)
            turtle.drop()
        end
    end
end
 
function placeTorch(tunnelNo) 
    local torchCount = turtle.getItemCount(torchSlot)
    -- Check if we got atleast 2 torches, to avoid collecting dirty stuff
    if torchCount >= 2 then
        turtle.select(torchSlot)
        turtle.place()
    end
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
 
 
-- mining
 
function collect()
    if turtle.detect() then
        for c=1,16 do
            turtle.select(c)
            if turtle.compare() then
                return true
            end
        end
    end
end
 
function collectUp()
    if turtle.detectUp() then
        for c=1,16 do
            turtle.select(c)
            if turtle.compareUp() then
                return true
            end
        end
    end
end
 
function collectDown()
    if turtle.detectDown() then
        for c=1,16 do
            turtle.select(c)
            if turtle.compareDown() then
                return true
            end
        end
    end
end
 
function mineOresAround()
    -- Mining Ores on same level
    for turn=1,4 do
        turtle.turnLeft()
        if collect() then
            moveForward()
            mineOresAround()
            moveBack()
        end
    end
 
    -- Mining Ores up
    if collectUp() then
        moveUp()
        mineOresAround()
        moveDown()
    end
 
    -- Mining Ores down
    if collectDown() then
        moveDown()
        mineOresAround()
        moveUp()
    end
    -- Finished mining Ores on same level
end
 
function mineTunnel(tunnelNo) 
    -- Dig until length of the tunnel
    for l=1,length do
        moveForward()
        turtle.digUp()
    end
 
    turtle.back()
    moveUp()
    placeTorch(tunnelNo)
    moveDown()
 
    -- Turn around after finish
    print("Reached end of tunnel #"..tostring(tunnelNo).."..")
    turnAround()
 
    -- and Walk back, but check for ores and mine them
    for l=1,length - 1 do
        -- After finish, move one block forward
        moveForward()
 
        mineOresAround()
        moveUp()
        mineOresAround()
        moveDown()
 
    end
 
    --print("Reached start of tunnel.")
end
 
function stripMine(tunnelNo) 
 
    -- dig main-floor with space between tunnels
    for s=1,space do
        moveForward()
        turtle.digUp()
    end
 
    -- turn to right and start digging first tunnel
    turtle.turnRight()
 
    -- Return after finishing first tunnel
    mineTunnel(tunnelNo)
 
    -- Rotation looks to opposite site of tunnel, 
    -- so just start to dig the tunnel in the other way.
    mineTunnel(tunnelNo)
 
    -- After finish turn to left, so we are back at our tunnel-cross
    turtle.turnLeft()
end
 
-- main
 
-- intitial forward step
function main()
 
    for t=1,tunnels do
 
        print("Start strip mining tunnel #"..tostring(t))
        stripMine(t)
 
        -- And now we can repeat the whole thing.
        print("I'm back at from tunnel #"..tostring(t))
        refuelSlot()
 
    end
 
    turnAround()
    while not turtle.detect() do
        turtle.forward()
    end
 
    emptyTurtle()
    print("Ready to go!")
 
end
 
main()
