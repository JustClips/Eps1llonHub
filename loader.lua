-- loader.lua - Updated to load complete integrated script
local function loadCompleteScript()
    local url = "https://raw.githubusercontent.com/JustClips/Eps1llonHub/main/Eps1llonHub_Complete.lua"
    local success, src = pcall(function()
        return game:HttpGetAsync(url)
    end)
    
    if success then
        print("🔸 Loading Eps1llon Hub 2025 Complete Script...")
        return assert(loadstring(src))()
    else
        warn("⚠️ Failed to load complete script, falling back to modular loading...")
        
        -- Fallback to modular loading
        local function loadModule(path)
            local moduleUrl = ("https://raw.githubusercontent.com/JustClips/Eps1llonHub/main/%s"):format(path)
            local moduleSrc = game:HttpGetAsync(moduleUrl)
            return assert(loadstring(moduleSrc))()
        end

        -- Load UI library
        local UI = loadModule("modules/ui.lua")

        -- Load ESP module
        local ESP = loadModule("modules/esp.lua")
        ESP:Setup(UI)

        return UI
    end
end

-- Load the complete script
loadCompleteScript()
