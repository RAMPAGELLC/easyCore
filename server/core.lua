easyCore = {}
easyCore.Modules = {}
easyCore.Plugins = {}

exports('GetServerObject', function()
    return easyCore
end)

exports('GetPluginObject', function()
    return easyCore.Plugins
end)

exports('GetModule', function(module)
    if easyCore.Modules[module] then
        return easyCore.Modules[module]
    else
        repeat Citizen.Wait(1 * 1000) until easyCore.Modules[module] ~= nil
        return easyCore.Modules[module]
    end
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local easyCore = exports['easyCore']:GetServerObject()