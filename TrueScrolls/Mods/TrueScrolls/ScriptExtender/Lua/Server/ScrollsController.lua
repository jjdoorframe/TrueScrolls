--- Statis wizard class GUID
--- @type string
local wizardClassGuid = "a865965f-501b-46e9-9eaa-7748e8c04d09"

--- Difficulty Classes for scroll casting rolls
--- @type table
local scrollCastDC = {
    [-9] = "a73f1a07-853a-4b5a-9dcb-c432756416cb",
    [-8] = "9fc259e6-de70-4d9f-9427-6ad24989d387",
    [-7] = "f8ff86fb-59f2-467f-acea-13298549d082",
    [-6] = "ed6ff833-2749-473b-a5b9-62368e5044e8",
    [-5] = "705849d9-7e26-45d9-8b7a-bc641e7ae137",
    [-4] = "95a34899-01c4-461c-965d-facb257fca2a",
    [-3] = "677b93b7-55e0-4269-bf6f-e25074568430",
    [-2] = "9d728a5e-5b9f-4a8b-bcfa-3459285ac618",
    [-1] = "35d24d3d-6204-4547-bc38-73d92c095bf1",
    [0] = "315636f7-fa56-4387-93dc-4d01307434a9",
    [1] = "2cf23b54-20b9-4e96-a0e5-48bf36f1ef79",
    [2] = "9a11d469-a1fe-458f-9f9e-6ed9462061c3",
    [3] = "3773fc3a-4f0c-4de4-81ce-b8e848ed3f7e",
    [4] = "fd790959-ce3e-4c72-a1bb-ca8e7d50d93d",
    [5] = "d142c3d3-20da-4c85-a7d3-036c86c245b4",
    [6] = "3e324f0c-e201-413b-be72-cd8b051f1ab1",
    [7] = "7255dc8c-4736-45ec-a5ee-e9ae69f609d7",
    [8] = "eccfc15f-bffa-4703-87de-4df2b59733fa",
    [9] = "425f79b7-c6d8-49d8-9f12-5a1755171522",
    [10] = "2bbf4378-ba88-45c2-bac0-16532f918a3d",
    [11] = "2487019c-4a01-410f-87a1-139233936872",
    [12] = "2aca566f-32b1-4eb1-b415-4825f6720596",
    [13] = "88ce202f-d04d-4c12-9ea7-ceb4be05a268",
    [14] = "b3e97b50-eee2-4279-ae0b-7aed7a46b069",
    [15] = "2b783c12-aa6a-46c9-a2a2-3a39efb025e5",
    [16] = "1665b57b-5ac2-44de-8dbb-07295a1b89c2",
    [17] = "25abf340-30b1-4708-b838-32d53fd85269",
    [18] = "4dc74262-73d2-4579-a305-2467917bc3d7",
    [19] = "2dd8b6f5-ce44-4e88-af30-e59c26a61afd",
    [20] = "20996974-e31d-4b17-abc9-765239423269"
}

--- Static attack roll bonuses depending on spell level
--- @type table
local scrollRollBonus = {
    [0] = 5,
    [1] = 5,
    [2] = 5,
    [3] = 7,
    [4] = 7,
    [5] = 9,
    [6] = 9,
    [7] = 10,
    [8] = 10,
    [9] = 11
}

-- Gather lists of all available spells for each subclass
local function InitializeSpellLists()
    if ClassSpells == nil then
        local bardClassTable = "229c98da-2cd1-4a5e-8051-9d90ec7931e7"
        local loreClassTable = "36e6ea13-317e-4e6e-ac63-fe6d50e9f014"
        local bardLevels = {
            [6] = true,
            [10] = true,
            [14] = true,
            [18] = true
        }
        local progressionsData = Ext.StaticData.GetAll("Progression")
        local classSpellLists = {}
        ClassSpells = {}

        -- Iterate through all progressions and get spell list UUIDs for classes and subclasses
        for _, progressionUuid in pairs(progressionsData) do
            local progression = Ext.StaticData.Get(progressionUuid, "Progression")
            local skipLevel = false

            -- Group all spell lists of a subclass in a table
            if progression then
                if progression.AddSpells and #progression.AddSpells > 0 then
                    for _, addSpell in pairs(progression.AddSpells) do
                        if addSpell.SpellUUID then
                            if classSpellLists[progression.TableUUID] == nil then
                                classSpellLists[progression.TableUUID] = {}
                            end

                            -- Update if the spell list doesn't exist or the new level is lower
                            -- Spell lists repeat and we want to know the lowest level that it becomes available at
                            if classSpellLists[progression.TableUUID][addSpell.SpellUUID] == nil or progression.Level < classSpellLists[progression.TableUUID][addSpell.SpellUUID] then
                                classSpellLists[progression.TableUUID][addSpell.SpellUUID] = progression.Level
                            end
                        end
                    end
                end

                if progression.SelectSpells and #progression.SelectSpells > 0 then
                    for _, selectSpell in pairs(progression.SelectSpells) do
                        if selectSpell.SpellUUID then
                            -- Skip bard's magical secrets lists
                            if progression.TableUUID == bardClassTable or progression.TableUUID == loreClassTable then
                                if bardLevels[progression.Level] then
                                    skipLevel = true
                                end
                            end

                            if skipLevel == false then
                                if classSpellLists[progression.TableUUID] == nil then
                                    classSpellLists[progression.TableUUID] = {}
                                end

                                if classSpellLists[progression.TableUUID][selectSpell.SpellUUID] == nil or progression.Level < classSpellLists[progression.TableUUID][selectSpell.SpellUUID] then
                                    classSpellLists[progression.TableUUID][selectSpell.SpellUUID] = progression.Level
                                end
                            end
                        end
                    end
                end
            end
        end

        -- Populate subclass tables with spell IDs from gathered spell lists
        for tableUuid, spellListUuids in pairs(classSpellLists) do
            if ClassSpells[tableUuid] == nil then
                ClassSpells[tableUuid] = {}
            end

            for spellListUuid, level in pairs(spellListUuids) do
                local spellList = Ext.StaticData.Get(spellListUuid, "SpellList")
                if spellList and spellList.Spells then
                    for _, spellId in pairs(spellList.Spells) do
                        if ClassSpells[tableUuid][spellId] == nil or level < ClassSpells[tableUuid][spellId] then
                            ClassSpells[tableUuid][spellId] = level
                        end
                    end
                end
            end
        end

        -- Cleaning it from empty lists
        for key, subTable in pairs(ClassSpells) do
            if type(subTable) == "table" and next(subTable) == nil then
                ClassSpells[key] = nil
            end
        end

        Log("Initialized spell lists for classes")
    end
end

--- Toggle attack roll bonuses
---@alias ModifyBoostState "Enable" | "Disable"
---@param characterGuid string
---@param state ModifyBoostState
local function ModifyBoostBonuses(characterGuid, state)
    local character = Ext.Entity.Get(characterGuid)
    local characterName = GetDisplayName(characterGuid)

    if character and character.BoostsContainer then
        local boosts = character.BoostsContainer.Boosts

        -- Already disabled
        if ActiveScrollCasters[characterGuid] and state == "Disable" then
            Log("Boosts already disabled: %s", characterGuid)
            return
        end

        if ActiveScrollCasters[characterGuid] == nil then
            if state == "Disable" then
                ActiveScrollCasters[characterGuid] = {}
                Log("Initialized boosts table for: %s", characterName)
            else
                Log("ERROR: Attempting to enable boosts, but table is not found: %s", characterName)
                return
            end
        end

        for _, boost in ipairs(boosts) do
            if boost.Type == "RollBonus" then
                for _, boostEntity in ipairs(boost.Boosts) do
                    local boostType = boostEntity.RollBonusBoost.RollType

                    if boostType == "MeleeSpellAttack" or boostType == "RangedSpellAttack" or boostType == "Attack" then
                        local boostCause = boostEntity.BoostInfo.Cause.Cause
                        local boostParams = boostEntity.RollBonusBoost.Amount.Params
                        local boostName = tostring(boostCause) .. tostring(boostType)
                        local persistedData = ActiveScrollCasters[characterGuid][boostName]
                        local boostDicesAmount
                        local boostAdditionalValue

                        -- Set roll bonuses to 0 to disable them
                        if state == "Disable" then
                            for _, param in ipairs(boostParams) do
                                local success, value = pcall(function()
                                    return param.AmountOfDices
                                end)

                                if success and value then
                                    boostDicesAmount = param.AmountOfDices
                                    boostAdditionalValue = param.DiceAdditionalValue

                                    param.AmountOfDices = 0
                                    param.DiceAdditionalValue = 0
                                end
                            end

                            -- Save roll bonuses to be restored later
                            local boostTable = {
                                AmountOfDices = boostDicesAmount,
                                DiceAdditionalValue = boostAdditionalValue
                            }

                            ActiveScrollCasters[characterGuid][boostName] = boostTable
                        elseif persistedData then
                            for _, param in ipairs(boostParams) do
                                local success, value = pcall(function()
                                    return param.AmountOfDices
                                end)

                                -- Restore roll bonuses
                                if success and value then
                                    param.AmountOfDices = persistedData.AmountOfDices
                                    param.DiceAdditionalValue = persistedData.DiceAdditionalValue
                                end
                            end
                        end
                    end
                end
            end
        end

        if state == "Enable" then
            ActiveScrollCasters[characterGuid] = nil
            Log("Enabled boosts for: %s", characterName)
        else
            Log("Disabled boosts for: %s", characterName)
        end
    end
end

---@param osiCharacterGuid string
---@param itemGuid string
---@param status string
function OnItemUsed(osiCharacterGuid, itemGuid, status)
    local characterGuid = GetGuid(osiCharacterGuid)
    local item = Ext.Entity.Get(itemGuid)
    local spellId = nil

    -- Check if the item being used is a scroll
    if status and item and item.Data then
        local itemStats = Ext.Stats.Get(item.Data.StatsId)
        if itemStats and itemStats.Using == "_MagicScroll" and string.sub(itemStats.Name, 1, 8) ~= "FFT_Rune" then
            local useActions = item.UseAction.UseActions

            for _, action in ipairs(useActions) do
                if action.Type and action.Type == "UseSpell" and action.Spell then
                    -- Set spell ID to the real spell in case the scroll template was changed
                    spellId = GetTrueSpell(action.Spell)
                    break
                end
            end
        end
    end

    if spellId and characterGuid then
        -- Check if Revivify override setting is true
        if spellId == "Teleportation_Revivify" and GetSetting(characterGuid, "RevivifyScrollOverride") == true then
            return
        end

        local progression = GetCharacterProgression(characterGuid)

        if progression then
            local abilityData = GetAbilityCheckData(characterGuid, progression, spellId)

            -- Ability only returns if character can cast the spell
            if abilityData and abilityData.BestAbility then
                local spellStat = Ext.Stats.Get(spellId)

                if spellStat and spellStat.Level and item and item.ServerItem then
                    local itemObject = Ext.Stats.Get(item.ServerItem.Stats)

                    if itemObject then
                        -- Add character to table that tracks a queue of scroll casting
                        ScrollCastQueue[characterGuid] = {
                            Spell = spellId,
                            ScrollTemplate = item.ServerItem.Template.Id,
                            UseCosts = itemObject.UseCosts,
                            SpellLevel = spellStat.Level,
                            Ability = abilityData.BestAbility,
                            SkipCheck = abilityData.SkipCheck,
                            MartialModifier = abilityData.MartialModifier,
                            Processed = false
                        }
                    end
                end
            elseif GetSetting(characterGuid, "ClassRestriction") == true then
                -- Cancel previewing spell
                Osi.ApplyStatus(characterGuid, "TRUESCROLLS_FORBIDDEN", 0, 1)
                Osi.Freeze(characterGuid)
                SetTimer(100, UnfreezeCaster, characterGuid)
            end
        end
    end
end

---@param osiCharacterGuid string
---@param spellId string
function OnPreviewingSpell(osiCharacterGuid, spellId)
    local characterGuid = GetGuid(osiCharacterGuid)
    local characterName = GetDisplayName(osiCharacterGuid)

    if characterGuid then
        local statusName = "TRUESCROLLS_" .. characterGuid
        local spell = GetTrueSpell(spellId)

        if ScrollCastQueue and ScrollCastQueue[characterGuid] then
            if ScrollCastQueue[characterGuid].Spell == spell then
                -- Check if preview event is happening right after using a scroll
                if ScrollCastQueue[characterGuid].Processed == false then
                    Log("Started preview from scroll: %s", characterName)
                    ScrollCastQueue[characterGuid].Processed = true

                    if GetSetting(characterGuid, "StaticAttackRoll") == false then
                        return
                    end

                    local rollStatus = Ext.Stats.Get(statusName)
                    local spellLevel = ScrollCastQueue[characterGuid].SpellLevel or 0
                    local baseRollBonus = GetCharacterRollBonus(characterGuid) or 0
                    local configRollBonus = GetSetting(characterGuid, "StaticAttackRollBonus") or 0
                    local finalRollBonus = scrollRollBonus[spellLevel] - baseRollBonus + configRollBonus

                    -- Disable roll bonuses from passives and statuses
                    ModifyBoostBonuses(characterGuid, "Disable")

                    if rollStatus == nil then
                        -- Create a status unique for the character to support real time casting in co-op
                        rollStatus = Ext.Stats.Create(statusName, "StatusData", "TRUESCROLLS_CASTING")
                    end

                    -- Set a static attack roll bonus
                    rollStatus.Boosts = "RollBonus(MeleeSpellAttack," .. finalRollBonus .. ");RollBonus(RangedSpellAttack," .. finalRollBonus .. ")"

                    Ext.Stats.Sync(statusName)
                    Osi.ApplyStatus(characterGuid, statusName, -1, 1)
                else
                    Log("Casting the same spell without a scroll: %s", characterName)

                    ScrollCastQueue[characterGuid] = nil
                    ModifyBoostBonuses(characterGuid, "Enable")
                    Osi.RemoveStatus(characterGuid, statusName)
                end
            else
                Log("Casting another spell: %s", characterName)

                ScrollCastQueue[characterGuid] = nil
                ModifyBoostBonuses(characterGuid, "Enable")
                Osi.RemoveStatus(characterGuid, statusName)
            end
        elseif CharacterHasStatus(characterGuid, statusName) then
            Osi.RemoveStatus(characterGuid, statusName)
        end
    end
end

--- Consume action resource required for the spell
---@param characterGuid string
---@param resource string
function ConsumeActionResource(characterGuid, resource)
    -- This is jank, but it works
    -- ActionPoint, 1 = ActionPoint:1
    local consumeName, number = string.match(resource, "([^:]+):(%d+)")
    local consumeAmount = tonumber(number)
    local character = Ext.Entity.Get(characterGuid)

    if character and character.TurnBased and character.TurnBased.IsInCombat_M then
        local actionResources = character.ActionResources.Resources

        for resourceGuid, resourceTables in pairs(actionResources) do
            local resourceStat = Ext.StaticData.Get(resourceGuid, "ActionResource")

            for _, resourceData in ipairs(resourceTables) do
                if resourceStat and resourceStat.Name == consumeName then
                    if resourceData.Amount >= consumeAmount then
                        resourceData.Amount = resourceData.Amount - consumeAmount
                        character:Replicate("ActionResources")
                        break
                    end
                end
            end
        end
    end
end

--- Consume spell slot required for the spell
--- @param characterGuid string
--- @param spellId string
function ConsumeSpellSlot(characterGuid, spellId)
    local character = Ext.Entity.Get(characterGuid)
    local spell = Ext.Stats.Get(spellId)
    local spellSlotGuid = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"

    if character and character.ActionResources and spell and spell.Level then
        local resources = character.ActionResources.Resources

        for resourceGuid, resourceData in pairs(resources) do
            if resourceGuid == spellSlotGuid then
                for _, spellSlot in ipairs(resourceData) do
                    if spellSlot and spellSlot.Level and spellSlot.Level == spell.Level then
                        spellSlot.Amount = spellSlot.Amount - 1
                        break
                    end
                end
            end
        end

        character:Replicate("ActionResources")
    end
end

---@param osiCharacterGuid string
---@param spellId string
function OnUsingSpell(osiCharacterGuid, spellId)
    local characterGuid = GetGuid(osiCharacterGuid)

    if characterGuid and ScrollCastQueue and ScrollCastQueue[characterGuid] then
        if GetSetting(characterGuid, "CastRoll") == true then
            local castData = ScrollCastQueue[characterGuid]
            local spell = GetTrueSpell(spellId)

            if castData.Spell == spell and castData.SkipCheck == false then
                local configValue = GetSetting(characterGuid, "CastRollBonus") or 0
                local castDC = math.clamp(castData.SpellLevel + castData.MartialModifier + configValue, -9, 20)

                Osi.RequestPassiveRoll(characterGuid, characterGuid, "RawAbility", tostring(castData.Ability), scrollCastDC[castDC], 0, "TC_CastScrollCheck")
            end
        else
            ScrollCastQueue[characterGuid] = nil
        end
    end
end

function OnStoppedCasting(character)
    if character and character.Uuid and ScrollCastQueue then
        local characterGuid = character.Uuid.EntityUuid

        if ScrollCastQueue[characterGuid] then
            local statusName = "TRUESCROLLS_" .. characterGuid
            ScrollCastQueue[characterGuid] = nil
            ModifyBoostBonuses(characterGuid, "Enable")
            Osi.RemoveStatus(characterGuid, statusName)
        end
    end
end

--- Remove a learned spell from the character, since we can't prevent learning spells
---@param characterGuid string
---@param spellId string
function RemoveLearnedSpell(characterGuid, spellId)
    local found = false
    local character = Ext.Entity.Get(characterGuid)
    local characterName = GetDisplayName(characterGuid)

    if character and character.SpellContainer and character.SpellBookPrepares and character.SpellBook and character.LearnedSpells then
        local spellContainer = character.SpellContainer.Spells
        local spellPrepares = character.SpellBookPrepares.PreparedSpells
        local spellBook = character.SpellBook.Spells
        local learnedSpells = character.LearnedSpells

        for i, spell in ipairs(spellContainer) do
            if spell and spell.SpellId then
                if spell.SpellId.OriginatorPrototype == spellId then
                    character.SpellContainer.Spells[i] = nil
                    found = true
                end
            end
        end

        for i, spell in ipairs(spellPrepares) do
            if spell and spell.OriginatorPrototype then
                if spell.OriginatorPrototype == spellId then
                    character.SpellBookPrepares.PreparedSpells[i] = nil
                    found = true
                end
            end
        end

        for i, spell in ipairs(spellBook) do
            if spell and spell.Id then
                if spell.Id.OriginatorPrototype == spellId then
                    character.SpellBook.Spells[i] = nil
                    found = true
                end
            end
        end

        if learnedSpells.field_18 and learnedSpells.field_18[wizardClassGuid] then
            local spells = learnedSpells.field_18[wizardClassGuid]

            for value, spell in pairs(spells) do
                if spell == spellId then
                    character.LearnedSpells.field_18[wizardClassGuid][value] = false
                    character.LearnedSpells.field_18[wizardClassGuid][spell] = false
                    found = true
                end
            end

            character:Replicate("SpellContainer")
            character:Replicate("SpellBookPrepares")
            character:Replicate("SpellBook")
            character:Replicate("LearnedSpells")

            if found == true then
                -- Something somewhere readds the spells to components during processing, so we need to retry until it's gone
                RemoveLearnedSpell(characterGuid, spellId)
            else
                Log("Removed %s from %s", spellId, characterName)

                table.remove(ScrollLearning[characterGuid], 1)
                ProcessScrollLearning(characterGuid)
            end
        end
    end
end

--- Try to learn a spell from a scroll
---@param characterGuid string
---@param spellId string
function TryLearnSpell(characterGuid, spellId)
    if characterGuid and spellId then
        local spellStats = Ext.Stats.Get(spellId)
        local progression = GetCharacterProgression(characterGuid)
        local wizardTable = "d18eda7e-4b7d-490d-9952-cd33a3c60479"

        if spellStats and progression and progression[wizardTable] then
            local spellLevel = spellStats.Level or 0
            local configValue = GetSetting(characterGuid, "ScribeRollBonus") or 0
            local scribeDC = math.clamp(spellLevel + configValue, -9, 20)

            -- Check if wizard level is high enough to learn the spell, since the game doesn't check for it
            if GetSetting(characterGuid, "RequireWizardLevels") == true then
                local wizardLevel = progression[wizardTable].Level
                -- Wizard spell slots are gained every 2 levels
                local wizardSpellSlot = math.floor((wizardLevel + 1) / 2)

                if wizardSpellSlot < spellLevel and ScrollLearning and ScrollLearning[characterGuid] then
                    Log("Wizard level too low to copy %s", spellId)

                    RemoveLearnedSpell(characterGuid, ScrollLearning[characterGuid][1])
                    Osi.ApplyStatus(characterGuid, "TRUESCROLLS_WIZARDTOOLOW", 0, 1)
                    return
                end
            end

            Osi.RequestPassiveRoll(characterGuid, characterGuid, "SkillCheck", "Arcana", scrollCastDC[scribeDC], 0, "TC_LearnScrollCheck")
        end
    end
end

--- Process wizard spell learning queue, since bulk learning is possible
---@param characterGuid string
function ProcessScrollLearning(characterGuid)
    local characterName = GetDisplayName(characterGuid)

    if ScrollLearning[characterGuid] == nil or #ScrollLearning[characterGuid] == 0 then
        Log("Finished processing spell learning for %s", characterName)

        -- Restart processing if new spells were learned while the queue was being processed
        if ScrollLearningQueue[characterGuid] ~= nil then
            ScrollLearningQueue[characterGuid] = nil
            GatherNewLearnedSpells(characterGuid)
            Log("Restarting scroll learning queue for %s", characterName)
        end
    end

    TryLearnSpell(characterGuid, ScrollLearning[characterGuid][1])
end

--- Gather new spells learned by the wizard
---@param characterGuid string
function GatherNewLearnedSpells(characterGuid)
    local character = Ext.Entity.Get(characterGuid)

    if character and character.LearnedSpells then
        local learnedSpells = character.LearnedSpells

        if learnedSpells.field_18 and learnedSpells.field_18[wizardClassGuid] then
            local currentSpells = learnedSpells.field_18[wizardClassGuid]

            for _, spellId in pairs(currentSpells) do
                if LearnedSpells[characterGuid][spellId] == nil then
                    if ArrayContains(ScrollLearning[characterGuid], spellId) == false then
                        -- Only add spells that are not already in the queue
                        table.insert(ScrollLearning[characterGuid], spellId)
                    end
                end
            end

            ProcessScrollLearning(characterGuid)
        end
    end
end

function OnLearnedSpell(character)
    if character and character.Uuid then
        local characterGuid = character.Uuid.EntityUuid
        local characterName = GetDisplayName(characterGuid)

        if GetSetting(characterGuid, "ScribeRoll") == false then
            return
        end

        if LearnedSpells[characterGuid] == nil then
            LearnedSpells[characterGuid] = GetLearnedSpells(characterGuid)
            Log("Learned a spell, but wasn't initialized: %s", characterName)
            return
        end

        if ScrollLearning and ScrollLearning[characterGuid] == nil then
            ScrollLearning[characterGuid] = {}
        end

        -- Player learned more spells while the queue was being processed
        if #ScrollLearning[characterGuid] > 0 then
            ScrollLearningQueue[characterGuid] = true
            Log("Already being processed: %s", characterName)
            return
        end

        GatherNewLearnedSpells(characterGuid)
    end
end

---@param eventName string
---@param osiCharacterGuid string
---@param rollResult number
function OnRollResult(eventName, osiCharacterGuid, rollResult)
    local characterGuid = GetGuid(osiCharacterGuid)

    if characterGuid then
        if eventName == "TC_CastScrollCheck" and ScrollCastQueue and ScrollCastQueue[characterGuid] then
            if rollResult == 0 then
                -- Consume an action resource only if character is in turn-based mode
                ModifyBoostBonuses(characterGuid, "Enable")
                ConsumeActionResource(characterGuid, ScrollCastQueue[characterGuid].UseCosts)
                Osi.TemplateRemoveFromUser(ScrollCastQueue[characterGuid].ScrollTemplate, characterGuid, 1)
                Osi.Freeze(characterGuid)
                SetTimer(100, UnfreezeCaster, characterGuid)
            end

            ScrollCastQueue[characterGuid] = nil
        elseif eventName == "TC_LearnScrollCheck" and ScrollLearning and ScrollLearning[characterGuid] then
            if rollResult == 0 then
                RemoveLearnedSpell(characterGuid, ScrollLearning[characterGuid][1])
            else
                local spellId = ScrollLearning[characterGuid][1]
                LearnedSpells[characterGuid][spellId] = true

                table.remove(ScrollLearning[characterGuid], 1)
                ProcessScrollLearning(characterGuid)
            end
        elseif eventName == "TC_CraftScrollCheck" and ActiveScribing and ActiveScribing[characterGuid] then
            if rollResult == 1 then
                ProcessScribingProgress(characterGuid)
            else
                ActiveScribing[characterGuid].Processed = true
                TrySaveScribingProgress()
            end
        end
    end
end

--- Get wizard learned spells
---@param characterGuid string
function GetLearnedSpells(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local spellIds = {}

    if character and character.LearnedSpells then
        local learnedSpells = character.LearnedSpells

        if learnedSpells and learnedSpells.field_18 and learnedSpells.field_18[wizardClassGuid] then -- TODO field_18 will be deprecated!
            local spellTable = learnedSpells.field_18[wizardClassGuid]

            for _, spell in pairs(spellTable) do
                spellIds[spell] = true
            end
        end
    end

    return spellIds
end

--- Cache wizard learned spells when characters join party
---@param osiCharacterGuid string
function AddCharacterLearnedSpells(osiCharacterGuid)
    local characterGuid = GetGuid(osiCharacterGuid)

    if characterGuid and LearnedSpells and LearnedSpells[characterGuid] == nil then
        LearnedSpells[characterGuid] = GetLearnedSpells(characterGuid)
        Log("Updated learned spells for: %s", GetDisplayName(characterGuid))
    end
end

--- Recreate scroll items to fix spellbook and use action mismatch when updating root templates
function RecreateScrolls()
    local spellBookEntities = Ext.Entity.GetAllEntitiesWithComponent("SpellBook")
    local scrollStacks = {}

    for _, entity in pairs(spellBookEntities) do
        if entity and entity.UseAction and entity.Use and entity.Use.ItemUseType == "Scroll" then
            local useActions = entity.UseAction.UseActions
            local spells = entity.SpellBook.Spells
            local spellMatch = false
            local originatorMatch = false

            -- UseActions update correctly when templates are changed for existing item entities
            for _, action in ipairs(useActions) do
                if string.find(action.Spell, "TrueScrolls") then
                    spellMatch = true
                end
            end

            -- SpellBook component gets populated on item creation, so we need to recreate the item to update it
            for _, spell in ipairs(spells) do
                if string.find(spell.Id.OriginatorPrototype, "TrueScrolls") then
                    originatorMatch = true
                end
            end

            -- Only recreate items that have mismatched spellbook and use action
            if spellMatch ~= originatorMatch then
                if entity.InventoryMember and entity.GameObjectVisual and entity.Uuid then
                    local inventory = entity.InventoryMember.Inventory
                    local itemTemplate = entity.GameObjectVisual.RootTemplateId

                    if inventory.InventoryIsOwned then
                        local owner = inventory.InventoryIsOwned.Owner
                        local ownerGuid = owner.Uuid.EntityUuid
                        local stackAmount = Osi.GetStackAmount(entity.Uuid.EntityUuid)
                        local scrollData = {
                            Guid = ownerGuid,
                            Item = entity.Uuid.EntityUuid,
                            Template = itemTemplate,
                            Amount = stackAmount
                        }

                        table.insert(scrollStacks, scrollData)
                    end
                end
            end
        end
    end

    for _, data in ipairs(scrollStacks) do
        Osi.RequestDelete(data.Item)
    end

    -- Add new ones only after deleting to avoid stacking issues while deleting
    for _, data in ipairs(scrollStacks) do
        Osi.TemplateAddTo(data.Template, data.Guid, data.Amount)
    end
end

function OnGameplayStarted()
    -- Store all spells learned from scrolls for each character
    local learnedSpellsEntities = Ext.Entity.GetAllEntitiesWithComponent("LearnedSpells")

    for _, entity in pairs(learnedSpellsEntities) do
        if entity and entity.Uuid then
            local characterGuid = entity.Uuid.EntityUuid
            local learnedSpells = GetLearnedSpells(characterGuid)

            if learnedSpells then
                LearnedSpells[characterGuid] = learnedSpells
            end
        end
    end

    RecreateScrolls()
end

--- Failsafe to remove scroll casting status and reapply boosts when reset is clicked
---@param owner string
function ResetServerCharacter(owner)
    local resetScope = {}

    if owner == "Global" then
        resetScope = GetPartyMembers()
    else
        resetScope[owner] = true
    end

    for characterGuid, _ in pairs(resetScope) do
        local statusName = "TRUESCROLLS_" .. characterGuid
        ScrollCastQueue[characterGuid] = nil
        ModifyBoostBonuses(characterGuid, "Enable")
        Osi.RemoveStatus(characterGuid, statusName)
    end
end

--- Update party members and send data to clients
function UpdatePartyMembers()
    Ext.Vars.SyncModVariables()
    local partyMembers = GetPartyMembers()
    local thiefClassTable = "f6acc595-46b4-4d96-b7d5-6f33366fc2de"
    local artificerClassTable = "6b701f1f-c477-43f0-9afe-0e169f65fc7a"
    local wizardTable = "d18eda7e-4b7d-490d-9952-cd33a3c60479"
    local partyData = {}

    for characterGuid, _ in pairs(partyMembers) do
        local character = Ext.Entity.Get(characterGuid)
        local characterSpells = GetCharacterSpells(characterGuid)
        local progression = GetCharacterProgression(characterGuid)
        local isThief = false
        local isArtificer = false
        local isWizard = false
        local proficientArcana = false
        local sortedSpells = {}

        if GetSetting(characterGuid, "CraftingArcanaProficiency") == false then
            proficientArcana = true
        end

        for spellId, _ in pairs(characterSpells.SpellBook) do
            local spell = Ext.Stats.Get(spellId)

            -- Get every spell in character's spellbook
            if spell and spell.Level and spell.DisplayName then
                local spellData = {
                    Spell = spellId,
                    Name = Ext.Loca.GetTranslatedString(spell.DisplayName),
                    Level = spell.Level
                }

                -- Add to array for sorting
                table.insert(sortedSpells, spellData)
            else
                Log("%s is missing level!", spellId)
            end
        end

        -- Sort spells by level and name
        table.sort(sortedSpells, function(a, b)
            if a.Level ~= b.Level then
                return a.Level < b.Level
            else
                return a.Name < b.Name
            end
        end)

        characterSpells.SpellBook = {}

        for _, spellData in ipairs(sortedSpells) do
            table.insert(characterSpells.SpellBook, spellData.Spell)
        end

        -- Check if character is proficient in Arcana
        if proficientArcana == false and character and character.BoostsContainer then
            local boosts = character.BoostsContainer.Boosts

            for _, boost in ipairs(boosts) do
                if boost.Type == "ProficiencyBonus" then
                    local boostTable = boost.Boosts

                    for _, boostEntity in ipairs(boostTable) do
                        if boostEntity.ProficiencyBonusBoost.Skill == "Arcana" then
                            proficientArcana = true
                        end
                    end
                end
            end
        end

        if progression then
            if progression[thiefClassTable] then
                isThief = true
            end

            if progression[artificerClassTable] then
                isArtificer = true
            end

            if progression[wizardTable] then
                isWizard = true
            end
        end

        partyData[characterGuid] = {
            Proficient = proficientArcana,
            Spells = characterSpells,
            Thief = isThief,
            Artificer = isArtificer,
            Wizard = isWizard
        }
    end

    Ext.Net.BroadcastMessage("TrueScrolls_UpdatePartyMembers", Ext.Json.Stringify(partyData))
end

--- Check if character is in combat and update scribing progress
---@param characterGuid string
function OnEnteredCombat(characterGuid)
    if ActiveScribing[characterGuid] then
        local craftingRuleset = GetSetting(characterGuid, "CraftingRuleset")

        if craftingRuleset == "RulesetRAW" then
            ActiveScribing[characterGuid].SkipDay = true
            SavePersistence(true)
        elseif craftingRuleset == "RulesetSimplified" then
            ActiveScribing[characterGuid].ShortDay = true
            SavePersistence(true)
        end
    end
end

--- Try saving scribing progress after long rest
function TrySaveScribingProgress()
    for _, scribing in pairs(ActiveScribing) do
        if not scribing.Processed then
            return
        end
    end

    -- Enable inventory and gold events after all scribing progress is processed
    ScribingProcess = false
    SetTimer(100, CalculateScribingCost, true, true)
    SetTimer(100, UpdateSpellPreparedStatus, nil, true)
    SetTimer(100, SavePersistence)
end

--- Apply a random complication to the character
--- @param characterGuid string
function ApplyRandomComplication(characterGuid)
    local data = ActiveScribing[characterGuid]

    local complications = {
        [1] = function()
            -- Does literally nothing, just an icon
            Osi.ApplyStatus(characterGuid, "CAMP_DAISY_EXHAUSTED", 0, 1)
            SetTimer(1000, ApplyNewStatus, characterGuid, "TRUESCROLLS_COMPLICATION", 0)
        end,
        [2] = function()
            Osi.UseSpell(characterGuid, data.Spell, characterGuid)
            ConsumeSpellSlot(characterGuid, data.Spell)
            SetTimer(1000, ApplyNewStatus, characterGuid, "TRUESCROLLS_COMPLICATION", 0)
        end,
        [3] = function()
            local spellList = {}

            for spellId, spellData in pairs(ScrollsList) do
                if spellData.Level == data.Level then
                    table.insert(spellList, spellId)
                end
            end

            -- Changes the scribed spell to a random one of the same level without player's knowledge
            data.ComplicationScroll = spellList[math.random(1, #spellList)]

            SavePersistence()
        end
    }

    complications[math.random(1, 3)]()
end

--- Process scribing progress for the character
---@param characterGuid string
function ProcessScribingProgress(characterGuid)
    local partyMembers = GetPartyMembers()
    local data = ActiveScribing[characterGuid]
    local characterGold = Osi.GetGold(data.Character)
    local remainder
    local cost = data.Payment
    local progress = 1

    -- Only take gold when CumulativeProgress is 0 or > 1
    if data.SkipPayment == false then
        if characterGold < data.Payment then
            remainder = data.Payment - characterGold
            cost = characterGold
        end

        Osi.AddGold(data.Character, -cost)

        Log("Took %s gold from %s", cost, GetDisplayName(data.Character))

        -- Don't need additional checks if characters have gold
        -- We know they do from CalculateScribingCost
        if remainder ~= nil then
            for character, _ in pairs(partyMembers) do
                local gold = Osi.GetGold(character)

                if gold < remainder then
                    remainder = remainder - gold
                    Osi.AddGold(character, -gold)
                    Log("Took %s gold from %s", gold, GetDisplayName(character))
                else
                    Osi.AddGold(character, -remainder)
                    remainder = nil
                    Log("Took %s gold from %s", remainder, GetDisplayName(character))
                    break
                end
            end
        end

        data.Paid = data.Paid + data.Payment

        local wholeDays = math.floor(data.CumulativeProgress)

        -- Once full day is processed, remove it from CumulativeProgress
        if wholeDays > 0 then
            data.CumulativeProgress = data.CumulativeProgress - wholeDays
        end
    end

    if GetSetting(characterGuid, "CraftingRequireItems") == true then
        local items = GetCharacterScribeItems(characterGuid)

        if data.ScrollUsed == false then
            Osi.TemplateRemoveFromUser(items.Scroll.Guid, characterGuid, 1)
            data.ScrollUsed = true
        end

        -- Maybe I'll add more item qualities in the future with unique properties
        if items.Quill.Quality == "Basic" then
            local quillBreakChance = GetSetting(characterGuid, "CraftingQuillBreakChance")

            if math.random() <= quillBreakChance then
                Osi.TemplateRemoveFromUser(items.Quill.Guid, characterGuid, 1)
            end
        end

        if items.Ink.Quality == "Basic" then
            Osi.TemplateRemoveFromUser(items.Ink.Guid, characterGuid, 1)
        end
    end

    -- RulesetLightActivity setting allows to scribe for 2h during long rest
    if data.ShortDay == true then
        progress = 0.25
    end

    data.CumulativeProgress = data.CumulativeProgress + progress
    data.ElapsedTime = data.ElapsedTime + progress
    data.CanAfford = false
    data.SkipDay = false
    data.ShortDay = false
    data.HasItems = false
    data.CurrentItems = GetCharacterScribeItems()
    data.ComplicationCount = 0
    data.Processed = true

    -- Roll for a complication every workweek of scribing
    if data.ElapsedTime % 5 == 0 and GetSetting(characterGuid, "CraftingComplications") == true then
        local chance = GetSetting(characterGuid, "CraftingComplicationChance")

        if math.random() <= chance then
            SetTimer(1000, ApplyRandomComplication, characterGuid)
        end
    end

    if data.ElapsedTime >= data.Time then
        local spellId = data.Spell

        if data.ComplicationScroll ~= nil then
            spellId = data.ComplicationScroll
            SetTimer(1000, ApplyNewStatus, characterGuid, "TRUESCROLLS_COMPLICATION", 0)
        end

        if ScrollsList[spellId] then
            Osi.TemplateAddTo(ScrollsList[spellId].Template, characterGuid, 1)

            ActiveScribing[characterGuid] = nil
        end
    end

    -- Osi.RequestPassiveRoll is very slow, so we only save progress after all characters are processed
    TrySaveScribingProgress()
end

function OnLongRestFinished()
    -- Prevents inventory and gold events triggering recalculation while processing costs
    ScribingProcess = true
    CalculateScribingCost(true, true)

    for characterGuid, data in pairs(ActiveScribing) do
        data.Processed = false

        if data.CanAfford == true and data.SkipDay == false and data.HasItems == true then
            if GetSetting(characterGuid, "CraftingArcanaCheck") == true then
                local configValue = GetSetting(characterGuid, "CraftingCheckBonus") or 0
                local craftDC = math.clamp(data.Level + configValue, -9, 20)

                Osi.RequestPassiveRoll(characterGuid, characterGuid, "SkillCheck", "Arcana", scrollCastDC[craftDC], 0, "TC_CraftScrollCheck")
            else
                ProcessScribingProgress(characterGuid)
            end
        else
            data.ComplicationCount = data.ComplicationCount + 1

            -- Apply a random complication if character has failed to scribe for twice the scribing time
            if data.ComplicationCount >= data.Time * 2 and GetSetting(characterGuid, "CraftingComplications") == true then
                SetTimer(1000, ApplyRandomComplication, characterGuid)
                data.ComplicationCount = 0
            end

            data.SkipDay = false
            data.ShortDay = false
        end
    end

    if next(ActiveScribing) == nil then
        SavePersistence()
    end
end

--- Calculate the cost of scribing spells for each character in the party
---@param skipNotification? boolean
---@param skipUpdate? boolean
function CalculateScribingCost(skipNotification, skipUpdate)
    skipNotification = skipNotification or false
    local partyMembers = GetPartyMembers()
    local cachedScribing = DeepCopy(ActiveScribing)
    local individualCost = {}
    local totalGold = 0
    local dirty = false

    for characterGuid, _ in pairs(partyMembers) do
        totalGold = totalGold + Osi.GetGold(characterGuid)
    end

    for characterGuid, data in pairs(cachedScribing) do
        local progress = cachedScribing[characterGuid].CumulativeProgress
        ActiveScribing[characterGuid].CanAfford = false
        ActiveScribing[characterGuid].HasItems = false
        ActiveScribing[characterGuid].SkipPayment = false

        -- Cost is only calculated for each full day of scribing
        -- Short day adds 0.25 to CumulativeProgress, so we skip the calculation below 1
        if cachedScribing[characterGuid].Paused == false and (progress >= 1 or progress == 0) then
            local payment = data.Cost.BasePayment

            -- Last day gets the remainder added to the cost for unevenly split payments
            if data.Time - data.ElapsedTime == 1 then
                payment = payment + data.Cost.Remainder
            end

            -- Add each cost to array for sorting
            table.insert(individualCost, {
                Character = characterGuid,
                Payment = payment
            })

            if GetSetting(characterGuid, "CraftingRequireItems") == true then
                local items = GetCharacterScribeItems(characterGuid)
                local hasItems = true

                for type, item in pairs(items) do
                    -- Scroll item is only used once per scribing process
                    if item.Quality == "None" and (type ~= "Scroll" or data.ScrollUsed == false) then
                        hasItems = false
                    end
                    
                    if data.CurrentItems[type] and item.Quality ~= data.CurrentItems[type] then
                        dirty = true
                    end
                end

                ActiveScribing[characterGuid].HasItems = hasItems
                ActiveScribing[characterGuid].CurrentItems = items
            else
                ActiveScribing[characterGuid].HasItems = true
            end
        elseif progress < 1 then
            ActiveScribing[characterGuid].CanAfford = true
            ActiveScribing[characterGuid].HasItems = true
            ActiveScribing[characterGuid].SkipPayment = true
        end
    end

    table.sort(individualCost, function(a, b)
        return a.Payment < b.Payment
    end)

    for _, data in ipairs(individualCost) do
        local characterGold = Osi.GetGold(data.Character)
        local canAfford = false

        if characterGold >= data.Payment then
            canAfford = true
            totalGold = totalGold - data.Payment
        elseif GetSetting(data.Character, "CraftingSharedGold") == true and totalGold >= data.Payment then
            canAfford = true
            totalGold = totalGold - data.Payment
        end

        -- Show notification if a status has changed
        if cachedScribing[data.Character].CanAfford ~= canAfford or cachedScribing[data.Character].Payment ~= data.Payment then
            dirty = true
        end

        ActiveScribing[data.Character].CanAfford = canAfford
        ActiveScribing[data.Character].Payment = data.Payment
    end

    SavePersistence(dirty and not skipNotification, skipUpdate)
end

--- Pause or resume scribing process for the given character
---@param characterGuid string
function TogglePauseScribing(characterGuid)
    if ActiveScribing[characterGuid] then
        ActiveScribing[characterGuid].Paused = not ActiveScribing[characterGuid].Paused
        CalculateScribingCost(true)
    end
end

--- Cancel scribing process for the given character
--- @param characterGuid string
function CancelScribing(characterGuid)
    if ActiveScribing[characterGuid] then
        ActiveScribing[characterGuid] = nil
        SavePersistence()
    end
end

--- Start scribing process with the given data
---@param scribeData table
function StartScribing(scribeData)
    if scribeData == nil then
        return
    end

    ActiveScribing[scribeData.Character] = scribeData
    CalculateScribingCost(true)
end

--- Update scribing data with new values from client after scribing settings change
---@param scribeData table
function UpdateScribedSpells(scribeData)
    for characterGuid, data in pairs(ActiveScribing) do
        local newData = scribeData[characterGuid]

        if newData then
            ActiveScribing[characterGuid].Time = newData.Time
            ActiveScribing[characterGuid].Cost = newData.Cost
        end
    end

    SavePersistence()
end

--- Check if scribed spell is prepared and update the status
---@alias RestType "ShortRest" | "LongRest"
---@param restType? RestType
---@param skipUpdate? boolean
function UpdateSpellPreparedStatus(restType, skipUpdate)
    local dirty = false

    for characterGuid, data in pairs(ActiveScribing) do
        local character = Ext.Entity.Get(characterGuid)
        local characterSpells = GetCharacterSpells(characterGuid)
        local cachedPrepared = data.Prepared
        local cachedSkipDay = data.SkipDay
        local cachedShortDay = data.ShortDay
        local preparedSetting = GetSetting(characterGuid, "CraftingSpellPrepared")

        if characterSpells.PreparedSpells[data.Spell] or preparedSetting == "PreparedDisabled" then
            data.Prepared = true
        else
            data.Prepared = false
        end

        -- Skip the day if the spell is not prepared and prepared setting isn't disabled
        if data.Prepared == false and (preparedSetting == "PreparedShortRest" or (restType == "LongRest" and preparedSetting == "PreparedLongRest")) then
            data.SkipDay = true
        end

        if restType == "ShortRest" and character and character.CampPresence == nil then
            local craftingRuleset = GetSetting(characterGuid, "CraftingRuleset")

            if craftingRuleset == "RulesetRAW" then
                data.SkipDay = true
            elseif craftingRuleset == "RulesetSimplified" then
                data.ShortDay = true
            end
        end

        -- Show notification if a status has changed
        if cachedPrepared ~= data.Prepared or cachedSkipDay ~= data.SkipDay or cachedShortDay ~= data.ShortDay then
            dirty = true
        end
    end

    SavePersistence(dirty, skipUpdate)
end

function OnShortRested(osiGuid)
    local host = Osi.GetHostCharacter()

    -- Triggers for every character in the party, but we only need to update once
    if host and host == GetGuid(osiGuid) then
        UpdateSpellPreparedStatus("ShortRest")
    end
end

function OnEndDayStateChanged(entity)
    if entity and entity.CampEndTheDayState then
        local newState

        -- 2 = Long rest started, 4 = Long rest finished
        if entity.CampEndTheDayState.State == 2 then
            newState = true
        elseif entity.CampEndTheDayState.State == 4 then
            newState = false
        end

        if newState == false then
            OnLongRestFinished()
        elseif newState == true then
            UpdateSpellPreparedStatus("LongRest")
        end

        if newState ~= nil then
            local function DelayMessage()
                Ext.Net.BroadcastMessage("TrueScrolls_ClientEndDayStateChanged", Ext.Json.Stringify({
                    State = newState
                }))
            end

            -- Delay a bit while the game is loading to show notification
            SetTimer(3000, DelayMessage)
        end
    end
end

--- Recalculate scribing when inventory is updated with templates that match scribing items
--- @param characterGuid string
--- @param fullTemplate string
function InventoryUpdated(characterGuid, fullTemplate)
    if ScribingProcess == false and ActiveScribing[characterGuid] and GetSetting(characterGuid, "CraftingRequireItems") == true then
        for _, itemList in pairs(ScribingItemTypes) do
            for _, templateId in pairs(itemList) do
                if string.sub(fullTemplate, -#templateId) == templateId then
                    CalculateScribingCost()
                    return
                end
            end
        end
    end
end

function OnSessionLoaded()
    InitializeGameplayTables()
    InitializeSpellLists()
    LoadBackupConfig()
    LoadPersistence()
    ScribingProcess = false

    Log("SESSION LOADED - SERVER")
end