-- loader.lua
local function loadModule(path)
    local url = ("https://raw.githubusercontent.com/JustClips/Eps1llonHub/main/%s"):format(path)
    local src = game:HttpGetAsync(url)
    return assert(loadstring(src))()
end

-- 1) Load UI library
local UILib = loadModule("modules/ui.lua")

-- 2) Create main window
local Window = UILib:NewWindow({
    Title = "Eps1llon Hub 2025",
    Size  = UDim2.fromOffset(600, 500),
})

-- 3) Grab sections
local sections = {
    Configuration = UILib:GetSection("Configuration"),
    Combat        = UILib:GetSection("Combat"),
    ESP           = UILib:GetSection("ESP"),
    Inventory     = UILib:GetSection("Inventory"),
    Misc          = UILib:GetSection("Misc"),
    ["UI Settings"]= UILib:GetSection("UI Settings"),
}

-- 4) Wire up feature modules

-- Combat (uses SetupTab)
local Aimbot = loadModule("modules/aimbot.lua")
Aimbot:SetupTab(sections.Combat)

-- ESP (uses Setup and takes the UI-lib)
local ESP = loadModule("modules/esp.lua")
ESP:Setup(UILib)

-- Misc / Utilities (uses SetupTab)
local Utils = loadModule("modules/utils.lua")
Utils:SetupTab(sections.Misc)
