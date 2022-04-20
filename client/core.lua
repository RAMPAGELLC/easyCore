easyCore = {}
easyCore.Config = {}

exports('GetClientObject', function()
    return easyCore
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local easyCore = exports['easyCore']:GetClientObject()