local easyCore = exports['easyCore']:GetServerObject()
local pluginExports = {}

pluginExports.Settings = {
    CharacterCreationEnabled = true -- feature not completed and will breask easyCore.
}

pluginExports.ToggleCreator = function(player, characterid, boolean)
    TriggerClientEvent("easyCore:client:skincreator", player, characterid, boolean)
end

RegisterServerEvent("easyCore:server:updateSkin")
AddEventHandler("easyCore:server:updateSkin",
    function(characterid, dad, mum, dadmumpercent, skin, eyecolor, acne, skinproblem, freckle, wrinkle, wrinkleopacity,
        eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, hair, haircolor, torso, torsotext, leg, legtext,
        shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat,
        prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches,
        prop_watches_text)
        local PlayerId = source
        local success, data = easyCore.Player.GetPlayerById(PlayerId)

        if not success then
            return easyCore.Dev.Error("Failed to save character, can't find player!")
        end
        local license = data.Data.IdentifierData.License

        if license == "" then
            data.Functions.UpdateIdentifiers(true)
            success, data = easyCore.Player.GetPlayerById(PlayerId)
            license = data.Data.IdentifierData.License
            easyCore.Dev.Log(
                "Invalid identifier for skincreator. Auto called Player.Functions.UpdateIdentifier with boolean true.")
        end

        MySQL.Async.execute(
            "INSERT INTO outfits (dad, mum, dadmumpercent, skin, eyecolor, acne, skinproblem, freckle, wrinkle, wrinkleopacity, eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, hair, hairtext, torso, torsotext, leg, legtext, shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat, prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches, prop_watches_text) VALUES(:dad, :mum, :dadmumpercent, :skin, :eyecolor, :acne, :skinproblem, :freckle, :wrinkle, :wrinkleopacity, :eyebrow, :eyebrowopacity, :beard, :beardopacity, :beardcolor, :hair, :hairtext, :torso, :torsotext, :leg, :legtext, :shoes, :shoestext, :accessory, :accessorytext, :undershirt, :undershirttext, :torso2, :torso2text, :prop_hat, :prop_hat_text, :prop_glasses, :prop_glasses_text, :prop_earrings, :prop_earrings_text, :prop_watches, :prop_watches_text) ON DUPLICATE KEY UPDATE dad=@dad, mum=@mum, dadmumpercent=@dadmumpercent, skinton=@skin, eyecolor=@eyecolor, acne=@acne, skinproblem=@skinproblem, freckle=@freckle, wrinkle=@wrinkle, wrinkleopacity=@wrinkleopacity, eyebrow=@eyebrow, eyebrowopacity=@eyebrowopacity, beard=@beard, beardopacity=@beardopacity, beardcolor=@beardcolor, hair=@hair, hairtext=@hairtext, torso=@torso, torsotext=@torsotext, leg=@leg, legtext=@legtext, shoes=@shoes, shoestext=@shoestext, accessory=@accessory, accessorytext=@accessorytext, undershirt=@undershirt, undershirttext=@undershirttext, torso2=@torso2, torso2text=@torso2text, prop_hat=@prop_hat, prop_hat_text=@prop_hat_text, prop_glasses=@prop_glasses, prop_glasses_text=@prop_glasses_text, prop_earrings=@prop_earrings, prop_earrings_text=@prop_earrings_text, prop_watches=@prop_watches, prop_watches_text=@prop_watches_text WHERE license=@license AND characterid=@characterid",
            {
                ['@license'] = license,
                ['@characterid'] = characterid,
                ['@dad'] = dad,
                ['@mum'] = mum,
                ['@dadmumpercent'] = dadmumpercent,
                ['@skin'] = skin,
                ['@eyecolor'] = eyecolor,
                ['@acne'] = acne,
                ['@skinproblem'] = skinproblem,
                ['@freckle'] = freckle,
                ['@wrinkle'] = wrinkle,
                ['@wrinkleopacity'] = wrinkleopacity,
                ['@eyebrow'] = eyebrow,
                ['@eyebrowopacity'] = eyebrowopacity,
                ['@beard'] = beard,
                ['@beardopacity'] = beardopacity,
                ['@beardcolor'] = beardcolor,
                ['@hair'] = hair,
                ['@hairtext'] = haircolor,
                ['@torso'] = torso,
                ['@torsotext'] = torsotext,
                ['@leg'] = leg,
                ['@legtext'] = legtext,
                ['@shoes'] = shoes,
                ['@shoestext'] = shoestext,
                ['@accessory'] = accessory,
                ['@accessorytext'] = accessorytext,
                ['@undershirt'] = undershirt,
                ['@undershirttext'] = undershirttext,
                ['@torso2'] = torso2,
                ['@torso2text'] = torso2text,
                ['@prop_hat'] = prop_hat,
                ['@prop_hat_text'] = prop_hat_text,
                ['@prop_glasses'] = prop_glasses,
                ['@prop_glasses_text'] = prop_glasses_text,
                ['@prop_earrings'] = prop_earrings,
                ['@prop_earrings_text'] = prop_earrings_text,
                ['@prop_watches'] = prop_watches,
                ['@prop_watches_text'] = prop_watches_text
            })
        easyCore.Player.LoadCharacter(PlayerId)
    end)
--[[
example
local easyCore = exports['easyCore']:GetServerObject()
local skincreator = easyCore:GetPlugin("skincreator")
skincreator.ToggleCreator(-1, true)    
]]

easyCore:RegisterPlugin("skincreator", pluginExports)
