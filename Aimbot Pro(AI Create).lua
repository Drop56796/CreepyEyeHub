local UIS = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local player = players.LocalPlayer
local camera = workspace.CurrentCamera

local aimbotEnabled = false
local colorCheckEnabled = false
local target

local screenGui = Instance.new("ScreenGui", CoreGui)

local toggleAimbotButton = Instance.new("TextButton", screenGui)
toggleAimbotButton.Size = UDim2.new(0, 150, 0, 50)
toggleAimbotButton.Position = UDim2.new(0, 20, 0.5, -150)
toggleAimbotButton.Text = "Toggle Aimbot"

toggleAimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    toggleAimbotButton.Text = aimbotEnabled and "Aimbot ON" or "Aimbot OFF"
end)

local toggleColorCheckButton = Instance.new("TextButton", screenGui)
toggleColorCheckButton.Size = UDim2.new(0, 150, 0, 50)
toggleColorCheckButton.Position = UDim2.new(0, 20, 0.5, -90)
toggleColorCheckButton.Text = "Color Check"

toggleColorCheckButton.MouseButton1Click:Connect(function()
    colorCheckEnabled = not colorCheckEnabled
    toggleColorCheckButton.Text = colorCheckEnabled and "Color Check ON" or "Color Check OFF"
end)

local targetInfoButton = Instance.new("TextButton", screenGui)
targetInfoButton.Size = UDim2.new(0, 150, 0, 100)
targetInfoButton.Position = UDim2.new(0, 20, 0.5, -20)
targetInfoButton.Text = "No Target"
targetInfoButton.TextWrapped = true
targetInfoButton.TextYAlignment = Enum.TextYAlignment.Top

-- 显示目标玩家头像的ImageLabel
local targetImage = Instance.new("ImageLabel", targetInfoButton)
targetImage.Size = UDim2.new(0, 50, 0, 50)
targetImage.Position = UDim2.new(0.5, -25, 0.5, 0)
targetImage.BackgroundTransparency = 1

-- 显示目标玩家详细信息的标签
local targetDetailsLabel = Instance.new("TextLabel", screenGui)
targetDetailsLabel.Size = UDim2.new(0, 150, 0, 150)
targetDetailsLabel.Position = UDim2.new(0, 20, 0.5, 90)
targetDetailsLabel.Text = "Target Info: N/A"
targetDetailsLabel.TextWrapped = true
targetDetailsLabel.BackgroundTransparency = 1
targetDetailsLabel.TextColor3 = Color3.fromRGB(1, 1, 1)
targetDetailsLabel.Font = Enum.Font.SourceSansBold

-- 显示玩家自身详细信息的标签
local playerDetailsLabel = Instance.new("TextLabel", screenGui)
playerDetailsLabel.Size = UDim2.new(0, 150, 0, 150)
playerDetailsLabel.Position = UDim2.new(0, 230, 0.5, 90)
playerDetailsLabel.Text = "Player Info: N/A"
playerDetailsLabel.TextWrapped = true
playerDetailsLabel.BackgroundTransparency = 1
playerDetailsLabel.TextColor3 = Color3.fromRGB(1, 1, 1)
playerDetailsLabel.Font = Enum.Font.SourceSansBold

-- 创建中空的圆框
local aimCircle = Instance.new("ImageLabel", screenGui)
aimCircle.Size = UDim2.new(0, 200, 0, 200)
aimCircle.Position = UDim2.new(0.5, -100, 0.5, -100)
aimCircle.BackgroundTransparency = 1
aimCircle.Image = "rbxassetid://6034978103"  -- 这是一个圆形图像的AssetId
aimCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)
aimCircle.ImageTransparency = 0.5

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

-- 获取玩家当前手持物品名称
local function getToolInfo(character)
    local tool = character:FindFirstChildOfClass("Tool")
    return tool and tool.Name or "None"
end

-- 更新目标玩家信息
local function updateTargetInfo()
    if target then
        local targetPlayer = players:GetPlayerFromCharacter(target.Parent)
        if targetPlayer then
            targetInfoButton.Text = targetPlayer.Name
            targetImage.Image = "rbxthumb://type=AvatarHeadShot&id="..targetPlayer.UserId.."&w=150&h=150"

            -- 获取目标玩家当前手持物品
            local targetTool = getToolInfo(targetPlayer.Character)

            -- 更新目标玩家详细信息
            local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
            local targetPosition = targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character.HumanoidRootPart.Position
            local targetTeam = targetPlayer.Team and targetPlayer.Team.Name or "N/A"
            local targetSpeed = targetHumanoid and targetHumanoid.WalkSpeed or "N/A"
            
            local infoText = string.format("Health: %s\nPosition: %s\nTeam: %s\nSpeed: %s\nTool: %s",
                targetHumanoid and math.floor(targetHumanoid.Health) or "N/A",
                targetPosition and tostring(targetPosition) or "N/A",
                targetTeam,
                targetSpeed,
                targetTool
            )
            targetDetailsLabel.Text = "Target Info:\n" .. infoText
        else
            targetInfoButton.Text = "No Target"
            targetImage.Image = ""
            targetDetailsLabel.Text = "Target Info: N/A"
        end
    else
        targetInfoButton.Text = "No Target"
        targetImage.Image = ""
        targetDetailsLabel.Text = "Target Info: N/A"
    end
end

-- 更新玩家自身信息
local function updatePlayerInfo()
    local playerHumanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position
    local playerTeam = player.Team and player.Team.Name or "N/A"
    local playerSpeed = playerHumanoid and playerHumanoid.WalkSpeed or "N/A"

    -- 获取自身当前手持物品名称
    local playerTool = getToolInfo(player.Character)

    local infoText = string.format("Health: %s\nPosition: %s\nTeam: %s\nSpeed: %s\nTool: %s",
        playerHumanoid and math.floor(playerHumanoid.Health) or "N/A",
        playerPosition and tostring(playerPosition) or "N/A",
        playerTeam,
        playerSpeed,
        playerTool
    )
    playerDetailsLabel.Text = "Player Info:\n" .. infoText
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
