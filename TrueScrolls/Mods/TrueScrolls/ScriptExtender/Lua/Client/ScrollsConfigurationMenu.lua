local function ReferenceTab(treeParent)

    local refTable = treeParent:AddTable("RefTable", 1)
    refTable.ColumnDefs[1] = {
        Width = 1190,
        WidthFixed = true
    }

    local mainCell = refTable:AddRow():AddCell()

    MakeTableTitle(mainCell, GetString("SpellScrolls"))

    mainCell:AddText(WrapText("RefMainText", 95))
    mainCell:AddNewLine()

    local scrollTable = mainCell:AddTable("scrollTable", 4)
    scrollTable.Size = {1190, 500}
    scrollTable.RowBg = true
    scrollTable.BordersInnerV = true
    scrollTable.PadOuterX = true

    local scrollHeader = scrollTable:AddRow()
    scrollHeader.Headers = true

    scrollHeader:AddCell():AddText(GetString("SpellLevel"))
    scrollHeader:AddCell():AddText(GetString("Rarity"))
    scrollHeader:AddCell():AddText(GetString("SaveDC"))
    scrollHeader:AddCell():AddText(GetString("AttackBonus"))

    AddRefTableRow(scrollTable, GetString("Cantrip"), "Common", "13", "+5")
    AddRefTableRow(scrollTable, "1st", "Common", "13", "+5")
    AddRefTableRow(scrollTable, "2nd", "Uncommon", "13", "+5")
    AddRefTableRow(scrollTable, "3rd", "Uncommon", "15", "+7")
    AddRefTableRow(scrollTable, "4th", "Rare", "15", "+7")
    AddRefTableRow(scrollTable, "5th", "Rare", "17", "+9")
    AddRefTableRow(scrollTable, "6th", "VeryRare", "17", "+9")
    AddRefTableRow(scrollTable, "7th", "VeryRare", "18", "+10")
    AddRefTableRow(scrollTable, "8th", "VeryRare", "18", "+10")
    AddRefTableRow(scrollTable, "9th", "Legendary", "19", "+11")

    MakeTableTitle(mainCell, GetString("CopyingAScroll"))

    mainCell:AddText(WrapText("RefCopyText", 95))
end

local function PopulateGenericTab(treeParent, tabOwner, tabName)
    -- CONTENT GROUP -- 
    local contentGroup = treeParent:AddGroup("Content")

    if ModTabs and ModTabs[tabOwner] then
        ModTabs[tabOwner].Content = contentGroup
    end

    -- CONTENT TABLE --
    local contentTable = contentGroup:AddTable("GeneralTable", 1)
    contentTable.ColumnDefs[1] = {
        Width = 1190,
        WidthFixed = true
    }
    contentTable:SetStyle("CellPadding", 0)

    -- FIRST TABLE--
    local firstTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    firstTable.BordersInnerV = true
    firstTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }

    local firstRow = firstTable:AddRow()

    -- LEFT FIRST TABLE --
    local leftFirstTable = firstRow:AddCell():AddTable("LeftTopTable", 3)
    leftFirstTable.BordersInnerV = true
    leftFirstTable.RowBg = true
    leftFirstTable:SetStyle("CellPadding", 10)
    leftFirstTable.Size = {714, 150}

    local nameRow1 = leftFirstTable:AddRow()
    nameRow1.Headers = true

    AlignCellTitle(nameRow1, "Revivify", "Override")
    AlignCellTitle(nameRow1, "Class", "CastingAbility")
    AlignCellTitle(nameRow1, "Casting", "AbilityCheck")

    local checkboxRow1 = leftFirstTable:AddRow()
    local rightfirstTable = firstRow:AddCell():AddTable("Table", 1)

    MakeCheckbox(checkboxRow1, tabOwner, "RevivifyScrollOverride", "RevivifyTrue", "RevivifyFalse")
    MakeCheckbox(checkboxRow1, tabOwner, "ClassCasting", "ClassCastingTrue", "ClassCastingFalse")
    local castRollCheckbox = MakeCheckbox(checkboxRow1, tabOwner, "CastRoll", "CastingRollTrue", "CastingRollFalse")
    local castRollOnChange = castRollCheckbox.OnChange
    castRollCheckbox.OnChange = function(c)
        if castRollOnChange then
            castRollOnChange(c)
        end

        if c.Checked == true then
            rightfirstTable.Visible = true
        else
            rightfirstTable.Visible = false
        end
    end

    if castRollCheckbox.Checked == false then
        rightfirstTable.Visible = false
    end

    -- RIGHT FIRST TABLE --
    MakeSlider(rightfirstTable, tabOwner, "CastRollBonus", -10, 10, "Casting", "DifficultyModifier", "CastRollBonus")

    -- SECOND TABLE TABLE--
    local secondTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    secondTable.BordersInnerV = true
    secondTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }
    local secondRow = secondTable:AddRow()

    -- LEFT SECOND TABLE -- 
    local leftSecondTable = secondRow:AddCell():AddTable("LeftMidTable", 3)
    leftSecondTable.BordersInnerV = true
    leftSecondTable.RowBg = true
    leftSecondTable:SetStyle("CellPadding", 10)
    leftSecondTable.Size = {714, 150}

    local nameRow2 = leftSecondTable:AddRow()
    nameRow2.Headers = true
    AlignCellTitle(nameRow2, "Thief", "CanUseScrolls")
    AlignCellTitle(nameRow2, "SpellList", "Restrictions")
    AlignCellTitle(nameRow2, "Copying", "AbilityCheck")

    local rightSecondTable = secondRow:AddCell():AddTable("Table", 1)

    local checkboxRow2 = leftSecondTable:AddRow()
    MakeCheckbox(checkboxRow2, tabOwner, "ThiefCanCast", "ThiefCanCastTrue", "ThiefCanCastFalse")
    MakeCheckbox(checkboxRow2, tabOwner, "ClassRestriction", "ClassRestrictionTrue", "ClassRestrictionFalse")
    local copyRollCheckbox = MakeCheckbox(checkboxRow2, tabOwner, "ScribeRoll", "CopyingRollTrue", "CopyingRollFalse")
    local copyRollOnChange = copyRollCheckbox.OnChange
    copyRollCheckbox.OnChange = function(c)
        if copyRollOnChange then
            copyRollOnChange(c)
        end

        if c.Checked == true then
            rightSecondTable.Visible = true
        else
            rightSecondTable.Visible = false
        end
    end

    if copyRollCheckbox.Checked == false then
        rightSecondTable.Visible = false
    end

    MakeSlider(rightSecondTable, tabOwner, "CopyRollBonus", -10, 10, "Copying", "DifficultyModifier", "CopyingRollBonus")

    -- THIRD TABLE--
    local thirdTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    thirdTable.BordersInnerV = true
    thirdTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }
    local thirdRow = thirdTable:AddRow()

    -- LEFT THIRD TABLE -- 
    local leftThirdTable = thirdRow:AddCell():AddTable("LeftMidTable", 3)
    leftThirdTable.BordersInnerV = true
    leftThirdTable.RowBg = true
    leftThirdTable:SetStyle("CellPadding", 10)
    leftThirdTable.Size = {714, 150}

    local nameRow3 = leftThirdTable:AddRow()
    nameRow3.Headers = true

    AlignCellTitle(nameRow3, "Artificer", "AbilityCheck")
    AlignCellTitle(nameRow3, "StaticSpell", "SaveDC")
    AlignCellTitle(nameRow3, "Static", "AttackBonus")

    local rightThirdTable = thirdRow:AddCell():AddTable("Table", 1)

    local checkboxRow3 = leftThirdTable:AddRow()

    MakeCheckbox(checkboxRow3, tabOwner, "ArtificerRequireRoll", "ArtificerRollTrue", "ArtificerRollFalse")
    local spellSaveCheckbox = MakeCheckbox(checkboxRow3, tabOwner, "StaticSpellSaveDC", "StaticSaveDCTrue", "StaticSaveDCFalse")
    local spellSaveOnChange = spellSaveCheckbox.OnChange
    spellSaveCheckbox.OnChange = function(c)
        if spellSaveOnChange then
            spellSaveOnChange(c)
        end

        if tabOwner == "Global" then
            UpdateScrollSpells()
        end
    end

    if tabOwner ~= "Global" then
        spellSaveCheckbox.Disabled = true
        spellSaveCheckbox.Checked = GetSetting("Global", "StaticSpellSaveDC")
        spellSaveCheckbox:Tooltip():AddText(GetString("OnlyInGlobal"))
    end

    local attackRollCheckbox = MakeCheckbox(checkboxRow3, tabOwner, "StaticAttackRoll", "StaticAttackRollTrue", "StaticAttackRollFalse")
    local attackRollOnChange = attackRollCheckbox.OnChange
    attackRollCheckbox.OnChange = function(c)
        if attackRollOnChange then
            attackRollOnChange(c)
        end

        if attackRollCheckbox.Checked then
            rightThirdTable.Visible = true
        else
            rightThirdTable.Visible = false
        end
    end

    if attackRollCheckbox.Checked == false then
        rightThirdTable.Visible = false
    end

    MakeSlider(rightThirdTable, tabOwner, "StaticAttackRollBonus", -10, 10, "Additional", "AttackBonus", "AttackRollBonus")

    -- FOURTH TABLE--
    local fourthTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    fourthTable.BordersInnerV = true
    fourthTable.ColumnDefs[1] = {
        Width = 238,
        WidthFixed = true
    }

    local fourthRow = fourthTable:AddRow()

    -- LEFT FOURTH TABLE --
    local leftFourthTable = fourthRow:AddCell():AddTable("LeftFourthTable", 1)
    leftFourthTable.BordersInnerV = true
    leftFourthTable.RowBg = true
    leftFourthTable:SetStyle("CellPadding", 10)
    leftFourthTable.Size = {238, 150}

    local nameRow4 = leftFourthTable:AddRow()
    nameRow4.Headers = true

    AlignCellTitle(nameRow4, "Require", "WizardLevels")

    local checkboxRow4 = leftFourthTable:AddRow()

    MakeCheckbox(checkboxRow4, tabOwner, "RequireWizardLevels", "WizardLevelsTrue", "WizardLevelsFalse")
end

local function CreateTopBar(treeParent, tabOwner, tabName)
    -- HEADER TABLE --
    local headerTable = treeParent:AddTable("Header", 1)
    headerTable.ColumnDefs[1] = {
        Width = 1190,
        WidthFixed = true
    }
    headerTable:SetStyle("CellPadding", 0)
    MakeTableTitle(headerTable:AddRow():AddCell(), tabName)

    local controlTable = headerTable:AddRow():AddCell():AddTable("Control", 3)
    controlTable.Size = {1190, 100}
    controlTable.ColumnDefs[1] = {
        Width = 980,
        WidthFixed = true
    }
    controlTable.ColumnDefs[2] = {
        WidthStretch = true
    }
    controlTable.ColumnDefs[3] = {
        Width = 10,
        WidthFixed = true
    }

    local controlRow = controlTable:AddRow()
    local overrideCell = controlRow:AddCell()

    -- HEADER CONTROLS --
    if tabOwner ~= "Global" then
        local overrideTable = overrideCell:AddTable("OverrideTable", 2)
        overrideTable.ColumnDefs[1] = {
            Width = 234,
            WidthFixed = true
        }
        overrideTable.ColumnDefs[2] = {
            Width = 244,
            WidthFixed = true
        }
        overrideTable.PadOuterX = false
        overrideTable.NoPadInnerX = true
        overrideTable.NoPadOuterX = true
        overrideTable.BordersInnerV = true
        overrideTable:SetStyle("CellPadding", 0)

        local overrideRow = overrideTable:AddRow()

        local overrideTextTable = overrideRow:AddCell():AddTable("BonusText", 1)
        overrideTextTable.PadOuterX = false
        overrideTextTable.NoPadInnerX = true
        overrideTextTable.NoPadOuterX = true
        overrideTextTable:SetStyle("CellPadding", 8)

        local overrideTextRowTop = overrideTextTable:AddRow()
        overrideTextRowTop:AddSeparator()
        overrideTextRowTop.Headers = true

        local overrtideTextRow = overrideTextTable:AddRow()
        overrtideTextRow.Headers = true

        AlignCellTitle(overrtideTextRow, "Override")

        local overrideTextRowBottom = overrideTextTable:AddRow()
        overrideTextRowBottom:AddSeparator()
        overrideTextRowBottom.Headers = true

        local overrideCheckboxTable = overrideRow:AddCell():AddTable("BonusSlider", 1)
        overrideCheckboxTable.RowBg = true
        overrideCheckboxTable:SetStyle("CellPadding", 10)

        local overrideCheckboxRow = overrideCheckboxTable:AddRow()

        local overrideTrue = tabName .. " " .. GetString("OverrideTrue")
        local overrideFalse = tabName .. " " .. GetString("OverrideFalse")
        local overrideCheckbox = MakeCheckbox(overrideCheckboxRow, tabOwner, "OverrideGlobals")
        local overrideTooltip = overrideCheckbox:Tooltip():AddText(overrideCheckbox.Checked and overrideTrue or overrideFalse)
        local onChange = overrideCheckbox.OnChange
        overrideCheckbox.OnChange = function(c)
            if onChange then
                onChange(c)
            end

            if c.Checked then
                PopulateGenericTab(treeParent, tabOwner, tabName)
                overrideTooltip:Destroy()
                overrideTooltip = c:Tooltip():AddText(overrideTrue)
            elseif ModTabs[tabOwner].Content ~= nil then
                ModTabs[tabOwner].Content:Destroy()
                ModTabs[tabOwner].Content = nil
                overrideTooltip:Destroy()
                overrideTooltip = c:Tooltip():AddText(overrideFalse)
            end
        end

        if overrideCheckbox.Checked == true then
            PopulateGenericTab(treeParent, tabOwner, tabName)
        end
    end

    -- RESET BUTTON --
    local resetButton = controlRow:AddCell():AddButton(GetString("Reset5e"))
    resetButton:Tooltip():AddText("Reset " .. tabName .. " " .. GetString("Follow5e"))
    resetButton.Size = {200, 80}
    resetButton.OnClick = function()
        if tabOwner == "Global" then
            local spellSaveSetting = GetSetting(tabOwner, "StaticSpellSaveDC")
            local defaultSetting = ModConfig.Defaults.StaticSpellSaveDC

            if spellSaveSetting ~= defaultSetting then
                UpdateScrollSpells()
            end
        end

        Ext.Net.PostMessageToServer("RequestResetCharacter", Ext.Json.Stringify(tabOwner))

        ModConfig[tabOwner] = {}
        ModConfig[tabOwner].OverrideGlobals = true

        SaveConfig()
        RecreateTab(treeParent, tabOwner, tabName)
    end

    controlRow:AddCell()
end

local function CharacterTab(treeParent, tabOwner, tabName)
    if ModTabs[tabOwner] ~= nil then
        return
    end

    ModTabs[tabOwner] = {}
    ModTabs[tabOwner].Tab = treeParent

    CreateTopBar(treeParent, tabOwner, tabName)
end

local function MainTab(treeParent)
    local tabOwner = "Global"
    local tabName = GetString("Global")

    if ModTabs[tabOwner] == nil then
        LoadConfig()

        if ModConfig[tabOwner] == nil then
            ModConfig[tabOwner] = {}
        end

        local mainTabBar = treeParent:AddTabBar("MainTabBar")
        local globalTab = mainTabBar:AddTabItem(tabOwner)

        ModTabs[tabOwner] = {}
        ModTabs[tabOwner].Tab = globalTab

        ModTabs.MainTab = mainTabBar

        CreateTopBar(globalTab, tabOwner, tabName)
        PopulateGenericTab(globalTab, tabOwner, tabName)
    elseif ModTabs.Global ~= nil then
        RecreateTab(ModTabs.Global.Tab, tabOwner, tabName)
    end
end

function RecreateTab(treeParent, tabOwner, tabName)
    if ModTabs and ModTabs[tabOwner] and ModTabs[tabOwner].Content ~= nil then
        ModTabs[tabOwner].Content:Destroy()
        ModTabs[tabOwner].Content = nil

        PopulateGenericTab(treeParent, tabOwner, tabName)
    end
end

Ext.RegisterNetListener("UpdatePartyMembers", function(call, payload)
    local partyMembers = Ext.Json.Parse(payload)

    if partyMembers == nil then
        Log("Failed to get party members!")
        return
    end

    for tabOwner, _ in pairs(ModTabs) do
        if tabOwner ~= "Global" and tabOwner ~= "MainTab" then
            if ModTabs and ModTabs[tabOwner] ~= nil and ModTabs[tabOwner].Tab ~= nil then
                ModTabs[tabOwner].Tab:Destroy()
                ModTabs[tabOwner] = nil
            end
        end
    end

    for characterGuid, _ in pairs(partyMembers) do
        local characterName = GetDisplayName(characterGuid)

        if characterName then
            if ModTabs and ModTabs[characterGuid] == nil then
                LoadConfig()

                if ModConfig[characterGuid] == nil then
                    ModConfig[characterGuid] = {}
                end

                if ModTabs.MainTab ~= nil then
                    local newTab = ModTabs.MainTab:AddTabItem(characterName)
                    CharacterTab(newTab, characterGuid, characterName)
                end
            end
        end
    end

    if ModTabs.Global ~= nil then
        RecreateTab(ModTabs.Global.Tab, "Global", GetString("Global"))
    end
end)

Ext.Events.SessionLoaded:Subscribe(function()
    UpdateScrollSpells()
    Log("SESSION LOADED - CLIENT")
end)

Ext.Events.StatsLoaded:Subscribe(function()
    LoadBackupConfig()
    Log("STATS LOADED - CLIENT")
end)

if Ext.Mod.IsModLoaded("755a8a72-407f-4f0d-9a33-274ac0f0b53d") == true then
    if ModTabs == nil then
        ModTabs = {}
    end

    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "True Scrolls", MainTab)
    Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "5e Reference", ReferenceTab)
end


