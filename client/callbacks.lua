exports["kimi_callbacks"]:Register("easyCore:client:InitCharacterCustomization", function()
    exports['ec-appearance']:startPlayerCustomization(function(appearance)
        if (appearance) then
            return true, appearance
        else
            return false, appearance
        end
    end)
end)
