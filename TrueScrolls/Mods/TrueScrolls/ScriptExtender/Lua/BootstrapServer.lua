Ext.Require("Shared/ScrollsModUtils.lua")
Ext.Require("Server/ScrollsGameplayUtils.lua")
Ext.Require("Shared/ScrollsTemplateOverrides.lua")
Ext.Require("Server/ScrollsListeners.lua")
Ext.Require("Server/ScrollsController.lua")

-- Requires DebuggingEnabled in DarknessUtils.lua
Ext.Events.ResetCompleted:Subscribe(ReloadStats)

Ext.Vars.RegisterModVariable(ModuleUUID, "ModConfig", {
    Server = true,
    Client = true,
    WriteableOnServer = false,
    WriteableOnClient = true,
    SyncToServer = true
})