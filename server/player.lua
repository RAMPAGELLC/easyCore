easyCore.Player = {}
easyCore.Player.Users = {}

function easyCore.Player.GetPlayerById(PlayerId)
    if easyCore.Player.Users[PlayerId] then
        return true, easyCore.Player.Users[PlayerId]
    else
        return false, {}
    end
end

function easyCore.Player.GetPlayerByIdentifier(Identifier, LookFor)
    for index, value in pairs(easyCore.Player.Users) do
        if value.IdentifierData[Identifier] == LookFor then
            return true, value
        end
    end

    return false
end

function easyCore.Player.GetPlayerByCitizenId(Value)
    return easyCore.Player.GetPlayerByIdentifier("CitizenId", Value)
end

function easyCore.Player.GetPlayerBySteam(Value)
    return easyCore.Player.GetPlayerByIdentifier("Steam", Value)
end

function easyCore.Player.GetPlayerByIP(Value)
    return easyCore.Player.GetPlayerByIdentifier("IP", Value)
end

function easyCore.Player.GetPlayerByDiscord(Value)
    return easyCore.Player.GetPlayerByIdentifier("Discord", Value)
end

function easyCore.Player.GetPlayerByLiveId(Value)
    return easyCore.Player.GetPlayerByIdentifier("LiveId", Value)
end

function easyCore.Player.GetPlayerByXboxLiveId(Value)
    return easyCore.Player.GetPlayerByIdentifier("XBL", Value)
end

function easyCore.Player.Save(PlayerId, ShowNotification)
    local PlayerData = easyCore.Player.Users[PlayerId]
    PlayerData.Ped = GetPlayerPed(PlayerId)
    PlayerData.Coords = GetEntityCoords(PlayerData.Ped)

    if ShowNotification == nil then
        ShowNotification = false
    end

    if PlayerData then
        local affectedRows;
        MySQL.Async.execute(
            'INSERT INTO players (citizenid, license, data, identifiers) VALUES (:citizenid, :license, :data, :identifiers) ON DUPLICATE KEY UPDATE citizenid = :citizenid, license = :license, data = :data, identifiers = :identifiers',
            {
                citizenid = PlayerData.citizenid,
                license = PlayerData.license,
                data = json.encode(PlayerData.CharacterData),
                identifiers = json.encode(PlayerData.IdentifierData)
            }, function(ar)
                affectedRows = ar;
            end)

        Citizne.Wait(1 * 1000);
        if affectedRows > 0 then
            if ShowNotification then
                easyCore.Functions.Notify(PlayerId, "success", "Data saved!")
            end

            return true
        else
            if ShowNotification then
                easyCore.Functions.Notify(PlayerId, "error", "Data was not able to be saved")
            end

            return false
        end
    else
        if ShowNotification then
            easyCore.Functions.Notify(PlayerId, "error", "Data was not able to be saved")
        end

        return false
    end
end

function easyCore.Player.GetCharacters(PlayerId)
    local Identifiers = easyCore.Functions.ExtractIdentifiers(PlayerId)
end

function easyCore.Player.Login(PlayerId, CharacterId)
end

function easyCore.Player.Logout(PlayerId)
    local success, data = easyCore.Player.GetPlayerById(PlayerId)
    if success then
        data.Data.CharacterData.Characters[data.Data.CharacterData.ActivateCharacter].LoggedIn = false
        data.Functions.Save(false)
        print("[easyCore] Saved player data for PlayerId ".. PlayerId)
    else
        warn("[easyCore] Error occured attempting to logout a non-existent player. PlayerId: ".. PlayerId)
    end
end

function easyCore.Player.Verify(PlayerId, PlayerData)
    local self = {}
    self.Data = {       
        ["PlayerId"] = PlayerId,
        ["Ped"] = GetPlayerPed(PlayerId),
        ["Coords"] = GetEntityCoords(self.Data.Ped),
    }

end

function easyCore.Player.Create(PlayerId, PlayerData)
    local self = {}
    self.Functions = {}
    self.Data = PlayerData 
    self.Data = {
        ["PlayerId"] = PlayerId,
        ["Ped"] = GetPlayerPed(PlayerId),
        ["Coords"] = GetEntityCoords(self.Data.Ped),

        ["CharacterData"] = {
            ["ActiveCharacter"] = 1,
            ["MaxCharacters"] = 5,
            ["Characters"] = {
                [1] = {
                    -- Basic
                    FirstName = "John",
                    LastName = "Doe",
                    BirthDate = "12/24/1969",
                    Phone = "123-456-7890",
                    PlayerUID = 1, -- Unique Player ID saved & re-used every login for same user, not same as FiveM player id.

                    Licenses = {
                        driver = true,
                        business = true,
                        firearm = true
                    },

                    -- Money
                    Cash = easyCore.Settings.DefaultCash or 5000,
                    Bank = easyCore.Settings.DefaultBank or 1000,

                    -- Health
                    Hunger = 100,
                    Thirst = 100,
                    Stamina = 100,

                    -- Job
                    JobId = 1,
                    OnDuty = false,

                    -- Criminaltiy
                    GangAssociation = false,
                    GangId = 1,

                    LoggedIn = true,
                    LastLogin = os.time(),
                    LastLoginFormated = os.date('%Y-%m-%d %H:%M:%S', self.Data.CharacterData.Characters[1].LastLogin)
                }
            }
        },

        ["IdentifierData"] = {
            ["License"] = "",
            ["Discord"] = "",
            ["IP"] = "",
            ["CitizenId"] = "",
            ["Steam"] = "",
            ["XBL"] = "",
            ["LiveId"] = ""
        }
    }

    self.Functions.Save = function(ShowNotification)
        return easyCore.Player.Save(self.Data.PlayerId, ShowNotification or false) -- Boolean value. true = success, false = error.
    end

    self.Functions.UpdateCoords = function(AutoSave)
        self.Data.Ped = GetPlayerPed(PlayerId)
        self.Data.Coords = GetEntityCoords(self.Data.Ped)

        if AutoSave ~= nil and AutoSave then
            return self.Functions.Save()
        end

        return true
    end

    self.Functions.UpdatePed = function(AutoSave)
        self.Data.Ped = GetPlayerPed(PlayerId)

        if AutoSave ~= nil and AutoSave then
            return self.Functions.Save()
        end

        return true
    end

    self.Functions.UpdateIdentifiers = function(AutoSave)
        local Identifiers = easyCore.Functions.ExtractIdentifiers(PlayerId)
        self.Data.IdentifierData.License = Identifiers.License
        self.Data.IdentifierData.Discord = Identifiers.Discord
        self.Data.IdentifierData.IP = Identifiers.IP
        self.Data.IdentifierData.Steam = Identifiers.Steam
        self.Data.IdentifierData.XBL = Identifiers.XBL
        self.Data.IdentifierData.LiveId = Identifiers.LiveId

        if AutoSave ~= nil and AutoSave then
            return self.Functions.Save()
        end

        return true
    end

    self.Functions.UpdatePed(false)
    self.Functions.UpdateCoords(false)
    self.Functions.UpdateIdentifiers(false)
    self.Data.IdentifierData.CitizenId = easyCore.Shared.CreateCitizenId()

    easyCore.Player.Users[self.Data.PlayerId] = self
    easyCore.Player.Save(self.Data.PlayerId)
end