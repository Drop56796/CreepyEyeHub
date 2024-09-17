-- 创建一个屏幕 GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 创建一个打开按钮
local openButton = Instance.new("TextButton")
openButton.Text = "Open UI"
openButton.Size = UDim2.new(0.1, 0, 0.1, 0)
openButton.Position = UDim2.new(0, 0, 0.45, 0)
openButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Parent = screenGui

-- 创建一个框架
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.6, 0)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

-- 添加圆角
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- 创建标题栏
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0.1, 0)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
titleBar.Parent = frame

-- 添加圆角到标题栏
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

-- 添加标题文本
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Ly Client"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- 创建按钮部分
local button = Instance.new("TextButton")
button.Text = "Toggle Cape"
button.Size = UDim2.new(1, 0, 0.1, 0)
button.Position = UDim2.new(0, 0, 0.1, 0)
button.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- 默认灰色
button.BackgroundTransparency = 0.5
button.BorderSizePixel = 0
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Parent = frame

-- 创建滑块部分
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(1, 0, 0.1, 0)
sliderFrame.Position = UDim2.new(0, 0, 0.2, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = frame

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(0.05, 0, 1, 0)
slider.Position = UDim2.new(0, 0, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
slider.Text = ""
slider.Parent = sliderFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Speed: 20"
speedLabel.Size = UDim2.new(1, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Parent = sliderFrame

-- 使 UI 可拖动（支持移动设备）
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- 添加自定义斗篷
local function addCape(player)
    local cape = Instance.new("Part")
    cape.Name = "Cape"
    cape.Size = Vector3.new(2, 3, 0.1)
    cape.Anchored = false
    cape.CanCollide = false
    cape.Color = Color3.fromRGB(0, 0, 255) -- 自定义颜色
    cape.Material = Enum.Material.Fabric

    -- 添加一个网格使斗篷更薄
    local mesh = Instance.new("BlockMesh")
    mesh.Scale = Vector3.new(1, 1, 0.01)
    mesh.Parent = cape

    -- 添加一个焊接约束
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = cape
    weld.Part1 = player.Character:WaitForChild("HumanoidRootPart")
    weld.Parent = cape

    cape.Parent = player.Character

    -- 添加一个 BodyVelocity 使斗篷随风飘动
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, -10, 0)
    bodyVelocity.MaxForce = Vector3.new(0, 100, 0)
    bodyVelocity.Parent = cape

    -- 更新斗篷位置
    game:GetService("RunService").Stepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local velocity = player.Character.HumanoidRootPart.Velocity
            bodyVelocity.Velocity = Vector3.new(velocity.X, -10, velocity.Z)
        end
    end)
end

-- 移除斗篷
local function removeCape(player)
    if player.Character and player.Character:FindFirstChild("Cape") then
        player.Character.Cape:Destroy()
    end
end

-- 按钮点击事件
local capeEnabled = false
button.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    capeEnabled = not capeEnabled

    if capeEnabled then
        addCape(player)
        -- 颜色动画：灰色 -> 绿色
        for i = 0, 1, 0.1 do
            button.BackgroundColor3 = Color3.fromRGB(128 + 127 * i, 128 + 127 * i, 128 - 128 * i)
            wait(0.05)
        end
    else
        removeCape(player)
        -- 颜色动画：绿色 -> 红色
        for i = 0, 1, 0.1 do
            button.BackgroundColor3 = Color3.fromRGB(255 - 255 * i, 255 - 255 * i, 0 + 255 * i)
            wait(0.05)
        end
    end
end)

-- 滑块拖动事件
local sliderDragging = false
slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true
    end
end)

slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relativePosition = input.Position.X - sliderFrame.AbsolutePosition.X
        local sliderPosition = math.clamp(relativePosition / sliderFrame.AbsoluteSize.X, 0, 1)
        slider.Position = UDim2.new(sliderPosition, 0, 0, 0)
        local speed = 20 + math.floor(sliderPosition * 15) -- 速度范围 20 到 35
        speedLabel.Text = "Speed: " .. speed
        -- 调-- 调整角色速度
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

-- 打开按钮点击事件
openButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)
