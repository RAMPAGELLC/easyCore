easyCore.Functions = {}

function easyCore.Functions.Notify(Status, Message, Length)
    SendNUIMessage({
        action = "displayAlert",
        data = {
            type = Status,
            text = Message,
            length = Length or 4 * 1000,
        }
    })
end