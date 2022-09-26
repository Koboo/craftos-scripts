-- ItemCheck Pro v1 by Koboo
function checkItem(itemName, slot)
    local data = turtle.getItemDetail()
    if turtle.getItemCount(slot) == 0 and not (data and data.name == itemName) then
        print("Waiting for "..tostring(itemName).." in slot "..tostring(slot).."..")
        turtle.select(slot)
        while not (data and data.name == itemName) do
            data = turtle.getItemDetail()
            sleep(2.5)
        end
    end
end
