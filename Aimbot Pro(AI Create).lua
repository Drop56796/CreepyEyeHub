local UIS = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))  -- 创建ScreenGui并附加到CoreGui

-- 给screenGui取一个名字
screenGui.Name = "MyCustomScreenGui"  -- 你可以根据需要自定义这个名字

local player = players.LocalPlayer
local camera = workspace.CurrentCamera

local aimbotEnabled = false
local colorCheckEnabled = false
local target

-- 自瞄切换按钮
local toggleAimbotButton = Instance.new("TextButton", screenGui)
toggleAimbotButton.Size = UDim2.new(0, 150, 0, 50)
toggleAimbotButton.Position = UDim2.new(0, 20, 0.5, -150)
toggleAimbotButton.Text = "Toggle Aimbot"
toggleAimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleAimbotButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

toggleAimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    toggleAimbotButton.Text = aimbotEnabled and "Aimbot ON" or "Aimbot OFF"
end)

-- 颜色队伍检测切换按钮
local toggleColorCheckButton = Instance.new("TextButton", screenGui)
toggleColorCheckButton.Size = UDim2.new(0, 150, 0, 50)
toggleColorCheckButton.Position = UDim2.new(0, 20, 0.5, -90)
toggleColorCheckButton.Text = "Color Check"
toggleColorCheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleColorCheckButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

toggleColorCheckButton.MouseButton1Click:Connect(function()
    colorCheckEnabled = not colorCheckEnabled
    toggleColorCheckButton.Text = colorCheckEnabled and "Color Check ON" or "Color Check OFF"
end)

-- 创建中空的圆框
local aimCircle = Instance.new("Frame", screenGui)
aimCircle.Size = UDim2.new(0, 200, 0, 200)
aimCircle.Position = UDim2.new(0.5, -100, 0.5, -100)
aimCircle.BackgroundTransparency = 1
aimCircle.BorderSizePixel = 3
aimCircle.BorderColor3 = Color3.fromRGB(255, 255, 255)
aimCircle.AnchorPoint = Vector2.new(0.5, 0.5)

-- 显示目标玩家信息的框
local targetInfoFrame = Instance.new("Frame", screenGui)
targetInfoFrame.Size = UDim2.new(0, 350, 0, 100)
targetInfoFrame.Position = UDim2.new(0.5, -450, 0.5, -175)
targetInfoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
targetInfoFrame.BackgroundTransparency = 0.5
targetInfoFrame.BorderSizePixel = 2
targetInfoFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- 显示目标玩家名字的标签
local targetNameLabel = Instance.new("TextLabel", targetInfoFrame)
targetNameLabel.Size = UDim2.new(0, 180, 0, 50)
targetNameLabel.Position = UDim2.new(0, 10, 0, 10)
targetNameLabel.Text = "No Target"
targetNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetNameLabel.TextScaled = true
targetNameLabel.BackgroundTransparency = 1
targetNameLabel.TextStrokeTransparency = 0.8

-- 显示目标玩家头像的框
local targetImageLabel = Instance.new("ImageLabel", targetInfoFrame)
targetImageLabel.Size = UDim2.new(0, 50, 0, 50)
targetImageLabel.Position = UDim2.new(0.5, -25, 0.5, -25)
targetImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
targetImageLabel.BackgroundTransparency = 1
targetImageLabel.Image = ""  -- 目标玩家头像图片链接

-- 显示目标玩家详细信息的标签
local targetDetailsLabel = Instance.new("TextLabel", screenGui)
targetDetailsLabel.Size = UDim2.new(0, 220, 0, 150)
targetDetailsLabel.Position = UDim2.new(0, 20, 0.5, 60)
targetDetailsLabel.Text = "Target Info: N/A"
targetDetailsLabel.TextWrapped = true
targetDetailsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
targetDetailsLabel.BackgroundTransparency = 0.5
targetDetailsLabel.BorderSizePixel = 2
targetDetailsLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
targetDetailsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetDetailsLabel.Font = Enum.Font.Code
targetDetailsLabel.TextStrokeTransparency = 0.8

-- 显示玩家自身详细信息的标签
local playerDetailsLabel = Instance.new("TextLabel", screenGui)
playerDetailsLabel.Size = UDim2.new(0, 350, 0, 100)
playerDetailsLabel.Position = UDim2.new(0.5, -450, 0.5, -50)
playerDetailsLabel.Text = "Player Info: N/A"
playerDetailsLabel.TextWrapped = true
playerDetailsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
playerDetailsLabel.BackgroundTransparency = 0.5
playerDetailsLabel.BorderSizePixel = 2
playerDetailsLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
playerDetailsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDetailsLabel.Font = Enum.Font.Code
playerDetailsLabel.TextStrokeTransparency = 0.8

-- 创建玩家当前手持物品的图标
local playerToolImage = Instance.new("ImageLabel", playerDetailsLabel)
playerToolImage.Size = UDim2.new(0, 50, 0, 50)
playerToolImage.Position = UDim2.new(0, 170, 0, 10)
playerToolImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
playerToolImage.BackgroundTransparency = 1
playerToolImage.Image = ""  -- 玩家当前手持物品的图标链接

-- 查找最近的目标头部
local function findNearestTargetHead()
    local nearestTarget
    local shortestDistance = math.huge

    for _, otherPlayer in pairs(players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
            
            -- 检查目标玩家是否活着
            local humanoid = otherPlayer.Character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then
                continue
            end

            -- 检查颜色队伍
            if colorCheckEnabled and otherPlayer.TeamColor == player.TeamColor then
                continue
            end

            local head = otherPlayer.Character.Head
            local distance = (head.Position - player.Character.Head.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestTarget = head
            end
        end
    end

    return nearestTarget
end

-- 自瞄功能
local function aimAtTarget()
    if target then
        local targetPosition = target.Position
        local direction = (targetPosition - camera.CFrame.Position).Unit
        local newCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
        camera.CFrame = newCFrame
    end
end

-- 绘制红线
local function drawLine()
    if target then
        local targetPosition = target.Position
        local playerPosition = player.Character.Head.Position
        local line = Instance.new("Part")
        line.Anchored = true
        line.CanCollide = false
        line.Size = Vector3.new(0.1, 0.1, (targetPosition - playerPosition).Magnitude)
        line.CFrame = CFrame.new(playerPosition, targetPosition) * CFrame.new(0, 0, -line.Size.Z / 2)
        line.Color = Color3.fromRGB(255, 0, 0)
        line.Parent = workspace

        game.Debris:AddItem(line, 0.1)  -- 0.1秒后删除辅助线
    end
end

-- 绘制瞄准框
local function drawBox()
    if target then
        local character = target.Parent
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local size = hrp.Size * 2  -- 调整框的大小以覆盖整个角色
            local box = Instance.new("SelectionBox")
            box.Adornee = hrp
            box.LineThickness = 0.05
            box.Color3 = Color3.fromRGB(0, 255, 0)  -- 绿色框
            box.Parent = workspace

            game.Debris:AddItem(box, 0.1)  -- 0.1秒后删除瞄准框
        end
    end
end

-- 获取玩家当前手持物品名称和图标
local function getToolInfo(character)
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        return tool.Name, tool.TextureId  -- 假设 TextureId 是工具的图标链接
    else
        return "None", ""
    end
end

-- 更新目标玩家信息
local function updateTargetInfo()
    if target then
        local targetPlayer = players:GetPlayerFromCharacter(target.Parent)
        if targetPlayer then
            targetNameLabel.Text = targetPlayer.Name

            -- 更新目标玩家详细信息
            local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
            local targetPosition = targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character.HumanoidRootPart.Position
            local targetTeam = targetPlayer.Team and targetPlayer.Team.Name or "N/A"
            local targetSpeed = targetHumanoid and targetHumanoid.WalkSpeed or "N/A"
            local targetToolName, targetToolImageId = getToolInfo(targetPlayer.Character)
            
            local infoText = string.format("Health: %s\nPosition: %s\nTeam: %s\nSpeed: %s\nTool: %s",
                targetHumanoid and math.floor(targetHumanoid.Health) or "N/A",
                targetPosition and tostring(targetPosition) or "N/A",
                targetTeam,
                targetSpeed,
                targetToolName
            )
            targetDetailsLabel.Text = "Target Info:\n" .. infoText

            -- 更新目标玩家头像
            targetImageLabel.Image = targetToolImageId
        else
            targetNameLabel.Text = "No Target"
            targetDetailsLabel.Text = "Target Info: N/A"
            targetImageLabel.Image = ""
        end
    else
        targetNameLabel.Text = "No Target"
        targetDetailsLabel.Text = "Target Info: N/A"
        targetImageLabel.Image = ""
    end
end

-- 更新玩家自身信息
local function updatePlayerInfo()
    local playerHumanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position
    local playerTeam = player.Team and player.Team.Name or "N/A"
    local playerSpeed = playerHumanoid and playerHumanoid.WalkSpeed or "N/A"

    -- 获取自身当前手持物品名称和图标
    local playerToolName, playerToolImageId = getToolInfo(player.Character)

    local infoText = string.format("Health: %s\nPosition: %s\nTeam: %s\nSpeed: %s\nTool: %s",
        playerHumanoid and math.floor(playerHumanoid.Health) or "N/A",
        playerPosition and tostring(playerPosition) or "N/A",
        playerTeam,
        playerSpeed,
        playerToolName
    )
    playerDetailsLabel.Text = "Player Info:\n" .. infoText

    -- 更新玩家当前手持物品图标
    playerToolImage.Image = playerToolImageId
end

-- 在每帧更新时调用
runService.RenderStepped:Connect(function()
    if aimbotEnabled then
        target = findNearestTargetHead()
        aimAtTarget()
        drawLine()
        drawBox()
        updateTargetInfo()
    end
    updatePlayerInfo()
end)
