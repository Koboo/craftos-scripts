-- Turtle Mining v4.1 by Koboo
 
-- variables
 
-- Distance between the individual tunnel (e.g. make 3 blocks between needs space = 4)
local spaceBetween = 4
 
-- Length of the side tunnel
local length = 10
 
-- inventory
 
function refuelTurtle() 
    -- Check if Fuel Level is below our minimum level
    if turtle.getFuelLevel() <= length then
        print("Running out of fuel.. refueling..")
 
        -- check if we got something other to refuel
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
        turtle.select(f)
        turtle.drop()
    end
end
 
function placeTorch(tunnelNo) 
    -- Iterate through all slots and check if we got torches any where
    for s=1,16 do
        local data = turtle.getItemDetail(s)
		if not data == nil then
    		local itemName = data.name
        	local count = data.count
		    -- Check if we got atleast 2 torches, to avoid collecting dirty stuff
        	-- and making refill easier
		    if string.match(itemName, "minecraft:torch") then
        	    if count >= 2 then
               		turtle.select(s)
		            turtle.place()
        	    end
			end
        end
    end
end
 
 
-- movement
 
function moveForward()
    refuelTurtle()
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
 
function shouldMine(success, data)
    if success then
        -- e.g. thermalexpansion:ore
        local itemName = tostring(data.name)
        -- e.g. 5
        local itemData = tostring(data.metadata)
        -- this results in thermalexpansion:ore/5
        if string.match(itemName, "ore") then
            return true
        end
    end
end
 
function mineOresAround()
    -- Mining Ores on same level
    for turn=1,4 do
        turtle.turnLeft()
        if shouldMine(turtle.inspect())then
            moveForward()
            mineOresAround()
            moveBack()
        end
    end
 
    -- Mining Ores up
    if shouldMine(turtle.inspectUp()) then
        moveUp()
        mineOresAround()
        moveDown()
    end
 
    -- Mining Ores down
    if shouldMine(turtle.inspectDown()) then
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
 
    -- todo: last block is not mined. It's because the turtle moves forward and then checks for ores
    -- and Walk back, but check for ores and mine them
    for l=1,length - 1 do
        -- After finish, move one block forward
        moveForward()
 
        mineOresAround()
        moveUp()
        mineOresAround()
        moveDown()
 
    end
end
 
function stripMine(tunnelNo) 
 
    -- dig main-floor with space between 2 tunnel
    for s=1,spaceBetween do
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
 
function main()
 
    -- todo: Recheck this variables:
 
    print("How many tunnels should I mine?")
    local result = read()
 
    if tonumber(result) > 0 then
 
        for t=1,result do
 
            print("Start strip mining tunnel #"..tostring(t))
            stripMine(t)
 
            -- And now we can repeat the whole thing.
            print("I'm back at from tunnel #"..tostring(t))
            refuelTurtle()
 
        end
 
        turnAround()
        while not turtle.detect() do
            turtle.forward()
        end
 
        emptyTurtle()
        print("I finished! Ready to go!")
    else 
        print("Sorry I don't know that number.")
    end
end
 
main()
