
-- modules/esp.lua
local RunService = game:GetService("RunService")
local Players    = game:GetService("Players")
local camera     = workspace.CurrentCamera
local player     = Players.LocalPlayer

-- Internal state
local espSettings = {
    Name      = false,
    HP        = false,
    Armor     = false,
    Distance  = false,
    Team      = false,
    Age       = false,
    Holding   = false,
    Highlight = false,
}
local espObjects = {}

-- Helper to read armor values
local function getArmor(prot)
    if prot:IsA("IntValue") or prot:IsA("NumberValue") then
        return prot.Value
    end
    if prot:IsA("Folder") or prot:IsA("Model") then
        local a = prot:FindFirstChild("Armor")
        if a and a:IsA("IntValue") then return a.Value end
        for _,v in ipairs(prot:GetChildren()) do
            if v:IsA("IntValue") then return v.Value end
        end
    end
    return nil
end

-- Clear all existing drawings
local function clearESP()
    for _, list in pairs(espObjects) do
        for _, d in ipairs(list) do
            if d and d.Remove then pcall(d.Remove, d) end
        end
    end
    table.clear(espObjects)
end

-- Main render function
local function renderESP()
    clearESP()
    local anyOn = false
    for _, v in pairs(espSettings) do
        if v then anyOn = true break end
    end
    if not anyOn then return end

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= player and pl.Character then
            local char = pl.Character
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local hum  = char:FindFirstChildOfClass("Humanoid")
            if hrp and head and hum and hum.Health > 0 then
                local pos, on = camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.3,0))
                if not on then continue end

                -- Highlight
                local hl = char:FindFirstChild("ESP_Highlight")
                if espSettings.Highlight then
                    if not hl then
                        hl = Instance.new("Highlight", char)
                        hl.Name               = "ESP_Highlight"
                        hl.Adornee            = char
                        hl.FillTransparency   = 0.5
                        hl.OutlineTransparency= 0
                    end
                    hl.FillColor = (pl.Team and pl.Team.TeamColor.Color) or Color3.new(1,1,1)
                elseif hl then
                    hl:Destroy()
                end

                -- Gather info lines
                local dist     = math.floor((hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                local hp       = math.floor(hum.Health)
                local armor    = "?"
                local vf       = char:FindFirstChild("Values")
                if vf then
                    local prot = vf:FindFirstChild("Protection")
                    if prot then
                        local a = getArmor(prot)
                        if type(a)=="number" then armor = tostring(a) end
                    end
                end
                local age      = char:FindFirstChild("Age") and tostring(char.Age.Value) or "?"
                local teamName = pl.Team and pl.Team.Name or "None"
                local tool     = char:FindFirstChildOfClass("Tool")
                local toolName = tool and tool.Name

                local lines, first, second = {}, {}, {}
                if espSettings.Name     then table.insert(first, pl.Name) end
                if espSettings.HP       then table.insert(first, hp.." HP") end
                if espSettings.Armor    then table.insert(first, armor.." Armor") end
                if espSettings.Distance then table.insert(first, dist.." studs") end
                if #first>0 then table.insert(lines, table.concat(first," | ")) end
                if espSettings.Team then table.insert(second, "Team: "..teamName) end
                if espSettings.Age  then table.insert(second, "Age: "..age) end
                if #second>0 then table.insert(lines, table.concat(second," | ")) end
                if espSettings.Holding and toolName then
                    table.insert(lines, "Holding: "..toolName)
                end

                -- Draw
                local totalH = #lines * 18
                local startY = pos.Y - totalH/2
                local drawn = {}
                for i, txt in ipairs(lines) do
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

-- Module table
local ESP = {}

function ESP:SetupTab(tab)
    local toggles = {
        {"Show Names",       "Name"},
        {"Show HP",          "HP"},
        {"Show Armor",       "Armor"},
        {"Show Distance",    "Distance"},
        {"Show Team",        "Team"},
        {"Show Age",         "Age"},
        {"Show Holding",     "Holding"},
        {"Highlight Players","Highlight"},
    }
    local leftX, rightX = 20, 240

    for i, pair in ipairs(toggles) do
        local col = (i-1) // 4
        local row = (i-1) % 4
        local x = (col == 0) and leftX or rightX
        local y = 20 + row * 50

        tab:Toggle({
            Name    = pair[1],
            Default = false,
            X       = x,
            Y       = y,
            Callback= function(val)
                espSettings[pair[2]] = val
            end,
        })
    end

    -- always-on render step (skips if nothing toggled)
    RunService:BindToRenderStep("Eps1llonESP", Enum.RenderPriority.Last.Value, renderESP)
end

return ESP
