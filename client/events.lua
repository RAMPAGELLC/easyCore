RegisterNetEvent('easyCore:client:notify')
AddEventHandler('easyCore:client:notify', function(Status, Message, Length)
    easyCore.Functions.Notify(Status, Message, Length)
end)
