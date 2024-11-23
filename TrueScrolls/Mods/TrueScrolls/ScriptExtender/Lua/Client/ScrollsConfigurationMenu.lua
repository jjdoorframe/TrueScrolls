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

    mainCell:AddText(WrapText("RefScribeText", 95))
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

    -- TOP TABLE--
    local topTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    topTable.BordersInnerV = true
    topTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }

    local topRow = topTable:AddRow()

    -- LEFT TOP TABLE --
    local leftTopTable = topRow:AddCell():AddTable("LeftTopTable", 3)
    leftTopTable.BordersInnerV = true
    leftTopTable.RowBg = true
    leftTopTable:SetStyle("CellPadding", 10)
    leftTopTable.Size = {714, 150}

    local nameRow1 = leftTopTable:AddRow()
    nameRow1.Headers = true

    AlignCellTitle(nameRow1, "Revivify", "Override")
    AlignCellTitle(nameRow1, "Class", "CastingAbility")
    AlignCellTitle(nameRow1, "Casting", "AbilityCheck")

    local checkboxRow1 = leftTopTable:AddRow()
    local rightTopTable

    MakeCheckbox(checkboxRow1, tabOwner, "RevivifyScrollOverride", "RevivifyTrue", "RevivifyFalse")
    MakeCheckbox(checkboxRow1, tabOwner, "ClassCasting", "ClassCastingTrue", "ClassCastingFalse")
    local castRollCheckbox = MakeCheckbox(checkboxRow1, tabOwner, "CastRoll", "CastingRollTrue", "CastingRollFalse")
    local castRollOnChange = castRollCheckbox.OnChange
    castRollCheckbox.OnChange = function(c)
        if castRollOnChange then
            castRollOnChange(c)
        end

        if c.Checked == true then
            rightTopTable.Visible = true
        else
            rightTopTable.Visible = false
        end
    end

    if castRollCheckbox.Checked == false then
        rightTopTable.Visible = false
    end

    -- RIGHT TOP TABLE --
    rightTopTable = topRow:AddCell():AddTable("Table", 1)
    MakeSlider(rightTopTable, tabOwner, "CastRollBonus", -10, 10, "Casting", "DifficultyModifier", "CastRollBonus")

    -- MIDDLE TABLE--
    local midTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    midTable.BordersInnerV = true
    midTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }
    local midRow = midTable:AddRow()

    -- LEFT MIDDLE TABLE -- 
    local leftMidTable = midRow:AddCell():AddTable("LeftMidTable", 3)
    leftMidTable.BordersInnerV = true
    leftMidTable.RowBg = true
    leftMidTable:SetStyle("CellPadding", 10)
    leftMidTable.Size = {714, 150}

    local nameRow2 = leftMidTable:AddRow()
    nameRow2.Headers = true
    AlignCellTitle(nameRow2, "Thief", "CanUseScrolls")
    AlignCellTitle(nameRow2, "SpellList", "Restrictions")
    AlignCellTitle(nameRow2, "Scribing", "AbilityCheck")

    local rightMidTable

    local checkboxRow2 = leftMidTable:AddRow()
    MakeCheckbox(checkboxRow2, tabOwner, "ThiefCanCast", "ThiefCanCastTrue", "ThiefCanCastFalse")
    MakeCheckbox(checkboxRow2, tabOwner, "ClassRestriction", "ClassRestrictionTrue", "ClassRestrictionFalse")
    local scribeRollCheckbox = MakeCheckbox(checkboxRow2, tabOwner, "ScribeRoll", "ScribingRollTrue", "ScribingRollFalse")
    local scribeRollOnChange = scribeRollCheckbox.OnChange
    scribeRollCheckbox.OnChange = function(c)
        if scribeRollOnChange then
            scribeRollOnChange(c)
        end

        if c.Checked == true then
            rightMidTable.Visible = true
        else
            rightMidTable.Visible = false
        end
    end

    if scribeRollCheckbox.Checked == false then
        rightMidTable.Visible = false
    end

    rightMidTable = midRow:AddCell():AddTable("Table", 1)
    MakeSlider(rightMidTable, tabOwner, "ScribeRollBonus", -10, 10, "Scribing", "DifficultyModifier", "ScribingRollBonus")

    -- BOTTOM TABLE--
    local bottomTable = contentTable:AddRow():AddCell():AddTable("TopTable", 2)
    bottomTable.BordersInnerV = true
    bottomTable.ColumnDefs[1] = {
        Width = 714,
        WidthFixed = true
    }
    local bottomRow = bottomTable:AddRow()

    -- LEFT BOTTOM TABLE -- 
    local leftBottomTable = bottomRow:AddCell():AddTable("LeftMidTable", 3)
    leftBottomTable.BordersInnerV = true
    leftBottomTable.RowBg = true
    leftBottomTable:SetStyle("CellPadding", 10)
    leftBottomTable.Size = {714, 150}

    local nameRow3 = leftBottomTable:AddRow()
    nameRow3.Headers = true

    AlignCellTitle(nameRow3, "Artificer", "AbilityCheck")
    AlignCellTitle(nameRow3, "StaticSpell", "SaveDC")
    AlignCellTitle(nameRow3, "Static", "AttackBonus")

    local rightBottomTable

    local checkboxRow3 = leftBottomTable:AddRow()

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
            rightBottomTable.Visible = true
        else
            rightBottomTable.Visible = false
        end
    end

    if attackRollCheckbox.Checked == false then
        rightBottomTable.Visible = false
    end

    rightBottomTable = bottomRow:AddCell():AddTable("Table", 1)
    MakeSlider(rightBottomTable, tabOwner, "StaticAttackRollBonus", -10, 10, "Additional", "AttackBonus", "AttackRollBonus")
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
        local overrideTooltip =  overrideCheckbox:Tooltip():AddText(overrideCheckbox.Checked and overrideTrue or overrideFalse)
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
    local resetButton = controlRow:AddCell():AddButton("Reset5e")
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
        ModTabs[tabOwner] = {}
        ModTabs[tabOwner].Tab = treeParent

        if ModConfig[tabOwner] == nil then
            ModConfig[tabOwner] = {}
        end

        local mainTabBar = treeParent:AddTabBar("MainTabBar")
        local globalTab = mainTabBar:AddTabItem(tabOwner)

        ModTabs.MainTab = mainTabBar

        CreateTopBar(globalTab, tabOwner, tabName)
        PopulateGenericTab(globalTab, tabOwner, tabName)

        Ext.Net.PostMessageToServer("RequestPartyUpdate","")
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

    for characterGuid, _ in pairs(partyMembers) do
        local characterName = GetDisplayName(characterGuid)

        if characterName then
            if ModTabs and ModTabs[characterGuid] == nil then
                if ModConfig[characterGuid] == nil then
                    ModConfig[characterGuid] = ModConfig.Defaults
                end

                if ModTabs.MainTab ~= nil then
                    local newTab = ModTabs.MainTab:AddTabItem(characterName)
                    CharacterTab(newTab, characterGuid, characterName)
                end
            end
        end
    end

    for tabOwner, _ in pairs(ModTabs) do
        if tabOwner ~= "Global" and tabOwner ~= "MainTab" then
            if partyMembers[tabOwner] == nil then
                if ModTabs and ModTabs[tabOwner] ~= nil and ModTabs[tabOwner].Tab ~= nil then
                    ModTabs[tabOwner].Tab:Destroy()
                    ModTabs[tabOwner] = nil
                end
            end
        end
    end
end)

Ext.Events.SessionLoaded:Subscribe(function()
    LoadConfig()
    InitializeClientTables()

    UpdateScrollSpells()
    Log("SESSION LOADED - CLIENT")
end)

Ext.Events.StatsLoaded:Subscribe(function()

    Log("STATS LOADED - CLIENT")
end)

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "True Scrolls", MainTab)
Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "5e Reference", ReferenceTab)
