easyCore.Dev = {}
local inspect = exports["easyCore"]:GetModule("inspect")

easyCore.Dev.Error = function(msg)
    print('[easyCore:ERROR] ' .. msg)
end

easyCore.Dev.Log = function(msg)
    print('[easyCore:LOG] ' .. msg)
end

easyCore.Dev.Dump = function(table)
    print(inspect(table))
end

-- to add. https://forum.cfx.re/t/release-warmenu-lua-menu-framework/41249
