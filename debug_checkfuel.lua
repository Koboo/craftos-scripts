-- Refueling Pro v1 by Koboo
function checkFuel() 
    if turtle.getFuelLevel() < 5 then
        if turtle.getItemCount(1) < 1 then
            print("Waiting for fuel..")
            while not turtle.refuel(0) do
                turtle.select(1)
                if turtle.getItemCount(1) > 0 then
                    print("I can't use item in slot '1' as fuel!")
                end
                sleep(2.5)
            end
        end
        turtle.refuel(1)
        print("Mhh.. tasty fuel! (level="..tostring(turtle.getFuelLevel())..")")
    end
end
