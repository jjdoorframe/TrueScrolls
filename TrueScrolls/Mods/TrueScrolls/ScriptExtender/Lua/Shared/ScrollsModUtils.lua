-- Toggle debug across the mod
DebuggingEnabled = false

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
        local path = 'Public/TrueScrolls/Stats/Generated/Data/'
        local stats = {'Status_BOOST.txt', 'TrueScrolls.txt'}

        for _, filename in pairs(stats) do
            local filePath = string.format('%s%s', path, filename)

            if string.len(filename) > 0 then
                Log('RELOADING %s', filePath)
                Ext.Stats.LoadStatsFile(filePath, false)
            else
                Log('Invalid file: %s', filePath)
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

function GetGuid(osiGuid)
    local entity = Ext.Entity.Get(osiGuid)
    local entityGuid = ""

    if entity and entity.Uuid then
        entityGuid = entity.Uuid.EntityUuid
    end

    return entityGuid
end

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
