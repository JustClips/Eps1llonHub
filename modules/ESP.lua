-- modules/esp.lua
local RunService = game:GetService("RunService")
local Players    = game:GetService("Players")
local camera     = workspace.CurrentCamera
local player     = Players.LocalPlayer

-- Internal ESP state
local espSettings = {
    Name=false, HP=false, Armor=false, Distance=false,
    Team=false, Age=false, Holding=false, Highlight=false,
}
local espObjects = {}

-- Clear previous drawings
local function clearESP()
    for _, list in pairs(espObjects) do
        for _, d in ipairs(list) do
            if d and d.Remove then pcall(d.Remove, d) end
        end
    end
    table.clear(espObjects)
end

-- Main render loop
local function renderESP()
    clearESP()
    local anyOn = false
    for _,v in pairs(espSettings) do
        if v then anyOn = true break end
    end
    if not anyOn then return end

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl~=player and pl.Character then
            local hrp  = pl.Character:FindFirstChild("HumanoidRootPart")
            local head = pl.Character:FindFirstChild("Head")
            local hum  = pl.Character:FindFirstChildOfClass("Humanoid")
            if hrp and head and hum and hum.Health>0 then
                local pos,on = camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.3,0))
                if not on then continue end

                -- Highlight toggle
                local hl = pl.Character:FindFirstChild("ESP_Highlight")
                if espSettings.Highlight then
                    if not hl then
                        hl = Instance.new("Highlight", pl.Character)
                        hl.Name                = "ESP_Highlight"
                        hl.Adornee             = pl.Character
                        hl.FillTransparency    = 0.5
                        hl.OutlineTransparency = 0
                    end
                    hl.FillColor = (pl.Team and pl.Team.TeamColor.Color) or Color3.new(1,1,1)
                elseif hl then
                    hl:Destroy()
                end

                -- Gather lines
                local dist = math.floor((hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                local hp   = math.floor(hum.Health)
                local vf   = pl.Character:FindFirstChild("Values")
                local armor = "?"
                if vf then
                    local prot = vf:FindFirstChild("Protection")
                    if prot and prot:IsA("IntValue") then armor = tostring(prot.Value) end
                end
                local age = pl.Character:FindFirstChild("Age") and tostring(pl.Character.Age.Value) or "?"
                local tool = pl.Character:FindFirstChildOfClass("Tool")
                local toolName = tool and tool.Name

                local lines, top, bot = {}, {}, {}
                if espSettings.Name     then table.insert(top, pl.Name) end
                if espSettings.HP       then table.insert(top, hp.." HP") end
                if espSettings.Armor    then table.insert(top, armor.." Armor") end
                if espSettings.Distance then table.insert(top, dist.." studs") end
                if #top>0 then table.insert(lines, table.concat(top," | ")) end

                if espSettings.Team then table.insert(bot, "Team: "..(pl.Team and pl.Team.Name or "None")) end
                if espSettings.Age  then table.insert(bot, "Age: "..age) end
                if #bot>0 then table.insert(lines, table.concat(bot," | ")) end
                if espSettings.Holding and toolName then
                    table.insert(lines, "Holding: "..toolName)
                end

                -- Draw text
                local totalH = #lines * 18
                local startY = pos.Y - totalH/2
                local drawn = {}
                for i,txt in ipairs(lines) do
                    local d = Drawing.new("Text")
                    d.Text         = txt
                    d.Size         = 16
                    d.Center       = true
                    d.Font         = 2
                    d.Color        = (pl.Team and pl.Team.TeamColor.Color) or Color3.new(1,1,1)
                    d.Outline      = true
                    d.OutlineColor = Color3.new(0,0,0)
                    d.Position     = Vector2.new(pos.X, startY + (i-1)*18)
                    d.Visible      = true
                    table.insert(drawn, d)
                end
                espObjects[pl] = drawn
            end
        end
    end
end

local ESP = {}

-- Called from loader with UI-lib instance
function ESP:Setup(UI)
    local defs = {
        {"Show Names",       "Name",      20,  20},
        {"Show HP",          "HP",        20,  70},
        {"Show Armor",       "Armor",     20, 120},
        {"Show Distance",    "Distance",  20, 170},
        {"Show Team",        "Team",     240,  20},
        {"Show Age",         "Age",      240,  70},
        {"Show Holding",     "Holding",  240, 120},
        {"Highlight Players","Highlight",240, 170},
    }

    for _, def in ipairs(defs) do
        UI:AddToggle("ESP", {
            Name    = def[1],
            Default = false,
            X       = def[3],
            Y       = def[4],
            Callback= function(val)
                espSettings[def[2]] = val
            end,
        })
    end

    RunService:BindToRenderStep("Eps1llonESP", Enum.RenderPriority.Last.Value, renderESP)
end

return ESP
