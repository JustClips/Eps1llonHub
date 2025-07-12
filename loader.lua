-- loader.lua
local function loadModule(path)
    local url = ("https://raw.githubusercontent.com/JustClips/Eps1llonHub/main/%s"):format(path)
    local src = game:HttpGetAsync(url)
    return assert(loadstring(src))()
end

-- 1) Load & run the UI-lib (it creates the ScreenGui, mainFrame, sidebar & tabSections)
local UI = loadModule("modules/ui.lua")

-- 2) Wire up your ESP module (it now uses UI:AddToggle under the hood)
local ESP = loadModule("modules/esp.lua")
ESP:Setup(UI)

-- 3) (Optional) Wire up other modules the same way, passing the UI instance:
-- local Aimbot = loadModule("modules/aimbot.lua")
-- Aimbot:Setup(UI)
-- local Utils   = loadModule("modules/utils.lua")
-- Utils:Setup(UI)
