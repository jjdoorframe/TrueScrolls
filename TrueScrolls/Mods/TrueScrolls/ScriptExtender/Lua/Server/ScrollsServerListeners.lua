Ext.Osiris.RegisterListener("UseFinished", 3, "after", function(characterGuid, itemGuid, state)
    OnItemUsed(characterGuid, itemGuid, state)
end)

Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", function(characterGuid, spellId, isMostPowerful, isUpcastable)
    OnPreviewingSpell(characterGuid, spellId)
end)

Ext.Osiris.RegisterListener("UsingSpell", 5, "before", function(characterGuid, spellId, spellType, spellElement, story)
    OnUsingSpell(characterGuid, spellId)
end)

Ext.Osiris.RegisterListener("RollResult", 6, "after", function(eventName, rollerGuid, subjectGuid, rollResult, isActive, criticality)
    OnRollResult(eventName, rollerGuid, rollResult)
end)

Ext.Osiris.RegisterListener("CharacterLeftParty", 1, "after", function(characterGuid)
    UpdatePartyMembers()
end)

Ext.Osiris.RegisterListener("ShortRested", 1, "after", function(character)
    OnShortRested(character)
end)

Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function(characterGuid)
    UpdatePartyMembers()
end)

Ext.Osiris.RegisterListener("GoldChanged", 2, "after", function(inventoryHolder, changeAmount)
    if ScribingProcess == false then
        CalculateScribingCost()
    end
end)

Ext.Osiris.RegisterListener("TemplateRemovedFrom", 3, "after", function(objectTemplate, object2, inventoryHolder)
    local characterGuid = GetGuid(inventoryHolder)

    InventoryUpdated(characterGuid, objectTemplate)
end)

Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", function(objectTemplate, object2, inventoryHolder, addType)
    local characterGuid = GetGuid(inventoryHolder)

    InventoryUpdated(characterGuid, objectTemplate)
end)

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(characterGuid)
    AddCharacterLearnedSpells(characterGuid)
    UpdatePartyMembers()
end)

Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(characterGuid)
    AddCharacterLearnedSpells(characterGuid)

    if DebuggingEnabled == true then
        UpdatePartyMembers()
    end
end)

function RegisterServerEntityListeners()
    Ext.Entity.OnDestroy("SpellCastIsCasting", function(entity)
        OnStoppedCasting(entity)
    end)

    Ext.Entity.OnChange("LearnedSpells", function(entity)
        OnLearnedSpell(entity)
    end)

    Ext.Entity.OnChange("CampEndTheDayState", function(entity)
        OnEndDayStateChanged(entity)
    end)

    Ext.Entity.OnChange("SpellBookPrepares", function(character)
        if character.Uuid ~= nil and GetSetting(character.Uuid.EntityUuid, "CraftingSpellPrepared") ~= "PreparedDisabled" then
            UpdateSpellPreparedStatus()
        end
    end)
end

Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", function(object, combatGuid)
    OnEnteredCombat(GetGuid(object))
end)

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(levelName, isEditor)
    OnGameplayStarted()
    UpdatePartyMembers()
end)

Ext.RegisterNetListener("TrueScrolls_SpellSaveSettingChanged", function(call, payload)
    local clientSpells = Ext.Json.Parse(payload)
    SetTimer(100, UpdateScrollSpells, clientSpells)
end)

Ext.RegisterNetListener("TrueScrolls_RequestPartyUpdate", function(call, payload)
    UpdatePartyMembers()
end)

Ext.RegisterNetListener("TrueScrolls_RequestResetCharacter", function(call, payload)
    ResetServerCharacter(payload)
end)

Ext.RegisterNetListener("TrueScrolls_ScrollsListUpdated", function(call, payload)
    local scrolls = Ext.Json.Parse(payload)

    if scrolls ~= nil then
        ScrollsList = scrolls
    end
end)

Ext.RegisterNetListener("TrueScrolls_CancelScribeClicked", function(call, payload)
    CancelScribing(payload)
end)

Ext.RegisterNetListener("TrueScrolls_PauseScribeClicked", function(call, payload)
    TogglePauseScribing(payload)
end)

Ext.RegisterNetListener("TrueScrolls_ProcessScribingStarted", function(call, payload)
    local scribeData = Ext.Json.Parse(payload)
    StartScribing(scribeData)
end)

Ext.RegisterNetListener("TrueScrolls_UpdateScribeData", function(call, payload)
    local scribeData = Ext.Json.Parse(payload)
    UpdateScribedSpells(scribeData)
end)

Ext.RegisterNetListener("TrueScrolls_CalculateScribingCost", function(call, payload)
    CalculateScribingCost()
end)

Ext.Events.SessionLoaded:Subscribe(function()
    OnSessionLoaded()
    RegisterServerEntityListeners()
end)