--- @class SettingItem
--- @field label1 string
--- @field label2 string
--- @field type string
--- @field setting string
--- @field trueKey string | nil
--- @field falseKey string | nil
--- @field min number | nil
--- @field max number | nil
--- @field options string[] | nil
--- @field condition boolean | nil
--- @field text string | nil
--- @field additionalLogic nil | fun() 
--- @field buttonType string | nil

--- @class SettingSection
--- @field title string
--- @field condition boolean | nil
--- @field items SettingItem[]

-- Global string table
StringTable = {
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
    StaticSaveDCTrue = "hcf886357fdb04c4d8ed1e64b33c7b0a84386",
    StaticSaveDCFalse = "h676f60f7bbf84f1b8250b5445b903286c302",
    StaticAttackRollBonus = "h950ad5245cff41c1a0b7bd7f238540408630",
    CastRollBonus = "h1a6dbfe1f384464a9fca19768b3825228220",
    ScribeRollBonus = "h20946e8a12364bba8f47d349f63c2e9eba7d",
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
    WizardLevelsFalse = "h9b9dfe01c9444ae99177f32946ed2c9917d0",
    CraftingTime = "hdd5303a36a5348a189aef802fa3aa81232f5",
    CraftingCost = "h69bd418bf45f425ba59977f1e7d591f95g5g",
    CraftingRequireItemsTrue = "h6a40c7fb2b78455392e0297f3f0dd9d9787f",
    CraftingRequireItemsFalse = "had89dee59b584d5f8273a60dc240a721d9a0",
    CraftingArcanaProficiencyTrue = "h8e1d52a7be8a40b4a14202851e78e039g1c9",
    CraftingArcanaProficiencyFalse = "h570d9a6132ea4b73b67cef6a33e419a416ad",
    CraftingSharedGoldTrue = "h3817823335c14250b41620cf5facc29ec786",
    CraftingSharedGoldFalse = "h12ed809109d042db93fd59e76dfd46a3d7e0",
    Scribing = "h918a332662154c90a6a8259c5e165b20e757",
    ScribingItems = "ha8ef31c5917944689b1ad4eb63d9385efag7",
    ArcanaProficiency = "h657045eead5f494f8dde0e279743dde65705",
    Share = "h3e658cf539974a4f920208d267e9d037fg58",
    ScribingCost = "h8d4fc5b086954d0f9152abc87ec75f49f45f",
    Adjust = "hec8d417522624146af2d52c9cb17522c56fc",
    ScribingTime = "h3209ce65935548de87fa98b0b6eda570fb08",
    PreparedSpell = "h5328fed43ae649d2aa50cf0b1ba3376158cd",
    PreparedDisabled = "hfd2c0df657cf4fa498ed63b584ee09314a29",
    PreparedLongRest = "hf3b26639824b42778aea804b911fd419870f",
    PreparedShortRest = "h83fdf44cf0af46928acc4013d67874adgf38",
    RequireRoll = "hbbc303df1413485097cfdf309d94706faea9",
    CraftingArcanaCheckTrue = "h8ab799c2ab8d46d0a39db1377d93d73551bg",
    CraftingArcanaCheckFalse = "h20a4afebd1604cd686436b5da77324464305",
    ArcanaCheck = "hd4d2c150bbed49d0bfe988cb0d90f785506b",
    Downtime = "h473584cfc147460fb36d4e10f42f2fd1938a",
    ActivityRuleset = "h5033f7ce1bd9467cbb6ef40e113fed69c17e",
    RulesetRAW = "hf38a2a956dd741f39bb7a72be15c53249d3a",
    RulesetSimplified = "h1a39b73924bf4c7a9a7b00ceaa4a9a446cc0",
    RulesetHomebrew = "h0390192eefdb4e27bc8034f6531f47b3ag25",
    Complications = "h5817b4acb9d14d88bd7ff166e1c72eaa4222",
    ChanceOf = "h858c371dd6944b05a229e0f4962a4a13b996",
    CraftingComplicationsTrue = "h872389d9aca94b6597165fcab870a9dca37e",
    CraftingComplicationsFalse = "he04986c0501b42e5a8dc68a404423dc7de9b",
    CraftingComplicationChance = "h8dff0f10029a49e7a3b44a86443d11acaa46",
    QuillBreaking = "h43ed22f3563c4d0f90bda5defc375ec075a0",
    CraftingQuillBreakChance = "haaa43064ee7f4245aae76eee03ad10a19612",
    RefScribingText = "h3f65a838d1824f1b996d05d1149355a752d4",
    ScribingASpellScroll = "hbb0e549ca7ae4d2faf41f57e10f0c7361272",
    Time = "he16e7e5147a54b2fbe5dedbc321d19604cd1",
    Cost = "hde532ec6eec24007ac4b39eb7e2c027d22da",
    st = "h11a3b0331b1a40a0bb1a6b47270ed904825c",
    nd = "hf9f0103969884e5989d0b8362a337a0a22b4",
    rd = "h7485b062d4b846cb84006a9613a3b3828da3",
    th = "hf2b060c02efd42139feb4890b1d79ba0c03f",
    gp = "h7b720c92d82e45bb84116986904402cecc0g",
    Day = "h653d7272ad4d431b8a57eab73e2c886996f1",
    Days = "hf17e9ec34bcf4ff494592e733bc54b558c3d",
    NotPrepared = "hee43a21b3a484972be324fc47ab5b1d8a899",
    NoCharactersArcana = "h063a3f652ee54f5e8c461f60390137804bbf",
    WaitingForInput = "hb8430dc00d6d48648954ae0fa14a9f5ffg47",
    ToggleScribingPanel = "h60b562ddb6204f2489d4586f49640455aeec",
    PressKeyModifier = "h83b24d5cd636476e9be66ad87f5874ca8f6g",
    ActiveScribingPanel = "h6c4c0c721df94dfe812790a78e2ecebe3g7a",
    Settings = "h19961661dcc740d79ea007b9313a936738a3",
    ShowNotifications = "he6fa86a5676843cfbe966027e7da97a9a08f",
    ShowNotificationsTooltip = "hc320cd07aa9841008844b2b1bdd3d14e5530",
    SetKeybind = "h43831050995a4107b76462fc96c8579ece8b",
    SetKeyBindTooltip = "h890192a023434611a52b3500703dc17400c3",
    AutoHide = "he60912635b3142248155598438c83ae20b2b",
    AutoHideTooltip = "h5e0b066bb3fc4845a954fcbe13711af2d016",
    AutoHideDelay = "h188a221856964479a6218d82874b2b21eb8a",
    AutoHideDelayTooltip = "ha7ceabd6d88d475a96e021d365d360e2cbdc",
    ResetPosition = "hfc5231d3a3274025bed4b59b9dd27d1642fe",
    ResetPositionTooltip = "h03f24b544628407d87e04bdbb0c54bda8abf",
    Scribe = "h15ecde9fbfa146c5874d221e8fa24bb6b788",
    AreYouSure = "hb0ee4fb15cb14231a5192080dfe2f5899454",
    Yes = "h9dfc0b36159446908367ac93d8a5afd7ffe6",
    No = "h51a08063830a4dcfa77bbfc92160ce821091",
    Pause = "hb139383f52344926b756a9667b1097610157",
    Resume = "h3a4b68e77df141c7a76c6ca050b534e5bafc",
    PauseTooltip = "hf5a5e4b9783f49b99d8604b474aa5e64d7g9",
    ResumeTooltip = "h0b07f23a9b9f4c9c8b23fdc380963e3f6f44",
    And = "he939d30cd19142b8986baf68ba5345bf182a",
    Hours = "hdfb9114fbb1f4065a5f35be631d258259886",
    Left = "h5e00e5a51c0949a090c11622471bdaa21883",
    Enabled = "heab59a83f47f4b5da96de01308c587b8gf77",
    Disabled = "h805e020fa9094b32bcfd9f004d2bb0b22g6f",
    ScribeTwoHours = "h8f16d220482048e2b25f23738b3064dd40d1",
    SpellNotPrepared = "h52b77fd8dba741b5a6d43dd6d2d6fcc9edbe",
    Missing = "h52704023eb814287aee2e0738207741456cf",
    AParchment = "h8acb77de532044dc8c652f266df4d597c5g7",
    AQuill = "h788063d1bc4d477789bf63ce686269e45153",
    Ink = "h251a54280af54854a3aa183fbb84087da9ae",
    WizardCopyCantripsTrue = "hd205d29953614bd0b06d4416ca5f7b9cd5b8",
    WizardCopyCantripsFalse = "h8b4f9c38a3a24cd9b810df449130c812e336",
    Reference = "hcda64c5b293e4596986e7d0008da5e2516ac",
    Spell = "h0e7fa0aaa910438d870749a6ec9a904e494f",
    Level = "he1f23bd31581406ba89781c4c802a150ecc9",
    CastingSettings = "h6f3436bef8a54cb6a27665d8a9a9771a8b16",
    CopyingSettings = "h02252415c01e4e7d8c2317d46237bde97377",
    ScribingSettings = "h57ffb72073bf4f9f83ae82fa8c883109aded",
    Set = "h8f01c2baa17447deb05a5e5da43c210647d3",
    Cancel = "h5dd341f0d28d40fd9d31ab55ffcb2caaa3a1"
}

-- String table for combo box option tooltips
ComboTooltipTable = {
    PreparedDisabled = "h4935ea83efc146f3b1cf324d84b318659461",
    PreparedLongRest = "hbaa958573710445982cc0d0f285ed3540168",
    PreparedShortRest = "h4788ec8cb55c4743bfb5f1b036f99deda630",
    RulesetRAW = "hf1e86a9701da4d25b6fefe0080cfdbace14d",
    RulesetSimplified = "h6c66bf5bad3748bc98951e591759a2018ebc",
    RulesetHomebrew = "hcc5f8361516249fb8b2c51375b5bd418d66g"
}

-- Flavor text to display when character is scribing during this long rest
ScribingFlavorText = {"hb9b9fb63ac7d4403941f2094aefa98c5ffg5", "h57baaf78466d4ca6993635b250e5dcb84ea2", "h7058d7e5a89c434894965e56df540718a0g2", "hde85402b530544bbaf7a5809f95adf96a538", "hb401fd93216b48159dd1574ac0575ffb676e", "hc24bce8e80904e0299df8a572facad8f37b9",
                      "h7f3d2e37fdf44dcbaa22e6096796a7a6f62e", "h46b36cd1d03e43f9961e01f2c04404a2e955", "hf9d106bf063142bd9e3c2170bb33e29cg7g6", "hb8e29bcd11b7488b994b1a9116143dd0beaf", "hb0c20e1d391445dbb2cc0caa341f3b6defb6", "h250059c4db344332b2a21da1ac13c7807041",
                      "h0b1e65cef79748d7aefdec75c04f008744ba", "hcfa6f3a7f7dc43c3a79fd0ad3d6384e2afa3", "ha7778b656db14b9ab543d37f2479813ad679", "h97072fa8610c4222bf913729a211958812g5", "he0f48569b25446f7ae33ce8fd53aab314ca3", "h0ef921c14fa4482e9e93c6542fa9d83ca2ea",
                      "h3947bfcd9ace42228146b7834538b5f7e7ef"}

-- Flavor text for paused scribing
ScribingPausedText = {"h935c586a0f9f4a4f822419f23689ca5e4ec7", "h963ccc0ae21e444aa4d3d9453ad16020ab8b", "he6b23daf6eb8485991b5d87f77073107ba34", "h1e675c03cdac4fc890494c3b60767b32b71e", "h240d530b80a948e58e576e52690ee00972ad", "h15b49331106b497aba4c2855254f459fd877",
                      "ha164842d504c48a2b179396c9d34536d53e5"}

-- Flavor text to display during the day when character will scribe later
ScribingLaterText = {"hab1452e37dbf4decb75b2f4723c24f8c3aac", "ha1b6734a64ed47f7baa3751db68d4e330282", "h36435ffbe6d1470d9ffee77baf5a1cd47bfd", "heca61114652a4037881359b2d1107b34c4bc", "hb5df457714174f69ab5bf3a81364ac95c34d", "h52c75d4dbb204a9da053e9ef57577075e2d3",
                     "h388929766a194e7ca34236bfb27d03a03ce3", "hcd23a2c1e16245cab20f799d51211ba6gacg", "hb7ee2166a016424ba938326816c6a0f474ge", "h31072833126f440983a2a807e4d68ed8gb10", "hfbba3b3a29e84a839b62cc2b30d352df1996", "ha69b3407fd6e415e95e4873a6ec912c8gfd3"}

-- Flavor text when it's the final day of scribing
ScribingFinalDayText = {"hdbc2384a069449cb87dc3885a9b85343ddd0", "h0b86d1479ee54a888761aefb475b773058dg", "hfb2a638af9794239a4b3a9667457eadaabaf", "h6bdb685ba4ef4a92afdb72ac35d809477a8e", "hc26c64464a0141c8b46a3d146f26427e2697", "ha30d40b987014798a738f86e19399e44fc0f",
                        "h601d7fd872db43cab4ba38cb6c21ffdcafa3", "hb74be35c3a5f4d38b36c19f14a38b89a0a55", "hadecc3a81e414d24b8e5873484cf08df9784", "h38b0d7e2f91d427f9fe0ab2a6bb6e0294caf", "h9b651be5f72744dfb424860ededc6efebb5c"}

--- Create a slider in a popup that saves its state to a setting
--- @param treeParent ExtuiGroup
--- @param tabOwner string
--- @param setting string
--- @param min number
--- @param max number
--- @param tooltip string
--- @param text1 string
--- @param text2 string
--- @param updateFunc fun(newValue: number)
function MakeSlider(treeParent, tabOwner, setting, min, max, tooltip, text1, text2, updateFunc)
    local settingValue = GetSetting(tabOwner, setting)
    local percentage = false

    if min == 0 and max == 100 then
        settingValue = settingValue * 100
        percentage = true
    end

    MakeTitle(treeParent, text1, text2)

    local slider = treeParent:AddSliderInt("", settingValue, min, max)
    slider.AlwaysClamp = true
    slider.NoInput = true
    slider:Tooltip():AddText(GetString(tooltip))
    slider.OnChange = function(s)
        local newValue = s.Value[1]

        if percentage == true then
            newValue = newValue / 100
        end

        SetSetting(tabOwner, setting, newValue)

        if updateFunc ~= nil then
            updateFunc(newValue)
        end
    end
end

--- Create a table for a setting that includes values for each spell level
---@param treeParent ExtuiTreeParent
---@param tabOwner string
---@param tabName string
---@param setting string
---@param text1 string
---@param text2 string
---@param minimum number
function MakeSpellLevelSetting(treeParent, tabOwner, tabName, setting, text1, text2, minimum)
    local tableWidth = 1500 * Scale()
    local tempValues = {}
    local inputCells = {}
    local inputWidgets = {}

    MakeTitle(treeParent, text1, text2)

    local levelTable = treeParent:AddTable("table", 1)
    levelTable:SetStyle("SeparatorTextBorderSize", 0)
    levelTable:SetStyle("SeparatorTextPadding", 0)
    levelTable:SetStyle("CellPadding", 0)
    levelTable.SizingStretchProp = true
    levelTable.ColumnDefs[1] = {
        Width = tableWidth,
        WidthFixed = true
    }

    local nameRow, settingsRow

    local function MakeInputCell(cell, i)
        local input = cell:AddInputInt("", tempValues[i])
        input.PositionOffset = {55 * Scale(), 0}
        input.CharsNoBlank = true
        input.OnChange = function(s)
            local value = input.Value[1]

            if s.Value[1] < minimum then
                value = minimum
            end

            tempValues[i] = value
        end

        inputWidgets[i] = input
    end

    for i = 0, 9, 1 do
        if i == 0 or i == 5 then
            nameRow, settingsRow = MakeSettingsRow(levelTable, 5)
        end

        tempValues[i] = GetSetting(tabOwner, setting, i)

        nameRow:AddCell():AddSeparatorText(FormatSpellLevel(i))
        local inputCell = settingsRow:AddCell()
        MakeInputCell(inputCell, i)

        inputCells[i] = inputCell
    end

    local confirmButton, resetButton = MakeTwoButtons(levelTable, tableWidth, 80, "Confirm", "Reset")

    -- Sets new values for each spell level and sends updated data for scribed spells to server
    confirmButton.OnClick = function()
        SetSetting(tabOwner, setting, tempValues)
        SetTimer(100, SendUpdatedScribeData)
    end

    -- Resets to the previous values for each spell level
    resetButton.OnClick = function()
        for i = 0, 9, 1 do
            tempValues[i] = GetSetting(tabOwner, setting, i)
            inputWidgets[i]:Destroy()
            MakeInputCell(inputCells[i], i)
        end
    end
end

--- Create a button in a table row that opens a popup with additional settings window
---@alias PopupTextType "Percent"
---@param treeParent ExtuiTableRow
---@param tooltip any
---@param text any
---@param size any
---@param textType PopupTextType
---@return ExtuiGroup, fun(updatedText: string | number)
function MakePopupButton(treeParent, tooltip, text, size, textType)
    local buttonTable = treeParent:AddCell():AddTable("button", 3)
    buttonTable.SizingStretchProp = true
    buttonTable.ColumnDefs[1] = {
        WidthStretch = true
    }
    buttonTable.ColumnDefs[2] = {
        Width = size * Scale(),
        WidthFixed = true
    }
    buttonTable.ColumnDefs[3] = {
        WidthStretch = true
    }

    local popupRow = buttonTable:AddRow()
    popupRow:AddCell()

    local popup = buttonTable:AddPopup("Popup")
    popup.AlwaysAutoResize = true

    local buttonCell = popupRow:AddCell()
    local button = nil

    local function RecreatePopupButton(updatedText)
        if button ~= nil then
            button:Destroy()
            button = nil
        end

        if updatedText ~= nil then
            text = updatedText
        end

        if type(text) == "number" and text > 0 then
            if textType == "Percent" then
                text = math.floor(text * 100) .. "%"
            else
                text = "+" .. text
            end
        elseif type(text) == "string" then
            text = GetString(text)
        end

        button = buttonCell:AddButton(text)
        button:Tooltip():AddText(GetString(tooltip))
        button:SetColor("Button", ToVec4(51, 43, 39, 1))
        button.Size = {size * Scale(), 50 * Scale()}
        button.OnClick = function()
            popup:Open()
        end
    end

    local popupContent = popup:AddGroup("Popup")

    RecreatePopupButton()

    popupRow:AddCell()

    return popupContent, RecreatePopupButton
end

--- Create a combo box in a table row that saves its state to a setting
---@param treeParent ExtuiTableRow
---@param tabOwner string
---@param setting string
---@param options table
---@return ExtuiCombo
function MakeCombo(treeParent, tabOwner, setting, options)
    local comboTable = treeParent:AddCell():AddTable("combo", 1)
    comboTable.SizingStretchProp = true

    local comboRow = comboTable:AddRow()

    local optionStrings = {}
    local currentOption = GetSetting(tabOwner, setting)
    local currentIndex
    local foundOption = false

    for i, option in ipairs(options) do
        table.insert(optionStrings, GetString(option))

        if option == currentOption then
            foundOption = true
            currentIndex = i
        end
    end

    if foundOption == false then
        currentIndex = 1
    end

    local combo = comboRow:AddCell():AddCombo("")
    combo.PositionOffset = {80 * Scale(), 0}
    local tooltip = combo:Tooltip():AddText(GetString(currentOption, ComboTooltipTable))
    combo.Options = optionStrings
    combo.SelectedIndex = currentIndex - 1
    combo.OnChange = function(c)
        currentOption = options[c.SelectedIndex + 1]
        SetSetting(tabOwner, setting, currentOption)
        tooltip:Destroy()
        tooltip = combo:Tooltip():AddText(GetString(currentOption, ComboTooltipTable))
    end

    return combo
end

--- Create a checkbox in a table row that saves its state to a setting
---@param treeParent ExtuiTableRow
---@param tabOwner string
---@param setting string
---@param tooltipTrue string
---@param tooltipFalse string
---@return ExtuiCheckbox
function MakeCheckbox(treeParent, tabOwner, setting, tooltipTrue, tooltipFalse)
    local checkboxTable = treeParent:AddCell():AddTable("checkbox", 3)
    checkboxTable.SizingStretchProp = true
    checkboxTable.ColumnDefs[1] = {
        WidthStretch = true
    }
    checkboxTable.ColumnDefs[2] = {
        Width = 50 * Scale(),
        WidthFixed = true
    }
    checkboxTable.ColumnDefs[3] = {
        WidthStretch = true
    }

    local checkboxRow = checkboxTable:AddRow()
    checkboxRow:AddCell()

    tooltipTrue = GetString(tooltipTrue) or ""
    tooltipFalse = GetString(tooltipFalse) or ""
    local checkbox = checkboxRow:AddCell():AddCheckbox("", false)
    checkbox.Checked = GetSetting(tabOwner, setting)

    local tooltip = checkbox:Tooltip():AddText(checkbox.Checked and tooltipTrue or tooltipFalse)

    checkbox.OnChange = function(c)
        tooltip:Destroy()

        if c.Checked then
            SetSetting(tabOwner, setting, true)
            tooltip = checkbox:Tooltip():AddText(tooltipTrue)
        else
            SetSetting(tabOwner, setting, false)
            tooltip = checkbox:Tooltip():AddText(tooltipFalse)
        end
    end

    checkboxRow:AddCell()

    return checkbox
end

--- Create a new row for 5e casting reference table
---@param treeParent ExtuiTable
---@param level integer
---@param rarity string
---@param dc string
---@param attack string
function MakeRefTableRow(treeParent, level, rarity, dc, attack)
    local row = treeParent:AddRow()
    row:AddCell():AddText(FormatSpellLevel(level))
    row:AddCell():AddText(GetString(rarity))
    row:AddCell():AddText(dc)
    row:AddCell():AddText(attack)
end

--- Create a new row for 5e scribing reference table
---@param treeParent ExtuiTable
---@param level integer
---@param time integer
---@param cost integer
function MakeScribeRefTableRow(treeParent, level, time, cost)
    local daysText = time <= 1 and GetString("Day") or GetString("Days")

    local row = treeParent:AddRow()
    row:AddCell():AddText(FormatSpellLevel(level))
    row:AddCell():AddText(time .. " " .. daysText)
    row:AddCell():AddText(cost .. " " .. GetString("gp"))
end

--- Created centered text in a new cell of a table row
---@param treeParent ExtuiTableRow
---@param text1 string
---@param text2? string
function MakeTextCentered(treeParent, text1, text2)
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

--- Create a centered title and optional subtitle with separators at the top and bottom
---@param treeParent ExtuiTreeParent
---@param text1 string
---@param text2? string
function MakeTitle(treeParent, text1, text2)
    local separator1 = treeParent:AddSeparatorText(" ")
    separator1:SetStyle("SeparatorTextAlign", 1)
    separator1:SetStyle("SeparatorTextPadding", -10)
    separator1:SetStyle("SeparatorTextBorderSize", 10)

    if StringTable[text1] then
        text1 = GetString(text1)
    end

    local separatorText1 = treeParent:AddSeparatorText(text1)
    separatorText1:SetStyle("SeparatorTextBorderSize", 0)
    separatorText1:SetStyle("SeparatorTextPadding", 0)

    if text2 ~= nil then
        if StringTable[text2] then
            text2 = GetString(text2)
        end

        local separatorText2 = treeParent:AddSeparatorText(text2)
        separatorText2:SetStyle("SeparatorTextBorderSize", 0)
        separatorText2:SetStyle("SeparatorTextPadding", 0)
    end

    local separator2 = treeParent:AddSeparatorText(" ")
    separator2:SetStyle("SeparatorTextAlign", 1)
    separator2:SetStyle("SeparatorTextPadding", -10)
    separator2:SetStyle("SeparatorTextBorderSize", 10)
end

--- Create a new row for a spell in scribe table
---@param treeParent ExtuiTable
---@param tabOwner string
---@param spellId string
---@param isPrepared boolean
function MakeScribeRow(treeParent, tabOwner, spellId, isPrepared)
    local spellData = GetSpellScribeData(tabOwner, spellId)

    if spellData == nil then
        return
    end

    local spellRow = treeParent:AddRow()
    local dayText = spellData.Time <= 1 and GetString("Day") or GetString("Days")
    local levelText = FormatSpellLevel(spellData.Level)

    spellRow:AddCell():AddImage(spellData.Icon, {60 * Scale(), 60 * Scale()})
    spellRow:AddCell():AddText(spellData.Name)
    spellRow:AddCell():AddText(levelText)
    spellRow:AddCell():AddText(spellData.Time .. " " .. dayText)
    spellRow:AddCell():AddText(spellData.Cost.Total .. " " .. GetString("gp"))

    if isPrepared == true then
        local scribeButton = spellRow:AddCell():AddButton(GetString("Scribe"))
        scribeButton.Size = {150 * Scale(), 50 * Scale()}
        scribeButton.OnClick = function(c)
            Ext.Net.PostMessageToServer("TrueScrolls_ProcessScribingStarted", Ext.Json.Stringify(spellData))
        end
    end
end

--- Create a new row for populating with settings
---@param treeParent ExtuiTable
---@param numRows integer
---@return ExtuiTableRow, ExtuiTableRow
function MakeSettingsRow(treeParent, numRows)
    local settingsTable = treeParent:AddRow():AddCell():AddTable("NameTable", numRows)
    settingsTable.SizingStretchSame = true
    settingsTable.BordersInnerV = true
    settingsTable.RowBg = false
    settingsTable:SetStyle("CellPadding", 10)

    local nameRow = settingsTable:AddRow()
    nameRow:SetColor("TableHeaderBg", ToVec4(69, 49, 33, 0.8))
    nameRow.Headers = true

    local settingsRow = settingsTable:AddRow()
    settingsRow:SetColor("TableHeaderBg", ToVec4(236, 202, 142, 0.3))
    settingsRow.Headers = true

    return nameRow, settingsRow
end

--- Create a button that opens a confirmation popup
---@param treeParent ExtuiTreeParent
---@param text string
---@param sizeX number
---@param sizeY number
---@return function
function MakeConfirmationButton(treeParent, text, sizeX, sizeY)
    local cancelPopup
    local cancelYes
    local externalCallback = nil

    local function CreateNewPopup()
        cancelPopup = treeParent:AddPopup("Cancel")
        cancelPopup.AlwaysAutoResize = true
        MakeTitle(cancelPopup, "AreYouSure")

        cancelYes = cancelPopup:AddButton(GetString("Yes"))
        cancelYes.Size = {120 * Scale(), 50 * Scale()}
        cancelYes.OnClick = function()
            if externalCallback then
                externalCallback()
            end

            if cancelPopup ~= nil then
                cancelPopup:Destroy()
                cancelPopup = nil
            end
        end

        local cancelNo = cancelPopup:AddButton(GetString("No"))
        cancelNo.SameLine = true
        cancelNo.Size = {120 * Scale(), 50 * Scale()}
        cancelNo.OnClick = function()
            if cancelPopup ~= nil then
                cancelPopup:Destroy()
                cancelPopup = nil
            end
        end
    end

    CreateNewPopup()

    local button = treeParent:AddButton(GetString(text))
    button.Size = {sizeX * Scale(), sizeY * Scale()}
    button.OnClick = function()
        if cancelPopup == nil then
            CreateNewPopup()
        end

        if cancelPopup ~= nil then
            cancelPopup:Open()
        end
    end

    local function SetOnConfirm(callback)
        externalCallback = callback
    end

    return SetOnConfirm
end

--- Create a table to display scribing progress
---@param treeParent ExtuiTreeParent
---@param tabOwner string
---@param isWindow boolean
---@param cachedInfoText? string
function MakeScribeProgressTable(treeParent, tabOwner, isWindow, cachedInfoText)
    local scribeData = ActiveScribing[tabOwner]
    local progressTableSize = isWindow and 650 * Scale() or 1200 * Scale()
    local progressBarSize = scribeData.ElapsedTime / scribeData.Time * progressTableSize
    local daysLeft = scribeData.Time - scribeData.ElapsedTime
    local pauseButtonText = GetString("Pause")
    local pauseButtonTooltip = GetString("PauseTooltip")
    local progressInfoText = WrapText(GetProgressInfoText(tabOwner), 47, true)
    -- Short days count as 0.25 progress == 2h per day out of 8h max
    local remainderText = daysLeft % 1 == 0 and "" or " " .. GetString("And") .. " " .. math.floor(daysLeft % 1 * 8) .. " " .. GetString("Hours")
    local days = math.floor(daysLeft) == 1 and GetString("Day") or GetString("Days")
    local daysLeftText = math.floor(daysLeft) .. " " .. days .. remainderText .. " " .. GetString("Left")

    if cachedInfoText ~= nil then
        progressInfoText = cachedInfoText
    end

    if scribeData.Paused == true then
        pauseButtonText = GetString("Resume")
        pauseButtonTooltip = GetString("ResumeTooltip")
    end

    -- PROGRESS TABLE --
    local progressTable = treeParent:AddTable("progressTable", 1)
    progressTable:SetStyle("CellPadding", 0)
    progressTable.BordersOuter = true
    progressTable.NoHostExtendX = true
    progressTable.ColumnDefs[1] = {
        Width = progressTableSize,
        WidthFixed = true
    }

    -- isWindow is displaying progress in notification window, otherwise in MCM
    if isWindow == true then
        progressTable.RowBg = true
        progressTable:SetColor("TableRowBg", {0, 0, 0, 0.75})
        progressTable:SetColor("TableRowBgAlt", {0, 0, 0, 0.75})

        local characterName = progressTable:AddRow():AddCell():AddSeparatorText(GetDisplayName(tabOwner))
        characterName:SetStyle("SeparatorTextBorderSize", 0)
        characterName:SetStyle("SeparatorTextPadding", 10)
    end

    MakeTitle(progressTable:AddRow():AddCell(), scribeData.Name, scribeData.Paid .. " / " .. scribeData.Cost.Total .. " " .. GetString("gp"))

    -- There is a progress bar widget in v21 now, but can't change its colors
    local progressBar = progressTable:AddRow():AddCell():AddButton("")
    progressBar:SetColor("Button", ToVec4(236, 202, 142, 0.3))
    progressBar.Disabled = true
    progressBar.Size = {progressBarSize, 50 * Scale()}

    local progressOverlay = progressTable:AddRow():AddCell():AddSeparatorText(daysLeftText)
    progressOverlay:SetStyle("SeparatorTextBorderSize", 0)
    progressOverlay:SetStyle("SeparatorTextPadding", 0)
    progressOverlay.PositionOffset = {0, -45 * Scale()}

    MakeTitle(progressTable:AddRow():AddCell(), progressInfoText)

    if isWindow == false then
        local cancelTable = progressTable:AddRow():AddCell():AddTable("CancelTable", 3)
        cancelTable.SizingStretchSame = true

        local cancelRow = cancelTable:AddRow()

        local pauseButton = cancelRow:AddCell():AddButton(pauseButtonText)
        pauseButton.Size = {progressTableSize / 3, 80 * Scale()}
        pauseButton:Tooltip():AddText(pauseButtonTooltip)
        pauseButton.OnClick = function()
            Ext.Net.PostMessageToServer("TrueScrolls_PauseScribeClicked", tabOwner)
        end

        cancelRow:AddCell()

        local cancelButton = MakeConfirmationButton(cancelRow:AddCell(), "Cancel", progressTableSize / Scale() / 3, 80)
        cancelButton(function()
            Ext.Net.PostMessageToServer("TrueScrolls_CancelScribeClicked", tabOwner)
        end)
    end
end

--- Create two buttons at far ends of a window
---@param treeParent ExtuiTreeParent
---@param windowWidth number
---@param buttonheight number
---@param text1 string
---@param text2 string
---@return ExtuiButton, ExtuiButton
function MakeTwoButtons(treeParent, windowWidth, buttonheight, text1, text2)
    buttonheight = buttonheight * Scale()
    local buttonTable = treeParent:AddTable("buttonTable", 3)
    buttonTable.SizingStretchSame = true

    buttonTable:AddRow():AddCell():AddText(" ")
    local buttonRow = buttonTable:AddRow()

    local confirmButton = buttonRow:AddCell():AddButton(GetString(text1))
    confirmButton.Size = {windowWidth / 3, buttonheight}

    buttonRow:AddCell()

    local cancelButton = buttonRow:AddCell():AddButton(GetString(text2))
    cancelButton.Size = {windowWidth / 3, buttonheight}

    return confirmButton, cancelButton
end
