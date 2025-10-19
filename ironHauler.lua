-- hauler_iron.lua
-- Only imports iron ore and iron ingots into the ME Bridge on the back

-- Wrap the ME Bridge on the back side
local me = peripheral.wrap("back")
if not me then
    error("No ME Bridge found on back side!")
end

-- Function to check if an item is iron ore or ingot
local function isIron(item)
    return item.name == "minecraft:iron_ore" or item.name == "minecraft:iron_ingot"
end

-- Upload all iron items
local function uploadIron()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and isIron(item) then
            local countImported = me.importItem({name=item.name, count=item.count}, "back")
            print("Imported "..countImported.."x "..item.name)
            -- Remove leftovers if import didn't take all
            if countImported < item.count then
                turtle.select(slot)
                turtle.drop()
            end
        end
    end
    turtle.select(1)
end

-- Main loop
while true do
    uploadIron()
    sleep(5) -- check every 5 seconds
end