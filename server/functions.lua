easyCore.Functions = {}

function easyCore.Functions.Notify(Source, Status, Message, Length)
    TriggerClientEvent("easyCore:client:notify", Source, Status, Message, Length or 4 * 1000)
end

function easyCore.Functions.GetIdentifier(source, type)
    local identifiers = GetPlayerIdentifiers(source)

    for _, identifier in pairs(identifiers) do
        if string.find(identifier, type) then
            return identifier
        end
    end
    
    return nil
end

function easyCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return vector4(coords.x, coords.y, coords.z, heading)
end

function easyCore.Functions.ExtractIdentifiers(i)
    local steamid = false
    local license = false
    local discord = false
    local xbl = false
    local liveid = false
    local ip = false

    for k, v in pairs(GetPlayerIdentifiers(i)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    return {
        Steam = steamid,
        License = license,
        Discord = discord,
        XBL = xbl,
        LiveID = liveid,
        IP = ip
    }
end