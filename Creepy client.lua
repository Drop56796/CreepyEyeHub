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

    if noClipEnabled then
        game:GetService('RunService').Stepped:Connect(function()
            if noClipEnabled then
                character.Humanoid:ChangeState(11) -- No-clip state
            end
        end)
    else
        -- Reset collision group to default
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                PhysicsService:SetPartCollisionGroup(part, "Default")
            end
        end
        character.Humanoid:ChangeState(0) -- Normal state
    end
end)

local esp = false

tab1:Toggle("esp", false, function(state)
    esp = state
    if esp then
        repeat
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/UILibs/main/ESP/Arrows/Example"))()
            wait(5)
        until not esp
    end
end)

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
