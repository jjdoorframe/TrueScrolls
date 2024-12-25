function LoadConfig()
    Ext.Vars.SyncModVariables()
    local modVars = Ext.Vars.GetModVariables(ModuleUUID)

    if modVars and modVars.ModConfig then
        ModConfig = KeysToNumbers(modVars.ModConfig)
    else
        ModConfig = {}
    end
end

function SaveConfig()
    if ModConfig then
        Ext.Vars.GetModVariables(ModuleUUID).ModConfig = KeysToNumbers(ModConfig)
    end
end

function SaveUIConfig()
    local newConfig = Ext.Json.Stringify(UIConfig)

    local saveStatus = pcall(Ext.IO.SaveFile, "TrueScrolls/UISettings.json", newConfig)

    if not saveStatus then
        Log("CONFIG: Failed to save config file")
    else
        LoadUIConfig()
        Log("CONFIG: Config file saved successfully")
    end
end

function LoadUIConfig()
    UIConfig = {
        ShowNotifications = true,
        AutoHide = true,
        AutoHideDelay = 10,
        Keybind = "SLASH",
        Modifiers = {}
    }

    local status, fileContent = pcall(Ext.IO.LoadFile, "TrueScrolls/UISettings.json")

    if not status or not fileContent then
        Log("CONFIG: Couldn't load config. Using defaults")
    else
        local parseStatus, result = pcall(Ext.Json.Parse, fileContent)

        if not parseStatus then
            Log("CONFIG: Failed to parse JSON")
        else
            UIConfig = result
        end
    end
end

--- Return a setting value for a given owner and setting name
---@param owner string
---@param settingName string
---@param index? number
---@return any
function GetSetting(owner, settingName, index)
    local value = nil

    if BackupConfig == nil then
        LoadBackupConfig()
    end

    if BackupConfig.OverrideGlobals == true then
        value = BackupConfig[settingName]

        if index and type(value) == "table" then
            return value[index]
        end

        return value
    end

    if ModConfig == nil then
        LoadConfig()
    end

    if index ~= nil then
        index = tonumber(index)
    end

    if index ~= nil then
        if ModConfig[owner] and ModConfig[owner].OverrideGlobals == true and ModConfig[owner][settingName] and ModConfig[owner][settingName][index] then
            value = ModConfig[owner][settingName][index]
        elseif ModConfig.Global and ModConfig.Global[settingName] and ModConfig.Global[settingName][index] then
            value = ModConfig.Global[settingName][index]
        else
            value = ConfigDefaults[settingName][index]
        end
    end

    if value == nil and index == nil then
        if ModConfig[owner] and ModConfig[owner].OverrideGlobals and ModConfig[owner][settingName] ~= nil then
            value = ModConfig[owner][settingName]
        elseif ModConfig.Global and ModConfig.Global[settingName] ~= nil then
            value = ModConfig.Global[settingName]
        else
            value = ConfigDefaults[settingName]
        end
    end

    return value
end

---@param tabOwner string
---@param settingName string
---@param state any
---@param index? integer
function SetSetting(tabOwner, settingName, state, index)
    if ModConfig[tabOwner] == nil then
        ModConfig[tabOwner] = {}
    end

    if index ~= nil then
        index = tonumber(index)
    end

    if index ~= nil then
        if ModConfig[tabOwner][settingName] == nil then
            ModConfig[tabOwner][settingName] = ConfigDefaults[settingName]
        end

        ModConfig[tabOwner][settingName][index] = state
    else
        ModConfig[tabOwner][settingName] = state
    end

    SaveConfig()
end

---@param handle string
---@param maxLength integer
---@param skipNewLine? boolean
function WrapText(handle, maxLength, skipNewLine)
    local text = GetString(handle)
    local wrappedLines = {}

    local paragraphs = {}

    for paragraph in text:gmatch("[^\n]+") do
        table.insert(paragraphs, paragraph)
    end

    for _, paragraph in ipairs(paragraphs) do
        local currentLine = ""
        for word in paragraph:gmatch("%S+") do
            if #currentLine + #word + 1 <= maxLength then
                if currentLine ~= "" then
                    currentLine = currentLine .. " "
                end
                currentLine = currentLine .. word
            else
                table.insert(wrappedLines, currentLine)
                currentLine = word
            end
        end

        if currentLine ~= "" then
            table.insert(wrappedLines, currentLine)
        end

        if skipNewLine ~= true then
            table.insert(wrappedLines, "")
        end
    end

    if #wrappedLines > 0 and wrappedLines[#wrappedLines] == "" then
        table.remove(wrappedLines, #wrappedLines)
    end

    return table.concat(wrappedLines, "\n")
end

---@param key string
---@param tableIn? table<string, string>
function GetString(key, tableIn)
    local stringOut = key
    local tableRef = tableIn or StringTable

    if tableRef[key] ~= nil then
        stringOut = Ext.Loca.GetTranslatedString(tableRef[key]):gsub("<br>", "\n")
    end

    if stringOut == "" then
        stringOut = key
    end

    return stringOut
end

---@param tbl string[]
function GetRandomString(tbl)
    return Ext.Loca.GetTranslatedString(tbl[math.random(#tbl)])
end

--- Scale UI elements based on viewport size
function Scale()
    return Ext.IMGUI.GetViewportSize()[2] / 2160
end

function RequestPartyUpdate()
    local function delayMessage()
        Ext.Net.PostMessageToServer("TrueScrolls_RequestPartyUpdate", "")
    end

    SetTimer(100, delayMessage)
end

--- Update data for scribed spells after settings change and send to server
function SendUpdatedScribeData()
    local spellData = {}

    if ActiveScribing then
        for characterGuid, data in pairs(ActiveScribing) do
            local spell = GetSpellScribeData(characterGuid, data.Spell, true)
            spellData[characterGuid] = spell
        end

        Ext.Net.PostMessageToServer("TrueScrolls_UpdateScribeData", Ext.Json.Stringify(spellData))
    end
end

---@param characterGuid string
---@param spellId string
---@param updateData? boolean
function GetSpellScribeData(characterGuid, spellId, updateData)
    local spell = Ext.Stats.Get(spellId)
    local data = {}

    if spell and spell.Level and spell.DisplayName then
        local totalTime = GetSetting(characterGuid, "CraftingTime", spell.Level)
        local totalCostCalc = GetSetting(characterGuid, "CraftingCost", spell.Level)
        local totalCost = totalCostCalc

        if updateData == true and ActiveScribing[characterGuid] then
            totalCostCalc = totalCostCalc - ActiveScribing[characterGuid].Paid
        end

        local basePayment = totalCostCalc > 0 and math.floor(totalCostCalc / totalTime) or 0
        local remainder = totalCostCalc % totalTime

        data = {
            Character = characterGuid,
            Spell = spellId,
            Name = Ext.Loca.GetTranslatedString(spell.DisplayName),
            Level = spell.Level,
            Time = totalTime,
            Cost = {
                Total = totalCost,
                BasePayment = basePayment,
                Remainder = remainder
            },
            Icon = spell.Icon,
            ElapsedTime = 0,
            Paused = false,
            CanAfford = false,
            Payment = 0,
            Prepared = true,
            SkipDay = false,
            Paid = 0,
            HasItems = false,
            ScrollUsed = false,
            ShortDay = false,
            CumulativeProgress = 0,
            ComplicationCount = 0,
            ComplicationScroll = nil,
            SkipPayment = false,
            Processed = false,
            CurrentItems = {
                Scroll = {
                    Quality = "None",
                    Guid = nil
                },
                Quill = {
                    Quality = "None",
                    Guid = nil
                },
                Ink = {
                    Quality = "None",
                    Guid = nil
                }
            }
        }
    end

    return data
end

---@param level integer
---@return string
function FormatSpellLevel(level)
    local levelText = ""

    local spellText = {
        [0] = GetString("Cantrip"),
        [1] = "1" .. GetString("st"),
        [2] = "2" .. GetString("nd"),
        [3] = "3" .. GetString("rd")
    }

    if level <= 3 then
        levelText = spellText[level]
    else
        levelText = level .. GetString("th")
    end

    return levelText
end

---@param r number
---@param g number
---@param b number
---@param a number
---@return number[]
function ToVec4(r, g, b, a)
    return {r / 255, g / 255, b / 255, a}
end

---@return boolean | nil
function GetLongRestState()
    if LongRestState == nil then
        local entity = Ext.Entity.GetAllEntitiesWithComponent("CampEndTheDayState")[1]

        if entity and entity.CampEndTheDayState then
            if entity.CampEndTheDayState.State == 2 then
                LongRestState = true
            else
                LongRestState = false
            end
        end
    end

    return LongRestState
end

---@param text string
---@param maxLength integer
---@return integer
function GetWrappedLinesCount(text, maxLength)
    local lines = {}
    for paragraph in text:gmatch("[^\n]+") do
        local currentLine = ""
        for word in paragraph:gmatch("%S+") do
            if #currentLine + #word + 1 <= maxLength then
                if currentLine ~= "" then
                    currentLine = currentLine .. " "
                end
                currentLine = currentLine .. word
            else
                table.insert(lines, currentLine)
                currentLine = word
            end
        end
        if currentLine ~= "" then
            table.insert(lines, currentLine)
        end
        table.insert(lines, "")
    end
    if #lines > 0 and lines[#lines] == "" then
        table.remove(lines, #lines)
    end
    return #lines
end

---@param text string
---@param maxLength integer
---@param totalLines integer
---@return string
function PadWrappedText(text, maxLength, totalLines, skipNewLine)
    local wrappedLines = {}
    local paragraphs = {}

    for paragraph in text:gmatch("[^\n]+") do
        table.insert(paragraphs, paragraph)
    end

    for _, paragraph in ipairs(paragraphs) do
        local currentLine = ""
        for word in paragraph:gmatch("%S+") do
            if #currentLine + #word + 1 <= maxLength then
                if currentLine ~= "" then
                    currentLine = currentLine .. " "
                end
                currentLine = currentLine .. word
            else
                table.insert(wrappedLines, currentLine)
                currentLine = word
            end
        end

        if currentLine ~= "" then
            table.insert(wrappedLines, currentLine)
        end

        if not skipNewLine then
            table.insert(wrappedLines, "")
        end
    end

    if skipNewLine and #wrappedLines > 0 and wrappedLines[#wrappedLines] == "" then
        table.remove(wrappedLines, #wrappedLines)
    end

    while #wrappedLines < totalLines do
        table.insert(wrappedLines, "")
    end

    return table.concat(wrappedLines, "\n")
end

---@param characterGuid string
---@return string
function GetScribingProgressState(characterGuid)
    local data = ActiveScribing[characterGuid]
    local daysLeft = data.Time - data.ElapsedTime
    local hasError = data.Prepared == false or data.CanAfford == false or data.HasItems == false

    if data.Paused == true or data.SkipDay == true then
        return "Paused"
    elseif hasError == true then
        return "Error"
    elseif data.ShortDay == true then
       return "ShortDay"
    elseif GetLongRestState() == true then
        if daysLeft == 1 then
           return "FinalDay"
        else
           return "LongRest"
        end
    else
       return "Default"
    end
end

---@param characterGuid string
---@return string
function GetProgressInfoText(characterGuid)
    local progressInfoText = ""
    local data = ActiveScribing[characterGuid]
    local state = GetScribingProgressState(characterGuid)
    local erroStrings = {}
    local errorConditions = {
        Prepared = GetString("SpellNotPrepared"),
        CanAfford = GetString("Missing") .. " " .. data.Payment .. " " .. GetString("gp") .. "!",
        HasItems = ""
    }

    for condition, errorText in pairs(errorConditions) do
        if data[condition] == false then
            local outText = errorText

            if condition == "HasItems" and next(data.CurrentItems) then
                local missingItems = {}

                for item, details in pairs(data.CurrentItems) do
                    if details.Quality == "None" then
                        if item == "Scroll" and data.ScrollUsed == false then
                            table.insert(missingItems, GetString("AParchment"))
                        elseif item == "Quill" then
                            table.insert(missingItems, GetString("AQuill"))
                        elseif item == "Ink" then
                            table.insert(missingItems, GetString("Ink"))
                        end
                    end
                end

                if #missingItems == 1 then
                    outText = GetString("Missing") .. " " .. missingItems[1] .. "!"
                else
                    local lastItem = table.remove(missingItems)
                    outText = GetString("Missing") .. " " .. table.concat(missingItems, ", ") .. ", " .. GetString("And") .. " " .. lastItem .. "!"
                end
            end

            table.insert(erroStrings, outText)
        end
    end

    if state == "Paused" then
        progressInfoText = GetRandomString(ScribingPausedText)
    elseif state == "Error" then
        progressInfoText = table.concat(erroStrings, "\n")
    elseif state == "ShortDay" then
        progressInfoText = GetString("ScrribeTwoHours")
    elseif state == "FinalDay" then
        progressInfoText = GetRandomString(ScribingFinalDayText)
    elseif state == "LongRest" then
        progressInfoText = GetRandomString(ScribingFlavorText)
    else
        progressInfoText = GetRandomString(ScribingLaterText)
    end

    return progressInfoText
end

---@param setting string
---@return any
function GetDisplayUISetting(setting)
    if setting == "Keybind" then
        local outKeybind = ""

        for _, modifier in ipairs(UIConfig.Modifiers) do
            outKeybind = outKeybind .. modifier .. "+"
        end

        outKeybind = outKeybind .. UIConfig.Keybind

        return outKeybind
    end

    if type(UIConfig[setting]) == "number" then
        return UIConfig[setting]
    end

    if UIConfig[setting] == true then
        return GetString("Enabled")
    else
        return GetString("Disabled")
    end
end

---@param value number
function FormatNumber(value)
    if math.floor(value) == value then
        return string.format("%d", value)
    else
        return string.format("%.1f", value)
    end
end

--- Recalculate scribing cost when a setting changes
function RequestRecalculateCost()
    local function delayMessage()
        Ext.Net.PostMessageToServer("TrueScrolls_CalculateScribingCost", "")
    end

    SetTimer(100, delayMessage)
end
