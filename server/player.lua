-- Tables
easyCore.Player = {}
easyCore.Player.Users = {}

if not easyCore.Plugins["skincreator"] then
    warn("Skin creator module is required in-order for the system to properly work")
    return true
end

-- Plugins
local skincreator = easyCore:GetPlugin("skincreator")

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
                citizenid = PlayerData.IdentifierData.CitizenId,
                license = PlayerData.IdentifierData.License,
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

function easyCore.Player.CreatePhoneNumber()
    local UniqueFound = false
    local PhoneNumber = nil

    while not UniqueFound do
        PhoneNumber = math.random(100, 999) .. math.random(1000000, 9999999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.Sync.prepare('SELECT COUNT(*) as count FROM players WHERE data LIKE ?', {query})

        if result == 0 then
            UniqueFound = true
        end
    end

    return PhoneNumber
    -- from QBCore main/server/player.lua QBCore.Functions.CreatePhoneNumber()
end

function easyCore.Player.GetCharacters(PlayerId)
    local License = easyCore.Functions.ExtractIdentifiers(PlayerId).License
    local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where license = ?', {License})

    if not skincreator.Settings.CharacterCreationEnabled then
        -- if the request was not successful as defined by the first boolean
        -- will check the second boolean, if true then it was forcefully returned false
        -- as characters been disabled.

        -- im terrible at explaining.
        return false, true
    end

    if PlayerData then
        return true, PlayerData.CharacterData.Characters or {}
    else
        return false, false
    end
end

function easyCore.Player.CreateCharacter(PlayerId, CharacterData, SetAsCurrentCharacter)
    local License = easyCore.Functions.ExtractIdentifiers(PlayerId).License
    local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where license = ?', {License})

    if PlayerData then
        local Id = #PlayerData.CharacterData.Characters + 1;
        local Template = {
            -- Basic
            FirstName = "John",
            LastName = "Doe",
            BirthDate = "12/24/1969",
            Phone = "123-456-7890",

            Licenses = {
                driver = false,
                business = false,
                firearm = false
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
            JobGrade = 1,
            OnDuty = false,

            -- Criminaltiy
            GangAssociation = false,
            GangId = 1,
            GangGrade = 1,

            LoggedIn = true,
            LastLogin = os.time(),
            LastLoginFormated = os.date('%Y-%m-%d %H:%M:%S', self.Data.CharacterData.Characters[1].LastLogin),
        }

        Template.FirstName = CharacterData.FirstName or "John"
        Template.LastName = CharacterData.LastName or "Doe"
        Template.BirthDate = CharacterData.BirthDate or "12/24/1969"
        Template.Phone = CharacterData.Phone or easyCore.Player.CreatePhoneNumber()

        PlayerData.CharacterData.Characters[Id] = Template

        if SetAsCurrentCharacter ~= nil and SetAsCurrentCharacter then
            PlayerData.CharacterData.ActiveCharacter = Id
            skincreator.ToggleCreator(PlayerId, Id, true)
            easyCore.Player.LoadCharacter(PlayerId)
        end
    else
        return false
    end
end

function easyCore.Player.Login(PlayerId, CitizenId, CharacterId)
    local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', {CitizenId})
    local license = easyCore.Functions.ExtractIdentifiers(PlayerId).License

    if PlayerData then
        if license == PlayerData.license then
            -- Use saved data
            PlayerData.CharacterData.ActiveCharacter = CharacterId
            easyCore.Player.Verify(PlayerId, PlayerData)
        else
            DropPlayer(PlayerId, "Exploiting")
        end
    else
        -- Create
        PlayerData.CharacterData.ActiveCharacter = 0
        easyCore.Player.Verify(PlayerId, PlayerData)
    end
end

function easyCore.Player.Logout(PlayerId)
    local success, data = easyCore.Player.GetPlayerById(PlayerId)
    if success then
        data.Data.CharacterData.Characters[data.Data.CharacterData.ActivateCharacter].LoggedIn = false
        data.Functions.Save(false)
        print("[easyCore] Saved player data for PlayerId " .. PlayerId)
    else
        warn("[easyCore] Error occured attempting to logout a non-existent player. PlayerId: " .. PlayerId)
    end
end

function easyCore.Player.Verify(PlayerId, PlayerData)
    local Identifiers = easyCore.Functions.ExtractIdentifiers(PlayerId)
    local self = {}
    self.Data = {
        ["PlayerId"] = PlayerId,
        ["Ped"] = GetPlayerPed(PlayerId),
        ["Coords"] = GetEntityCoords(self.Data.Ped),

        ["CharacterData"] = {
            ["ActiveCharacter"] = 1,
            ["MaxCharacters"] = 5,
            ["Characters"] = {}
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

    -- Verify CharacterData
    self.Data.CharacterData.ActiveCharacter = PlayerData.CharacterData.ActiveCharacter or 0
    self.Data.CharacterData.MaxCharacters = PlayerData.CharacterData.MaxCharacters or easyCore.Settings.MaxCharacters
    self.Data.CharacterData.Characters = PlayerData.CharacterData.Characters or {}

    -- Verify IdentifierData
    self.Data.IdentifierData.License = PlayerData.IdentifierData.License or Identifiers.License
    self.Data.IdentifierData.Discord = PlayerData.IdentifierData.Discord or Identifiers.Discord
    self.Data.IdentifierData.IP = PlayerData.IdentifierData.IP or Identifiers.IP
    self.Data.IdentifierData.Steam = PlayerData.IdentifierData.Steam or Identifiers.Steam
    self.Data.IdentifierData.CitizenId = PlayerData.IdentifierData.CitizenId or easyCore.Shared.CreateCitizenId()

    easyCore.Player.Create(PlayerId, self.Data)
end

function easyCore.Player.Create(PlayerId, PlayerData)
    local self = {}
    self.Functions = {}
    self.Data = PlayerData

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

    easyCore.Player.Users[self.Data.PlayerId] = self
    easyCore.Player.Save(self.Data.PlayerId)
end
