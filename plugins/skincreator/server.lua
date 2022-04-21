local easyCore = exports['easyCore']:GetServerObject()
local pluginExports = {}

pluginExports.Settings = {
    CharacterCreationEnabled = true -- feature not completed and will breask easyCore.
}

pluginExports.ToggleCreator = function(player, characterid, boolean)
    TriggerClientEvent("easyCore:client:skincreator", player, characterid, boolean)
end

pluginExports.LoadSkin = function(player, dad, mum, dadmumpercent, skin, eyecolor, acne, skinproblem, freckle, wrinkle, wrinkleopacity,
    eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, hair, haircolor, torso, torsotext, leg, legtext,
    shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat,
    prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches,
    prop_watches_text)

    TriggerClientEvent("easyCore:client:loadskin", player, dad, mum, dadmumpercent, skin, eyecolor, acne, skinproblem, freckle, wrinkle, wrinkleopacity,
    eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, hair, haircolor, torso, torsotext, leg, legtext,
    shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat,
    prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches,
    prop_watches_text)
end

MySQL.ready(function()
    MySQL.Async.execute('CREATE TABLE IF NOT EXISTS `player_skins` (`id` int(11) NOT NULL auto_increment, `identifier` varchar(128) NOT NULL, `skin` LONGTEXT NULL DEFAULT NULL, PRIMARY KEY  (`id`), UNIQUE(`identifier`))',{}, 
    function() end)
end)

RegisterServerEvent('cui_character:save')
AddEventHandler('cui_character:save', function(data)
    local _source = source
    local license = easyCore.Functions.ExtractIdentifiers(_source).License

    if license then
        MySQL.ready(function()
            MySQL.Async.execute('INSERT INTO `player_skins` (`identifier`, `skin`) VALUES (@identifier, @skin) ON DUPLICATE KEY UPDATE `skin` = @skin', {
                ['@skin'] = json.encode(data),
                ['@identifier'] = license
            })
        end)
    end
end)

RegisterServerEvent('cui_character:requestPlayerData')
AddEventHandler('cui_character:requestPlayerData', function()
    local _source = source
    local license = easyCore.Functions.ExtractIdentifiers(_source).License

    if license then
        MySQL.ready(function()
            MySQL.Async.fetchAll('SELECT skin FROM player_skins WHERE identifier = @identifier', {
                ['@identifier'] = license
            }, function(users)
                local playerData = { skin = nil, newPlayer = true}
                if users and users[1] ~= nil and users[1].skin ~= nil then
                    playerData.skin = json.decode(users[1].skin)
                    playerData.newPlayer = false
                end
                TriggerClientEvent('cui_character:recievePlayerData', _source, playerData)
            end)
        end)
    end
end)

--[[
example
local easyCore = exports['easyCore']:GetServerObject()
local skincreator = easyCore:GetPlugin("skincreator")
skincreator.ToggleCreator(-1, 1, true)    
]]

easyCore:RegisterPlugin("skincreator", pluginExports)