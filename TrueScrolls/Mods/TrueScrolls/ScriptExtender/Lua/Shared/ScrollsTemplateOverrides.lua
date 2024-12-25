--- Replace spells in scroll templates with the ones in TrueScrolls.txt or vice versa
---@param clientSpells? table<string, string>
function UpdateScrollSpells(clientSpells)
    local allObjects = Ext.Stats.GetStats("Object")
    local allSpells = Ext.Stats.GetStats("SpellData")
    local spellsTrueScrolls = clientSpells
    local staticDc = GetSetting("Global", "StaticSpellSaveDC")
    local wizardCantris = GetSetting("Global", "WizardCopyCantrips")
    local scrollsList = {}

    if staticDc == nil then
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
                local spellRef

                for i, actionData in ipairs(scrollTemplate.OnUsePeaceActions) do
                    if actionData and actionData.Type == "UseSpell" then
                        local spellStats = Ext.Stats.Get(actionData.Spell)

                        if actionData.Spell == "Projectile_Fireball_FromScroll" then
                            actionData.Spell = "Projectile_Fireball"
                        end

                        spellRef = actionData.Spell

                        if staticDc == true then
                            if spellsTrueScrolls[actionData.Spell] then
                                actionData.Spell = spellsTrueScrolls[actionData.Spell]
                            end
                        elseif string.find(actionData.Spell, "TrueScrolls") then
                            if spellStats and spellStats.Using ~= nil then
                                actionData.Spell = spellStats.Using
                                spellRef = actionData.Spell
                            end
                        end

                        local trueSpell = GetTrueSpell(actionData.Spell)
                        scrollsList[trueSpell] = {
                            Template = object.RootTemplate,
                            Level = spellStats.Level
                        }
                    elseif actionData and actionData.Type == "LearnSpell" then
                        local checkSpell = actionData.Spell

                        if checkSpell == nil or checkSpell == "" then
                            checkSpell = spellRef
                        end

                        local spellStats = Ext.Stats.Get(checkSpell)

                        if spellStats and spellStats.Level == 0 then
                            if wizardCantris == true then
                                actionData.Spell = tostring(checkSpell)
                            else
                                actionData.Spell = ""
                            end
                        end
                    end
                end
            end
        end
    end

    if Ext.IsClient() == true then
        Ext.Net.PostMessageToServer("TrueScrolls_SpellSaveSettingChanged", Ext.Json.Stringify(spellsTrueScrolls))
        Ext.Net.PostMessageToServer("TrueScrolls_ScrollsListUpdated", Ext.Json.Stringify(scrollsList))
        Log("Updated spell scrolls with static DC - CLIENT")
    else
        RecreateScrolls()
        Log("Updated spell scrolls with static DC - SERVER")
    end
end
