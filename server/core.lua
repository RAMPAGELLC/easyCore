easyCore = {}
easyCore.Plugins = {}

exports('GetServerObject', function()
    return easyCore
end)

exports('GetPluginObject', function()
    return easyCore.Plugins
end)

exports('GetPlugin', function(module)
    if easyCore.Plugins[module] then
        return easyCore.Plugins[module]
    else
        repeat Citizen.Wait(1 * 1000) until easyCore.Plugins[module] ~= nil
        return easyCore.Plugins[module]
    end
end)

exports('RegisterPlugin', function(name, pluginexports)
    easyCore.Plugins[name] = pluginexports
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local easyCore = exports['easyCore']:GetServerObject()