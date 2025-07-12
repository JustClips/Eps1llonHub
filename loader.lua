-- loader.lua
local function loadModule(path)
    local url = ("https://raw.githubusercontent.com/JustClips/Eps1llonHub/main/%s"):format(path)
    local src = game:HttpGetAsync(url)
    return assert(loadstring(src))()
end

-- 1) Fetch your UI‐lib (modules/ui.lua)
local UILib = loadModule("modules/ui.lua")

-- 2) Create the main window
local Window = UILib:NewWindow({
    Title = "Eps1llon Hub 2025",
    Size  = UDim2.fromOffset(600, 500),
})

-- 3) Grab each section (UI‐lib paints the icons/titles)
local sections = {
    Configuration = UILib:GetSection("Configuration"),
    Combat        = UILib:GetSection("Combat"),
    ESP           = UILib:GetSection("ESP"),
    Inventory     = UILib:GetSection("Inventory"),
    Misc          = UILib:GetSection("Misc"),
    ["UI Settings"]= UILib:GetSection("UI Settings"),
}

-- 4) Load & wire your modules into each section
-- Configuration (if you have one)
-- local Config = loadModule("modules/configuration.lua")
-- Config:SetupTab(sections.Configuration)

-- Combat features
local Aimbot = loadModule("modules/aimbot.lua")
Aimbot:SetupTab(sections.Combat)

-- ESP features
local ESP = loadModule("modules/esp.lua")
ESP:SetupTab(sections.ESP)

-- Inventory features (if any)
-- local Inventory = loadModule("modules/inventory.lua")
-- Inventory:SetupTab(sections.Inventory)

-- Misc features
local Utils = loadModule("modules/utils.lua")
Utils:SetupTab(sections.Misc)

-- UI Settings (if any)
-- local UIControls = loadModule("modules/uicontrols.lua")
-- UIControls:SetupTab(sections["UI Settings"])
