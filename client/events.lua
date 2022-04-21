RegisterNetEvent('easyCore:client:notify')
AddEventHandler('easyCore:client:notify', function(Status, Message, Length)
    easyCore.Functions.Notify(Status, Message, Length)
end)

RegisterNetEvent('easyCore:client:SetPlayerAppearance')
AddEventHandler('easyCore:client:SetPlayerAppearance', function(appearance)
    exports['ec-appearance']:setPlayerAppearance(appearance)
end)
