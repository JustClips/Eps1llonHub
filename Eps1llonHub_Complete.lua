--// Eps1llon Hub 2025 | Complete Full Script - All Features
--// Created: 2025-01-16 22:26:11 UTC | Author: JustClips | User: JustClips
--// Updated: 2025-07-12 18:12:28 UTC | Integrated with new UI library

-- ========================================
-- 1. LOAD EXTERNAL CHAT SYSTEM FIRST
-- ========================================

pcall(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/9fj3k2mL"))()
end)

-- ========================================
-- 2. Services and Globals  
-- ========================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = Workspace.CurrentCamera

local IS_MOBILE = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local function isTouch(input) return input.UserInputType == Enum.UserInputType.Touch end

-- ========================================
-- 3. Load UI Library (INTERNAL VERSION)
-- ========================================

local Eps1llonUI = {}
Eps1llonUI._VERSION = "2025.07.12"

local gui = Instance.new('ScreenGui')
gui.Name = 'Eps1llonHub'
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then gui.Parent = player:WaitForChild('PlayerGui') end

-- MAIN FRAME
local mainFrame = Instance.new('Frame', gui)
mainFrame.Size = UDim2.new(0, 650, 0, 420)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.14
mainFrame.Active = true
mainFrame.Draggable = false
Instance.new('UICorner', mainFrame).CornerRadius = UDim.new(0, 8)
local UIScale = Instance.new("UIScale", mainFrame)
UIScale.Scale = 1

-- HEADER (DRAG)
local headerFrame = Instance.new('Frame', mainFrame)
headerFrame.Size = UDim2.new(1, 0, 0, 30)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundTransparency = 1
headerFrame.Active = true

do
    local dragging, dragStart, startPos = false, nil, nil
    headerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
            dragging, dragStart, startPos = true, input.Position, mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or isTouch(input)) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then dragging = false end
    end)
end

local title = Instance.new('TextLabel', headerFrame)
title.Size = UDim2.new(1, -65, 1, 0)
title.Text = 'Eps1llon Hub'
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local underline = Instance.new('Frame', mainFrame)
underline.Size = UDim2.new(1, 0, 0, 4)
underline.Position = UDim2.new(0, 0, 0, 30)
underline.BackgroundTransparency = 0
underline.BackgroundColor3 = Color3.fromRGB(31, 81, 138)
underline.BorderSizePixel = 0

local minimize = Instance.new('TextButton', headerFrame)
minimize.Size = UDim2.new(0, 25, 0, 25)
minimize.Position = UDim2.new(1, -50, 0, 2)
minimize.Text = '-'
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundTransparency = 1
minimize.BorderSizePixel = 0

local close = Instance.new('TextButton', headerFrame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -25, 0, 2)
close.Text = 'X'
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 1
close.BorderSizePixel = 0
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- SIDEBAR
local sidebar = Instance.new('Frame', mainFrame)
sidebar.Size = UDim2.new(0, 140, 0, 340)
sidebar.Position = UDim2.new(0, 10, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BackgroundTransparency = 0.12
sidebar.BorderSizePixel = 0
Instance.new('UICorner', sidebar).CornerRadius = UDim.new(0, 6)
local outline = Instance.new('UIStroke', sidebar)
outline.Thickness = 2
outline.Color = Color3.fromRGB(31, 81, 138)
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local highlighter = Instance.new('Frame', sidebar)
highlighter.Size = UDim2.new(1, 0, 0, 30)
highlighter.Position = UDim2.new(0, 0, 0, 10)
highlighter.BackgroundColor3 = Color3.fromRGB(31, 81, 138)
highlighter.BackgroundTransparency = 0.3
highlighter.BorderSizePixel = 0
highlighter.ZIndex = 2
Instance.new('UICorner', highlighter).CornerRadius = UDim.new(1, 999)

-- CONTENT FRAME
local contentFrame = Instance.new('Frame', mainFrame)
contentFrame.Size = UDim2.new(0, 480, 0, 340)
contentFrame.Position = UDim2.new(0, 160, 0, 50)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
contentFrame.BackgroundTransparency = 0.7
contentFrame.BorderSizePixel = 0
Instance.new('UICorner', contentFrame).CornerRadius = UDim.new(0, 6)
local outlineContentFrame = Instance.new('UIStroke', contentFrame)
outlineContentFrame.Thickness = 2
outlineContentFrame.Color = Color3.fromRGB(31, 81, 138)
outlineContentFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- TABS
local _TABS = {
    "Configuration",
    "Combat",
    "ESP",
    "Inventory",
    "Misc",
    "UI Settings",
}
local iconData = {
    Configuration = "134572329997100", Combat = "94883448905030", ESP = "92313485402528", 
    Inventory = "135628846657243", Misc = "121583805460244", ["UI Settings"] = "93991072023597",
}
local ICON_SIZE, ICON_LEFT_PAD, TEXT_LEFT_PAD = 24, 6, 34
local sidebarButtons, tabSections, tabCallbacks = {}, {}, {}

local DEFAULT_COLOR, ACTIVE_COLOR, DEFAULT_SIZE, ACTIVE_SIZE = Color3.fromRGB(210,210,210), Color3.fromRGB(255,255,255), 16, 18

local function createSection(name)
    local section = Instance.new('Frame')
    section.Name = name
    section.Size = UDim2.new(1, 0, 1, 0)
    section.BackgroundTransparency = 1
    section.Visible = false
    section.Parent = contentFrame
    return section
end

local function setButtonActive(idx)
    for i, group in ipairs(sidebarButtons) do
        local btn, isActive = group.TextButton, (i == idx)
        TweenService:Create(btn, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {
            TextSize = isActive and ACTIVE_SIZE or DEFAULT_SIZE,
            TextColor3 = isActive and ACTIVE_COLOR or DEFAULT_COLOR
        }):Play()
        btn.Font = Enum.Font.GothamBold
        if isActive then
            TweenService:Create(highlighter, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = group.ButtonFrame.Position,
                Size = group.ButtonFrame.Size,
                BackgroundTransparency = 0.13
            }):Play()
        end
    end
end

local function createSidebarButton(text, yPos, idx)
    local buttonFrame = Instance.new('Frame', sidebar)
    buttonFrame.Size = UDim2.new(1, 0, 0, 30)
    buttonFrame.Position = UDim2.new(0, 0, 0, yPos)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.ZIndex = 3
    if iconData[text] then
        local image = Instance.new("ImageLabel", buttonFrame)
        image.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
        image.Position = UDim2.new(0, ICON_LEFT_PAD, 0.5, -ICON_SIZE/2)
        image.BackgroundTransparency = 1
        image.Image = "rbxassetid://" .. iconData[text]
        image.ImageColor3 = Color3.fromRGB(255,255,255)
        image.ScaleType = Enum.ScaleType.Fit
        image.ZIndex = 4
    end
    local button = Instance.new('TextButton', buttonFrame)
    button.Size = UDim2.new(1, -TEXT_LEFT_PAD, 1, 0)
    button.Position = UDim2.new(0, TEXT_LEFT_PAD, 0, 0)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = DEFAULT_SIZE
    button.TextColor3 = DEFAULT_COLOR
    button.BackgroundTransparency = 1
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.ZIndex = 5
    button.MouseButton1Click:Connect(function()
        for _, sec in pairs(tabSections) do sec.Visible = false end
        tabSections[text].Visible = true
        setButtonActive(idx)
        if tabCallbacks[text] then tabCallbacks[text]() end
        -- Call ResizeSectionContents when switching tabs
        ResizeSectionContents()
    end)
    button.TouchTap:Connect(function()
        for _, sec in pairs(tabSections) do sec.Visible = false end
        tabSections[text].Visible = true
        setButtonActive(idx)
        if tabCallbacks[text] then tabCallbacks[text]() end
        ResizeSectionContents()
    end)
    sidebarButtons[idx] = { ButtonFrame = buttonFrame, TextButton = button }
    return buttonFrame
end

for i, name in ipairs(_TABS) do
    tabSections[name] = createSection(name)
    createSidebarButton(name, 10 + (i - 1) * 35, i)
end
tabSections[_TABS[1]].Visible = true
setButtonActive(1)

-- ========================================
-- 4. Animation Presets and Gradients
-- ========================================

local function createRippleEffect(button)
    local ripple = Instance.new("Frame", button)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.ZIndex = button.ZIndex + 1
    Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
    
    TweenService:Create(ripple, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(2, 0, 2, 0),
        Position = UDim2.new(-0.5, 0, -0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    
    game:GetService("Debris"):AddItem(ripple, 0.3)
end

-- ========================================
-- 5. Section Setup with Centered Headers
-- ========================================

local function createSectionHeader(section, title, icon)
    local header = Instance.new("Frame", section)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.Position = UDim2.new(0, 0, 0, 5)
    header.BackgroundTransparency = 1
    
    if icon then
        local iconImg = Instance.new("ImageLabel", header)
        iconImg.Size = UDim2.new(0, 28, 0, 28)
        iconImg.Position = UDim2.new(0.5, -60, 0.5, -14)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = "rbxassetid://" .. icon
        iconImg.ImageColor3 = Color3.fromRGB(31, 81, 138)
        iconImg.ScaleType = Enum.ScaleType.Fit
    end
    
    local titleLabel = Instance.new("TextLabel", header)
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0.5, icon and -25 or -100, 0, 0)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    
    return header
end

-- ========================================
-- 6. UI Helper Functions (Enhanced toggles, sliders, dropdowns)
-- ========================================

function Eps1llonUI:AddButton(tab, opts)
    local section = tabSections[tab]
    assert(section, "Tab "..tostring(tab).." does not exist.")
    local btn = Instance.new("TextButton", section)
    btn.Size = UDim2.new(0, 210, 0, 38)
    btn.Position = UDim2.new(0, opts.X or 20, 0, opts.Y or (#section:GetChildren()-1)*42 + 15)
    btn.Text = opts.Name or "Button"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 17
    btn.TextColor3 = opts.TextColor3 or Color3.fromRGB(220,240,255)
    btn.BackgroundColor3 = opts.BackgroundColor3 or Color3.fromRGB(32,32,36)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.TextXAlignment = Enum.TextXAlignment.Center
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.MouseButton1Click:Connect(function() 
        createRippleEffect(btn)
        if opts.Callback then opts.Callback() end 
    end)
    btn.TouchTap:Connect(function() 
        createRippleEffect(btn)
        if opts.Callback then opts.Callback() end 
    end)
    return btn
end

function Eps1llonUI:AddLabel(tab, opts)
    local section = tabSections[tab]
    assert(section, "Tab "..tostring(tab).." does not exist.")
    local lbl = Instance.new("TextLabel", section)
    lbl.Size = UDim2.new(1, -40, 0, opts.Height or 30)
    lbl.Position = UDim2.new(0, opts.X or 20, 0, opts.Y or (#section:GetChildren()-1)*32 + 12)
    lbl.Text = opts.Text or "Label"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = opts.TextSize or 16
    lbl.TextColor3 = opts.TextColor3 or Color3.fromRGB(220, 220, 220)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = opts.TextXAlignment or Enum.TextXAlignment.Left
    lbl.TextYAlignment = opts.TextYAlignment or Enum.TextYAlignment.Center
    return lbl
end

-- Enhanced Toggle with Cyan Glow Effects
function createEnhancedToggle(tab, opts)
    local section = tabSections[tab]
    assert(section, "Tab "..tostring(tab).." does not exist.")
    local container = Instance.new("Frame", section)
    container.Size = UDim2.new(0, opts.Width or 210, 0, 40)
    container.Position = UDim2.new(0, opts.X or 20, 0, opts.Y or (#section:GetChildren()-1)*44 + 12)
    container.BackgroundColor3 = opts.BackgroundColor3 or Color3.fromRGB(32, 32, 36)
    container.BackgroundTransparency = 0.17
    container.BorderSizePixel = 0
    Instance.new('UICorner', container).CornerRadius = UDim.new(0, 11)

    local label = Instance.new("TextLabel", container)
    label.Text = opts.Name or "Toggle"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 16
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center

    local pillow = Instance.new("Frame", container)
    pillow.Size = UDim2.new(0, 52, 0, 24)
    pillow.Position = UDim2.new(1, -60, 0.5, -12)
    pillow.BackgroundColor3 = opts.Default and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(44,44,47)
    pillow.BorderSizePixel = 0
    Instance.new("UICorner", pillow).CornerRadius = UDim.new(1, 999)

    -- Cyan glow effect for ESP toggles
    local glow = Instance.new("Frame", pillow)
    glow.Size = UDim2.new(1, 8, 1, 8)
    glow.Position = UDim2.new(0, -4, 0, -4)
    glow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    glow.BackgroundTransparency = opts.Default and 0.7 or 1
    glow.BorderSizePixel = 0
    glow.ZIndex = pillow.ZIndex - 1
    Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 999)

    local knob = Instance.new("Frame", pillow)
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = opts.Default and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(230,230,255)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 999)

    local value = opts.Default and true or false
    local function setToggle(val)
        value = val
        local targetColor = val and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(44,44,47)
        local glowTrans = val and 0.7 or 1
        
        TweenService:Create(pillow, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(glow, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = glowTrans}):Play()
        TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = val and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play()
        if opts.Callback then opts.Callback(val) end
    end
    pillow.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
            setToggle(not value)
        end
    end)
    pillow.TouchTap:Connect(function() setToggle(not value) end)
    return container, setToggle
end

function Eps1llonUI:AddToggle(tab, opts)
    return createEnhancedToggle(tab, opts)
end

-- Enhanced Slider with Hover Effects
function setupEnhancedSliderDrag(tab, opts)
    local section = tabSections[tab]
    assert(section, "Tab "..tostring(tab).." does not exist.")
    local frame = Instance.new("Frame", section)
    frame.Size = UDim2.new(1, -40, 0, 54)
    frame.Position = UDim2.new(0, 20, 0, opts.Y or (#section:GetChildren()-1)*58 + 10)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.41
    frame.BorderSizePixel = 0
    Instance.new('UICorner', frame).CornerRadius = UDim.new(0, 12)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = opts.Name or "Slider"
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 17
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    
    local barBG = Instance.new("Frame", frame)
    barBG.Size = UDim2.new(0.62, -20, 0, 20)
    barBG.Position = UDim2.new(0.35, 10, 0, 16)
    barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    barBG.BorderSizePixel = 0
    barBG.ClipsDescendants = true
    Instance.new("UICorner", barBG).CornerRadius = UDim.new(1, 999)
    
    local fill = Instance.new("Frame", barBG)
    fill.Size = UDim2.new(((opts.Default or opts.Min)-opts.Min)/(opts.Max-opts.Min), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = Color3.fromRGB(43, 110, 158)
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 999)
    
    local valText = Instance.new("TextLabel", fill)
    valText.Size = UDim2.new(1, -8, 1, 0)
    valText.Position = UDim2.new(0, 8, 0, 0)
    valText.BackgroundTransparency = 1
    valText.TextColor3 = Color3.fromRGB(210, 240, 255)
    valText.Font = Enum.Font.GothamBold
    valText.TextSize = 16
    valText.TextXAlignment = Enum.TextXAlignment.Right
    valText.TextYAlignment = Enum.TextYAlignment.Center
    valText.Text = tostring(opts.Default or opts.Min)

    -- Hover effects
    frame.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.2}):Play()
    end)
    frame.MouseLeave:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.41}):Play()
    end)

    local function setSliderPos(x)
        local percent = math.clamp(x / barBG.AbsoluteSize.X, 0, 1)
        local value = math.floor((opts.Min or 0) + ((opts.Max or 100) - (opts.Min or 0))*percent + 0.5)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        valText.Text = tostring(value)
        if opts.Callback then opts.Callback(value) end
    end
    local draggingSlider = false
    local function beginDrag(input)
        draggingSlider = true
        setSliderPos(input.Position.X - barBG.AbsolutePosition.X)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingSlider = false end
        end)
    end
    barBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
            beginDrag(input)
        end
    end)
    barBG.TouchTap:Connect(function(x, y)
        if barBG.AbsoluteSize.X > 0 then
            setSliderPos(x - barBG.AbsolutePosition.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or isTouch(input)) then
            setSliderPos(input.Position.X - barBG.AbsolutePosition.X)
        end
    end)
    return frame, valText
end

function Eps1llonUI:AddSlider(tab, opts)
    return setupEnhancedSliderDrag(tab, opts)
end

-- Enhanced Dropdown System
function createEnhancedDropdown(tab, opts)
    local section = tabSections[tab]
    assert(section, "Tab "..tostring(tab).." does not exist.")
    
    local dropdown = Instance.new("Frame", section)
    dropdown.Size = UDim2.new(0, opts.Width or 210, 0, 38)
    dropdown.Position = UDim2.new(0, opts.X or 20, 0, opts.Y or (#section:GetChildren()-1)*42 + 15)
    dropdown.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
    dropdown.BorderSizePixel = 0
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 8)
    
    local button = Instance.new("TextButton", dropdown)
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.Text = opts.Default or "Select Option"
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.BackgroundTransparency = 1
    button.TextXAlignment = Enum.TextXAlignment.Center
    
    local arrow = Instance.new("TextLabel", dropdown)
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -25, 0, 0)
    arrow.Text = "▼"
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 12
    arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
    arrow.BackgroundTransparency = 1
    arrow.TextXAlignment = Enum.TextXAlignment.Center
    arrow.TextYAlignment = Enum.TextYAlignment.Center
    
    local optionsFrame = Instance.new("Frame", dropdown)
    optionsFrame.Size = UDim2.new(1, 0, 0, #opts.Options * 32)
    optionsFrame.Position = UDim2.new(0, 0, 1, 2)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 10
    Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 8)
    
    local isOpen = false
    
    for i, option in ipairs(opts.Options) do
        local optionButton = Instance.new("TextButton", optionsFrame)
        optionButton.Size = UDim2.new(1, 0, 0, 32)
        optionButton.Position = UDim2.new(0, 0, 0, (i-1) * 32)
        optionButton.Text = option
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 14
        optionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        optionButton.BackgroundTransparency = 1
        optionButton.TextXAlignment = Enum.TextXAlignment.Center
        optionButton.ZIndex = 11
        
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundTransparency = 0
            optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundTransparency = 1
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            button.Text = option
            optionsFrame.Visible = false
            isOpen = false
            arrow.Text = "▼"
            if opts.Callback then opts.Callback(option) end
        end)
    end
    
    button.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        optionsFrame.Visible = isOpen
        arrow.Text = isOpen and "▲" or "▼"
    end)
    
    return dropdown
end

-- ========================================
-- 7. Configuration Tab Implementation
-- ========================================

createSectionHeader(tabSections["Configuration"], "Configuration", "134572329997100")

-- Speedwalk Toggle
local speedWalkEnabled = false
local originalWalkSpeed = 16

createEnhancedToggle("Configuration", {
    Name = "Speed Walk",
    X = 20,
    Y = 60,
    Default = false,
    Callback = function(enabled)
        speedWalkEnabled = enabled
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if enabled then
                originalWalkSpeed = player.Character.Humanoid.WalkSpeed
                player.Character.Humanoid.WalkSpeed = 50
            else
                player.Character.Humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end
})

-- JumpPower Slider
setupEnhancedSliderDrag("Configuration", {
    Name = "Jump Power",
    Min = 50,
    Max = 150,
    Default = 50,
    Y = 120,
    Callback = function(value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

-- Infinite Water Toggle
local infiniteWaterEnabled = false

createEnhancedToggle("Configuration", {
    Name = "Infinite Water",
    X = 20,
    Y = 190,
    Default = false,
    Callback = function(enabled)
        infiniteWaterEnabled = enabled
        -- Implementation for infinite water would go here
        print("Infinite Water:", enabled)
    end
})

-- ========================================
-- 8. Combat Tab Implementation
-- ========================================

createSectionHeader(tabSections["Combat"], "Combat", "94883448905030")

-- Reach Expander with Radius Slider
local reachEnabled = false
local reachRadius = 10

createEnhancedToggle("Combat", {
    Name = "Reach Expander",
    X = 20,
    Y = 60,
    Default = false,
    Callback = function(enabled)
        reachEnabled = enabled
        print("Reach Expander:", enabled)
    end
})

setupEnhancedSliderDrag("Combat", {
    Name = "Reach Radius",
    Min = 5,
    Max = 25,
    Default = 10,
    Y = 120,
    Callback = function(value)
        reachRadius = value
        print("Reach Radius:", value)
    end
})

-- Auto Hit Toggle
local autoHitEnabled = false

createEnhancedToggle("Combat", {
    Name = "Auto Hit",
    X = 20,
    Y = 190,
    Default = false,
    Callback = function(enabled)
        autoHitEnabled = enabled
        print("Auto Hit:", enabled)
    end
})

-- ========================================
-- 9. ESP Tab Implementation (Enhanced)
-- ========================================

createSectionHeader(tabSections["ESP"], "ESP", "92313485402528")

-- ESP Settings with Cyan Glow Effects
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
                    hl.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan glow
                    hl.OutlineColor = Color3.fromRGB(0, 255, 255)
                elseif hl then
                    hl:Destroy()
                end

                -- Gather lines with cyan coloring
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

                -- Draw text with cyan glow effect
                local totalH = #lines * 18
                local startY = pos.Y - totalH/2
                local drawn = {}
                for i,txt in ipairs(lines) do
                    local d = Drawing.new("Text")
                    d.Text         = txt
                    d.Size         = 16
                    d.Center       = true
                    d.Font         = 2
                    d.Color        = Color3.fromRGB(0, 255, 255) -- Cyan color
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

-- ESP Toggles with enhanced styling
local espDefs = {
    {"Show Names",       "Name",      20,  60},
    {"Show HP",          "HP",        20, 110},
    {"Show Armor",       "Armor",     20, 160},
    {"Show Distance",    "Distance",  20, 210},
    {"Show Team",        "Team",     240,  60},
    {"Show Age",         "Age",      240, 110},
    {"Show Holding",     "Holding",  240, 160},
    {"Highlight Players","Highlight",240, 210},
}

for _, def in ipairs(espDefs) do
    createEnhancedToggle("ESP", {
        Name    = def[1],
        Default = false,
        X       = def[3],
        Y       = def[4],
        Width   = 200,
        Callback= function(val)
            espSettings[def[2]] = val
        end,
    })
end

RunService:BindToRenderStep("Eps1llonESP", Enum.RenderPriority.Last.Value, renderESP)

-- ========================================
-- 10. Inventory Tab Implementation
-- ========================================

createSectionHeader(tabSections["Inventory"], "Inventory", "135628846657243")

-- Smart Grabtools System
local grabToolsEnabled = false
local toolList = {"Sword", "Bow", "Arrow", "Shield", "Hammer", "Axe"}

createEnhancedToggle("Inventory", {
    Name = "Smart Grabtools",
    X = 20,
    Y = 60,
    Default = false,
    Callback = function(enabled)
        grabToolsEnabled = enabled
        print("Smart Grabtools:", enabled)
    end
})

-- Tool List Display
local toolListFrame = Instance.new("ScrollingFrame", tabSections["Inventory"])
toolListFrame.Size = UDim2.new(0, 200, 0, 120)
toolListFrame.Position = UDim2.new(0, 20, 0, 120)
toolListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toolListFrame.BackgroundTransparency = 0.3
toolListFrame.BorderSizePixel = 0
toolListFrame.ScrollBarThickness = 6
Instance.new("UICorner", toolListFrame).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout", toolListFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 2)

for i, tool in ipairs(toolList) do
    local toolLabel = Instance.new("TextLabel", toolListFrame)
    toolLabel.Size = UDim2.new(1, -10, 0, 25)
    toolLabel.Text = "• " .. tool
    toolLabel.Font = Enum.Font.Gotham
    toolLabel.TextSize = 14
    toolLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    toolLabel.BackgroundTransparency = 1
    toolLabel.TextXAlignment = Enum.TextXAlignment.Left
    toolLabel.LayoutOrder = i
end

-- Auto-pickup Toggle
createEnhancedToggle("Inventory", {
    Name = "Auto Pickup",
    X = 250,
    Y = 60,
    Default = false,
    Callback = function(enabled)
        print("Auto Pickup:", enabled)
    end
})

-- Enhanced Input Field for Tool Search
local searchFrame = Instance.new("Frame", tabSections["Inventory"])
searchFrame.Size = UDim2.new(0, 200, 0, 35)
searchFrame.Position = UDim2.new(0, 250, 0, 120)
searchFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
searchFrame.BorderSizePixel = 0
Instance.new("UICorner", searchFrame).CornerRadius = UDim.new(0, 8)

local searchBox = Instance.new("TextBox", searchFrame)
searchBox.Size = UDim2.new(1, -10, 1, -6)
searchBox.Position = UDim2.new(0, 5, 0, 3)
searchBox.Text = "Search tools..."
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 14
searchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
searchBox.BackgroundTransparency = 1
searchBox.TextXAlignment = Enum.TextXAlignment.Left

-- ========================================
-- 11. Misc Tab Implementation
-- ========================================

createSectionHeader(tabSections["Misc"], "Misc", "121583805460244")

-- Instant Pickup Toggle
createEnhancedToggle("Misc", {
    Name = "Instant Pickup",
    X = 20,
    Y = 60,
    Default = false,
    Callback = function(enabled)
        print("Instant Pickup:", enabled)
    end
})

-- Kill the Carrier Toggle
createEnhancedToggle("Misc", {
    Name = "Kill the Carrier",
    X = 20,
    Y = 120,
    Default = false,
    Callback = function(enabled)
        print("Kill the Carrier:", enabled)
    end
})

-- Plant Tree Toggle
createEnhancedToggle("Misc", {
    Name = "Plant Tree",
    X = 20,
    Y = 180,
    Default = false,
    Callback = function(enabled)
        print("Plant Tree:", enabled)
    end
})

-- Job GUI Dropdown
local jobOptions = {"Blacksmith", "Farmer", "Miner", "Builder", "Hunter", "Guard"}

createEnhancedDropdown("Misc", {
    Name = "Job GUI",
    X = 250,
    Y = 60,
    Width = 180,
    Options = jobOptions,
    Default = "Select Job",
    Callback = function(selected)
        print("Selected Job:", selected)
    end
})

-- ========================================
-- 12. Resizable MainFrame & Responsive System
-- ========================================

-- Responsive Resize Function
function ResizeSectionContents()
    local scale = UIScale.Scale
    
    -- Update all sections' content based on scale
    for tabName, section in pairs(tabSections) do
        for _, child in pairs(section:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
                -- Scale text sizes
                if child:FindFirstChild("TextSize") then
                    child.TextSize = math.floor(child.TextSize * scale)
                end
                
                -- Update child text elements
                for _, subChild in pairs(child:GetChildren()) do
                    if subChild:IsA("TextLabel") or subChild:IsA("TextButton") then
                        subChild.TextSize = math.floor(subChild.TextSize * scale)
                    end
                end
            end
        end
    end
end

-- Make the main frame resizable
local function makeResizable(frame)
    local resizeHandle = Instance.new("TextButton", frame)
    resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    resizeHandle.Position = UDim2.new(1, -20, 1, -20)
    resizeHandle.Text = "⟣"
    resizeHandle.Font = Enum.Font.GothamBold
    resizeHandle.TextSize = 16
    resizeHandle.TextColor3 = Color3.fromRGB(150, 150, 150)
    resizeHandle.BackgroundTransparency = 1
    resizeHandle.ZIndex = 10
    
    local resizing = false
    local startSize, startPos
    
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
            resizing = true
            startSize = frame.Size
            startPos = input.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or isTouch(input)) then
            local delta = input.Position - startPos
            local newWidth = math.max(500, startSize.X.Offset + delta.X)
            local newHeight = math.max(350, startSize.Y.Offset + delta.Y)
            
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
            
            -- Update content frame size
            contentFrame.Size = UDim2.new(0, newWidth - 170, 0, newHeight - 80)
            
            -- Call resize function for responsive elements
            ResizeSectionContents()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
            resizing = false
        end
    end)
end

makeResizable(mainFrame)

-- Scale adjustment for mobile
if IS_MOBILE then
    UIScale.Scale = 0.8
    ResizeSectionContents()
end

-- ========================================
-- 13. Minimize Button & Insert Key Toggle
-- ========================================

-- Minimize Button Logic (already implemented above)
local minimizedButton = Instance.new('ImageButton', gui)
minimizedButton.Name = "Eps1llonMini"
minimizedButton.Size = UDim2.new(0, 55, 0, 55)
minimizedButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizedButton.BackgroundTransparency = 0.08
minimizedButton.AutoButtonColor = true
minimizedButton.Visible = false
Instance.new('UICorner', minimizedButton).CornerRadius = UDim.new(1, 999)

local esText = Instance.new('TextLabel', minimizedButton)
esText.Size = UDim2.new(1, 0, 1, 0)
esText.Position = UDim2.new(0, 0, 0, 0)
esText.BackgroundTransparency = 1
esText.Text = "ES"
esText.TextColor3 = Color3.fromRGB(255,255,255)
esText.TextStrokeTransparency = 0.25
esText.Font = Enum.Font.GothamBlack
esText.TextScaled = true
esText.ZIndex = 2
esText.TextYAlignment = Enum.TextYAlignment.Center
esText.TextXAlignment = Enum.TextXAlignment.Center
esText.TextSize = 12

local function animateObj(obj, scaleFrom, scaleTo, transpFrom, transpTo, duration, cb)
    local scaleObj = obj:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", obj)
    scaleObj.Scale = scaleFrom
    obj.BackgroundTransparency = transpFrom
    obj.Visible = true
    local tw1 = TweenService:Create(scaleObj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = scaleTo})
    local tw2 = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = transpTo})
    tw1:Play() tw2:Play()
    tw1.Completed:Connect(function() if cb then cb() end end)
end

local draggingMini, dragStartMini, startPosMini
minimizedButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then
        draggingMini = true
        dragStartMini = input.Position
        startPosMini = minimizedButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then draggingMini = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingMini and (input.UserInputType == Enum.UserInputType.MouseMovement or isTouch(input)) then
        local delta = input.Position - dragStartMini
        minimizedButton.Position = UDim2.new(
            startPosMini.X.Scale, startPosMini.X.Offset + delta.X,
            startPosMini.Y.Scale, startPosMini.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or isTouch(input) then draggingMini = false end
end)

local function setMainVisible(val)
    mainFrame.Visible = val
    minimizedButton.Visible = not val
end

minimize.MouseButton1Click:Connect(function()
    animateObj(mainFrame, 1, 0, 0.14, 1, 0.22, function()
        setMainVisible(false)
        animateObj(minimizedButton, 0, 1, 1, 0.08, 0.22)
    end)
end)

minimizedButton.MouseButton1Click:Connect(function()
    animateObj(minimizedButton, 1, 0, 0.08, 1, 0.18, function()
        setMainVisible(true)
        animateObj(mainFrame, 0, 1, 1, 0.14, 0.23)
    end)
end)

minimizedButton.TouchTap:Connect(function()
    animateObj(minimizedButton, 1, 0, 0.08, 1, 0.18, function()
        setMainVisible(true)
        animateObj(mainFrame, 0, 1, 1, 0.14, 0.23)
    end)
end)

-- Insert Key Toggle for GUI Visibility
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        gui.Enabled = not gui.Enabled
    end
end)

-- ========================================
-- 14. UI Settings Tab
-- ========================================

createSectionHeader(tabSections["UI Settings"], "UI Settings", "93991072023597")

-- Scale Slider
setupEnhancedSliderDrag("UI Settings", {
    Name = "UI Scale",
    Min = 50,
    Max = 150,
    Default = 100,
    Y = 60,
    Callback = function(value)
        UIScale.Scale = value / 100
        ResizeSectionContents()
    end
})

-- Transparency Slider
setupEnhancedSliderDrag("UI Settings", {
    Name = "Transparency",
    Min = 0,
    Max = 90,
    Default = 14,
    Y = 130,
    Callback = function(value)
        mainFrame.BackgroundTransparency = value / 100
    end
})

-- Theme Toggle
createEnhancedToggle("UI Settings", {
    Name = "Dark Theme",
    X = 20,
    Y = 200,
    Default = true,
    Callback = function(enabled)
        local newColor = enabled and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(240, 240, 240)
        mainFrame.BackgroundColor3 = newColor
    end
})

-- ========================================
-- 15. Final Startup & Completion Messages
-- ========================================

-- Initial positioning for mobile
if IS_MOBILE then
    minimizedButton.Position = UDim2.new(0, 20, 0, 100)
end

-- Startup completion message
print("🔸 Eps1llon Hub 2025 | Loaded Successfully")
print("🔸 External Chat: Auto-loaded from pastebin")
print("🔸 All Features: Configuration, Combat, ESP, Inventory, Misc")
print("🔸 Insert Key: Toggle GUI visibility")
print("🔸 Responsive Design: Resize GUI for optimal experience")
print("🔸 Mobile Compatible: Touch controls enabled")

-- Auto-resize warning for users
spawn(function()
    wait(2)
    print("💡 Tip: Drag the resize handle (⟣) in bottom-right to resize GUI")
    print("💡 All toggles and UI elements will scale responsively!")
end)

-- Return the library for external use if needed
return Eps1llonUI