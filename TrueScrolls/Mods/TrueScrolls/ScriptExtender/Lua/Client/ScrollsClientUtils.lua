local stringTable = {
    RefMainText = "h1b7de7ffab3d4b31abff44128d29da568670",
    RefCopyText = "h8b3c149deb70426aaab7c69fb113ae4e097g",
    RevivifyTrue = "h7c8b0c313baf41c1b488c473919157236e55",
    RevivifyFalse = "hac4f35376e6f4ef0adff511a3c78a282g008",
    ClassRestrictionTrue = "h459be7df43204f86a3d4313cd508ac9dffag",
    ClassRestrictionFalse = "he993a70f80c04649aa3e0aa11117984dff43",
    CastingRollTrue = "h704c3298d4a647c59b1d029782ec936fg602",
    CastingRollFalse = "h012783d6453d498e86fa737ace95f36dee60",
    CopyingRollTrue = "h9e57fb03c42c496ab6a1f56e66d74e18893f",
    CopyingRollFalse = "h9d3583bdbf0a457784ec12e65b720c0b9c02",
    StaticAttackRollTrue = "h5dca14e9991a4162a9a20f88959281305g15",
    StaticAttackRollFalse = "h50759bb185a4401eb6cc165df8224038d0cg",
    StaticSaveDCTrue = "h17e37f5372d64fa1a5a9d08f34b07ca729dd",
    StaticSaveDCFalse = "h676f60f7bbf84f1b8250b5445b903286c302",
    AttackRollBonus = "h950ad5245cff41c1a0b7bd7f238540408630",
    CastRollBonus = "h1a6dbfe1f384464a9fca19768b3825228220",
    CopyingRollBonus = "h20946e8a12364bba8f47d349f63c2e9eba7d",
    ThiefCanCastTrue = "h13b9015031b64c73a5c1987bdaa69afde25c",
    ThiefCanCastFalse = "h9b462b02200e4a0cbebf8580c7779ad80058",
    ArtificerRollTrue = "h82a471111f8b4349b044630478a07fea7303",
    ArtificerRollFalse = "h2563fec1cac64bb395a0551f50fd8863235c",
    ClassCastingTrue = "h97a8a75525e242bd8663f73483663ded7gf7",
    ClassCastingFalse = "h134681ce10ea4e6099bcef281b3439c335f9",
    SpellScrolls = "he5f57c741216430d8fdbcc8c73c317529104",
    SpellLevel = "h2552ac3c2dac4746a87663306ea0c330efeg",
    Rarity = "h058910c9880e41e8986735962f86da00c18e",
    SaveDC = "hd9906feb1f6e4ca5b42e53c005afe9dcd820",
    AttackBonus = "h796f794338994a93b3f8ce8b96a57cc2gf12",
    Cantrip = "he9b69193ee264c218cc6a7d721c360baa604",
    Common = "h1539170d214c4de19ab54e9d403db641fdcg",
    Uncommon = "h7063ed7083d14ce6b123547ef55765fcb3c7",
    Rare = "h1057830b9c334810ab985ea5a7c20afccb6e",
    VeryRare = "h1f29940aeca84ef09960972db266006bef05",
    Legendary = "h56b867221a564b79b89dc9a77b38d08d6178",
    CopyingAScroll = "h56b1551eb2a84c9cbf4abffd1bc2d1704d26",
    Revivify = "h5cf9bfbee34d47c4a4684c3100f0495fedbg",
    Override = "h051bdf3407614a73952c401f8c81fb3b4e86",
    Class = "ha9ec1b84a32e4dd6a7438c1be6383265beba",
    CastingAbility = "h43924f67d13e4d4c9bfcf62d594627fba426",
    Casting = "hd4c230ce7dfb4777827d27b27cee7720a5a6",
    AbilityCheck = "h84cba14e5d4343d6b6c9f6fda62594e49e5f",
    DifficultyModifier = "h30f60aee6de5463ebd1fd6538461bf8798c4",
    Thief = "hfdb4918f61774e67b361dd2e278eba139308",
    CanUseScrolls = "h971b8f680ff54f5a962420038093c28cf9bg",
    SpellList = "hfd66978ab33544148480428a789d7f31cb4b",
    Restrictions = "ha24c068719144d768861ba289348f7295183",
    Copying = "h25d20e37ecbd40218fb9f93435a17b11f2d5",
    Artificer = "h89a4b304e005497b9cd12041bb091a7851ef",
    StaticSpell = "h26b283e99919480b84cc1fe6992c9a0fb240",
    Static = "h51d49bc4070f41f2930a66697583efb9457a",
    OnlyInGlobal = "h7c306da6c66d477181168598daa6495391a2",
    Additional = "h8a6962775ba44a10bfae3cd3b87edd43e80b",
    OverrideTrue = "ha81b0ff13bbd406fba91d3d9352487922a6d",
    OverrideFalse = "hd66e9fc2b8df483aa175dec57627b04bc1fe",
    Reset5e = "h46b16544ce394c00980c79a8e8987d436f98",
    Reset = "he76d3246c42a4cf4bee9a171c20c1a5b671a",
    Follow5e = "h8c09f4566bc54084abacf75b451bf0d3g911",
    Global = "h7c56dd86fbd34a2fbbdbfdc3cf5fac4dbbf3",
    Require = "hfc6b180862444e4cabf3013ee8c2293b5723",
    WizardLevels = "h5346f073925d4bb193d054a413414be2e4f2",
    WizardLevelsTrue = "h3b3b18f7e2b74e2d984740657fb8b1ec223g",
    WizardLevelsFalse = "h9b9dfe01c9444ae99177f32946ed2c9917d0"
}

function LoadConfig()
    Ext.Vars.SyncModVariables()
    local modVars = Ext.Vars.GetModVariables(ModuleUUID)

    if modVars and modVars.ModConfig then
        ModConfig = modVars.ModConfig
    else
        ModConfig = {}
    end

    ModConfig.Defaults = ConfigDefaults
end

function SaveConfig()
    if ModConfig then
        Ext.Vars.GetModVariables(ModuleUUID).ModConfig = ModConfig
    end
end

function GetSetting(owner, settingName)
    LoadConfig()
    local value = nil

    if ModConfig then
        if ModConfig[owner] ~= nil and ModConfig[owner][settingName] ~= nil then
            value = ModConfig[owner][settingName]
        elseif ModConfig.Defaults ~= nil then
            value = ModConfig.Defaults[settingName]
        end
    end

    return value
end

function SetSetting(tabOwner, settingName, state)
    if ModConfig[tabOwner] == nil then
        ModConfig[tabOwner] = {}
    end

    ModConfig[tabOwner][settingName] = state
    SaveConfig()
end

function MakeCheckbox(treeParent, tabOwner, setting, tooltipTrue, tooltipFalse)
    local checkboxTable = treeParent:AddCell():AddTable("checkbox", 3)
    checkboxTable.ColumnDefs[1] = {
        WidthStretch = true
    }
    checkboxTable.ColumnDefs[2] = {
        Width = 50,
        WidthFixed = true
    }
    checkboxTable.ColumnDefs[3] = {
        WidthStretch = true
    }

    local checkboxRow = checkboxTable:AddRow()
    checkboxRow:AddCell()

    local tooltip
    local skipTooltip = false

    if tooltipTrue == nil or tooltipFalse == nil then
        skipTooltip = true
    end

    tooltipTrue = GetString(tooltipTrue) or ""
    tooltipFalse = GetString(tooltipFalse) or ""
    local checkbox = checkboxRow:AddCell():AddCheckbox("", false)
    checkbox.Checked = GetSetting(tabOwner, setting)

    if skipTooltip == false then
        tooltip = checkbox:Tooltip():AddText(checkbox.Checked and tooltipTrue or tooltipFalse)
    end
    checkbox.OnChange = function(c)
        if c.Checked then
            SetSetting(tabOwner, setting, true)

            if skipTooltip == false then
                tooltip:Destroy()
                tooltip = checkbox:Tooltip():AddText(tooltipTrue)
            end
        else
            SetSetting(tabOwner, setting, false)

            if skipTooltip == false then
                tooltip:Destroy()
                tooltip = checkbox:Tooltip():AddText(tooltipFalse)
            end
        end
    end

    checkboxRow:AddCell()

    return checkbox
end

function MakeSlider(treeParent, tabOwner, setting, min, max, title1, title2, tooltip)
    treeParent.RowBg = true
    treeParent:SetStyle("CellPadding", 10)

    local nameSlider1 = treeParent:AddRow()
    nameSlider1.Headers = true
    AlignCellTitle(nameSlider1, title1, title2)

    local sliderTable = treeParent:AddRow():AddCell():AddTable("slider", 3)
    sliderTable.ColumnDefs[1] = {
        Width = 10,
        WidthFixed = true
    }
    sliderTable.ColumnDefs[2] = {
        WidthStretch = true
    }
    sliderTable.ColumnDefs[3] = {
        Width = 5,
        WidthFixed = true
    }

    local sliderRow = sliderTable:AddRow()
    sliderRow:AddCell()

    local slider = sliderRow:AddCell():AddSliderInt("", GetSetting(tabOwner, setting), min, max)
    slider.AlwaysClamp = true
    slider.NoInput = true
    slider.ItemWidth = 420 -- blaze it
    slider:Tooltip():AddText(GetString(tooltip))
    slider.OnChange = function(s)
        SetSetting(tabOwner, setting, s.Value[1])
    end

    sliderRow:AddCell()

    return treeParent
end

---@param handle string
---@param maxLength number
---@return string
function WrapText(handle, maxLength)
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

        table.insert(wrappedLines, "")
    end

    if #wrappedLines > 0 and wrappedLines[#wrappedLines] == "" then
        table.remove(wrappedLines, #wrappedLines)
    end

    return table.concat(wrappedLines, "\n")
end

function AddRefTableRow(treeParent, level, rarity, dc, attack)
    local row = treeParent:AddRow()
    row:AddCell():AddText(level)
    row:AddCell():AddText(GetString(rarity))
    row:AddCell():AddText(dc)
    row:AddCell():AddText(attack)
end

function AlignCellTitle(treeParent, text1, text2)
    local cell = treeParent:AddCell()
    local textTitle1 = cell:AddSeparatorText(GetString(text1))
    textTitle1:SetStyle("SeparatorTextBorderSize", 0)
    textTitle1:SetStyle("SeparatorTextPadding", 0)

    if text2 ~= nil then
        local textTitle2 = cell:AddSeparatorText(GetString(text2))
        textTitle2:SetStyle("SeparatorTextBorderSize", 0)
        textTitle2:SetStyle("SeparatorTextPadding", 0)
    end
end

function MakeTableTitle(treeParent, text)
    local separator1 = treeParent:AddSeparatorText(" ")
    separator1:SetStyle("SeparatorTextAlign", 1)
    separator1:SetStyle("SeparatorTextPadding", -10)
    separator1:SetStyle("SeparatorTextBorderSize", 10)

    local separatorText = treeParent:AddSeparatorText(text)
    separatorText:SetStyle("SeparatorTextBorderSize", 0)
    separatorText:SetStyle("SeparatorTextPadding", 0)

    local separator2 = treeParent:AddSeparatorText(" ")
    separator2:SetStyle("SeparatorTextAlign", 1)
    separator2:SetStyle("SeparatorTextPadding", -10)
    separator2:SetStyle("SeparatorTextBorderSize", 10)
end

function GetString(key)
    return Ext.Loca.GetTranslatedString(stringTable[key]):gsub("<br>", "\n")
end
