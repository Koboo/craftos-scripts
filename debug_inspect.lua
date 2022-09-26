-- Inspect Pro v1 by Koboo
function showResult(success, data)
    print("Success: "..tostring(success))
    if success then 
        print("Name: "..tostring(data.name))
        print("Metadata: "..tostring(data.metadata))
    else
        print("No block found!")
    end
end
 
print("Inspect block in Front (f) / Back (b) / Down (d) / Up (u)?")
local result = read()
 
if result == "f" then
    local success, data = turtle.inspect()
    showResult(success, data)
elseif result == "d" then
    local success, data = turtle.inspectDown()
    showResult(success, data)
elseif result == "u" then
    local success, data = turtle.inspectUp()
    showResult(success, data)
elseif result == "b" then
    turtle.turnLeft()
    turtle.turnLeft()
    local success, data = turtle.inspect()
    showResult(success, data)
    turtle.turnRight()
    turtle.turnRight()
else 
    print("Unknown direction! (input="..tostring(result)..")")
end
