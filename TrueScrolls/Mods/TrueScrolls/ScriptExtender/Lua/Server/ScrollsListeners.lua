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

function RegisterEntityListeners()
    Ext.Entity.OnDestroy("SpellCastIsCasting", function(entity)
        OnStoppedCasting(entity)
    end)

    Ext.Entity.OnChange("LearnedSpells", function(entity)
        OnLearnedSpell(entity)
    end)
end

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(levelName, isEditor)
    OnGameplayStarted(levelName)
    UpdatePartyMembers()
end)

Ext.RegisterNetListener("SpellSaveSettingChanged", function(call, payload)
    local clientSpells = Ext.Json.Parse(payload)
    SetTimer(100, UpdateScrollSpells, clientSpells)
end)

Ext.RegisterNetListener("RequestPartyUpdate", function(call, payload)
    UpdatePartyMembers()
end)

Ext.RegisterNetListener("RequestResetCharacter", function(call, payload)
    local owner = Ext.Json.Parse(payload)
    ResetServerCharacter(owner)
end)

Ext.Events.SessionLoaded:Subscribe(function()
    OnSessionLoaded()
    RegisterEntityListeners()
end)
