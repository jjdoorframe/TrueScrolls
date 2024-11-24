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

--- Get character classes, subclasses and spellcasting abilities
---@param characterGuid string
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

        if abilityData.BestAbility == nil and (GetSetting(characterGuid, "ClassRestriction") == false or GetSetting(characterGuid, "ThiefCanCast") == true) then
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

---@param spellId string
function GetTrueSpell(spellId)
    if string.find(spellId, "Scroll") then
        local spellStat = Ext.Stats.Get(spellId)
        return spellStat.Using
    else
        return spellId
    end
end

function GetSetting(owner, settingName)
    local config = Ext.Vars.GetModVariables(ModuleUUID).ModConfig
    local value = nil

    if config ~= nil then
        if config[owner] and config[owner].OverrideGlobals == true and config[owner][settingName] ~= nil then
            value = config[owner][settingName]
        elseif config.Global ~= nil and config.Global[settingName] ~= nil then
            value = config.Global[settingName]
        else
            value = config.Defaults[settingName]
        end
    end

    return value
end

function GetPartyMembers()
    local party = Osi.DB_PartyMembers:Get(nil)
    local partyMembers = {}

    if party then
        for _, member in pairs(party) do
            local characterGuid = GetGuid(member[1])
            local character = Ext.Entity.Get(characterGuid)

            if character and character.IsSummon == nil then
                partyMembers[characterGuid] = true
            end
        end
    end

    return partyMembers
end

function math.clamp(value, min, max)
    return math.max(min, math.min(value, max))
end