local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
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

local originalTransparency = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Illusion_ModularUI_Pro"
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
mainFrame.Size = UDim2.new(0, 540, 0, 360)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
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
titleText.Text = "ILLUSION <font color='#8a73ff'>MODULE</font>"
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
tabHolder.Size = UDim2.new(0, 130, 1, -65)
tabHolder.Position = UDim2.new(0, 15, 0, 55)
tabHolder.BackgroundTransparency = 1
tabHolder.ScrollBarThickness = 0
tabHolder.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabHolder

local containerHolder = Instance.new("Folder")
containerHolder.Name = "ContainerHolder"
containerHolder.Parent = mainFrame

local tabs = {"ESP", "COMBAT", "PLAYER", "ANIMATIONS", "VISUAL", "SETTINGS"}
local pages = {}

for i, tabName in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "Tab"
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(22, 19, 32) or Color3.fromRGB(13, 13, 17)
    tabBtn.TextColor3 = (i == 1) and Color3.fromRGB(138, 115, 255) or Color3.fromRGB(140, 140, 165)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Text = "    " .. tabName
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.Parent = tabHolder
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, -165, 1, -65)
    page.Position = UDim2.new(0, 155, 0, 55)
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
    btn.Size = UDim2.new(1, 0, 0, 38)
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

local combatPage = pages["COMBAT"].Page
local combatContainer = Instance.new("Frame")
combatContainer.Size = UDim2.new(1, -5, 0, 260)
combatContainer.BackgroundTransparency = 1
combatContainer.Parent = combatPage

local sheriffColumn = Instance.new("ScrollingFrame")
sheriffColumn.Size = UDim2.new(0.48, 0, 1, 0)
sheriffColumn.Position = UDim2.new(0, 0, 0, 0)
sheriffColumn.BackgroundTransparency = 1
sheriffColumn.ScrollBarThickness = 2
sheriffColumn.Parent = combatContainer

local sheriffLayout = Instance.new("UIListLayout")
sheriffLayout.SortOrder = Enum.SortOrder.LayoutOrder
sheriffLayout.Padding = UDim.new(0, 8)
sheriffLayout.Parent = sheriffColumn

local sheriffHeader = Instance.new("TextLabel")
sheriffHeader.Size = UDim2.new(1, 0, 0, 24)
sheriffHeader.BackgroundTransparency = 1
sheriffHeader.Text = "SHERIFF"
sheriffHeader.TextColor3 = Color3.fromRGB(90, 150, 255)
sheriffHeader.TextSize = 12
sheriffHeader.Font = Enum.Font.GothamBold
sheriffHeader.Parent = sheriffColumn

createButton(sheriffColumn, "Auto Selection: OFF", false, function(btn)
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

createButton(sheriffColumn, "Shoot Button: OFF", false, function(btn)
    shootButtonEnabled = not shootButtonEnabled
    btn.Text = shootButtonEnabled and "Shoot Button: ON" or "Shoot Button: OFF"
    floatingShootBtn.Visible = shootButtonEnabled
    return shootButtonEnabled
end)

local murderColumn = Instance.new("ScrollingFrame")
murderColumn.Size = UDim2.new(0.48, 0, 1, 0)
murderColumn.Position = UDim2.new(0.52, 0, 0, 0)
murderColumn.BackgroundTransparency = 1
murderColumn.ScrollBarThickness = 2
murderColumn.Parent = combatContainer

local murderLayout = Instance.new("UIListLayout")
murderLayout.SortOrder = Enum.SortOrder.LayoutOrder
murderLayout.Padding = UDim.new(0, 8)
murderLayout.Parent = murderColumn

local murderHeader = Instance.new("TextLabel")
murderHeader.Size = UDim2.new(1, 0, 0, 24)
murderHeader.BackgroundTransparency = 1
murderHeader.Text = "MURDER"
murderHeader.TextColor3 = Color3.fromRGB(255, 75, 75)
murderHeader.TextSize = 12
murderHeader.Font = Enum.Font.GothamBold
murderHeader.Parent = murderColumn

createButton(murderColumn, "Aimbot (Coming Soon)", false, function() end)

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
            if part and part.Parent then
                part.Transparency = trans
            end
        end
        originalTransparency = {}
    end
    return xrayEnabled
end)

createStandardButton("PLAYER", "Speed Boost (Coming Soon)", false, function() end)
createStandardButton("ANIMATIONS", "Custom Anim (Coming Soon)", false, function() end)
createStandardButton("SETTINGS", "Rejoin Server", false, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
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

floatingShootBtn.MouseButton1Click:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local role, _ = getRole(player)
            if role == "Murderer" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local mRoot = player.Character.HumanoidRootPart
                local char = LocalPlayer.Character
                if char then
                    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or (LocalPlayer.Backpack and (LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")))
                    if gun and gun:IsA("Tool") then
                        if gun.Parent ~= char then
                            LocalPlayer.Character.Humanoid:EquipTool(gun)
                        end
                        if gun:FindFirstChild("Shoot") then
                            gun.Shoot:FireServer(mRoot.Position, mRoot.Position)
                        elseif gun:FindFirstChild("KnifeServer") then
                            gun.KnifeServer:InvokeServer(mRoot.Position)
                        else
                            pcall(function()
                                gun:Activate()
                            end)
                        end
                    end
                end
                break
            end
        end
    end
end)

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

            local displayText = ""
            if namesEnabled then
                displayText = player.Name .. "\n[" .. role .. "]"
            else
                displayText = "[" .. role .. "]"
            end

            if distanceEnabled then
                local dist = math.floor((rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                if namesEnabled then
                    displayText = displayText .. " (" .. dist .. "m)"
                else
                    displayText = "[" .. role .. "] (" .. dist .. "m)"
                end
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
            if connection then
                connection:Disconnect()
            end
        end)
    end

    player.CharacterAdded:Connect(setupCharacter)
    if player.Character then
        task.spawn(function()
            setupCharacter(player.Character)
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    applyESP(player)
end

Players.PlayerAdded:Connect(applyESP)

RunService.Heartbeat:Connect(function()
    if autoEquipGunEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "Gun" or obj.Name == "Revolver" or obj.Name == "DropPickup" then
                local handle = obj:FindFirstChild("Handle") or obj:FindFirstChild("Part") or (obj:IsA("BasePart") and obj)
                if handle then
                    local oldCFrame = hrp.CFrame
                    hrp.CFrame = handle.CFrame
                    task.wait()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
                    end
                    break
                end
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
