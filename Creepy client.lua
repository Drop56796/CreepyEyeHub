local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "Creepy Client Welcome",
    Text = "V1.2",
    Duration = 3, 
})
wait(3)

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/UI-Lib.lua"))()
assert(lib, "Failed to load library")

local win = lib:Window("Creepy client Welcome ["..game.Players.LocalPlayer.Name.."] Executor:"..identifyexecutor"", Color3.fromRGB(1, 0, 0), Enum.KeyCode.RightControl)
assert(win, "Failed to create window")

local tab1 = win:Tab("Player1")
assert(tab1, "Failed to create tab1")

local tab2 = win:Tab("Player2")
assert(tab2, "Failed to create tab2")

local tab3 = win:Tab("Doors")
assert(tab3, "Failed to create tab3")

local tab4 = win:Tab("忍者传奇")
assert(tab4, "Failed to create tab4")

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
    local runService = game:GetService("RunService")

    local function setNoClip(enabled)
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not enabled
            end
        end
        if enabled then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        else
            character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end

    if noClipEnabled then
        _G.NoClip = runService.Stepped:Connect(function()
            setNoClip(true)
        end)
    else
        if _G.NoClip then
            _G.NoClip:Disconnect()
            _G.NoClip = nil
        end
        setNoClip(false)
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

tab2:Toggle("High Light", false, function(state)
    local Light = game:GetService("Lighting")

    function dofullbright()
        Light.Ambient = Color3.new(1, 1, 1)
        Light.ColorShift_Bottom = Color3.new(1, 1, 1)
        Light.ColorShift_Top = Color3.new(1, 1, 1)
    end

    function resetLighting()
        Light.Ambient = Color3.new(0, 0, 0)
        Light.ColorShift_Bottom = Color3.new(0, 0, 0)
        Light.ColorShift_Top = Color3.new(0, 0, 0)
    end

    if state then  
        while state do
            dofullbright()
            wait(1000000000)
        end
    else
        resetLighting()
    end
end)

tab1:Textbox("Speed",true, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

tab1:Textbox("FOV",true, function(t)
game.Workspace.CurrentCamera.FieldOfView = t
end)

tab1:Textbox("Gravity",true, function(t)
game.Workspace.Gravity = t
end)

tab1:Textbox("JumpPower",true, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
end)

tab3:Button("Bobhub", function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

tab3:Button("Slience Hub V2", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Moonsec/moonsec/moonsec.lua"))()
end)

tab3:Button("Super Script", function()
loadstring(game: HttpGet("https://raw.githubusercontent.com/Fazedrab/EntitySpawner/main/doors(orionlib).lua"))()
end)

tab3:Button("心跳永远胜利", function()
firesignal(game.ReplicatedStorage.Bricks.ClutchHeartbeat.OnClientEvent)
end)

tab4:Button("1", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/zerpqe/script/main/NinjaLegends.lua"))()
end)

tab4:Button("2", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/harisiskandar178/5repo/main/script4.lua"))()
end)
