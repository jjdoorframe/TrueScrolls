Ext.Require("Shared/ScrollsModUtils.lua")
Ext.Require("Server/ScrollsGameplayUtils.lua")
Ext.Require("Shared/ScrollsTemplateOverrides.lua")
Ext.Require("Server/ScrollsServerListeners.lua")
Ext.Require("Server/ScrollsController.lua")

-- Requires DebuggingEnabled in DarknessUtils.lua
Ext.Events.ResetCompleted:Subscribe(ReloadStats)

Ext.Vars.RegisterModVariable(ModuleUUID, "ModConfig", {
    Server = true,
    Client = true,
    WriteableOnServer = true,
    WriteableOnClient = true,
    SyncToServer = true,
    SyncToClient = true
})

Ext.Vars.RegisterModVariable(ModuleUUID, "ActiveScribing", {
    Server = true,
    Client = true,
    WriteableOnServer = true,
    SyncToServer = true,
    SyncToClient = true
})