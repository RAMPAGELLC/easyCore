--[[
    Tired of 200 resources from ESX/QB?
    Limit it down to one!

    File Names:
    shared.lua/shared_example.lua will share across client and server.
    server.lua/server_example.lua will share across the server only.
    client.lua/client_example.lua will share across the client only.
]]

local easyCore = easyCore:GetPluginObject() -- this can only be used server side.