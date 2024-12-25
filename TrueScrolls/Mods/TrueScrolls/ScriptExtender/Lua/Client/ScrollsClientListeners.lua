Ext.RegisterNetListener("TrueScrolls_UpdatePartyMembers", function(call, payload)
    local partyMembers = Ext.Json.Parse(payload)
    RefreshTabs(partyMembers)
end)

Ext.RegisterNetListener("TrueScrolls_ClientEndDayStateChanged", function(call, payload)
    local newState = Ext.Json.Parse(payload)
    LongRestState = newState.State

    if newState.State ~= nil and UIConfig.ShowNotifications == true then
        ShowScribeWindow()
    end
end)

Ext.RegisterNetListener("TrueScrolls_ClientShowScribeWindow", function(call, payload)
    if UIConfig.ShowNotifications == true then
        ShowScribeWindow()
    end
end)

Ext.Events.KeyInput:Subscribe(function(event, key, test)
    if event.Event ~= "KeyDown" then
        return
    end

    if ScribeWindow and ScribeWindow.KeybindActive then
        TempKeybind = event.Key
        TempModifiers = {}

        ScribeWindow.KeybindText:Destroy()
        ScribeWindow.KeybindText = nil

        local outKeybind = ""

        for _, mod in pairs(event.Modifiers) do
            outKeybind = outKeybind .. tostring(mod) .. "+"
            table.insert(TempModifiers, mod)
        end

        outKeybind = outKeybind .. tostring(event.Key)

        ScribeWindow.KeybindText = ScribeWindow.KeybindTextCell:AddSeparatorText(outKeybind)

        event:PreventAction()
    elseif UIConfig and tostring(event.Key) == UIConfig.Keybind then
        local modifiersPressed = {}
        local lookup = {}

        for _, mod in pairs(event.Modifiers) do
            table.insert(modifiersPressed, mod)
        end

        if #modifiersPressed ~= #UIConfig.Modifiers then
            return
        end

        for _, saved in ipairs(UIConfig.Modifiers) do
            lookup[saved] = true
        end

        for _, pressed in ipairs(modifiersPressed) do
            if lookup[pressed] == nil then
                return
            end
        end

        if ScribeWindow and ScribeWindow.Content then
            CloseScribeWindow()
        else
            ShowScribeWindow()
        end
    end
end)

Ext.Events.SessionLoaded:Subscribe(function()
    UpdateScrollSpells()
    Log("SESSION LOADED - CLIENT")
end)

Ext.Events.StatsLoaded:Subscribe(function()
    LoadBackupConfig()
    LoadUIConfig()
    Log("STATS LOADED - CLIENT")
end)

LoadUIConfig()