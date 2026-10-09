local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local espEnabled = true
local namesEnabled = true
local distanceEnabled = true
local boxEnabled = false
local tracersEnabled = false
local gunEspEnabled = false
local coinEspEnabled = false
local xrayEnabled = false
local hitboxEnabled = false

local originalTransparency = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2_Menu"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 40, 0, 40)
openButton.Position = UDim2.new(0, 20, 0, 20)
openButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
openButton.BorderSizePixel = 0
openButton.Text = "MM"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 14
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Active = true
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openButton

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 280)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = mainFrame

local titleBar = Instance.new("TextButton")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.Text = "  MM2 Hub"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.TextSize = 14
titleBar.Font = Enum.Font.GothamBold
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local collapseButton = Instance.new("TextButton")
collapseButton.Name = "CollapseButton"
collapseButton.Size = UDim2.new(0, 30, 0, 30)
collapseButton.Position = UDim2.new(1, -35, 0, 2)
collapseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
collapseButton.Text = "X"
collapseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
collapseButton.TextSize = 14
collapseButton.Font = Enum.Font.GothamBold
collapseButton.Parent = titleBar

local collapseCorner = Instance.new("UICorner")
collapseCorner.CornerRadius = UDim.new(0, 6)
collapseCorner.Parent = collapseButton

local tabHolder = Instance.new("ScrollingFrame")
tabHolder.Name = "TabHolder"
tabHolder.Size = UDim2.new(0, 100, 1, -45)
tabHolder.Position = UDim2.new(0, 5, 0, 40)
tabHolder.BackgroundTransparency = 1
tabHolder.ScrollBarThickness = 2
tabHolder.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabHolder

local containerHolder = Instance.new("Folder")
containerHolder.Name = "ContainerHolder"
containerHolder.Parent = mainFrame

local tabs = {"ESP", "COMBAT", "PLAYER", "ANIMATIONS", "VISUAL", "SETTINGS"}
local pages = {}

for i, tabName in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "Tab"
    tabBtn.Size = UDim2.new(1, 0, 0, 30)
    tabBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(35, 35, 35)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.Text = tabName
    tabBtn.Parent = tabHolder
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, -115, 1, -45)
    page.Position = UDim2.new(0, 110, 0, 40)
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
            pData.Button.BackgroundColor3 = (name == tabName) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(35, 35, 35)
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
local function createButton(tabName, text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 35)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.Parent = pages[tabName].Page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

createButton("ESP", "ESP: ON", true, function(btn)
    espEnabled = not espEnabled
    btn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    btn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "Names: ON", true, function(btn)
    namesEnabled = not namesEnabled
    btn.Text = namesEnabled and "Names: ON" or "Names: OFF"
    btn.BackgroundColor3 = namesEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "Distance: ON", true, function(btn)
    distanceEnabled = not distanceEnabled
    btn.Text = distanceEnabled and "Distance: ON" or "Distance: OFF"
    btn.BackgroundColor3 = distanceEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "Boxes: OFF", false, function(btn)
    boxEnabled = not boxEnabled
    btn.Text = boxEnabled and "Boxes: ON" or "Boxes: OFF"
    btn.BackgroundColor3 = boxEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "Tracers: OFF", false, function(btn)
    tracersEnabled = not tracersEnabled
    btn.Text = tracersEnabled and "Tracers: ON" or "Tracers: OFF"
    btn.BackgroundColor3 = tracersEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "ESP Gun: OFF", false, function(btn)
    gunEspEnabled = not gunEspEnabled
    btn.Text = gunEspEnabled and "ESP Gun: ON" or "ESP Gun: OFF"
    btn.BackgroundColor3 = gunEspEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("ESP", "Coin ESP: OFF", false, function(btn)
    coinEspEnabled = not coinEspEnabled
    btn.Text = coinEspEnabled and "Coin ESP: ON" or "Coin ESP: OFF"
    btn.BackgroundColor3 = coinEspEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("COMBAT", "Hitboxes: OFF", false, function(btn)
    hitboxEnabled = not hitboxEnabled
    btn.Text = hitboxEnabled and "Hitboxes: ON" or "Hitboxes: OFF"
    btn.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
end)

createButton("VISUAL", "X-Ray: OFF", false, function(btn)
    xrayEnabled = not xrayEnabled
    btn.Text = xrayEnabled and "X-Ray: ON" or "X-Ray: OFF"
    btn.BackgroundColor3 = xrayEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 45, 45)
    
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
end)

createButton("COMBAT", "Aimbot (Coming Soon)", false, function() end)
createButton("PLAYER", "Speed Boost (Coming Soon)", false, function() end)
createButton("ANIMATIONS", "Custom Anim (Coming Soon)", false, function() end)
createButton("SETTINGS", "Rejoin Server", false, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
local function getRole(player)
    if not player.Character then return "Innocent", Color3.fromRGB(0, 255, 0) end
    
    local backpack = player:FindFirstChildOfClass("Backpack")
    local character = player.Character
    
    local hasGun = false
    local hasKnife = false

    -- Глубокая проверка рюкзака и персонажа на наличие оружия (срабатывает сразу на 10-секундном таймере)
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            local name = item.Name:lower()
            if name:find("gun") or name:find("revolver") then hasGun = true end
            if name:find("knife") then hasKnife = true end
        end
    end

    if character then
        for _, item in ipairs(character:GetChildren()) do
            local name = item.Name:lower()
            if name:find("gun") or name:find("revolver") then hasGun = true end
            if name:find("knife") then hasKnife = true end
        end
    end
    
    if hasKnife then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif hasGun then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    else
        return "Innocent", Color3.fromRGB(0, 255, 0)
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
        billboard.Size = UDim2.new(0, 150, 0, 70)
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
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                if hitboxEnabled then
                    local _, color = getRole(player)
                    rootPart.Size = Vector3.new(4, 4, 4)
                    rootPart.Transparency = 0.7
                    rootPart.Color = color
                    rootPart.CanCollide = false
                else
                    rootPart.Size = Vector3.new(2, 2, 1)
                    rootPart.Transparency = 1
                end
            end
        end
    end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" then
            if gunEspEnabled then
                if not obj:FindFirstChild("GunHighlight") and (obj:IsA("Model") or obj:IsA("BasePart")) then
                    local gunHighlight = Instance.new("Highlight")
                    gunHighlight.Name = "GunHighlight"
                    gunHighlight.Adornee = obj
                    gunHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                    gunHighlight.FillTransparency = 0.3
                    gunHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    gunHighlight.Parent = obj

                    local partToAdorn = obj:IsA("Model") and obj.PrimaryPart or obj
                    if partToAdorn then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "GunTag"
                        billboard.Adornee = partToAdorn
                        billboard.Size = UDim2.new(0, 90, 0, 35)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.MaxDistance = 9e9

                        local txt = Instance.new("TextLabel")
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextScaled = true
                        txt.Font = Enum.Font.SourceSansBold
                        txt.Text = "DROP GUN"
                        txt.TextColor3 = Color3.fromRGB(255, 255, 0)
                        txt.TextStrokeTransparency = 0
                        txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        txt.Parent = billboard
                        billboard.Parent = obj
                    end
                end
            else
                local hl = obj:FindFirstChild("GunHighlight")
                if hl then hl:Destroy() end
                local tag = obj:FindFirstChild("GunTag")
                if tag then tag:Destroy() end
            end
        end

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
