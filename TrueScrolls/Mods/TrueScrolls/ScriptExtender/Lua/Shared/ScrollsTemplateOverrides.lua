--- Replace spells in scroll templates with the ones in TrueScrolls.txt or vice versa
---@param clientSpells table | nil
function UpdateScrollSpells(clientSpells)
    local allObjects = Ext.Stats.GetStats("Object")
    local allSpells = Ext.Stats.GetStats("SpellData")
    local spellsTrueScrolls = clientSpells
    local configValue = GetSetting("Global", "StaticSpellSaveDC")

    if configValue == nil then
        Log("Failed to get config value for Spell Save DC!")
        return
    end

    -- Get all the spells from TrueScrolls.txt
    if spellsTrueScrolls == nil then
        spellsTrueScrolls = {}

        for _, spellName in pairs(allSpells) do
            if string.find(spellName, "TrueScrolls") then
                local spellStat = Ext.Stats.Get(spellName)
                spellsTrueScrolls[spellStat.Using] = spellName
            end
        end
    end

    for _, objectName in pairs(allObjects) do
        local object = Ext.Stats.Get(objectName)

        -- Get template referenced in each scroll object
        if object and object.Using and object.Using == "_MagicScroll" then
            local scrollTemplate

            if Ext.IsClient() == true then
                scrollTemplate = Ext.ClientTemplate.GetTemplate(object.RootTemplate)
            else
                scrollTemplate = Ext.ServerTemplate.GetTemplate(object.RootTemplate)
            end

            if scrollTemplate and #scrollTemplate.OnUsePeaceActions > 0 then
                for _, actionData in ipairs(scrollTemplate.OnUsePeaceActions) do
                    if actionData and actionData.Type == "UseSpell" then
                        if actionData.Spell == "Projectile_Fireball_FromScroll" then
                            actionData.Spell = "Projectile_Fireball"
                        end

                        if configValue == true then
                            if spellsTrueScrolls[actionData.Spell] then
                                actionData.Spell = spellsTrueScrolls[actionData.Spell]
                            end
                        elseif string.find(actionData.Spell, "TrueScrolls") then
                            local spellStats = Ext.Stats.Get(actionData.Spell)

                            if spellStats and spellStats.Using ~= nil then
                                actionData.Spell = spellStats.Using
                            end
                        end
                    end
                end
            end
        end
    end

    if Ext.IsClient() == true then
        Ext.Net.PostMessageToServer("SpellSaveSettingChanged", Ext.Json.Stringify(spellsTrueScrolls))
        Log("Updated spell scrolls with static DC - CLIENT")
    else
        Log("Updated spell scrolls with static DC - SERVER")
    end

    if Ext.IsServer() == true then
        RecreateScrolls()
    end

end
