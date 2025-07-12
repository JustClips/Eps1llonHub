-- loader.lua
local function loadModule(path)
    local url = "https://raw.githubusercontent.com/YourUser/Eps1llonHub/main/" .. path
    local src = game:HttpGetAsync(url)
    return assert(loadstring(src))()
end

-- 1) load your UI library
local UILib = loadModule("modules/ui.lua")

-- 2) create the main window
local Window = UILib:NewWindow({
    Title = "Eps1llon Hub 2025",
    Size  = UDim2.fromOffset(600, 500),
})

-- 3) grab the sections (UI-lib will put icons/titles for you)
local sections = {
    Configuration = UILib:GetSection("Configuration"),
    Combat        = UILib:GetSection("Combat"),
    ESP           = UILib:GetSection("ESP"),
    Inventory     = UILib:GetSection("Inventory"),
    Misc          = UILib:GetSection("Misc"),
    ["UI Settings"]= UILib:GetSection("UI Settings"),
}

-- 4) load & wire up each feature
-- Configuration features (e.g. WalkSpeed, JumpPower)
-- local Config = loadModule("modules/configuration.lua")
-- Config:SetupTab(sections.Configuration)

-- Combat features (Aimbot, Reach Expander, Auto Hit)
local Aimbot = loadModule("modules/aimbot.lua")
Aimbot:SetupTab(sections.Combat)

-- ESP
local ESP = loadModule("modules/esp.lua")
ESP:SetupTab(sections.ESP)

-- Inventory features
-- local Inventory = loadModule("modules/inventory.lua")
-- Inventory:SetupTab(sections.Inventory)

-- Misc features (Instant Pickup, Kill Carrier, etc.)
local Utils = loadModule("modules/utils.lua")
Utils:SetupTab(sections.Misc)

-- UI Settings
-- local UIControls = loadModule("modules/uicontrols.lua")
-- UIControls:SetupTab(sections["UI Settings"])
