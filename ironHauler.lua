-- hauler_to_ae2.lua
-- This turtle will push everything in its inventory into the ME Bridge

-- Find the ME Bridge remotely
local me = peripheral.find("me_bridge")
if not me then
    error("No ME Bridge found!")
end

-- Function to upload all items in the turtle inventory to AE2
local function uploadInventory()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        print(item)
        if item then
            -- Send item into the ME Bridge
            local countImported = me.importItem({name=item.name, count=item.count}, "back")
            print("Imported "..countImported.."x "..item.name)
            -- Clear leftover items if not fully imported
            turtle.select(slot)
            turtle.drop()
        end
    end
    turtle.select(1)
end

-- Main loop
while true do
    uploadInventory()
    print("Sleeping 5 seconds before next check...")
    sleep(5)  -- repeat every 5 seconds
end