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
