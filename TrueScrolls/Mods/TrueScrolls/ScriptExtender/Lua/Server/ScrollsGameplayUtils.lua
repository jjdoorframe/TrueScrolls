function InitializeGameplayTables()
    if ScrollCastQueue == nil then
        ScrollCastQueue = {}
    end

    if ScrollLearning == nil then
        ScrollLearning = {}
    end

    if LearnedSpells == nil then
        LearnedSpells = {}
    end

    if ActiveScrollCasters == nil then
        ActiveScrollCasters = {}
    end

    if ScrollLearningQueue == nil then
        ScrollLearningQueue = {}
    end
end

ScribingItemTypes = {
    Scroll = {
        Basic = "70df8a39-bf38-48bd-83a9-ae42116ca3ca"
    },
    Quill = {
        Basic = "4e0647d7-baec-46c2-bca2-86596ecbf1ed"
    },
    Ink = {
        Basic = "98f13cd0-0069-466f-bb6e-5b8964b46e66"
    }
}

--- Get character classes, subclasses and spellcasting abilities
---@param characterGuid string
---@return table | nil
function GetCharacterProgression(characterGuid)
    local emptyClassGuid = "00000000-0000-0000-0000-000000000000"
    local character = Ext.Entity.Get(characterGuid)
    local classesTable = {}
    local progressionTable = nil

    if character and character.Classes and character.Classes.Classes then
        local characterClassesData = character.Classes.Classes

        for _, classData in ipairs(characterClassesData) do
            if classData.ClassUUID ~= emptyClassGuid then
                local classDescription = Ext.StaticData.Get(classData.ClassUUID, "ClassDescription")

                if classDescription then
                    classesTable[classData.ClassUUID] = {
                        Level = classData.Level,
                        Ability = classDescription.SpellCastingAbility
                    }
                end
            end

            if classData.SubClassUUID ~= emptyClassGuid then
                local classDescription = Ext.StaticData.Get(classData.ClassUUID, "ClassDescription")

                if classDescription then
                    classesTable[classData.SubClassUUID] = {
                        Level = classData.Level,
                        Ability = classDescription.SpellCastingAbility
                    }
                end
            end
        end
    end

    for classUuid, classData in pairs(classesTable) do
        local classStaticData = Ext.StaticData.Get(classUuid, "ClassDescription")

        if classStaticData and classStaticData.ProgressionTableUUID then
            local progressionTableUuid = classStaticData.ProgressionTableUUID

            if progressionTable == nil then
                progressionTable = {}
            end

            progressionTable[progressionTableUuid] = {
                Level = classData.Level,
                Ability = classData.Ability
            }
        end
    end

    return progressionTable
end

--- Get all character ability values
---@param characterGuid string
---@return table | nil
function GetCharacterAbilities(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local abilities = nil

    if character and character.Stats and character.Stats.Abilities then
        local stats = character.Stats.Abilities

        abilities = {
            Strength = stats[2],
            Dexterity = stats[3],
            Constitution = stats[4],
            Intelligence = stats[5],
            Wisdom = stats[6],
            Charisma = stats[7]
        }
    end

    return abilities
end

--- Get highest spell slot level of a character
--- @param characterGuid string
--- @return integer
function GetHighestSpellSlot(characterGuid)
    local spellSlotGuid = "d136c5d9-0ff0-43da-acce-a74a07f8d6bf"
    local character = Ext.Entity.Get(characterGuid)
    local highestLevel = 0

    if character and character.ActionResources then
        local resources = character.ActionResources.Resources

        for resourceGuid, resourceData in pairs(resources) do
            if resourceGuid == spellSlotGuid then
                for _, spellSlot in ipairs(resourceData) do
                    if spellSlot and spellSlot.Level and highestLevel < spellSlot.Level then
                        highestLevel = spellSlot.Level
                    end
                end
            end
        end
    end

    return highestLevel
end

--- Get casting ability required for the spell
---@param characterGuid string
---@param classesTable table
---@param spellId string
---@return table
function GetAbilityCheckData(characterGuid, classesTable, spellId)
    local thiefClassTable = "f6acc595-46b4-4d96-b7d5-6f33366fc2de"
    local artificerClassTable = "6b701f1f-c477-43f0-9afe-0e169f65fc7a"
    local bardClassTable = "229c98da-2cd1-4a5e-8051-9d90ec7931e7"
    local loreClassTable = "36e6ea13-317e-4e6e-ac63-fe6d50e9f014"
    local classCastingSetting = GetSetting(characterGuid, "ClassCasting")
    local spellStats = Ext.Stats.Get(spellId)
    local spellLevel = 0
    local characterAbilities = GetCharacterAbilities(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local characterSpellSlotLevel = GetHighestSpellSlot(characterGuid)
    local abilityData = {
        BestAbility = nil,
        SkipCheck = false,
        MartialModifier = 0,
        IsThief = false,
        IsArtificer = false
    }

    if spellStats and spellStats.Level then
        spellLevel = spellStats.Level
    end

    if ClassSpells and classesTable and spellId and characterAbilities and character and classCastingSetting ~= nil then
        for class, classData in pairs(classesTable) do
            if ClassSpells[class] and ClassSpells[class][spellId] then
                local lowestSpellLevel = ClassSpells[class][spellId]
                local casterLevel = classData.Level

                local currentAbility = classData.Ability

                if abilityData.BestAbility == nil or characterAbilities[abilityData.BestAbility] < characterAbilities[currentAbility] then
                    abilityData.BestAbility = currentAbility
                end

                if classCastingSetting == false then
                    lowestSpellLevel = spellLevel
                    casterLevel = characterSpellSlotLevel
                end

                if lowestSpellLevel <= casterLevel then
                    abilityData.SkipCheck = true
                end
            end

            -- Find bard spells selected as magical secrets
            if (class == bardClassTable and classData.Level >= 10) or (class == loreClassTable and classData.Level >= 6) then
                if character.SpellBook then
                    local spellBook = character.SpellBook.Spells

                    for _, spell in ipairs(spellBook) do
                        if spell and spell.Id and spell.Id.OriginatorPrototype == spellId then
                            abilityData.BestAbility = "Charisma"
                            abilityData.SkipCheck = true
                        end
                    end
                end
            end

            if class == thiefClassTable and classData.Level >= 13 then
                abilityData.IsThief = true
            end

            if class == artificerClassTable and classData.Level >= 14 then
                abilityData.IsArtificer = true
            end
        end

        if abilityData.IsArtificer then
            if GetSetting(characterGuid, "ArtificerRequireRoll") == false then
                abilityData.SkipCheck = true
            end

            if abilityData.BestAbility == nil then
                abilityData.BestAbility = "Intelligence"
            end
        end

        if abilityData.BestAbility == nil and (GetSetting(characterGuid, "ClassRestriction") == false or (abilityData.IsThief == true and GetSetting(characterGuid, "ThiefCanCast") == true)) then
            abilityData.BestAbility = GetCharacterCastingAbility(characterGuid)

            if abilityData.BestAbility == "None" then
                abilityData.BestAbility = "Intelligence"
                abilityData.MartialModifier = math.floor((characterAbilities.Intelligence - 10) / 2)
            end
        end
    end

    return abilityData
end

--- Get casting ability that's used for roll bonuses
---@param characterGuid string
---@return string | nil
function GetCharacterCastingAbility(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local castingAbility = nil

    if character and character.Classes then
        local classes = character.Classes.Classes
        local classData = Ext.StaticData.Get(classes[#classes].ClassUUID, "ClassDescription")

        if classData then
            castingAbility = classData.SpellCastingAbility
        end
    end

    return castingAbility
end

--- Get character static attack roll bonus
---@param characterGuid string
---@return integer | nil
function GetCharacterRollBonus(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local abilities = GetCharacterAbilities(characterGuid)
    local castingAbility = GetCharacterCastingAbility(characterGuid)
    local totalRollBonus = nil

    if character and character.Stats and abilities and castingAbility and castingAbility ~= "None" then
        local castingModifier = math.floor((abilities[castingAbility] - 10) / 2)
        local proficiencyBonus = character.Stats.ProficiencyBonus

        totalRollBonus = castingModifier + proficiencyBonus
    end

    return totalRollBonus
end

--- Restore character control after cancelling spell
---@param characterGuid string
function UnfreezeCaster(characterGuid)
    if characterGuid ~= nil then
        Osi.Unfreeze(characterGuid)
    end
end

---@param characterGuid string
---@param statusIn string
---@return boolean
function CharacterHasStatus(characterGuid, statusIn)
    local entity = Ext.Entity.Get(characterGuid)

    if entity and entity.StatusContainer and entity.StatusContainer.Statuses then
        local entityStatuses = entity.StatusContainer.Statuses

        for _, statusId in pairs(entityStatuses) do
            if statusId == statusIn then
                return true
            end
        end
    end

    return false
end

---@param owner string
---@param settingName string
function GetSetting(owner, settingName)
    if BackupConfig == nil then
        LoadBackupConfig()
    end

    if BackupConfig.OverrideGlobals == true then
        return BackupConfig[settingName]
    end

    Ext.Vars.SyncModVariables()
    local config = Ext.Vars.GetModVariables(ModuleUUID).ModConfig
    local value = nil

    if config ~= nil then
        if config[owner] and config[owner].OverrideGlobals == true and config[owner][settingName] ~= nil then
            value = config[owner][settingName]
        elseif config.Global ~= nil and config.Global[settingName] ~= nil then
            value = config.Global[settingName]
        end
    end

    if value == nil then
        value = ConfigDefaults[settingName]
    end

    return value
end

function GetPartyMembers()
    local party = Osi.DB_PartyMembers:Get(nil)
    local partyMembers = {}

    if party then
        for _, member in pairs(party) do
            local characterGuid = GetGuid(tostring(member[1]))
            local character = Ext.Entity.Get(characterGuid)

            if character and character.IsSummon == nil then
                partyMembers[characterGuid] = true
            end
        end
    end

    return partyMembers
end

---@param value number
---@param min number
---@param max number
function math.clamp(value, min, max)
    return math.max(min, math.min(value, max))
end

--- Get character spells and prepared spells
---@param characterGuid string
function GetCharacterSpells(characterGuid)
    local character = Ext.Entity.Get(characterGuid)
    local spells = {
        SpellBook = {},
        PreparedSpells = {}
    }

    if character and character.SpellBook and character.SpellBookPrepares and ScrollsList then
        local spellPrepares = character.SpellBookPrepares.PreparedSpells
        local spellBook = character.SpellBook.Spells

        for _, spell in ipairs(spellBook) do
            if spell and spell.Id then
                local spellId = spell.Id.OriginatorPrototype

                if ScrollsList[spellId] ~= nil then
                    spells.SpellBook[spellId] = true
                end
            end
        end

        for _, spell in ipairs(spellPrepares) do
            if spell and spell.OriginatorPrototype then
                local spellId = spell.OriginatorPrototype

                if ScrollsList[spellId] ~= nil then
                    spells.PreparedSpells[spellId] = true
                end
            end
        end

        -- PreparedDisabled allows to scribe spells without preparing them
        if GetSetting(characterGuid, "CraftingSpellPrepared") == "PreparedDisabled" then
            spells.PreparedSpells = spells.SpellBook
        end
    end

    return spells
end

---@param entityGuid string
function GetTemplate(entityGuid)
    local entity = Ext.Entity.Get(entityGuid)
    local template = nil

    if entity and entity.Template then
        template = entity.Template.Id
    end

    return template
end

--- Check what scribing items character has in inventory
---@param characterGuid? string
function GetCharacterScribeItems(characterGuid)
    local items = {
        Scroll = {
            Quality = "None",
            Guid = nil
        },
        Quill = {
            Quality = "None",
            Guid = nil
        },
        Ink = {
            Quality = "None",
            Guid = nil
        }
    }

    if characterGuid == nil then
        return items
    end

    for type, itemList in pairs(ScribingItemTypes) do
        for quality, templateId in pairs(itemList) do
            if Osi.TemplateIsInInventory(templateId, characterGuid) > 0 then
                if items[type].Quality == "None" or items[type].Quality == "Basic" then
                    items[type].Quality = quality
                    items[type].Guid = templateId
                end
            end
        end
    end

    return items
end

---@param characterGuid string
---@param status string
---@param duration integer
function ApplyNewStatus(characterGuid, status, duration)
    Osi.ApplyStatus(characterGuid, status, duration, 1)
end

function LoadPersistence()
    local modVars = Ext.Vars.GetModVariables(ModuleUUID)

    if modVars then
        if modVars.ActiveScribing then
            ActiveScribing = modVars.ActiveScribing
            Log("PERSISTENCE: Active scribing loaded")
        else
            ActiveScribing = {}
            Log("PERSISTENCE: Initializing active scribing")
        end
    else
        ActiveScribing = {}
        Log("PERSISTENCE: Failed to load modvar")
    end
end

---@param sendNotification? boolean
---@param skipUpdate? boolean
function SavePersistence(sendNotification, skipUpdate)
    if ActiveScribing then
        Ext.Vars.GetModVariables(ModuleUUID).ActiveScribing = ActiveScribing
        Ext.Vars.SyncModVariables()

        if skipUpdate ~= true then
            SetTimer(50, UpdatePartyMembers)
        end

        if sendNotification == true then
            Ext.Net.BroadcastMessage("TrueScrolls_ClientShowScribeWindow", "")
        end

        Log("PERSISTENCE: Active scribing saved")
    else
        Log("PERSISTENCE: Failed to save active scribing")
    end
end
