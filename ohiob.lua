local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/Ohio/UI-Lib.lua"))()

local win = lib:Window("ohio",Color3.fromRGB(1, 0.5, 0), Enum.KeyCode.RightControl)

local tab1 = win:Tab("公告")
local tab2 = win:Tab("main")

tab1:Label("本脚本为Ohio 为题")
tab1:Label("script edit by nys195")
tab1:Label("version = 1.0b")

-- 定义自瞄状态变量
local aimbotEnabled = false

-- 创建UI界面
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.AnchorPoint = Vector2.new(1, 0)  -- 右上角对齐
frame.Position = UDim2.new(1, -20, 0.5, -100)  -- 屏幕中间偏右且稍微往上
frame.Size = UDim2.new(0, 200, 0, 100)
frame.BackgroundTransparency = 0.5  -- 半透明背景
frame.Visible = false  -- 初始时隐藏UI

local nameLabel = Instance.new("TextLabel")
nameLabel.Parent = frame
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.Size = UDim2.new(1, 0, 0.25, 0)
nameLabel.Text = "Enemy Name"
nameLabel.TextScaled = true
nameLabel.BackgroundTransparency = 1

local avatarImage = Instance.new("ImageLabel")
avatarImage.Parent = frame
avatarImage.Position = UDim2.new(0, 0, 0.25, 0)
avatarImage.Size = UDim2.new(0.5, 0, 0.75, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"  -- 默认占位图

local toolLabel = Instance.new("TextLabel")
toolLabel.Parent = frame
toolLabel.Position = UDim2.new(0.5, 0, 0.25, 0)
toolLabel.Size = UDim2.new(0.5, 0, 0.375, 0)
toolLabel.Text = "Tool Name"
toolLabel.TextScaled = true
toolLabel.BackgroundTransparency = 1

local healthLabel = Instance.new("TextLabel")
healthLabel.Parent = frame
healthLabel.Position = UDim2.new(0.5, 0, 0.625, 0)
healthLabel.Size = UDim2.new(0.5, 0, 0.375, 0)
healthLabel.Text = "Health: 100/100"
healthLabel.TextScaled = true
healthLabel.BackgroundTransparency = 1

-- 定义自瞄功能
local function FindClosestEnemy()
    local closestDistance = math.huge
    local closestEnemy = nil
    
    for _, enemy in ipairs(GetAllEnemies()) do
        local distance = (enemy.Position - GetPlayer().Position).magnitude
        if distance < closestDistance then
            closestDistance = distance
            closestEnemy = enemy
        end
    end
    
    return closestEnemy
end

local function AimAt(enemy)
    GetPlayer().Camera.CFrame = CFrame.new(GetPlayer().Camera.Position, enemy.Position)
end

local function UpdateEnemyInfo(enemy)
    nameLabel.Text = enemy.Name
    
    if enemy:FindFirstChild("Headshot") then
        avatarImage.Image = enemy.Headshot.Value
    end

    if enemy:FindFirstChildOfClass("Tool") then
        toolLabel.Text = enemy:FindFirstChildOfClass("Tool").Name
    else
        toolLabel.Text = "No Tool"
    end
    
    if enemy:FindFirstChild("Humanoid") then
        local health = enemy.Humanoid.Health
        local maxHealth = enemy.Humanoid.MaxHealth
        healthLabel.Text = "Health: " .. math.floor(health) .. "/" .. math.floor(maxHealth)
    end
end

local function Aimbot()
    if aimbotEnabled then
        local closestEnemy = FindClosestEnemy()
        if closestEnemy then
            AimAt(closestEnemy)
            UpdateEnemyInfo(closestEnemy)
            frame.Visible = true  -- 显示UI
        else
            frame.Visible = false -- 没有敌人时隐藏UI
        end
    else
        frame.Visible = false -- 自瞄关闭时隐藏UI
    end
end

-- Toggle按钮集成自瞄功能
tab2:Toggle("开自瞄", false, function(t)
    aimbotEnabled = t -- 根据按钮状态启用或禁用自瞄功能

    -- 启动或停止自瞄功能
    if aimbotEnabled then
        game:GetService("RunService").RenderStepped:Connect(Aimbot)
    else
        frame.Visible = false -- 关闭自瞄时隐藏UI
    end
end)

local a = 0
tab2:Dropdown("Dropdown", {"all look aura", "coming soon"}, function(t)
    if t == "all look aura" then
        local ProximityPromptService = game:GetService("ProximityPromptService")

        -- 当ProximityPrompt被显示时自动触发点击
        ProximityPromptService.PromptShown:Connect(function(prompt)
            if prompt.Enabled then
                prompt:Trigger() -- 直接触发点击
            end
        end)
    elseif t == "coming soon" then
        print(a)
    else
        print("未知选项")
    end
end)
