local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Bedwars / Creepy Client',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Bedwars'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Player')

MainGroup:AddToggle('Fly', {
    Text = 'Fly',
    Default = false,
    Tooltip = 'Bro Think he in minecraft Create mode',
    Callback = function(Value)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")
        local flying = false
        local speed = 35
        local lastPosition = humanoidRootPart.Position
        local direction = Vector3.new(0, 0, 0)

        local function updateDirection()
            local currentPosition = humanoidRootPart.Position
            local moveDirection = (currentPosition - lastPosition)
            moveDirection = Vector3.new(moveDirection.X, 0, moveDirection.Z).Unit
            if moveDirection.Magnitude > 0 then
                direction = moveDirection
            else
                direction = Vector3.new(0, 0, 0)
            end
            lastPosition = currentPosition
        end

        if Value then
            flying = true
            lastPosition = humanoidRootPart.Position
            loopConnection = RunService.RenderStepped:Connect(function()
                if flying then
                    updateDirection()
                    humanoidRootPart.Velocity = direction * speed
                end
            end)
        else
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            flying = false
        end
    end
})


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

MainGroup:AddToggle('No Clip', {
    Text = 'No Clip',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        if Value then
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

MainGroup:AddToggle('PlayerESP', {
    Text = 'Player ESP',
    Default = false,
    Callback = function(Value)
        if Value then
            if not _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = true
                
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                        local espUI = Instance.new("BillboardGui", player.Character.Head)
                        espUI.Name = "ESPUI"
                        espUI.Size = UDim2.new(0, 100, 0, 25)
                        espUI.Adornee = player.Character.Head
                        espUI.AlwaysOnTop = true
                        espUI.StudsOffset = Vector3.new(0, 2, 0)

                        local nameLabel = Instance.new("TextLabel", espUI)
                        nameLabel.Text = player.Name
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.new(1, 1, 1)

                        local box = Instance.new("BoxHandleAdornment", player.Character)
                        box.Name = "ESPBox"
                        box.Adornee = player.Character
                        box.Size = player.Character:GetExtentsSize()
                        box.Color3 = Color3.new(1, 0, 0)
                        box.Transparency = 0.5
                        box.AlwaysOnTop = true
                    end
                end
            end
        else
            if _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = false
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local espUI = player.Character.Head:FindFirstChild("ESPUI")
                        if espUI then
                            espUI:Destroy()
                        end

                        local box = player.Character:FindFirstChild("ESPBox")
                        if box then
                            box:Destroy()
                        end
                    end
                end
            end
        end
    end
})

MainGroup:AddToggle('KillAura', {
    Text = 'Kill Aura(自己点击)',
    Default = false,
    Callback = function(Value)
        if Value then
            if not _G.KillAuraEnabled then
                _G.KillAuraEnabled = true
                
                -- 初始化服务和变量
                local RunService = game:GetService("RunService")
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local Humanoid = Character:WaitForChild("Humanoid")
                local radius = 10
                local jumpHeight = 50
                local speed = 20
                local targetLockSpeed = 0.1

                -- 检测是否是敌方玩家
                local function isEnemy(player)
                    return player.Team ~= LocalPlayer.Team
                end

                -- 查找最近的敌方玩家
                local function findNearestEnemy()
                    local nearestEnemy = nil
                    local shortestDistance = radius
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and isEnemy(player) then
                            local distance = (player.Character.PrimaryPart.Position - Character.PrimaryPart.Position).Magnitude
                            if distance < shortestDistance then
                                nearestEnemy = player
                                shortestDistance = distance
                            end
                        end
                    end
                    return nearestEnemy
                end

                -- 自动跳跃
                local function autoJump()
                    if Humanoid.FloorMaterial ~= Enum.Material.Air then
                        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end

                -- 锁头功能
                local function lockOnHead(target)
                    local head = target.Character:FindFirstChild("Head")
                    if head then
                        local direction = (head.Position - Character.Head.Position).Unit
                        local targetPosition = Character.Head.Position + direction * 10
                        Character.PrimaryPart.CFrame = CFrame.new(Character.PrimaryPart.Position, targetPosition)
                    end
                end

                -- 绕敌功能
                local function orbitAround(target)
                    local angle = tick() * speed
                    local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
                    local targetPosition = target.Character.PrimaryPart.Position + offset
                    Character.PrimaryPart.CFrame = CFrame.new(Character.PrimaryPart.Position, targetPosition)
                end

                -- 主循环
                _G.KillAuraConnection = RunService.RenderStepped:Connect(function()
                    local nearestEnemy = findNearestEnemy()
                    if nearestEnemy then
                        autoJump()
                        lockOnHead(nearestEnemy)
                        orbitAround(nearestEnemy)
                    end
                end)
            end
        else
            if _G.KillAuraEnabled then
                _G.KillAuraEnabled = false
                if _G.KillAuraConnection then
                    _G.KillAuraConnection:Disconnect()
                    _G.KillAuraConnection = nil
                end
            end
        end
    end
})

LeftGroupBox:AddSlider('MySlider', {
    Text = 'Speed',
    Default = 1,
    Min = 0,
    Max = 35,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})


LeftGroupBox:AddSlider('MySlider', {
    Text = 'FOV',
    Default = 0,
    Min = 0,
    Max = 120,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        game.Workspace.CurrentCamera.FieldOfView = Value
    end
})
