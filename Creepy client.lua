local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
assert(lib, "Failed to load library")

local win = lib:Window("Creepy client v1", Color3.fromRGB(1, 0, 0), Enum.KeyCode.RightControl)
assert(win, "Failed to create window")

local tab1 = win:Tab("Here>>>")
assert(tab1, "Failed to create tab1")

local tab2 = win:Tab("Here>>>")
assert(tab2, "Failed to create tab2")

-- 自动跳跃
local autoJumpEnabled = false
tab2:Toggle("Auto-Jump", false, function(state)
    autoJumpEnabled = state
    if autoJumpEnabled then
        while autoJumpEnabled do
            -- 执行跳跃操作
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            wait(0.1) -- 根据需要调整延迟
        end
    else
        -- 停止跳跃操作
        autoJumpEnabled = false
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
