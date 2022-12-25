easyCore.Shared = {}

easyCore.Shared.CreateCitizenId = function()
    local template = 'xxxxxxxx-xxxx-xxxx-yxxx-xxxxxxxxxxxx'
    
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)

    -- from jrus/lua-uuid.lua
    -- https://gist.github.com/jrus/3197011
end

easyCore.Shared.Round = function(number)
    if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
        number = number - (number % 1)
    else
        number = (number - (number % 1)) + 1
    end
    return number

    -- from hastumer, edited by neuron.
    -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
end