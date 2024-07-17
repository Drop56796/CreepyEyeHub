local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
end)

if not success then
    warn("Failed to load UI library")
    return
end

local GUIWindow = Library:CreateWindow({
    Name = "Creepy Client V2.01",
    Themeable = false
})

local GUI = GUIWindow:CreateTab({
    Name = "主功能"
})

local window_player = GUI:CreateSection({
    Name = "玩家"
})

local camfovslider = window_player:AddSlider({
    Name = "FOV",
    Value = 70,
    Min = 50,
    Max = 120,
    Callback = function(Value)
        game:GetService("Workspace").CurrentCamera.FieldOfView = Value
    end
})

local PlayerWalkSpeedSlider = window_player:AddSlider({
    Name = "Speed",
    Value = 20,
    Min = 1,
    Max = 75,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local PlayerGravitySlider = window_player:AddSlider({
    Name = "Gravity",
    Value = 1,
    Min = 1,
    Max = 100,
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end
})

local PlayerJumpPowerSlider = window_player:AddSlider({
    Name = "JumpPower",
    Value = 1,
    Min = 1,
    Max = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

local playerESP = window_player:AddToggle({
    Name = "Freecam",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        local camera = workspace.CurrentCamera
        local speed = 1
        local touchControls = {}

        local function isMobile()
            return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        end

        if state then
            camera.CameraType = Enum.CameraType.Scriptable
            if isMobile() then
                _G.Freecam = runService.RenderStepped:Connect(function()
                    local moveDirection = Vector3.new()
                    if touchControls["MoveForward"] then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if touchControls["MoveBackward"] then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if touchControls["MoveLeft"] then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if touchControls["MoveRight"] then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if touchControls["MoveUp"] then
                        moveDirection = moveDirection + camera.CFrame.UpVector
                    end
                    if touchControls["MoveDown"] then
                        moveDirection = moveDirection - camera.CFrame.UpVector
                    end

                    camera.CFrame = camera.CFrame + moveDirection * speed
                end)

                UserInputService.TouchStarted:Connect(function(touch, gameProcessedEvent)
                    if not gameProcessedEvent then
                        if touch.Position.Y < workspace.CurrentCamera.ViewportSize.Y / 2 then
                            touchControls["MoveForward"] = true
                        else
                            touchControls["MoveBackward"] = true
                        end
                    end
                end)

                UserInputService.TouchEnded:Connect(function(touch, gameProcessedEvent)
                    if not gameProcessedEvent then
                        touchControls["MoveForward"] = false
                        touchControls["MoveBackward"] = false
                    end
                end)
            else
                _G.Freecam = runService.RenderStepped:Connect(function()
                    local moveDirection = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                        moveDirection = moveDirection - camera.CFrame.UpVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                        moveDirection = moveDirection + camera.CFrame.UpVector
                    end

                    camera.CFrame = camera.CFrame + moveDirection * speed
                end)
            end
        else
            if _G.Freecam then
                _G.Freecam:Disconnect()
                _G.Freecam = nil
            end
            camera.CameraType = Enum.CameraType.Custom
        end
    end
})

local vampire = GUI:CreateSection({
    Name = "thirsy Vampire"
})

local playerESP = vampire:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
})

local playerESP = vampire:AddToggle({
    Name = "No cilp",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        if state then
            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        else
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
})

local invisibilityToggle = vampire:AddToggle({
    Name = "Invisibility",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if state then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                player.Character.Head.Transparency = 1
                player.Character.Torso.Transparency = 1
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            else
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                player.Character.Head.Transparency = 0
                player.Character.Torso.Transparency = 0
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                        part.CanCollide = true
                    end
                end
            end
        else
            warn("Humanoid not found!")
        end
    end
})

local prison = GUI:CreateSection({
    Name = "Prison life"
})

local teleportLocations = {
    ["Yard"] = CFrame.new(50, 10, 50),
    ["Cafeteria"] = CFrame.new(100, 10, 100),
    ["Cells"] = CFrame.new(150, 10, 150),
    ["Armory"] = CFrame.new(200, 10, 200)
}

for location, cframe in pairs(teleportLocations) do
    prison:AddButton({
        Name = "Teleport to " .. location,
        Callback = function()
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = cframe
        end
    })
end

-- Adding buttons to switch teams
prison:AddButton({
    Name = "Switch to Inmate",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Bright orange")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

prison:AddButton({
    Name = "Switch to Guards",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Bright blue")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

prison:AddButton({
    Name = "Switch to Neutral",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Medium stone grey")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

-- Adding button to switch to Criminal
prison:AddButton({
    Name = "Switch to Criminal",
    Callback = function()
        local player = game.Players.LocalPlayer
        player.Character.HumanoidRootPart.CFrame = CFrame.new(500, 10, 500)
        wait(1)
        workspace.Remote.TeamEvent:FireServer("Bright red")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

local killAuraToggle = prison:AddToggle({
    Name = "Kill Aura(May be invalid)",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            while state do
                for _, target in pairs(game.Players:GetPlayers()) do
                    if target ~= player and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
                        local distance = (player.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).magnitude
                        if distance < 10 then
                            target.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(10)
                        end
                    end
                end
                wait(0.1)
            end
        else
            warn("Humanoid not found!")
        end
    end
})

local playerESP = prison:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
})

local playerESP = prison:AddToggle({
    Name = "No cilp",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        if state then
            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        else
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
})

local doorESPEnabled = false
local itemESPEnabled = false
local lookAuraEnabled = false
local KeyESPEnable = false
local wardrobeESPEnabled = false
local goldESPEnabled = false

local function toggleDoorESP(state)
    doorESPEnabled = state
    for _, door in pairs(workspace:GetDescendants()) do
        if door.Name == "Door" then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Parent = door
                highlight.Adornee = door
            else
                if door:FindFirstChildOfClass("Highlight") then
                    door:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end

local function toggleItemESP(state)
    itemESPEnabled = state
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Tool") or item:IsA("Part") then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Parent = item
                highlight.Adornee = item
            else
                if item:FindFirstChildOfClass("Highlight") then
                    item:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end

local function toggleLookAura(state)
    lookAuraEnabled = state
    local player = game.Players.LocalPlayer
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        while state do
            for _, target in pairs(workspace:GetDescendants()) do
                if target:IsA("Model") and target:FindFirstChild("ClickDetector") then
                    local distance = (player.Character.HumanoidRootPart.Position - target.PrimaryPart.Position).magnitude
                    if distance < 10 then
                        fireclickdetector(target.ClickDetector)
                    end
                end
            end
            wait(0.1)
        end
    else
        warn("Humanoid not found!")
    end
end

local GUI = GUIWindow:CreateTab({
    Name = "Doors"
})

local Doors = GUI:CreateSection({
    Name = "Function"
})

local lookauraToggle = Doors:AddToggle({
    Name = "Door ESP",
    Default = false,
    Callback = function(state)
        toggleDoorESP(state)
    end
})

local lookauraToggle = Doors:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = function(state)
        toggleItemESP(state)
    end
})

local lookauraToggle = Doors:AddToggle({
    Name = "Look Aura",
    Default = false,
    Callback = function(state)
        toggleLookAura(state)
    end
})

local function toggleGoldESP(state)
    goldESPEnabled = state
    for _, room in pairs(game:GetService("Workspace").CurrentRooms:GetChildren()) do
        local goldPile = room:FindFirstChild("Assets") and room.Assets:FindFirstChild("Dresser") and room.Assets.Dresser:FindFirstChild("DrawerContainer") and room.Assets.Dresser.DrawerContainer:FindFirstChild("GoldPile") and room.Assets.Dresser.DrawerContainer.GoldPile:FindFirstChild("Hitbox")
        if goldPile then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Parent = goldPile
                highlight.Adornee = goldPile
            else
                if goldPile:FindFirstChildOfClass("Highlight") then
                    goldPile:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end

local goldESPToggle = Doors:AddToggle({
    Name = "Gold ESP",
    Default = false,
    Callback = function(state)
        toggleGoldESP(state)
    end
})

local function toggleWardrobeESP(state)
    wardrobeESPEnabled = state
    for _, wardrobe in pairs(game:GetService("Workspace").Assets.Wardrobe:GetChildren()) do
        local mainPart = wardrobe:FindFirstChild("Main")
        if mainPart then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Parent = mainPart
                highlight.Adornee = mainPart
            else
                if mainPart:FindFirstChildOfClass("Highlight") then
                    mainPart:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end

local WardrobeToggle = Doors:AddToggle({
    Name = "Wardrobe ESP",
    Default = false,
    Callback = function(state)
        toggleWardrobeESP(state)
    end
})

local function createLabel(part, text, color)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Adornee = part
    billboardGui.Parent = part

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = color or Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Parent = billboardGui
end

local function monitorRoomAssets()
    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
        if room:FindFirstChild("Assets") then
            for _, asset in pairs(room.Assets:GetChildren()) do
                if asset.Name:find("keyObtain") then
                    createLabel(asset, "Key", Color3.new(1, 0, 0)) -- Red color for keys
                else
                    createLabel(asset, asset.Name, Color3.new(1, 1, 1)) -- White color for other assets
                end
            end
        end
    end
end

local function toggleKeyESP(state)
    KeyESPEnable = state
    if state then
        monitorRoomAssets()
    else
        -- Optionally, you can add code here to remove the labels when the toggle is turning off
        for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
            if room:FindFirstChild("Assets") then
                for _, asset in pairs(room.Assets:GetChildren()) do
                    local billboardGui = asset:FindFirstChildOfClass("BillboardGui")
                    if billboardGui then
                        billboardGui:Destroy()
                    end
                end
            end
        end
    end
end

local keyESPToggle = Doors:AddToggle({
    Name = "Key ESP",
    Default = false,
    Callback = function(state)
        toggleKeyESP(state)
    end
})

local playerESP = prison:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
})

local playerESP = Doors:AddToggle({
    Name = "No cilp",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        if state then
            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        else
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
})

vampire:AddLabel({ Name = "Tip:开的时候不要开演都不带演" })
Doors:AddLabel({ Name = "Tip:有些功能可能失效" })

local window_credits_tab = GUIWindow:CreateTab({ Name = "创作者" })
local window_credits = window_credits_tab:CreateSection({
	Name = "创作"
})
window_credits:AddLabel({ Name = "UI:MrWhite" })
window_credits:AddLabel({ Name = "QQ:3756646428" })

local GUI = GUIWindow:CreateTab({ Name = "公告" })
local version = version_tab:CreateSection({
	Name = "↓↓↓↓↓"
})

version:AddLabel({ Name = "目前版本2.01 正式" })
version:AddLabel({ Name = "欢迎使用我的朋友:"..game.Players.LocalPlayer.Name.."" })
version:AddLabel({ Name = "注入器:"..identifyexecutor"" })
version:AddLabel({ Name = "你正处在游戏:"..game.GameId.."" })
