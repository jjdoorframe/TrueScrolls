-- Toggle debug across the mod
DebuggingEnabled = false

ConfigDefaults = {
    OverrideGlobals = false,
    RevivifyScrollOverride = false,
    ClassRestriction = true,
    CastRoll = true,
    StaticAttackRoll = true,
    StaticAttackRollBonus = 0,
    StaticSpellSaveDC = true,
    ScribeRoll = true,
    ThiefCanCast = false,
    ArtificerRequireRoll = false,
    CastRollBonus = 0,
    ScribeRollBonus = 0,
    ClassCasting = true,
    RequireWizardLevels = true,
    CraftingTime = {
        [0] = 1,
        [1] = 1,
        [2] = 3,
        [3] = 5,
        [4] = 10,
        [5] = 20,
        [6] = 40,
        [7] = 80,
        [8] = 160,
        [9] = 240
    },
    CraftingCost = {
        [0] = 15,
        [1] = 25,
        [2] = 250,
        [3] = 500,
        [4] = 2500,
        [5] = 5000,
        [6] = 15000,
        [7] = 25000,
        [8] = 50000,
        [9] = 250000
    },
    CraftingRequireItems = false,
    CraftingArcanaProficiency = true,
    CraftingSharedGold = true,
    CraftingQuillBreakChance = 0.25,
    CraftingSpellPrepared = "PreparedLongRest",
    WizardCopyCantrips = false,
    CraftingRuleset = "RulesetHomebrew",
    CraftingArcanaCheck = false,
    CraftingCheckBonus = 0,
    CraftingComplications = true,
    CraftingComplicationChance = 0.1,
    MajorVersion = 1
}

---@param message string
function Log(message, ...)
    if DebuggingEnabled then
        local formattedMessage = string.format(message, ...)
        Ext.Utils.Print("[True Scrolls] " .. formattedMessage)
    end
end

-- Reloads stats files at runtime
-- Only enabled with debugging
function ReloadStats()
    if DebuggingEnabled then
        local path = "Public/TrueScrolls/Stats/Generated/Data/"
        local stats = {"Status_BOOST.txt", "TrueScrolls.txt", "Object.txt"}

        for _, filename in pairs(stats) do
            local filePath = string.format("%s%s", path, filename)

            if string.len(filename) > 0 then
                Log("RELOADING %s", filePath)
                Ext.Stats.LoadStatsFile(filePath, false)
            else
                Log("Invalid file: %s", filePath)
            end
        end
    end
end

function Dump(fileName, data)
    if DebuggingEnabled then
        local file = "Dumps/" .. fileName .. ".json"
        Ext.IO.SaveFile(file, Ext.DumpExport(data))
        Log("%s successfully dumped", file)
    end
end

---@param time integer
function SetTimer(time, call, ...)
    local startTime = Ext.Utils.MonotonicTime()
    local event
    local args = {...}
    event = Ext.Events.Tick:Subscribe(function()

        if Ext.Utils.MonotonicTime() - startTime >= time then
            call(table.unpack(args))
            Ext.Events.Tick:Unsubscribe(event)
        end
    end)

    return event
end

---@param osiGuid string
function GetGuid(osiGuid)
    local entity = Ext.Entity.Get(osiGuid)
    local entityGuid = ""

    if entity and entity.Uuid then
        entityGuid = entity.Uuid.EntityUuid
    end

    return entityGuid
end

---@param array table
---@param search any
function ArrayContains(array, search)
    for _, element in ipairs(array) do
        if element == search then
            return true
        end
    end

    return false
end

---@param entityGuid string
---@return string
function GetDisplayName(entityGuid)
    local entity = Ext.Entity.Get(entityGuid)
    local name = "FAILED_TO_GET_NAME"

    if entity and entity.DisplayName and entity.DisplayName.NameKey then
        name = entity.DisplayName.NameKey:Get()
    end

    return name
end

---@param spellId string
function GetTrueSpell(spellId)
    if string.find(spellId, "Scroll") then
        local spellStat = Ext.Stats.Get(spellId)
        return spellStat.Using
    else
        return spellId
    end
end

---@param orig table | any
function DeepCopy(orig)
    local copy

    if type(orig) == 'table' then
        copy = {}

        for key, value in pairs(orig) do
            copy[key] = DeepCopy(value)
        end
    else
        copy = orig
    end

    return copy
end

---@param tbl table
function KeysToNumbers(tbl)
    local normalizedTable = {}

    for k, v in pairs(tbl) do
        local numericKey = tonumber(k) or k

        if type(v) == "table" then
            normalizedTable[numericKey] = KeysToNumbers(v)
        else
            normalizedTable[numericKey] = v
        end
    end
    
    return normalizedTable
end

function SaveBackupConfig()
    local newConfig = Ext.Json.Stringify(ConfigDefaults)

    local saveStatus = pcall(Ext.IO.SaveFile, "TrueScrolls/ModConfig.json", newConfig)
    if not saveStatus then
        Log("CONFIG: Failed to save config file")
    else
        LoadBackupConfig()
        Log("CONFIG: Config file saved successfully")
    end
end

function LoadBackupConfig()
    BackupConfig = {}
    local cachedConfig = {}

    local status, fileContent = pcall(Ext.IO.LoadFile, "TrueScrolls/ModConfig.json")
    if not status or not fileContent then
        Log("CONFIG: Couldn't load config. Creating new one")
        SaveBackupConfig()
    else
        local parseStatus, result = pcall(Ext.Json.Parse, fileContent)
        if not parseStatus then
            Log("CONFIG: Failed to parse JSON")
        else
            cachedConfig = result
        end
    end

    for key, value in pairs(ConfigDefaults) do
        if cachedConfig[key] == nil then
            cachedConfig[key] = value
        end
    end

    BackupConfig = cachedConfig
end