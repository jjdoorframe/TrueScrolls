Ext.Require("Shared/ScrollsModUtils.lua")
Ext.Require("Shared/ScrollsTemplateOverrides.lua")
Ext.Require("Client/ScrollsConfigurationMenu.lua")
Ext.Require("Client/ScrollsClientUtils.lua")

Ext.Vars.RegisterModVariable(ModuleUUID, "ModConfig", {
    Server = true,
    Client = true,
    WriteableOnServer = false,
    WriteableOnClient = true,
    SyncToServer = true
})