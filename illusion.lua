local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local namesEnabled = false
local distanceEnabled = false
local boxEnabled = false
local tracersEnabled = false
local coinEspEnabled = false
local xrayEnabled = false
local autoEquipGunEnabled = false
local shootButtonEnabled = false
local autoShootEnabled = false
local knifeAuraEnabled = false
local knifeAimEnabled = false
local killAllEnabled = false
local aimbotEnabled = false
local silentAimEnabled = false
local gunDropEspEnabled = false
local antiAfkEnabled = false
local fullBrightEnabled = false
local infiniteJumpEnabled = false
local flyEnabled = false
local noclipEnabled = false
local antiFlingEnabled = false
local autoDodgeEnabled = false
local bhopEnabled = false
local spinBotEnabled = false
local autoFarmCoinsEnabled = false
local autoFarmXpEnabled = false
local autoCollectEnabled = false
local autoResetEnabled = false
local autoRejoinEnabled = false

local originalTransparency = {}
local originalLighting = {Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, GlobalShadows = Lighting.GlobalShadows}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Illusion_ModularUI_Pro_Expanded"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 50, 0, 50)
openButton.Position = UDim2.new(0, 25, 0, 25)
openButton.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
openButton.BorderSizePixel = 0
openButton.Text = "ILLUSION"
openButton.TextColor3 = Color3.fromRGB(138, 115, 255)
openButton.TextSize = 10
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Active = true
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 14)
openCorner.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(60, 45, 110)
openStroke.Thickness = 1.5
openStroke.Parent = openButton

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 380)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = mainFrame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(45, 38, 70)
frameStroke.Thickness = 1.8
frameStroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 300, 1, 0)
titleText.Position = UDim2.new(0, 20, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ILLUSION <font color='#8a73ff'>MODULE PRO</font>"
titleText.RichText = true
titleText.TextColor3 = Color3.fromRGB(245, 245, 250)
titleText.TextSize = 17
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local collapseButton = Instance.new("TextButton")
collapseButton.Name = "CollapseButton"
collapseButton.Size = UDim2.new(0, 32, 0, 32)
collapseButton.Position = UDim2.new(1, -45, 0.5, -16)
collapseButton.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
collapseButton.Text = "—"
collapseButton.TextColor3 = Color3.fromRGB(180, 180, 200)
collapseButton.TextSize = 14
collapseButton.Font = Enum.Font.GothamBold
collapseButton.Parent = titleBar

local collapseCorner = Instance.new("UICorner")
collapseCorner.CornerRadius = UDim.new(0, 10)
collapseCorner.Parent = collapseButton

local tabHolder = Instance.new("ScrollingFrame")
tabHolder.Name = "TabHolder"
tabHolder.Size = UDim2.new(0, 120, 1, -65)
tabHolder.Position = UDim2.new(0, 15, 0, 55)
tabHolder.BackgroundTransparency = 1
tabHolder.ScrollBarThickness = 0
tabHolder.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabHolder

local containerHolder = Instance.new("Folder")
containerHolder.Name = "ContainerHolder"
containerHolder.Parent = mainFrame

local tabs = {"ESP", "COMBAT", "MURDER", "AUTOFARM", "TELEPORT", "PLAYER", "VISUAL", "SETTINGS"}
local pages = {}

for i, tabName in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "Tab"
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(22, 19, 32) or Color3.fromRGB(13, 13, 17)
    tabBtn.TextColor3 = (i == 1) and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(140, 140, 165)
    tabBtn.TextSize = 11
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Text = "  " .. tabName
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.Parent = tabHolder
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, -150, 1, -65)
    page.Position = UDim2.new(0, 140, 0, 55)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.Visible = (i == 1)
    page.Parent = containerHolder

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    pages[tabName] = {Page = page, Button = tabBtn}

    tabBtn.MouseButton1Click:Connect(function()
        for name, pData in pairs(pages) do
            pData.Page.Visible = (name == tabName)
            pData.Button.BackgroundColor3 = (name == tabName) and Color3.fromRGB(22, 19, 32) or Color3.fromRGB(13, 13, 17)
            pData.Button.TextColor3 = (name == tabName) and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(140, 140, 165)
        end
    end)
end

local function makeDraggable(topbarobject, object)
    local dragging = false
    local dragStart, startPos

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                local delta = input.Position - dragStart
                object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

makeDraggable(titleBar, mainFrame)
makeDraggable(openButton, openButton)

collapseButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openButton.Visible = false
end)
local function createButton(parent, text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(15, 14, 19)
    btn.TextColor3 = defaultState and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(175, 175, 195)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = defaultState and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(30, 26, 45)
    stroke.Thickness = 1.2
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local newState = callback(btn)
        if newState ~= nil then
            stroke.Color = newState and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(30, 26, 45)
            btn.TextColor3 = newState and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(175, 175, 195)
        end
    end)
    return btn
end

local function createStandardButton(tabName, text, defaultState, callback)
    return createButton(pages[tabName].Page, text, defaultState, callback)
end

createStandardButton("ESP", "ESP: OFF", false, function(btn)
    espEnabled = not espEnabled
    btn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    return espEnabled
end)

createStandardButton("ESP", "Names: OFF", false, function(btn)
    namesEnabled = not namesEnabled
    btn.Text = namesEnabled and "Names: ON" or "Names: OFF"
    return namesEnabled
end)

createStandardButton("ESP", "Distance: OFF", false, function(btn)
    distanceEnabled = not distanceEnabled
    btn.Text = distanceEnabled and "Distance: ON" or "Distance: OFF"
    return distanceEnabled
end)

createStandardButton("ESP", "Boxes: OFF", false, function(btn)
    boxEnabled = not boxEnabled
    btn.Text = boxEnabled and "Boxes: ON" or "Boxes: OFF"
    return boxEnabled
end)

createStandardButton("ESP", "Tracers: OFF", false, function(btn)
    tracersEnabled = not tracersEnabled
    btn.Text = tracersEnabled and "Tracers: ON" or "Tracers: OFF"
    return tracersEnabled
end)

createStandardButton("ESP", "Coin ESP: OFF", false, function(btn)
    coinEspEnabled = not coinEspEnabled
    btn.Text = coinEspEnabled and "Coin ESP: ON" or "Coin ESP: OFF"
    return coinEspEnabled
end)

createStandardButton("ESP", "Gun Drop ESP: OFF", false, function(btn)
    gunDropEspEnabled = not gunDropEspEnabled
    btn.Text = gunDropEspEnabled and "Gun Drop ESP: ON" or "Gun Drop ESP: OFF"
    return gunDropEspEnabled
end)

createStandardButton("COMBAT", "Auto Selection: OFF", false, function(btn)
    autoEquipGunEnabled = not autoEquipGunEnabled
    btn.Text = autoEquipGunEnabled and "Auto Selection: ON" or "Auto Selection: OFF"
    return autoEquipGunEnabled
end)

local floatingShootBtn = Instance.new("TextButton")
floatingShootBtn.Name = "FloatingShootButton"
floatingShootBtn.Size = UDim2.new(0, 110, 0, 45)
floatingShootBtn.Position = UDim2.new(0.8, 0, 0.7, 0)
floatingShootBtn.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
floatingShootBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
floatingShootBtn.TextSize = 14
floatingShootBtn.Font = Enum.Font.GothamBold
floatingShootBtn.Text = "SHOOT"
floatingShootBtn.Visible = false
floatingShootBtn.Active = true
floatingShootBtn.Draggable = true
floatingShootBtn.Parent = screenGui

local fCorner = Instance.new("UICorner")
fCorner.CornerRadius = UDim.new(0, 10)
fCorner.Parent = floatingShootBtn

local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(255, 75, 75)
fStroke.Thickness = 1.5
fStroke.Parent = floatingShootBtn

createStandardButton("COMBAT", "Shoot Button: OFF", false, function(btn)
    shootButtonEnabled = not shootButtonEnabled
    btn.Text = shootButtonEnabled and "Shoot Button: ON" or "Shoot Button: OFF"
    floatingShootBtn.Visible = shootButtonEnabled
    return shootButtonEnabled
end)

createStandardButton("COMBAT", "Auto Shoot: OFF", false, function(btn)
    autoShootEnabled = not autoShootEnabled
    btn.Text = autoShootEnabled and "Auto Shoot: ON" or "Auto Shoot: OFF"
    return autoShootEnabled
end)

createStandardButton("COMBAT", "Auto Grab Gun: OFF", false, function(btn)
    autoCollectEnabled = not autoCollectEnabled
    btn.Text = autoCollectEnabled and "Auto Grab Gun: ON" or "Auto Grab Gun: OFF"
    return autoCollectEnabled
end)

createStandardButton("COMBAT", "Aimbot: OFF", false, function(btn)
    aimbotEnabled = not aimbotEnabled
    btn.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
    return aimbotEnabled
end)

createStandardButton("COMBAT", "Silent Aim: OFF", false, function(btn)
    silentAimEnabled = not silentAimEnabled
    btn.Text = silentAimEnabled and "Silent Aim: ON" or "Silent Aim: OFF"
    return silentAimEnabled
end)

local floatingThrowBtn = Instance.new("TextButton")
floatingThrowBtn.Name = "FloatingThrowButton"
floatingThrowBtn.Size = UDim2.new(0, 110, 0, 45)
floatingThrowBtn.Position = UDim2.new(0.8, 0, 0.55, 0)
floatingThrowBtn.BackgroundColor3 = Color3.fromRGB(30, 18, 18)
floatingThrowBtn.TextColor3 = Color3.fromRGB(255, 120, 80)
floatingThrowBtn.TextSize = 14
floatingThrowBtn.Font = Enum.Font.GothamBold
floatingThrowBtn.Text = "THROW"
floatingThrowBtn.Visible = false
floatingThrowBtn.Active = true
floatingThrowBtn.Draggable = true
floatingThrowBtn.Parent = screenGui

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 10)
tCorner.Parent = floatingThrowBtn

local tStroke = Instance.new("UIStroke")
tStroke.Color = Color3.fromRGB(255, 100, 75)
tStroke.Thickness = 1.5
tStroke.Parent = floatingThrowBtn

createStandardButton("MURDER", "Auto Throw Button: OFF", false, function(btn)
    local state = btn.Text:find("OFF") ~= nil
    btn.Text = state and "Auto Throw Button: ON" or "Auto Throw Button: OFF"
    floatingThrowBtn.Visible = state
    return state
end)

createStandardButton("MURDER", "Knife Aura: OFF", false, function(btn)
    knifeAuraEnabled = not knifeAuraEnabled
    btn.Text = knifeAuraEnabled and "Knife Aura: ON" or "Knife Aura: OFF"
    return knifeAuraEnabled
end)

createStandardButton("MURDER", "Knife Aim: OFF", false, function(btn)
    knifeAimEnabled = not knifeAimEnabled
    btn.Text = knifeAimEnabled and "Knife Aim: ON" or "Knife Aim: OFF"
    return knifeAimEnabled
end)

createStandardButton("MURDER", "Kill All: OFF", false, function(btn)
    killAllEnabled = not killAllEnabled
    btn.Text = killAllEnabled and "Kill All: ON" or "Kill All: OFF"
    return killAllEnabled
end)

createStandardButton("AUTOFARM", "Auto Farm Coins: OFF", false, function(btn)
    autoFarmCoinsEnabled = not autoFarmCoinsEnabled
    btn.Text = autoFarmCoinsEnabled and "Auto Farm Coins: ON" or "Auto Farm Coins: OFF"
    return autoFarmCoinsEnabled
end)

createStandardButton("AUTOFARM", "Auto Farm XP: OFF", false, function(btn)
    autoFarmXpEnabled = not autoFarmXpEnabled
    btn.Text = autoFarmXpEnabled and "Auto Farm XP: ON" or "Auto Farm XP: OFF"
    return autoFarmXpEnabled
end)

createStandardButton("AUTOFARM", "Auto Collect: OFF", false, function(btn)
    autoCollectEnabled = not autoCollectEnabled
    btn.Text = autoCollectEnabled and "Auto Collect: ON" or "Auto Collect: OFF"
    return autoCollectEnabled
end)

createStandardButton("TELEPORT", "Teleport to Lobby", false, function()
    local lobbyPart = Workspace:FindFirstChild("Lobby") or Workspace:FindFirstChild("SpawnLocation")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and lobbyPart then
        local pos = lobbyPart:IsA("BasePart") and lobbyPart.CFrame or (lobbyPart:IsA("Model") and lobbyPart:GetModelCFrame())
        if pos then LocalPlayer.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0, 5, 0) end
    end
end)

createStandardButton("TELEPORT", "Teleport to Player", false, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(3, 0, 3)
                break
            end
        end
    end
end)

createStandardButton("TELEPORT", "Teleport to Sheriff", false, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local bp = p:FindFirstChildOfClass("Backpack")
            local char = p.Character
            if (bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver"))) or char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") then
                if char:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(3, 0, 3)
                    break
                end
            end
        end
    end
end)

createStandardButton("TELEPORT", "Teleport to Murderer", false, function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local bp = p:FindFirstChildOfClass("Backpack")
            local char = p.Character
            if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                if char:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(3, 0, 3)
                    break
                end
            end
        end
    end
end)

createStandardButton("PLAYER", "Infinite Jump: OFF", false, function(btn)
    infiniteJumpEnabled = not infiniteJumpEnabled
    btn.Text = infiniteJumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
    return infiniteJumpEnabled
end)

createStandardButton("PLAYER", "Fly: OFF", false, function(btn)
    flyEnabled = not flyEnabled
    btn.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    return flyEnabled
end)

createStandardButton("PLAYER", "Noclip: OFF", false, function(btn)
    noclipEnabled = not noclipEnabled
    btn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    return noclipEnabled
end)

createStandardButton("PLAYER", "Anti-Fling: OFF", false, function(btn)
    antiFlingEnabled = not antiFlingEnabled
    btn.Text = antiFlingEnabled and "Anti-Fling: ON" or "Anti-Fling: OFF"
    return antiFlingEnabled
end)

createStandardButton("PLAYER", "Auto Dodge: OFF", false, function(btn)
    autoDodgeEnabled = not autoDodgeEnabled
    btn.Text = autoDodgeEnabled and "Auto Dodge: ON" or "Auto Dodge: OFF"
    return autoDodgeEnabled
end)

createStandardButton("PLAYER", "Bhop: OFF", false, function(btn)
    bhopEnabled = not bhopEnabled
    btn.Text = bhopEnabled and "Bhop: ON" or "Bhop: OFF"
    return bhopEnabled
end)

createStandardButton("PLAYER", "Spin Bot: OFF", false, function(btn)
    spinBotEnabled = not spinBotEnabled
    btn.Text = spinBotEnabled and "Spin Bot: ON" or "Spin Bot: OFF"
    return spinBotEnabled
end)

createStandardButton("VISUAL", "X-Ray: OFF", false, function(btn)
    xrayEnabled = not xrayEnabled
    btn.Text = xrayEnabled and "X-Ray: ON" or "X-Ray: OFF"
    if xrayEnabled then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 0.6
            end
        end
    else
        for part, trans in pairs(originalTransparency) do
            if part and part.Parent then part.Transparency = trans end
        end
        originalTransparency = {}
    end
    return xrayEnabled
end)

createStandardButton("VISUAL", "FullBright: OFF", false, function(btn)
    fullBrightEnabled = not fullBrightEnabled
    btn.Text = fullBrightEnabled and "FullBright: ON" or "FullBright: OFF"
    if fullBrightEnabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.GlobalShadows = originalLighting.GlobalShadows
    end
    return fullBrightEnabled
end)

createStandardButton("VISUAL", "FOV Changer", false, function()
    Camera.FieldOfView = Camera.FieldOfView == 70 and 110 or 70
end)

createStandardButton("VISUAL", "Freecam", false, function() end)
createStandardButton("VISUAL", "Emote Unlocker", false, function() end)

createStandardButton("SETTINGS", "Anti-AFK: OFF", false, function(btn)
    antiAfkEnabled = not antiAfkEnabled
    btn.Text = antiAfkEnabled and "Anti-AFK: ON" or "Anti-AFK: OFF"
    if antiAfkEnabled then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if antiAfkEnabled then
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
    end
    return antiAfkEnabled
end)

createStandardButton("SETTINGS", "Server Hop", false, function()
    local servers = {}
    local success, result = pcall(function()
        return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if success and result and result.data then
        for _, s in ipairs(result.data) do
            if type(s) == "table" and s.playing < s.maxPlayers and s.id ~= game.JobId then
                table.insert(servers, s.id)
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        end
    end
end)

createStandardButton("SETTINGS", "Auto Open Boxes", false, function() end)
createStandardButton("SETTINGS", "Auto Reset", false, function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

createStandardButton("SETTINGS", "Auto Rejoin: OFF", false, function(btn)
    autoRejoinEnabled = not autoRejoinEnabled
    btn.Text = autoRejoinEnabled and "Auto Rejoin: ON" or "Auto Rejoin: OFF"
    return autoRejoinEnabled
end)

createStandardButton("SETTINGS", "Rejoin Server", false, function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

createStandardButton("SETTINGS", "Hide GUI", false, function()
    mainFrame.Visible = false
    openButton.Visible = true
end)

createStandardButton("SETTINGS", "Save Config", false, function() end)
createStandardButton("SETTINGS", "Mobile Support", false, function() end)
createStandardButton("SETTINGS", "Keybinds", false, function() end)
local function getRole(player)
    if not player.Character then return "Innocent", Color3.fromRGB(0, 255, 0) end
    local backpack = player:FindFirstChildOfClass("Backpack")
    local character = player.Character
    local hasGun = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or character:FindFirstChild("Gun") or character:FindFirstChild("Revolver")
    local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or character:FindFirstChild("Knife")
    if hasKnife then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif hasGun then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    else
        return "Innocent", Color3.fromRGB(0, 255, 0)
    end
end

local function getMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local backpack = player:FindFirstChildOfClass("Backpack")
            local char = player.Character
            if (backpack and backpack:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then
                return player
            end
        end
    end
    return nil
end

local function shootMurderer()
    local char = LocalPlayer.Character
    if not char then return end
    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") 
    if not gun and LocalPlayer:FindFirstChildOfClass("Backpack") then
        gun = LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
        if gun and char:FindFirstChild("Humanoid") then
            char.Humanoid:EquipTool(gun)
            task.wait(0.05)
        end
    end
    local murderer = getMurderer()
    if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
        local mPos = murderer.Character.HumanoidRootPart.Position
        local shootEvent = ReplicatedStorage:FindFirstChild("Shoot", true) or (gun and gun:FindFirstChild("Shoot"))
        if shootEvent and shootEvent:IsA("RemoteEvent") then
            shootEvent:FireServer(mPos, mPos)
        elseif gun and gun:FindFirstChild("KnifeServer") then
            gun.KnifeServer:InvokeServer(mPos)
        elseif gun then
            pcall(function() gun:Activate() end)
        end
    end
end

floatingShootBtn.MouseButton1Click:Connect(shootMurderer)

floatingThrowBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife") or (LocalPlayer:FindFirstChildOfClass("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
    if knife then
        if knife.Parent ~= char and char:FindFirstChild("Humanoid") then
            char.Humanoid:EquipTool(knife)
            task.wait(0.05)
        end
        local target = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                target = p.Character.HumanoidRootPart.Position
                break
            end
        end
        if target then
            local throwEvent = ReplicatedStorage:FindFirstChild("Throw", true) or knife:FindFirstChild("Throw") or knife:FindFirstChild("KnifeRemote")
            if throwEvent and throwEvent:IsA("RemoteEvent") then
                throwEvent:FireServer(target)
            else
                knife:Activate()
            end
        end
    end
end)

local function autoCollectGun()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hasGun = (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")) or 
                   (LocalPlayer:FindFirstChildOfClass("Backpack") and (LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")))
    if not hasGun then
        local hrp = char.HumanoidRootPart
        for _, obj in ipairs(Workspace:GetChildren()) do
            if (obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name == "DropPickup") and not obj:FindFirstChildOfClass("Humanoid") then
                local handle = obj:FindFirstChild("Handle") or obj:FindFirstChild("Part") or (obj:IsA("BasePart") and obj)
                if handle then
                    local oldCFrame = hrp.CFrame
                    hrp.CFrame = handle.CFrame
                    task.wait(0.05)
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = oldCFrame
                    end
                    break
                end
            end
        end
    end
end

local function applyESP(player)
    if player == LocalPlayer then return end
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = 2
    box.Filled = false

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5

    local function setupCharacter(character)
        if character:FindFirstChild("Highlight") then return end
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.Adornee = character
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.Parent = character

        local rootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not rootPart then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "MM2_ESP"
        billboard.Adornee = rootPart
        billboard.Size = UDim2.new(0, 120, 0, 60)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 9e9

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Info"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Parent = billboard
        billboard.Parent = character

        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not character or not character.Parent or not rootPart.Parent or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                box.Visible = false
                tracer.Visible = false
                highlight.Enabled = false
                billboard.Enabled = false
                return
            end
            highlight.Enabled = espEnabled
            billboard.Enabled = namesEnabled or distanceEnabled

            local role, color = getRole(player)
            highlight.FillColor = color

            local displayText = namesEnabled and (player.Name .. "\n[" .. role .. "]") or ("[" .. role .. "]")
            if distanceEnabled then
                local dist = math.floor((rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                displayText = displayText .. " (" .. dist .. "m)"
            end

            textLabel.Text = displayText
            textLabel.TextColor3 = color

            if boxEnabled then
                local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local height = 2500 / vector.Z
                    local width = height / 2
                    box.Size = Vector2.new(width, height)
                    box.Position = Vector2.new(vector.X - width / 2, vector.Y - height / 2)
                    box.Color = color
                    box.Visible = true
                else
                    box.Visible = false
                end
            else
                box.Visible = false
            end

            if tracersEnabled then
                local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(vector.X, vector.Y)
                    tracer.Color = color
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        end)

        player.CharacterRemoving:Connect(function()
            box.Visible = false
            tracer.Visible = false
            if connection then connection:Disconnect() end
        end)
    end

    player.CharacterAdded:Connect(setupCharacter)
    if player.Character then task.spawn(function() setupCharacter(player.Character) end) end
end

for _, player in ipairs(Players:GetPlayers()) do applyESP(player) end
Players.PlayerAdded:Connect(applyESP)

RunService.Heartbeat:Connect(function()
    if autoEquipGunEnabled or autoCollectEnabled then autoCollectGun() end
    if autoShootEnabled then shootMurderer() end

    if infiniteJumpEnabled then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.StateChanged:Connect(function(_, new)
                if new == Enum.HumanoidStateType.Jumping and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                end
            end)
        end
    end

    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
    end

    if noclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if spinBotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(25), 0)
    end

    if knifeAuraEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local knife = LocalPlayer.Character:FindFirstChild("Knife") or (LocalPlayer:FindFirstChildOfClass("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
        if knife then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        knife:Activate()
                    end
                end
            end
        end
    end

    for _, obj in ipairs(Workspace:GetChildren()) do
        if (obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name == "DropPickup") and not obj:FindFirstChildOfClass("Humanoid") then
            if gunDropEspEnabled and not obj:FindFirstChild("GunHighlight") then
                local hl = Instance.new("Highlight")
                hl.Name = "GunHighlight"
                hl.Adornee = obj
                hl.FillColor = Color3.fromRGB(255, 255, 0)
                hl.FillTransparency = 0.3
                hl.Parent = obj
            elseif not gunDropEspEnabled then
                local hl = obj:FindFirstChild("GunHighlight")
                if hl then hl:Destroy() end
            end
        end
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "Coin_Server" or obj.Name:lower():find("coin") or obj.Name:lower():find("idiot") then
            if coinEspEnabled then
                if not obj:FindFirstChild("CoinHighlight") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                    local coinHighlight = Instance.new("Highlight")
                    coinHighlight.Name = "CoinHighlight"
                    coinHighlight.Adornee = obj
                    coinHighlight.FillColor = Color3.fromRGB(0, 255, 255)
                    coinHighlight.FillTransparency = 0.4
                    coinHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    coinHighlight.Parent = obj
                end
            else
                local chl = obj:FindFirstChild("CoinHighlight")
                if chl then chl:Destroy() end
            end
        end
    end
end)
