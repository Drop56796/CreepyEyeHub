local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
assert(lib, "Failed to load library")

local win = lib:Window("Creepy client v1", Color3.fromRGB(1, 0, 0), Enum.KeyCode.RightControl)
assert(win, "Failed to create window")

local tab1 = win:Tab("Here>>>")
assert(tab1, "Failed to create tab1")

local tab2 = win:Tab("Here>>>")
assert(tab2, "Failed to create tab2")

local autoJumpEnabled = false
local noClipEnabled = false

tab2:Toggle("Auto-Jump", false, function(state)
    autoJumpEnabled = state
    if autoJumpEnabled then
        while autoJumpEnabled do
            -- 执行跳跃操作
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            wait(0.1) -- 根据需要调整延迟
        end
    end
end)

-- No-Clip Function
tab2:Toggle("No-Clip", false, function(state)
    noClipEnabled = state
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local PhysicsService = game:GetService("PhysicsService")

    -- Create collision groups
    PhysicsService:CreateCollisionGroup("NoClipGroup")
    PhysicsService:CreateCollisionGroup("IgnoreGroup")

    -- Set collision rules
    PhysicsService:CollisionGroupSetCollidable("NoClipGroup", "IgnoreGroup", false)

    -- Assign player to NoClipGroup
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            PhysicsService:SetPartCollisionGroup(part, "NoClipGroup")
        end
    end

    local connection
    if noClipEnabled then
        connection = game:GetService('RunService').Stepped:Connect(function()
            if noClipEnabled then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                character.Humanoid:ChangeState(11) -- No-clip state
            end
        end)
    else
        -- Reset collision group to default
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                PhysicsService:SetPartCollisionGroup(part, "Default")
                part.CanCollide = true
            end
        end
        character.Humanoid:ChangeState(0) -- Normal state
        if connection then connection:Disconnect() end
    end
end)

-- Custom ESP Function
local espEnabled = false

tab1:Toggle("Player ESP", false, function(state)
    espEnabled = state
    if espEnabled then
        -- Enable ESP
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if player.Character then
                    createESP(player)
                end
            end
        end

        game.Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if espEnabled then
                    createESP(player)
                end
            end)
        end)

        game.Players.PlayerRemoving:Connect(function(player)
            if player.Character and player.Character:FindFirstChildOfClass("Highlight") then
                player.Character:FindFirstChildOfClass("Highlight"):Destroy()
            end
            if player.Character and player.Character:FindFirstChildOfClass("BillboardGui") then
                player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
            end
        end)
    else
        -- Disable ESP
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChildOfClass("Highlight") then
                player.Character:FindFirstChildOfClass("Highlight"):Destroy()
            end
            if player.Character and player.Character:FindFirstChildOfClass("BillboardGui") then
                player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
            end
        end
    end
end)

function createESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.Parent = player.Character
    highlight.FillColor = Color3.new(1, 0, 0) -- Red color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline
    highlight.OutlineTransparency = 0

    -- Create BillboardGui for name and distance
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = player.Character:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = player.Character

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = player.Name
    textLabel.Parent = billboard

    -- Update distance
    game:GetService("RunService").RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            textLabel.Text = player.Name .. " (" .. math.floor(distance) .. " studs)"
        end
    end)
end

-- 自动治疗
local autoHealEnabled = false
tab1:Toggle("Auto-Heal", false, function(state)
    autoHealEnabled = state
    if autoHealEnabled then
        while autoHealEnabled do
            -- 执行治疗操作
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            end
            wait(5) -- 根据需要调整延迟
        end
    else
        -- 停止治疗操作
        autoHealEnabled = false
    end
end)
