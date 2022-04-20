-- Data Templates

function GetTemplates()
    return {
        ["Player"] = {
            Character = {
                -- Basic
                FirstName = "John",
                LastName = "Doe",
                BirthDate = "12/24/1969",
                Phone = "123-456-7890",
                PlayerUID = 1, -- Unique Player ID saved & re-used every login for same user, not same as FiveM player id.

                Licenses = {
                    driver = true,
                    business = true,
                    firearm = true,
                },

                -- Money
                Cash = 5000,
                Bank = 1000,

                -- Health
                Hunger = 100,
                Thirst = 100,
                Stamina = 100,

                -- Job
                JobId = 1,
                OnDuty = true,

                -- Criminaltiy
                GangAssociation = true,
                GangId = 1,

                LoggedIn = true,
                LastLogin = 1234567890,
                LastLoginFormated = "3/28/2022",
            },

            Identifiers = {
                License = "",
                Discord = "",
                IP = "",
                CitizenId = "",
            },

            Functions = {
                GetItems = function()
                end,
            }
        }
    }
end