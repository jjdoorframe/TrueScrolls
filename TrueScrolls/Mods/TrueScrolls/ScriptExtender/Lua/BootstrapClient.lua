Ext.Require("Shared/ScrollsModUtils.lua")
Ext.Require("Shared/ScrollsTemplateOverrides.lua")
Ext.Require("Client/ScrollsConfigurationMenu.lua")
Ext.Require("Client/ScrollsClientUtils.lua")
Ext.Require("Client/ScrollsClientListeners.lua")
Ext.Require("Client/ScrollsUIBuilder.lua")

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
    SyncToClient = true
})