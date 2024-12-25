--- Create a 5e reference tab
---@param treeParent ExtuiTreeParent
local function ReferenceTab(treeParent)

    local refTable = treeParent:AddTable("RefTable", 1)
    refTable.ColumnDefs[1] = {
        Width = 1190 * Scale(),
        WidthFixed = true
    }

    local mainCell = refTable:AddRow():AddCell()

    MakeTitle(mainCell, "SpellScrolls")

    mainCell:AddText(WrapText("RefMainText", 95))
    mainCell:AddNewLine()

    local scrollTable = mainCell:AddTable("scrollTable", 4)
    scrollTable.Size = {1190 * Scale(), 500 * Scale()}
    scrollTable.BordersInnerH = true
    scrollTable.PadOuterX = true

    local scrollHeader = scrollTable:AddRow()
    scrollHeader.Headers = true

    scrollHeader:AddCell():AddText(GetString("SpellLevel"))
    scrollHeader:AddCell():AddText(GetString("Rarity"))
    scrollHeader:AddCell():AddText(GetString("SaveDC"))
    scrollHeader:AddCell():AddText(GetString("AttackBonus"))

    MakeRefTableRow(scrollTable, 0, "Common", "13", "+5")
    MakeRefTableRow(scrollTable, 1, "Common", "13", "+5")
    MakeRefTableRow(scrollTable, 2, "Uncommon", "13", "+5")
    MakeRefTableRow(scrollTable, 3, "Uncommon", "15", "+7")
    MakeRefTableRow(scrollTable, 4, "Rare", "15", "+7")
    MakeRefTableRow(scrollTable, 5, "Rare", "17", "+9")
    MakeRefTableRow(scrollTable, 6, "VeryRare", "17", "+9")
    MakeRefTableRow(scrollTable, 7, "VeryRare", "18", "+10")
    MakeRefTableRow(scrollTable, 8, "VeryRare", "18", "+10")
    MakeRefTableRow(scrollTable, 9, "Legendary", "19", "+11")

    MakeTitle(mainCell, "CopyingAScroll")
    mainCell:AddText(WrapText("RefCopyText", 95))

    MakeTitle(mainCell, "ScribingASpellScroll")
    mainCell:AddText(WrapText("RefScribingText", 95))

    local scribeTable = mainCell:AddTable("scrollTable", 4)
    scribeTable.Size = {1190 * Scale(), 500 * Scale()}
    scribeTable.BordersInnerH = true
    scribeTable.PadOuterX = true

    local scribeHeader = scribeTable:AddRow()
    scribeHeader.Headers = true

    scribeHeader:AddCell():AddText(GetString("SpellLevel"))
    scribeHeader:AddCell():AddText(GetString("Time"))
    scribeHeader:AddCell():AddText(GetString("Cost"))

    MakeScribeRefTableRow(scribeTable, 0, 1, 15)
    MakeScribeRefTableRow(scribeTable, 1, 1, 25)
    MakeScribeRefTableRow(scribeTable, 2, 3, 250)
    MakeScribeRefTableRow(scribeTable, 3, 5, 500)
    MakeScribeRefTableRow(scribeTable, 4, 10, 2500)
    MakeScribeRefTableRow(scribeTable, 5, 20, 5000)
    MakeScribeRefTableRow(scribeTable, 6, 40, 15000)
    MakeScribeRefTableRow(scribeTable, 7, 80, 25000)
    MakeScribeRefTableRow(scribeTable, 8, 160, 50000)
    MakeScribeRefTableRow(scribeTable, 9, 240, 250000)
end

--- Populate a character's settings tab
---@param treeParent ExtuiTreeParent
---@param tabOwner string
---@param tabName string
---@param characterData? table
local function PopulateSettingsTab(treeParent, tabOwner, tabName, characterData)
    local isThief = characterData and characterData.Thief ~= false
    local isArtificer = characterData and characterData.Artificer ~= false
    local isWizard = characterData and characterData.Wizard ~= false
    local isGlobal = tabOwner == "Global"
    local isProficient = isGlobal or ((characterData and characterData.Proficient ~= false) or GetSetting(tabOwner, "CraftingArcanaProficiency") == false)

    ---Create all the settings automagically
    ---@type SettingSection[]
    local settingsConfig = {{
        title = "CastingSettings",
        items = {{
            label1 = "Revivify",
            label2 = "Override",
            type = "checkbox",
            setting = "RevivifyScrollOverride",
            trueKey = "RevivifyTrue",
            falseKey = "RevivifyFalse"
        }, {
            label1 = "Class",
            label2 = "CastingAbility",
            type = "checkbox",
            setting = "ClassCasting",
            trueKey = "ClassCastingTrue",
            falseKey = "ClassCastingFalse"
        }, {
            label1 = "Casting",
            label2 = "AbilityCheck",
            type = "checkbox",
            setting = "CastRoll",
            trueKey = "CastingRollTrue",
            falseKey = "CastingRollFalse",
            additionalLogic = RefreshTabs
        }, {
            label1 = "Casting",
            label2 = "DifficultyModifier",
            type = "slider",
            setting = "CastRollBonus",
            min = -10,
            max = 10,
            condition = GetSetting(tabOwner, "CastRoll")
        }, {
            label1 = "SpellList",
            label2 = "Restrictions",
            type = "checkbox",
            setting = "ClassRestriction",
            trueKey = "ClassRestrictionTrue",
            falseKey = "ClassRestrictionFalse"
        }, {
            label1 = "Static",
            label2 = "AttackBonus",
            type = "checkbox",
            setting = "StaticAttackRoll",
            trueKey = "StaticAttackRollTrue",
            falseKey = "StaticAttackRollFalse",
            additionalLogic = RefreshTabs
        }, {
            label1 = "Additional",
            label2 = "AttackBonus",
            type = "slider",
            setting = "StaticAttackRollBonus",
            min = -10,
            max = 10,
            condition = GetSetting(tabOwner, "StaticAttackRoll")
        }, {
            label1 = "Static Spell",
            label2 = "SaveDC",
            type = "checkbox",
            setting = "StaticSpellSaveDC",
            trueKey = "StaticSaveDCTrue",
            falseKey = "StaticSaveDCFalse",
            additionalLogic = UpdateScrollSpells,
            condition = isGlobal
        }, {
            label1 = "Thief",
            label2 = "CanUseScrolls",
            type = "checkbox",
            setting = "ThiefCanCast",
            trueKey = "ThiefCanCastTrue",
            falseKey = "ThiefCanCastFalse",
            condition = isThief
        }, {
            label1 = "Artificer",
            label2 = "RequireRoll",
            type = "checkbox",
            setting = "ArtificerRequireRoll",
            trueKey = "ArtificerRollTrue",
            falseKey = "ArtificerRollFalse",
            condition = isArtificer
        }}
    }, {
        title = "CopyingSettings",
        condition = isWizard,
        items = {{
            label1 = "Require",
            label2 = "WizardLevels",
            type = "checkbox",
            setting = "RequireWizardLevels",
            trueKey = "WizardLevelsTrue",
            falseKey = "WizardLevelsFalse"
        }, {
            label1 = "Copying",
            label2 = "AbilityCheck",
            type = "checkbox",
            setting = "ScribeRoll",
            trueKey = "CopyingRollTrue",
            falseKey = "CopyingRollFalse",
            additionalLogic = RefreshTabs
        }, {
            label1 = "Copying",
            label2 = "DifficultyModifier",
            type = "slider",
            setting = "ScribeRollBonus",
            min = -10,
            max = 10,
            condition = GetSetting(tabOwner, "ScribeRoll")
        }, {
            label1 = "Can Copy",
            label2 = "Cantrips",
            type = "checkbox",
            setting = "WizardCopyCantrips",
            trueKey = "WizardCopyCantripsTrue",
            falseKey = "WizardCopyCantripsFalse",
            additionalLogic = UpdateScrollSpells,
            condition = isGlobal
        }}
    }, {
        title = "ScribingSettings",
        items = {{
            label1 = "Require",
            label2 = "ArcanaProficiency",
            type = "checkbox",
            setting = "CraftingArcanaProficiency",
            trueKey = "CraftingArcanaProficiencyTrue",
            falseKey = "CraftingArcanaProficiencyFalse",
            additionalLogic = RefreshTabs
        }, {
            label1 = "Adjust",
            label2 = "ScribingTime",
            type = "levelTable",
            setting = "CraftingTime",
            text = "Set",
            minimum = 1,
            condition = isProficient
        }, {
            label1 = "Adjust",
            label2 = "ScribingCost",
            type = "levelTable",
            setting = "CraftingCost",
            text = "Set",
            minimum = 0,
            condition = isProficient
        }, {
            label1 = "Share",
            label2 = "ScribingCost",
            type = "checkbox",
            setting = "CraftingSharedGold",
            trueKey = "CraftingSharedGoldTrue",
            falseKey = "CraftingSharedGoldFalse",
            condition = isProficient,
            additionalLogic = RequestRecalculateCost
        }, {
            label1 = "Downtime",
            label2 = "ActivityRuleset",
            type = "combo",
            setting = "CraftingRuleset",
            options = {"RulesetRAW", "RulesetSimplified", "RulesetHomebrew"},
            condition = isProficient
        }, {
            label1 = "Require",
            label2 = "PreparedSpell",
            type = "combo",
            setting = "CraftingSpellPrepared",
            options = {"PreparedDisabled", "PreparedLongRest", "PreparedShortRest"},
            condition = isProficient,
            additionalLogic = RequestPartyUpdate
        }, {
            label1 = "Scribing",
            label2 = "Complications",
            type = "checkbox",
            setting = "CraftingComplications",
            trueKey = "CraftingComplicationsTrue",
            falseKey = "CraftingComplicationsFalse",
            condition = isProficient,
            additionalLogic = RefreshTabs
        }, {
            label1 = "ChanceOf",
            label2 = "Complications",
            type = "slider",
            setting = "CraftingComplicationChance",
            min = 0,
            max = 100,
            buttonType = "Percent",
            condition = isProficient and GetSetting(tabOwner, "CraftingComplications")
        }, {
            label1 = "Require",
            label2 = "ScribingItems",
            type = "checkbox",
            setting = "CraftingRequireItems",
            trueKey = "CraftingRequireItemsTrue",
            falseKey = "CraftingRequireItemsFalse",
            condition = isProficient,
            additionalLogic = RequestRecalculateCost
        }, {
            label1 = "ChanceOf",
            label2 = "QuillBreaking",
            type = "slider",
            setting = "CraftingQuillBreakChance",
            min = 0,
            max = 100,
            buttonType = "Percent",
            condition = isProficient and GetSetting(tabOwner, "CraftingRequireItems")
        }, {
            label1 = "Require",
            label2 = "ArcanaCheck",
            type = "checkbox",
            setting = "CraftingArcanaCheck",
            trueKey = "CraftingArcanaCheckTrue",
            falseKey = "CraftingArcanaCheckFalse",
            condition = isProficient,
            additionalLogic = RefreshTabs
        }, {
            label1 = "Scribing",
            label2 = "DifficultyModifier",
            type = "slider",
            setting = "CraftingCheckBonus",
            min = -10,
            max = 10,
            condition = isProficient and GetSetting(tabOwner, "CraftingArcanaCheck")
        }}
    }}

    local contentGroup = treeParent:AddGroup("Content")
    if SettingTabs and SettingTabs[tabOwner] then
        SettingTabs[tabOwner].Content = contentGroup
    end

    local contentTable = contentGroup:AddTable("GeneralTable", 1)
    contentTable.SizingStretchProp = true
    contentTable:SetStyle("CellPadding", 0)

    for _, section in ipairs(settingsConfig) do
        if section.condition == nil or section.condition == true then
            MakeTitle(contentTable:AddRow():AddCell(), section.title)

            local nameRow
            local settingsRow
            local maxColumns = 4
            local filteredItems = {}

            -- Gather all items that should be displayed ahead of time to get their count
            for _, element in ipairs(section.items) do
                if element.condition == nil or element.condition == true then
                    table.insert(filteredItems, element)
                end
            end

            if #filteredItems > 0 then
                local itemsNum = #filteredItems
                local numRows = math.ceil(itemsNum / maxColumns)

                -- Try to make the rows as even as possible by element count per row
                local elementsPerRow = math.floor(itemsNum / numRows)
                local extraElements = itemsNum % numRows
                local currentIndex = 1

                for row = 1, numRows do
                    local columnNum = elementsPerRow

                    if row <= extraElements then
                        columnNum = columnNum + 1
                    end

                    nameRow, settingsRow = MakeSettingsRow(contentTable, columnNum)

                    for col = 1, columnNum do
                        if currentIndex <= itemsNum then
                            local element = filteredItems[currentIndex]
                            local elementRef

                            MakeTextCentered(nameRow, element.label1, element.label2)

                            if element.type == "checkbox" then
                                elementRef = MakeCheckbox(settingsRow, tabOwner, element.setting, element.trueKey, element.falseKey)
                            elseif element.type == "slider" then
                                local popup, popupFunc = MakePopupButton(settingsRow, element.setting, GetSetting(tabOwner, element.setting), 100, element.buttonType)
                                MakeSlider(popup, tabOwner, element.setting, element.min, element.max, element.setting, element.label1, element.label2, popupFunc)
                            elseif element.type == "levelTable" then
                                local popupContent = MakePopupButton(settingsRow, element.setting, element.text, 200, element.buttonType)
                                MakeSpellLevelSetting(popupContent, tabOwner, tabName, element.setting, element.label1, element.label2, element.minimum)
                            elseif element.type == "combo" then
                                elementRef = MakeCombo(settingsRow, tabOwner, element.setting, element.options)
                            end

                            if elementRef and element.additionalLogic then
                                local originalOnChange = elementRef.OnChange
                                elementRef.OnChange = function(c)
                                    if originalOnChange then
                                        originalOnChange(c)
                                    end

                                    element.additionalLogic()
                                end
                            end

                            currentIndex = currentIndex + 1
                        end
                    end
                end
            end
        end
    end
end

--- Create top bar of the settings tab
---@param treeParent ExtuiTreeParent
---@param tabOwner string
---@param tabName string
---@param characterData? table
local function CreateSettingsTopBar(treeParent, tabOwner, tabName, characterData)
    -- HEADER TABLE --
    local headerTable = treeParent:AddTable("Header", 2)
    headerTable.SizingStretchSame = true
    headerTable:SetStyle("CellPadding", 0)
    local controlRow = headerTable:AddRow()

    local resetButton = MakeConfirmationButton(controlRow:AddCell(), GetString("Reset5e"), 300, 80)
    resetButton(function()
        Ext.Net.PostMessageToServer("TrueScrolls_RequestResetCharacter", tabOwner)

        ModConfig[tabOwner] = ConfigDefaults
        ModConfig[tabOwner].OverrideGlobals = true

        SaveConfig()
        SetTimer(10, RefreshTabs)

        if tabOwner == "Global" then
            UpdateScrollSpells()
        end
    end)

    -- HEADER CONTROLS --
    if tabOwner ~= "Global" then
        local overrideTable = controlRow:AddCell():AddTable("OverrideTable", 2)
        overrideTable.SizingStretchProp = true
        overrideTable.PadOuterX = false
        overrideTable.NoPadInnerX = true
        overrideTable.NoPadOuterX = true
        overrideTable.BordersInnerV = true
        overrideTable:SetStyle("CellPadding", 0)

        local overrideRow = overrideTable:AddRow()

        local overrideTextTable = overrideRow:AddCell():AddTable("BonusText", 1)
        overrideTextTable.SizingStretchProp = true
        overrideTextTable.PadOuterX = false
        overrideTextTable.NoPadInnerX = true
        overrideTextTable.NoPadOuterX = true
        overrideTextTable:SetStyle("CellPadding", 8)

        local overrideTextRowTop = overrideTextTable:AddRow()
        overrideTextRowTop:AddSeparator()
        overrideTextRowTop.Headers = true
        overrideTextRowTop:SetColor("TableHeaderBg", ToVec4(69, 49, 33, 0.8))

        local overrideTextRow = overrideTextTable:AddRow()
        overrideTextRow.Headers = true
        overrideTextRow:SetColor("TableHeaderBg", ToVec4(69, 49, 33, 0.8))

        MakeTextCentered(overrideTextRow, "Override")

        local overrideTextRowBottom = overrideTextTable:AddRow()
        overrideTextRowBottom:AddSeparator()
        overrideTextRowBottom.Headers = true
        overrideTextRowBottom:SetColor("TableHeaderBg", ToVec4(69, 49, 33, 0.8))

        local overrideCheckboxTable = overrideRow:AddCell():AddTable("BonusSlider", 1)
        overrideCheckboxTable.SizingStretchProp = true
        overrideCheckboxTable:SetStyle("CellPadding", 10)

        local overrideCheckboxRow = overrideCheckboxTable:AddRow()
        overrideCheckboxRow:SetColor("TableHeaderBg", ToVec4(236, 202, 142, 0.3))
        overrideCheckboxRow.Headers = true

        local overrideTrue = tabName .. " " .. GetString("OverrideTrue")
        local overrideFalse = tabName .. " " .. GetString("OverrideFalse")
        local overrideCheckbox = MakeCheckbox(overrideCheckboxRow, tabOwner, "OverrideGlobals", overrideTrue, overrideFalse)
        local onChange = overrideCheckbox.OnChange
        overrideCheckbox.OnChange = function(c)
            if onChange then
                onChange(c)
            end

            RefreshTabs()
        end

        if overrideCheckbox.Checked == true then
            PopulateSettingsTab(treeParent, tabOwner, tabName, characterData)
        end
    end
end

--- Create a tab bar for settings tabs
---@param treeParent ExtuiTreeParent
local function SettingsTab(treeParent)
    local tabOwner = "Global"
    local tabName = GetString("Global")

    if SettingTabs[tabOwner] == nil then
        LoadConfig()

        if ModConfig[tabOwner] == nil or ModConfig[tabOwner].MajorVersion == nil or ModConfig[tabOwner].MajorVersion < ConfigDefaults.MajorVersion then
            ModConfig[tabOwner] = ConfigDefaults
            SaveConfig()
        end

        local mainTabBar = treeParent:AddTabBar("MainTabBar")
        local globalTab = mainTabBar:AddTabItem(tabName)

        SettingTabs[tabOwner] = {}
        SettingTabs[tabOwner].Tab = globalTab

        SettingTabs.MainTab = mainTabBar

        CreateSettingsTopBar(globalTab, tabOwner, tabName)
        PopulateSettingsTab(globalTab, tabOwner, tabName)
    elseif SettingTabs.Global ~= nil then
        RecreateTab("Settings", tabOwner, tabName)
    end
end

--- Populate a character's scribing tab
---@param treeParent ExtuiTreeParent
---@param tabOwner string
---@param tabName string
---@param spellList? table
local function PopulateScribingList(treeParent, tabOwner, tabName, spellList)
    local contentGroup = treeParent:AddGroup("Content")
    contentGroup:SetStyle("SeparatorTextAlign", 0.5)

    if ScribingTabs and ScribingTabs[tabOwner] then
        ScribingTabs[tabOwner].Content = contentGroup
    end

    if spellList == nil and CachedSpells[tabOwner] ~= nil then
        spellList = CachedSpells[tabOwner]
    end

    if spellList == nil then
        return
    end

    local canScribe = true

    if ActiveScribing and ActiveScribing[tabOwner] then
        canScribe = false
        MakeScribeProgressTable(contentGroup, tabOwner, false)
    end

    -- CONTENT TABLE --
    local contentTable = contentGroup:AddTable("ContentTable", 1)
    contentTable.SizingStretchProp = true
    contentTable.NoHostExtendX = true

    -- SCRIBE TABLE --
    local scribeTable = contentTable:AddRow():AddCell():AddTable("ScribeTable", 6)
    scribeTable.BordersInnerH = true
    scribeTable.ScrollY = true
    scribeTable.SizingStretchProp = true
    scribeTable.NoHostExtendX = true
    scribeTable:SetStyle("CellPadding", 10)
    scribeTable.ColumnDefs[1] = {
        Width = 60 * Scale(),
        WidthFixed = true
    }

    local headerRow = scribeTable:AddRow()
    headerRow.Headers = true

    headerRow:AddCell()
    headerRow:AddCell():AddText(GetString("Spell"))
    headerRow:AddCell():AddText(GetString("Level"))
    headerRow:AddCell():AddText(GetString("Time"))
    headerRow:AddCell():AddText(GetString("Cost"))

    local unpreparedSpells = {}

    for _, v in ipairs(spellList.SpellBook) do
        table.insert(unpreparedSpells, v)
    end

    for _, spellId in ipairs(spellList.SpellBook) do
        if spellList.PreparedSpells[spellId] then
            MakeScribeRow(scribeTable, tabOwner, spellId, canScribe)

            for j, unprepSpellId in ipairs(unpreparedSpells) do
                if unprepSpellId == spellId then
                    table.remove(unpreparedSpells, j)
                    break
                end
            end
        end
    end

    if #unpreparedSpells > 0 then
        local unpreparedHeader = scribeTable:AddRow()
        unpreparedHeader.Headers = true
        unpreparedHeader:AddCell()
        unpreparedHeader:AddCell():AddText(GetString("NotPrepared"))

        for _, spellId in ipairs(unpreparedSpells) do
            MakeScribeRow(scribeTable, tabOwner, spellId, false)
        end
    end
end

--- Create a tab bar for scribing tabs
---@param treeParent ExtuiTreeParent
local function ScribingTab(treeParent)
    if ScribingTabs.MainTab == nil then
        local arcanaTable = treeParent:AddTable("Arcana", 1)

        MakeTitle(arcanaTable:AddRow():AddCell(), "NoCharactersArcana")
        local mainTabBar = treeParent:AddTabBar("MainTabBar")

        ScribingTabs.Arcana = arcanaTable
        ScribingTabs.MainTab = mainTabBar
    end
end

--- Create a window for setting a keybind
local function KeybindSettingWindow()
    if ScribeWindow.KeybindWindow ~= nil then
        ScribeWindow.KeybindWindow.Open = true
        ScribeWindow.KeybindActive = true
        ScribeWindow.KeybindText:Destroy()
        ScribeWindow.KeybindText = nil
        ScribeWindow.KeybindText = ScribeWindow.KeybindTextCell:AddSeparatorText(GetString("WaitingForInput"))
        return
    end

    local windowSize = {800 * Scale(), 350 * Scale()}
    local keybindWindow = Ext.IMGUI.NewWindow(GetString("ToggleScribingPanel"))
    keybindWindow.AlwaysAutoResize = true
    keybindWindow.Closeable = true
    keybindWindow.NoCollapse = true
    keybindWindow.NoMove = true
    keybindWindow:SetStyle("WindowMinSize", windowSize[1], 1)
    keybindWindow:SetStyle("WindowTitleAlign", 1)
    keybindWindow:SetStyle("WindowPadding", 0)
    keybindWindow:SetStyle("WindowBorderSize", 0)
    keybindWindow:SetStyle("SeparatorTextAlign", 0.5)
    keybindWindow:SetStyle("WindowTitleAlign", 0.5)
    keybindWindow:SetColor("TitleBgActive", {0, 0, 0, 0.9})
    keybindWindow:SetColor("TitleBg", {0, 0, 0, 0.9})
    keybindWindow:SetColor("TitleBgCollapsed", {0, 0, 0, 0.9})
    keybindWindow:SetColor("WindowBg", {0, 0, 0, 0.9})
    keybindWindow.OnClose = function()
        ScribeWindow.KeybindActive = false
    end

    -- KeybindActive == true prevents keys from being processed by the game
    ScribeWindow.KeybindActive = true
    ScribeWindow.KeybindWindow = keybindWindow

    -- Center window on screen
    local screenCenter = {Ext.IMGUI.GetViewportSize()[1] / 2, Ext.IMGUI.GetViewportSize()[2] / 2}
    keybindWindow:SetPos({screenCenter[1] - windowSize[1] / 2, screenCenter[2] - windowSize[2] / 2})

    local keybindTable = keybindWindow:AddTable("keybindTable", 1)
    keybindTable.SizingStretchProp = true
    keybindTable:SetStyle("SeparatorTextBorderSize", 0)
    keybindTable:SetStyle("SeparatorTextPadding", 0)
    keybindTable:SetStyle("CellPadding", 0)

    MakeTitle(keybindTable:AddRow():AddCell(), "PressKeyModifier")

    keybindTable:AddRow():AddCell():AddText(" ")

    local textCell = keybindTable:AddRow():AddCell()
    local keybindText = textCell:AddSeparatorText(GetString("WaitingForInput"))

    ScribeWindow.KeybindText = keybindText
    ScribeWindow.KeybindTextCell = textCell

    keybindTable:AddRow():AddCell():AddText(" ")

    local confirmButton, cancelButton = MakeTwoButtons(keybindTable:AddRow():AddCell(), windowSize[1], 80, "Confirm", "Cancel")

    confirmButton.OnClick = function()
        if TempKeybind ~= nil then
            UIConfig.Keybind = TempKeybind

            if TempModifiers ~= nil then
                UIConfig.Modifiers = TempModifiers
            end

            TempKeybind = nil
            TempModifiers = nil

            SaveUIConfig()

            ScribeWindow.KeybindButton.Shortcut = GetDisplayUISetting("Keybind")
        end

        ScribeWindow.KeybindActive = false
        ScribeWindow.KeybindWindow.Open = false
    end

    cancelButton.OnClick = function()
        ScribeWindow.KeybindActive = false
        ScribeWindow.KeybindWindow.Open = false
    end
end

--- Close scribing notification window
---@param fromAutohide? any
function CloseScribeWindow(fromAutohide)
    if ScribeWindow.Window ~= nil and ScribeWindow.Content ~= nil and (not fromAutohide or UIConfig.AutoHide) then
        ScribeWindow.Content:Destroy()
        ScribeWindow.Content = nil
        ScribeWindow.Window.Open = false
    end
end

--- Show or update scribing notification window
function ShowScribeWindow()
    if ActiveScribing == nil then
        return
    end

    if next(ActiveScribing) == nil then
        SetTimer(100, CloseScribeWindow)
        return
    end

    if ScribeWindow.Window == nil then
        local scribingWindow = Ext.IMGUI.NewWindow(GetString("ActiveScribingPanel"))
        scribingWindow.AlwaysAutoResize = true
        scribingWindow.Closeable = true
        scribingWindow.NoBackground = true
        scribingWindow.NoCollapse = true
        scribingWindow:SetStyle("WindowPadding", 0)
        scribingWindow:SetStyle("WindowBorderSize", 0)
        scribingWindow:SetStyle("SeparatorTextAlign", 0.5)
        scribingWindow:SetStyle("WindowTitleAlign", 0.5)
        scribingWindow:SetColor("TitleBgActive", {0, 0, 0, 0.75})
        scribingWindow:SetColor("TitleBg", {0, 0, 0, 0.75})
        scribingWindow:SetColor("TitleBgCollapsed", {0, 0, 0, 0.75})
        scribingWindow:SetColor("MenuBarBg", {0, 0, 0, 0.6})
        scribingWindow:SetColor("Border", {0, 0, 0, 0.75})
        scribingWindow:SetPos({0, 0})

        local mainMenu = scribingWindow:AddMainMenu()
        local scribingMenu = mainMenu:AddMenu(GetString("Settings"))

        local notificationsButton = scribingMenu:AddItem(GetString("ShowNotifications"))
        notificationsButton.Shortcut = GetDisplayUISetting("ShowNotifications")
        notificationsButton:Tooltip():AddText(GetString("ShowNotificationsTooltip"))
        notificationsButton.OnClick = function()
            UIConfig.ShowNotifications = not UIConfig.ShowNotifications
            SaveUIConfig()

            ScribeWindow.NotificationsButton.Shortcut = GetDisplayUISetting("ShowNotifications")
        end

        local keybindButton = scribingMenu:AddItem(GetString("SetKeybind"))
        keybindButton.Shortcut = GetDisplayUISetting("Keybind")
        keybindButton:Tooltip():AddText(GetString("SetKeyBindTooltip"))
        keybindButton.OnClick = function()
            KeybindSettingWindow()
        end

        local autohideButton = scribingMenu:AddItem(GetString("AutoHide"))
        autohideButton.Shortcut = GetDisplayUISetting("AutoHide")
        autohideButton:Tooltip():AddText(GetString("AutoHideTooltip"))
        autohideButton.OnClick = function()
            UIConfig.AutoHide = not UIConfig.AutoHide
            SaveUIConfig()

            ScribeWindow.AutoHideButton.Shortcut = GetDisplayUISetting("AutoHide")
        end

        local hideDelayButton = scribingMenu:AddItem(GetString("AutoHideDelay"))
        hideDelayButton.Shortcut = GetDisplayUISetting("AutoHideDelay") .. "s"
        hideDelayButton:Tooltip():AddText(GetString("AutoHideDelayTooltip"))

        local hideDelaySlider = scribingMenu:AddSliderInt("", GetDisplayUISetting("AutoHideDelay"), 5, 30)
        hideDelaySlider.AlwaysClamp = true
        hideDelaySlider.NoInput = true
        hideDelaySlider:Tooltip():AddText(GetString("AutoHideDelayTooltip"))
        hideDelaySlider.OnChange = function(s)
            UIConfig.AutoHideDelay = s.Value[1]
            SaveUIConfig()

            ScribeWindow.HideDelayButton.Shortcut = GetDisplayUISetting("AutoHideDelay") .. "s"
        end

        local resetPosButton = scribingMenu:AddItem(GetString("ResetPosition"))
        resetPosButton:Tooltip():AddText(GetString("ResetPositionTooltip"))
        resetPosButton.OnClick = function()
            scribingWindow:SetPos({0, 0})
        end

        ScribeWindow.Window = scribingWindow
        ScribeWindow.KeybindButton = keybindButton
        ScribeWindow.AutoHideButton = autohideButton
        ScribeWindow.HideDelayButton = hideDelayButton
        ScribeWindow.NotificationsButton = notificationsButton
    end

    ScribeWindow.Window.Open = true
    ScribeWindow.KeybindButton.Shortcut = GetDisplayUISetting("Keybind")
    ScribeWindow.AutoHideButton.Shortcut = GetDisplayUISetting("AutoHide")
    ScribeWindow.NotificationsButton.Shortcut = GetDisplayUISetting("ShowNotifications")

    if ScribeWindow.Content ~= nil then
        ScribeWindow.Content:Destroy()
        ScribeWindow.Content = nil
    end

    local scribingTable = ScribeWindow.Window:AddTable("ScribingTable", 3)
    scribingTable:SetStyle("CellPadding", 0)

    ScribeWindow.Content = scribingTable

    local rowRef
    local columnNum = 0
    local maxLines = 0
    local cachedProgressText = {}

    for characterGuid, _ in pairs(ActiveScribing) do
        local progressInfoText = GetProgressInfoText(characterGuid)
        maxLines = math.max(maxLines, GetWrappedLinesCount(progressInfoText, 47))
        cachedProgressText[characterGuid] = progressInfoText
    end

    for characterGuid, _ in pairs(ActiveScribing) do
        if columnNum == 0 then
            rowRef = scribingTable:AddRow()
        end

        local paddedText = PadWrappedText(cachedProgressText[characterGuid], 47, maxLines, true)

        MakeScribeProgressTable(rowRef:AddCell(), characterGuid, true, paddedText)

        columnNum = (columnNum + 1) % 3
    end

    if UIConfig.AutoHide then
        SetTimer(UIConfig.AutoHideDelay * 1000, CloseScribeWindow)
    end
end

--- Recreate a tab in MCM
---@alias TabType "Settings" | "Scribing"
---@param tabType TabType
---@param tabOwner string
---@param tabName string
---@param characterData? table
function RecreateTab(tabType, tabOwner, tabName, characterData)
    if tabName == nil then
        tabName = GetDisplayName(tabOwner)
    end

    if tabType == "Settings" and SettingTabs and SettingTabs[tabOwner] and SettingTabs[tabOwner].Content ~= nil then
        SettingTabs[tabOwner].Content:Destroy()
        SettingTabs[tabOwner].Content = nil

        PopulateSettingsTab(SettingTabs[tabOwner].Tab, tabOwner, tabName, characterData)
    elseif ScribingTabs and ScribingTabs[tabOwner] and ScribingTabs[tabOwner].Content ~= nil then
        ScribingTabs[tabOwner].Content:Destroy()
        ScribingTabs[tabOwner].Content = nil

        PopulateScribingList(ScribingTabs[tabOwner].Tab, tabOwner, tabName)
    end
end

--- Refresh all tabs in MCM
---@param partyMembers? table<string,table>
function RefreshTabs(partyMembers)
    if partyMembers == nil and CachedPartyMembers ~= nil then
        partyMembers = CachedPartyMembers
    end

    if partyMembers == nil then
        return
    end

    CachedPartyMembers = partyMembers
    LoadConfig()
    ActiveScribing = Ext.Vars.GetModVariables(ModuleUUID).ActiveScribing

    for tabOwner, _ in pairs(SettingTabs) do
        if tabOwner ~= "Global" and tabOwner ~= "MainTab" then
            if SettingTabs and SettingTabs[tabOwner] ~= nil and SettingTabs[tabOwner].Tab ~= nil then
                SettingTabs[tabOwner].Tab:Destroy()
                SettingTabs[tabOwner] = nil
            end
        end
    end

    for tabOwner, _ in pairs(ScribingTabs) do
        if tabOwner ~= "Arcana" and tabOwner ~= "MainTab" then
            if ScribingTabs and ScribingTabs[tabOwner] ~= nil and ScribingTabs[tabOwner].Tab ~= nil then
                ScribingTabs[tabOwner].Tab:Destroy()
                ScribingTabs[tabOwner] = nil
            end
        end
    end

    for characterGuid, data in pairs(partyMembers) do
        local characterName = GetDisplayName(characterGuid)

        if characterName then
            if SettingTabs and SettingTabs[characterGuid] == nil then
                local config = ModConfig[characterGuid]

                if config == nil or config.MajorVersion == nil or config.MajorVersion < ConfigDefaults.MajorVersion then
                    ModConfig[characterGuid] = ConfigDefaults
                    SaveConfig()
                    Log("Major version below latest. Resetting %s settings to default", characterName)
                end

                if SettingTabs.MainTab ~= nil then
                    local newSettingsTab = SettingTabs.MainTab:AddTabItem(characterName)

                    if SettingTabs[characterGuid] == nil then
                        SettingTabs[characterGuid] = {}
                        SettingTabs[characterGuid].Tab = newSettingsTab

                        CreateSettingsTopBar(newSettingsTab, characterGuid, characterName, data)
                    end
                end
            end

            if ScribingTabs and ScribingTabs[characterGuid] == nil and (data.Proficient == true or GetSetting(characterGuid, "CraftingArcanaProficiency") == false) then
                if ScribingTabs.MainTab ~= nil then
                    local newScribingTab = ScribingTabs.MainTab:AddTabItem(characterName)
                    ScribingTabs[characterGuid] = {}
                    ScribingTabs[characterGuid].Tab = newScribingTab
                    ScribingTabs.Arcana.Visible = false
                    CachedSpells[characterGuid] = data.Spells

                    PopulateScribingList(newScribingTab, characterGuid, characterName, data.Spells)
                end
            end
        end
    end

    if SettingTabs.Global ~= nil then
        RecreateTab("Settings", "Global", GetString("Global"))
    end

    -- Update scribe window state if it's open
    if ScribeWindow.Content ~= nil then
        ShowScribeWindow()
    end
end

if Ext.Mod.IsModLoaded("755a8a72-407f-4f0d-9a33-274ac0f0b53d") == true then
    if SettingTabs == nil then
        SettingTabs = {}
    end

    if ScribingTabs == nil then
        ScribingTabs = {}
    end

    if CachedSpells == nil then
        CachedSpells = {}
    end

    if ScribeWindow == nil then
        ScribeWindow = {}
    end

    if CachedScribingStates == nil then
        CachedScribingStates = {}
    end

    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, Ext.Loca.GetTranslatedString("h4d9d208921994637aaf1ddf7d2de9cfc4c5d"), ScribingTab)
    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, Ext.Loca.GetTranslatedString("h19961661dcc740d79ea007b9313a936738a3"), SettingsTab)
    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, Ext.Loca.GetTranslatedString("hcda64c5b293e4596986e7d0008da5e2516ac"), ReferenceTab)
end
