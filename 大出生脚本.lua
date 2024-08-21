local function playSound(soundId, volume, duration)
    -- 创建一个新的Sound对象
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume
    sound.PlayOnRemove = true
    sound.Parent = game:GetService("SoundService") -- 使用SoundService作为父对象

    -- 播放声音
    sound:Play()

    -- 在声音播放完毕后自动销毁
    local function onSoundEnded()
        sound:Destroy()
    end

    sound.Ended:Connect(onSoundEnded)

    -- 如果duration被设置，设置定时器以在duration之后销毁声音
    if duration then
        delay(duration, function()
            if sound.Parent then -- 确保声音对象仍然存在
                sound:Destroy()
            end
        end)
    end
end
-------------------------------------------
local RunService = game:GetService("RunService")

-- 创建 BoxHandleAdornment 实例
local function createBoxAdornment(part, color)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = part.Size
    box.AlwaysOnTop = true
    box.ZIndex = 10  -- 提高 ZIndex 确保在最上层
    box.AdornCullingMode = Enum.AdornCullingMode.Never
    box.Color3 = color
    box.Transparency = 0.5
    box.Adornee = part
    box.Parent = game.CoreGui
    return box
end

-- 创建 Highlight 实例
local function createHighlight(part, color)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0.5
    highlight.FillTransparency = 0.5
    highlight.Parent = part
    return highlight
end

-- 创建 BillboardGui 实例
local function createBillboardGui(core, color, name)
    local bill = Instance.new("BillboardGui", game.CoreGui)
    bill.AlwaysOnTop = true
    bill.Size = UDim2.new(0, 100, 0, 50)
    bill.Adornee = core
    bill.MaxDistance = 2000

    local mid = Instance.new("Frame", bill)
    mid.AnchorPoint = Vector2.new(0.5, 0.5)
    mid.BackgroundColor3 = color
    mid.Size = UDim2.new(0, 8, 0, 8)
    mid.Position = UDim2.new(0.5, 0, 0.5, 0)
    Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", mid)

    local txt = Instance.new("TextLabel", bill)
    txt.AnchorPoint = Vector2.new(0.5, 0.5)
    txt.BackgroundTransparency = 1
    txt.BackgroundColor3 = color
    txt.TextColor3 = color
    txt.Size = UDim2.new(1, 0, 0, 20)
    txt.Position = UDim2.new(0.5, 0, 0.7, 0)
    txt.Text = name
    txt.TextStrokeTransparency = 0.5
    txt.TextSize = 18
    txt.Font = Enum.Font.Jura -- 设置字体为 Jura
    Instance.new("UIStroke", txt)

    return bill
end

function esp(what, color, core, name)
    local parts = {}
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            for _, v in ipairs(what:GetChildren()) do
                if v:IsA("BasePart") then
                    table.insert(parts, v)
                end
            end
        elseif what:IsA("BasePart") then
            table.insert(parts, what)
        end
    elseif typeof(what) == "table" then
        for _, v in ipairs(what) do
            if v:IsA("BasePart") then
                table.insert(parts, v)
            end
        end
    end

    -- 创建和管理 BoxHandleAdornment 和 Highlight 实例
    local boxes = {}
    local highlights = {}
    for _, part in ipairs(parts) do
        local box = createBoxAdornment(part, color)
        table.insert(boxes, box)
        
        local highlight = createHighlight(part, color)
        table.insert(highlights, highlight)
    end

    local bill
    if core and name then
        bill = createBillboardGui(core, color, name)
    end

    local function checkAndUpdate()
        -- 检查 BoxHandleAdornment 和 Highlight 是否需要更新
        for _, box in ipairs(boxes) do
            if not box.Adornee or not box.Adornee:IsDescendantOf(workspace) then
                box:Destroy()
            end
        end
        
        for _, highlight in ipairs(highlights) do
            if not highlight.Adornee or not highlight.Adornee:IsDescendantOf(workspace) then
                highlight:Destroy()
            end
        end

        if bill and (not bill.Adornee or not bill.Adornee:IsDescendantOf(workspace)) then
            bill:Destroy()
        end
    end

    RunService.Stepped:Connect(checkAndUpdate)

    local ret = {}

    ret.delete = function()
        for _, box in ipairs(boxes) do
            box:Destroy()
        end
        
        for _, highlight in ipairs(highlights) do
            highlight:Destroy()
        end

        if bill then
            bill:Destroy()
        end
    end

    return ret
end
-----------------------------------
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2
local v = 1.4
local speedControlEnabled = false 
local FOVEnabled = false
-----------------------------flags-
local flags = {
    elevatorbreakerbox = false,
    spiderNoJump = false
}
------------------------------------
Notification:Notify(
    {Title = "出生 v" .. v, Description = "验证成功 script start now!"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 3, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
)
playSound("rbxassetid://4590657391", 1, 3.5)

Notification:Notify(
    {Title = "出生 v" .. v, Description = "script.lol.run"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 3, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
)
wait(2)

local OrionLib = loadstring(game:HttpGet(('https://github.com/Drop56796/CreepyEyeHub/blob/main/ThemeGuiNew.lua?raw=true')))() 
local Window = OrionLib:MakeWindow({Name = "出生脚本 v" .. v, HidePremium = true, SaveConfig = true, ConfigFolder = "Loser"})

local Tab = Window:MakeTab({
	Name = "公告",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("本脚本为 游戏 制作")
Tab:AddLabel("不怕banned和被骂没母和被挂你就用")
Tab:AddLabel("开始你的表演")
Tab:AddLabel("目前版本 v" .. v)
Tab:AddLabel("作者nys195")
Tab:AddLabel("-------------全部信息------------")
local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

-- 显示玩家基本信息
Tab:AddLabel("玩家名字: " .. player.Name)
Tab:AddLabel("玩家 DisplayName: " .. player.DisplayName)
Tab:AddLabel("玩家 User ID: " .. player.UserId)
Tab:AddLabel("账户年龄 (天): " .. player.AccountAge)
Tab:AddLabel("会员类型: " .. tostring(player.MembershipType))
Tab:AddLabel("当前团队: " .. (player.Team and player.Team.Name or "无"))

-- 显示玩家状态信息
if humanoid then
    Tab:AddLabel("当前生命值: " .. humanoid.Health)
    Tab:AddLabel("最大生命值: " .. humanoid.MaxHealth)
    Tab:AddLabel("行走速度: " .. humanoid.WalkSpeed)
    Tab:AddLabel("跳跃力: " .. humanoid.JumpPower)
end

-- 显示玩家位置信息
if rootPart then
    local position = rootPart.Position
    Tab:AddLabel("当前位置: (" .. math.floor(position.X) .. ", " .. math.floor(position.Y) .. ", " .. math.floor(position.Z) .. ")")
end

-- 显示玩家排行榜统计数据
local leaderstats = player:FindFirstChild("leaderstats")
if leaderstats then
    for _, stat in pairs(leaderstats:GetChildren()) do
        Tab:AddLabel(stat.Name .. ": " .. stat.Value)
    end
end

-- 显示玩家背包物品
local backpack = player.Backpack
for _, item in pairs(backpack:GetChildren()) do
    Tab:AddLabel("背包物品: " .. item.Name)
end

-- 显示其他玩家信息
for _, p in pairs(game.Players:GetPlayers()) do
    Tab:AddLabel("玩家: " .. p.Name)
end

-- 显示游戏和服务器信息
Tab:AddLabel("当前 Game ID: " .. game.GameId)
Tab:AddLabel("Place ID: " .. game.PlaceId)
local creatorName = game.CreatorType == Enum.CreatorType.Group and game.CreatorId or game.CreatorId
Tab:AddLabel("游戏创建者: " .. creatorName)
Tab:AddLabel("当前游戏人数: " .. #game.Players:GetPlayers())
Tab:AddLabel("当前 Ping: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())
local serverPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
Tab:AddLabel("服务器 Ping: " .. serverPing)
local fps = game:GetService("Stats").Workspace.Heartbeat:GetValue()
Tab:AddLabel("服务器 FPS: " .. math.floor(1 / fps))
Tab:AddLabel("服务器时间: " .. os.date("%Y-%m-%d %H:%M:%S", os.time()))

-- 显示玩家设备类型
local deviceType = game:GetService("UserInputService").TouchEnabled and "移动设备" or "PC"
Tab:AddLabel("设备类型: " .. deviceType)

-- 显示玩家是否为 Roblox 管理员
Tab:AddLabel("是否为 Roblox 管理员: " .. tostring(player:IsInGroup(1200769)))

-- 显示玩家是否处于安全模式
local isSafeMode = player:FindFirstChild("SafeMode")
Tab:AddLabel("安全模式: " .. (isSafeMode and "是" or "否"))

local Tab2 = Window:MakeTab({
	Name = "Criminaily",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab2:AddButton({
	Name = "开自瞄",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/Aimbot%20Pro(AI%20Create).lua?raw=true"))()
  	end    
})

Tab2:AddTextbox({
	Name = "speed",
	Default = "box input",
	TextDisappear = true,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end	  
})
Tab2:AddTextbox({
	Name = "fov",
	Default = "default box input",
	TextDisappear = true,
	Callback = function(Value)
		game:GetService("Workspace").CurrentCamera.FieldOfView = Value
	end	  
})

Tab2:AddToggle({
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

Tab2:AddToggle({
	Name = "Player esp",
	Default = false,
	Callback = function(state)
        if state then
            _G.espInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local espInstance = esp(player.Character, Color3.new(1, 0, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.espInstances, espInstance)
                end
            end
        else
            if _G.espInstances then
                for _, espInstance in pairs(_G.espInstances) do
                    espInstance.delete()
                end
                _G.espInstances = nil
            end
        end
    end
})

-- Declare variables to manage state and running status
local isRunning = false
local checkThread

-- Function to start monitoring nearby players
local function startMonitoring()
    isRunning = true
    checkThread = spawn(function()
        while isRunning do
            -- Check for nearby players
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 500 then
                        -- Notify the player
			playSound("rbxassetid://4590662766", 1, 3.5)
			local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
                        local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2
                        Notification:Notify(
                            {Title = "出生", Description = player.Name .. " 玩家在你50格范围之内"},
                            {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                            {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                        )
                    end
                end
            end
            task.wait(1) -- Adjust the wait time as needed
        end
    end)
end

-- Function to stop monitoring nearby players
local function stopMonitoring()
    isRunning = false
    if checkThread then
        checkThread:Destroy() -- Ensure the thread is properly terminated
    end
end

-- Add a toggle for player message
Tab2:AddToggle({
    Name = "Player Message",
    Default = false,
    Callback = function(state)
        if state then
            startMonitoring() -- Start monitoring when the toggle is enabled
        else
            stopMonitoring() -- Stop monitoring when the toggle is disabled
        end
    end
})

Tab2:AddToggle({
    Name = "Auto Interact",
    Default = false,
    Callback = function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25) -- Adjust the wait time as needed
            end
        else
            autoInteract = false
        end
    end
})

local Tab6 = Window:MakeTab({
	Name = "通用",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local spinning = false
local noClip = false -- Adjust this value for faster or slower spinning
local flying = false
local farming = false
local speed = 50
local defaultSpeed = 16
local boostedSpeed = 50
local spinSpeed = 500
local normalJumpPower = 50
local boostedJumpPower = 100

Tab6:AddToggle({
    Name = "变成老大",
    Default = false,
    Callback = function(state)
        spinning = state
        if spinning then
            -- Start spinning the player
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart") -- The part we want to rotate
            
            -- Spin loop
            spawn(function()
                while spinning do
                    rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                    task.wait(0.01) -- Adjust the wait time for faster or slower updates
                end
            end)
        end
    end
})

Tab6:AddToggle({
    Name = "给我飞起来!!!",
    Default = false,
    Callback = function(state)
        flying = state
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if flying then
            humanoidRootPart.Anchored = true -- Anchor the HumanoidRootPart to enable flight

            -- Fly loop
            spawn(function()
                while flying do
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.lookVector * speed * 0.1
                    task.wait(0.1)
                end
            end)
        else
            humanoidRootPart.Anchored = false -- Unanchor to stop flying
        end
    end
})

Tab6:AddToggle({
    Name = "变成知秋2",
    Default = false,
    Callback = function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25) -- Adjust the wait time as needed
            end
        else
            autoInteract = false
        end
    end
})

Tab6:AddToggle({
    Name = "火车头启动!!!",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if state then
            humanoid.WalkSpeed = boostedSpeed
        else
            humanoid.WalkSpeed = defaultSpeed
        end
    end
})

Tab6:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(state)
        noClip = state
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if noClip then
            -- NoClip loop
            spawn(function()
                while noClip do
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            -- Re-enable collision
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
})

Tab6:AddToggle({
    Name = "啊!!!!!!!",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if state then
            humanoid.JumpPower = boostedJumpPower
        else
            humanoid.JumpPower = normalJumpPower
        end
    end
})

Tab6:AddToggle({
    Name = "滑行者",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if state then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        else
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        end
    end
})

Tab6:AddToggle({
    Name = "变成知秋",
    Default = false,
    Callback = function(state)
        farming = state
        while farming do
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("Tool") and (item.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 10 then
                    fireclickdetector(item.ClickDetector) -- Simulates clicking the item
                end
            end
            task.wait(1) -- Adjust the wait time as needed
        end
    end
})

Tab6:AddToggle({
    Name = "Fake Lag",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if state then
            -- Freeze the player to simulate lag
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
        else
            -- Unfreeze the player
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
        end
    end
})

Tab6:AddToggle({
    Name = "Bunny Hop",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character:WaitForChild("Humanoid")

        if state then
            -- Start Bunny Hopping
            spawn(function()
                while state do
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(0.3) -- Adjust this value for faster or slower hopping
                end
            end)
        end
    end
})

Tab6:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer

        if state then
            -- Enable Infinite Jump
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                    player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})

Tab6:AddToggle({
    Name = "Invisible Character",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = state and 1 or 0 -- Set transparency to 1 (invisible) or 0 (visible)
                part.CanCollide = not state -- Disable collision when invisible
            elseif part:IsA("Accessory") then
                part.Handle.Transparency = state and 1 or 0
            end
        end
    end
})

local Tab3 = Window:MakeTab({
	Name = "Doors",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab3:AddButton({
	Name = "white king",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/white-King/blob/main/White%20King.lua?raw=true"))()
  	end    
})

Tab3:AddButton({
	Name = "Black king old",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/DOORS%20PC.lua?raw=true"))()
  	end    
})
Tab3:AddLabel("----------------功能----------------")
local autoInteract = false

Tab3:AddToggle({
    Name = "快速交互",
    Default = false,
    Callback = function(state)
        if state then
            -- open
            autoInteract = true

            -- getplayer
            local player = game.Players.LocalPlayer

            -- check
            workspace.CurrentRooms.ChildAdded:Connect(function(room)
                room.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("Model") then
                        local prompt = nil
                        if descendant.Name == "DrawerContainer" then
                            prompt = descendant:WaitForChild("Knobs"):WaitForChild("ActivateEventPrompt")
                        elseif descendant.Name == "GoldPile" then
                            prompt = descendant:WaitForChild("LootPrompt")
                        elseif descendant.Name:sub(1, 8) == "ChestBox" or descendant.Name == "RolltopContainer" then
                            prompt = descendant:WaitForChild("ActivateEventPrompt")
                        end

                        if prompt then
                            local interactions = prompt:GetAttribute("Interactions")
                            if not interactions then
                                task.spawn(function()
                                    while autoInteract and not prompt:GetAttribute("Interactions") do
                                        task.wait(0.1)
                                        if player:DistanceFromCharacter(descendant.PrimaryPart.Position) <= 12 then
                                            fireproximityprompt(prompt)
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end)
            end)

            -- check2
            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                for _, descendant in pairs(room:GetDescendants()) do
                    if descendant:IsA("Model") then
                        local prompt = nil
                        if descendant.Name == "DrawerContainer" then
                            prompt = descendant:WaitForChild("Knobs"):WaitForChild("ActivateEventPrompt")
                        elseif descendant.Name == "GoldPile" then
                            prompt = descendant:WaitForChild("LootPrompt")
                        elseif descendant.Name:sub(1, 8) == "ChestBox" or descendant.Name == "RolltopContainer" then
                            prompt = descendant:WaitForChild("ActivateEventPrompt")
                        end

                        if prompt then
                            local interactions = prompt:GetAttribute("Interactions")
                            if not interactions then
                                task.spawn(function()
                                    while autoInteract and not prompt:GetAttribute("Interactions") do
                                        task.wait(0.1)
                                        if player:DistanceFromCharacter(descendant.PrimaryPart.Position) <= 12 then
                                            fireproximityprompt(prompt)
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        else
            -- close
            autoInteract = false
        end
    end        
})

Tab3:AddToggle({
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

Tab3:AddToggle({
	Name = "玩家视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.espInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local espInstance = esp(player.Character, Color3.new(1, 0.78, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.espInstances, espInstance)
                end
            end
        else
            if _G.espInstances then
                for _, espInstance in pairs(_G.espInstances) do
                    espInstance.delete()
                end
                _G.espInstances = nil
            end
        end
    end
})

Tab3:AddToggle({
    Name = "门视奸👁️",
    Default = false,
    Callback = function(state)
        if state then
            _G.doorESPInstances = {}
            local esptable = {doors = {}}
            local flags = {espdoors = true}
            local doorCounter = 0  -- Initialize a counter for the doors
                
            local function setup(room)
                local door = room:WaitForChild("Door") -- Directly get the Door object
                
                task.wait(0.1)
                
                -- Increment the door counter and format it as a four-digit number starting from 0001
                doorCounter = doorCounter + 1
                local doorIndex = string.format("%04d", doorCounter)
                
                -- Set up ESP with the door index in the format "Door [0001]"
                local h = esp(door:WaitForChild("Door"), Color3.fromRGB(90, 255, 40), door, "Door [" .. doorIndex .. "]")
                table.insert(esptable.doors, h)
                
                door:WaitForChild("Door"):WaitForChild("Open").Played:Connect(function()
                    h.delete()
                end)
                
                door.AncestryChanged:Connect(function()
                    h.delete()
                end)
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room) 
                end
            end

            table.insert(_G.doorESPInstances, esptable)

        else
            if _G.doorESPInstances then
                for _, instance in pairs(_G.doorESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.doorESPInstances = nil
            end
        end
    end
})

Tab3:AddToggle({
	Name = "衣柜视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.lockerESPInstances = {}
            local esptable = {lockers = {}}
            local flags = {esplocker = true}

	    local function check(v)
                if v:IsA("Model") then
                    task.wait(0.1)
                    if v.Name == "Wardrobe" then
                        local h = esp(v.PrimaryPart, Color3.fromRGB(90, 255, 40), v.PrimaryPart, "Closet")
                        table.insert(esptable.lockers, h) 
                    elseif (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") then
                        local h = esp(v.PrimaryPart, Color3.fromRGB(90, 255, 40), v.PrimaryPart, "Locker")
                        table.insert(esptable.lockers, h) 
                    end
                end
            end
                
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                if assets then
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                    
                    task.spawn(function()
                        repeat task.wait() until not flags.esplocker
                        subaddcon:Disconnect()  
                    end) 
                end 
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.lockerESPInstances, esptable)

	else
            if _G.lockerESPInstances then
                for _, instance in pairs(_G.lockerESPInstances) do
                    for _, v in pairs(instance.lockers) do
                        v.delete()
                    end
                end
                _G.lockerESPInstances = nil
            end
        end
    end
})

Tab3:AddToggle({
    Name = "稀客删除",
    Default = false,
    Callback = function(state)
        if state then
            -- 创建一个函数用于删除包含 SeekMoving 的模型
            local function deleteModelIfSeekMoving(model)
                if model:FindFirstChild("SeekMoving") then
                    model:Destroy()
                end
            end

            -- 监听模型的添加事件
            local function onModelAdded(model)
                if model:IsA("Model") then
                    deleteModelIfSeekMoving(model)
                end
            end

            -- 监听 CurrentRooms 下的模型添加事件
            local modelAddedConnection
            modelAddedConnection = workspace.CurrentRooms.ChildAdded:Connect(function(model)
                onModelAdded(model)
            end)

            -- 遍历现有的模型并进行检查
            for _, model in pairs(workspace.CurrentRooms:GetChildren()) do
                if model:IsA("Model") then
                    deleteModelIfSeekMoving(model)
                end
            end

            -- 保存连接，以便在关闭时可以断开
            _G.modelAddedConnection = modelAddedConnection

        else
            -- 关闭功能，断开模型添加事件的监听
            if _G.modelAddedConnection then
                _G.modelAddedConnection:Disconnect()
                _G.modelAddedConnection = nil
            end
        end
    end
})

Tab3:AddToggle({
	Name = "高亮",
	Default = false,
	Callback = function(state)
        local Light = game:GetService("Lighting")

        local function dofullbright()
            Light.Ambient = Color3.new(1, 1, 1)
            Light.ColorShift_Bottom = Color3.new(1, 1, 1)
            Light.ColorShift_Top = Color3.new(1, 1, 1)
        end

        local function resetLighting()
            Light.Ambient = Color3.new(0, 0, 0)
            Light.ColorShift_Bottom = Color3.new(0, 0, 0)
            Light.ColorShift_Top = Color3.new(0, 0, 0)
        end

        if state then
            _G.fullBrightEnabled = true
            task.spawn(function()
                while _G.fullBrightEnabled do
                    dofullbright()
                    task.wait(0)  -- 每秒检查一次
                end
            end)
        else
            _G.fullBrightEnabled = false
            resetLighting()
        end
    end
})

Tab3:AddToggle({
	Name = "实体视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.entityESPInstances = {}
            local esptable = {entity = {}}
            local flags = {esprush = true}
            local entitynames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "Eyes", "JeffTheKiller", "SeekMoving"}
	    
            local addconnect
            addconnect = workspace.ChildAdded:Connect(function(v)
                if table.find(entitynames, v.Name) then
                    task.wait(0.1)
                    
                    local h = esp(v, Color3.fromRGB(255, 25, 25), v.PrimaryPart, v.Name:gsub("Moving", ""))
                    table.insert(esptable.entity, h)
                end
            end)

            local function setup(room)
                if room.Name == "50" or room.Name == "100" then
                    local figuresetup = room:WaitForChild("FigureSetup")
                
                    if figuresetup then
                        local fig = figuresetup:WaitForChild("FigureRagdoll")
                        task.wait(0.1)
                        
                        local h = esp(fig, Color3.fromRGB(255, 25, 25), fig.PrimaryPart, "Figure")
                        table.insert(esptable.entity, h)
                    end 
                else
                    local assets = room:WaitForChild("Assets")
                    
                    local function check(v)
                        if v:IsA("Model") and table.find(entitynames, v.Name) then
                            task.wait(0.1)
                            
                            local h = esp(v:WaitForChild("Base"), Color3.fromRGB(255, 25, 25), v.Base, "Snare")
                            table.insert(esptable.entity, h)
                        end
                    end
                    
                    assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                end 
            end
            
            local roomconnect
            roomconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
	    end

	    table.insert(_G.entityESPInstances, esptable)

        else
            if _G.entityESPInstances then
                for _, instance in pairs(_G.entityESPInstances) do
                    for _, v in pairs(instance.entity) do
                        v.delete()
                    end
                end
                _G.entityESPInstances = nil
            end
        end
    end				
})

Tab3:AddToggle({
	Name = "物品视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.itemESPInstances = {}
            local esptable = {items = {}}
            local flags = {espitems = true}

	    local function check(v)
                if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                    task.wait(0.1)
                    
                    local part = (v:FindFirstChild("Handle") or v:FindFirstChild("Prop"))
                    local h = esp(part, Color3.fromRGB(255, 255, 255), part, v.Name)
                    table.insert(esptable.items, h)
                end
            end
            
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                if assets then  
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                    
                    task.spawn(function()
                        repeat task.wait() until not flags.espitems
                        subaddcon:Disconnect()  
                    end) 
                end 
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room) 
                end
            end

            table.insert(_G.itemESPInstances, esptable)

        else
            if _G.itemESPInstances then
                for _, instance in pairs(_G.itemESPInstances) do
                    for _, v in pairs(instance.items) do
                        v.delete()
                    end
                end
                _G.itemESPInstances = nil
            end
        end
    end
})

Tab3:AddToggle({
	Name = "自动图书馆密码",
	Default = false,
	Callback = function(state)
        if state then
            _G.codeEventInstances = {}
            local flags = {getcode = true}

            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2
            local function deciphercode()
                local paper = char:FindFirstChild("LibraryHintPaper")
                local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
                
                local code = {[1]="_", [2]="_", [3]="_", [4]="_", [5]="_"}
                    
                if paper then
                    for i, v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                        if v:IsA("ImageLabel") and v.Name ~= "Image" then
                            for i, img in pairs(hints:GetChildren()) do
                                if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                                    local num = img:FindFirstChild("TextLabel").Text
                                    
                                    code[tonumber(v.Name)] = num 
                                end
                            end
                        end
                    end 
                end
                
                return code
            end
            
            local addconnect
            addconnect = char.ChildAdded:Connect(function(v)
                if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
                    task.wait()
                    
                    local code = table.concat(deciphercode())
                    
                    if code:find("_") then
                        Notification:Notify(
                            {Title = "出生", Description = "给我去收集所有书你还没收集完"},
                            {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                            {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                        )
                    else
                        Notification:Notify(
                            {Title = "出生", Description = "图书馆密码=" .. code},
                            {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                            {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                        )
                    end
                end
            end)
            
            table.insert(_G.codeEventInstances, addconnect)

        else
            if _G.codeEventInstances then
                for _, instance in pairs(_G.codeEventInstances) do
                    instance:Disconnect()
                end
                _G.codeEventInstances = nil
            end
        end
    end
})            

Tab3:AddToggle({
	Name = "书视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.bookESPInstances = {}
            local esptable = {books = {}}
            local flags = {espbooks = true}

	    local function check(v)
                if v:IsA("Model") and (v.Name == "LiveHintBook" or v.Name == "LiveBreakerPolePickup") then
                    task.wait(0.1)
                    
                    local h = esp(v, Color3.fromRGB(255, 255, 255), v.PrimaryPart, "Book")
                    table.insert(esptable.books, h)
                    
                    v.AncestryChanged:Connect(function()
                        if not v:IsDescendantOf(room) then
                            h.delete() 
                        end
                    end)
                end
            end
            
            local function setup(room)
                if room.Name == "50" or room.Name == "100" then
                    room.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(room:GetDescendants()) do
                        check(v)
                    end
                end
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.bookESPInstances, esptable)

	else
            if _G.bookESPInstances then
                for _, instance in pairs(_G.bookESPInstances) do
                    for _, v in pairs(instance.books) do
                        v.delete()
                    end
                end
                _G.bookESPInstances = nil
            end
        end
    end
})

-- Add the toggle to enable/disable speed control
Tab3:AddToggle({
    Name = "Enable Speed",
    Default = false,
    Callback = function(state)
        speedControlEnabled = state -- Update the variable based on the toggle state
        if not state then
            -- Reset the speed to default when speed control is disabled
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})
-- Add the textbox to input the desired speed
Tab3:AddTextbox({
    Name = "Speed",
    Default = "16", -- Default speed in Roblox is usually 16
    TextDisappear = true,
    Callback = function(Value)
        if speedControlEnabled then
            -- Convert the input to a number and update the WalkSpeed
            local speed = Value
            if speed then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
            else
                -- Handle invalid input (not a number)
                warn("Please enter a valid number.")
            end
        else
            warn("Speed control is disabled.")
        end
    end
})

Tab3:AddToggle({
	Name = "拉杆视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.locESPInstances = {}
            local esptable = {loc = {}}
            local flags = {esploc = true}

	    local function check(v)
                if v:IsA("Model") then
                    task.wait(0.1)
                    if v.Name == "LeverForGate" then
                        local h = esp(v.PrimaryPart, Color3.fromRGB(25, 55, 5), v.PrimaryPart, "Lever")
                        table.insert(esptable.lockers, h)
                    end
                end
            end
                
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                if assets then
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                    
                    task.spawn(function()
                        repeat task.wait() until not flags.esplocker
                        subaddcon:Disconnect()  
                    end) 
                end 
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.locESPInstances, esptable)

	else
            if _G.locESPInstances then
                for _, instance in pairs(_G.locESPInstances) do
                    for _, v in pairs(instance.loc) do
                        v.delete()
                    end
                end
                _G.locESPInstances = nil
            end
        end
    end
})

-- Add the toggle to enable/disable FOV control
Tab3:AddToggle({
    Name = "Enable FOV",
    Default = false,
    Callback = function(state)
        FOVEnabled = state -- Update the variable based on the toggle state
        if not state then
            -- Reset the FOV to default when FOV control is disabled
            game:GetService("Workspace").CurrentCamera.FieldOfView = 70
        end
    end
})
-- Add the textbox to input the desired FOV
Tab3:AddTextbox({
    Name = "FOV",
    Default = "70", -- Default FOV in Roblox is usually 70
    TextDisappear = true,
    Callback = function(FOV)
        if FOVEnabled then
            -- Convert the input to a number and update the FOV
            local fo = tonumber(FOV)
            if fo then
                game:GetService("Workspace").CurrentCamera.FieldOfView = fo
            else
                -- Handle invalid input (not a number)
                warn("Please enter a valid number.")
            end
        else
            warn("FOV control is disabled.")
        end
    end
})

local Tab4 = Window:MakeTab({
	Name = "Pressure",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab4:AddButton({
	Name = "Creepy client V2.4",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/pressure-ScriptV2.4.lua?raw=true"))()
  	end    
})

local Tab5 = Window:MakeTab({
	Name = "bedwars",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab5:AddButton({
	Name = "1",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/bedwars.lua?raw=true"))()
  	end    
})

Tab3:AddToggle({
	Name = "钥匙视奸👁️",
	Default = false,
	Callback = function(state)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local markedTargets = {}

        local function createCircularUI(parent, color)
            local mid = Instance.new("Frame", parent)
            mid.AnchorPoint = Vector2.new(0.5, 0.5)
            mid.BackgroundColor3 = color
            mid.Size = UDim2.new(0, 8, 0, 8)
            mid.Position = UDim2.new(0.5, 0, 0.0001, 0) -- Adjusted position
            Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
            Instance.new("UIStroke", mid)
            
            return mid
        end

        local function markTarget(target, customName)
            if not target then return end
            local oldTag = target:FindFirstChild("Batteries")
            if oldTag then
                oldTag:Destroy()
            end
            local oldHighlight = target:FindFirstChild("Highlight")
            if oldHighlight then
                oldHighlight:Destroy()
            end
            local tag = Instance.new("BillboardGui")
            tag.Name = "Batteries"
            tag.Size = UDim2.new(0, 200, 0, 50)
            tag.StudsOffset = Vector3.new(0, 0.7, 0) -- Adjusted offset
            tag.AlwaysOnTop = true
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextStrokeTransparency = 0 
            textLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.Font = Enum.Font.Jura
            textLabel.TextScaled = true
            textLabel.Text = customName
            textLabel.Parent = tag
            tag.Parent = target
            local highlight = Instance.new("Highlight")
            highlight.Name = "Highlight"
            highlight.Adornee = target
            highlight.FillColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 139)
            highlight.Parent = target
            markedTargets[target] = customName
            
            -- 添加优质圆圈 UI
            createCircularUI(tag, Color3.fromRGB(255, 255, 255))
        end

        local function recursiveFindAll(parent, name, targets)
            for _, child in ipairs(parent:GetChildren()) do
                if child.Name == name then
                    table.insert(targets, child)
                end
                recursiveFindAll(child, name, targets)
            end
        end

        local function Itemlocationname(name, customName)
            local targets = {}
            recursiveFindAll(game, name, targets)
            for _, target in ipairs(targets) do
                markTarget(target, customName)
            end
        end

        local function Invalidplayername(playerName, customName)
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Name == playerName and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        markTarget(head, customName)
                    end
                end
            end
        end

        if state then
             Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    local head = character:FindFirstChild("Head")
                    if head then
                        markTarget(head, player.Name)
                    end
                end)
            end)

            game.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "Key" then
                    markTarget(descendant, "Key")
                end
            end)

            RunService.RenderStepped:Connect(function()
                for target, customName in pairs(markedTargets) do
                    if target and target:FindFirstChild("Batteries") then
                        target.Batteries.TextLabel.Text = customName
                    else
                        if target then
                            markTarget(target, customName)
                        end
                    end
                end
            end)

            Invalidplayername("玩家名称", "玩家")
            Itemlocationname("Key", "Key")
        else
            for target, _ in pairs(markedTargets) do
                if target:FindFirstChild("Batteries") then
                    target.Batteries:Destroy()
                end
                if target:FindFirstChild("Highlight") then
                    target.Highlight:Destroy()
                end
            end
            markedTargets = {}
        end
    end        
})

Tab3:AddToggle({
    Name = "实体消息",
    Default = false,
    Callback = function(state)
        if state then
            local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90", "Eyes", "JeffTheKiller"}  -- 实体名称
            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2
            playSound("rbxassetid://4590662766", 1, 3.5)

            -- 确保 flags 和 plr 已定义
            local flags = flags or {} -- 防止错误
            local plr = game.Players.LocalPlayer -- 防止错误2

            local function notifyEntitySpawn(entity)
                Notification:Notify(
                    {Title = "出生[实体事件]", Description = entity.Name:gsub("Moving", ""):lower() .. " Spawned!"},
                    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
		)
            end

            local function onChildAdded(child)
                if table.find(entityNames, child.Name) then
                    repeat
                        task.wait()
                    until plr:DistanceFromCharacter(child:GetPivot().Position) < 1000 or not child:IsDescendantOf(workspace)
                    
                    if child:IsDescendantOf(workspace) then
                        notifyEntitySpawn(child)
                    end
                end
            end

            -- 无限循环以保持脚本运行并检查 hintrush 标志
            local running = true
            while running do
                local connection = workspace.ChildAdded:Connect(onChildAdded)
                
                repeat
                    task.wait(1) -- 根据需要调整等待时间
                until not flags.hintrush or not running
                
                connection:Disconnect()
            end 
        else 
            -- 关闭消息或进行其他清理（如有需要）
            running = false
        end
    end
})

Tab3:AddToggle({
    Name = "物品消息",
    Default = false,
    Callback = function(state)
        if state then
            _G.itemNotificationInstances = {}
            local flags = {notifitems = true}

            -- 加载通知库
            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2

            -- 发送通知的函数
            local function notifyItem(itemName)
                Notification:Notify(
                    {Title = "出生[物品事件]", Description = itemName .. " 已生成"},
                    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                )
            end

            -- 监控新物品的出现
            local function check(v)
                if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                    task.wait(0.1)

                    -- 尝试找到物品的主部件
                    local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop") or v:FindFirstChildWhichIsA("BasePart")
                    
                    -- 如果找到了部件，发送通知
                    if part then
                        local itemName = v.Name
                        notifyItem(itemName)
                    end
                end
            end

            -- 设置监视器以处理现有和新添加的物品
            local function setup(room)
                local assets = room:WaitForChild("Assets")

                if assets then
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v)
                    end)

                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end

                    task.spawn(function()
                        repeat task.wait() until not flags.notifitems
                        subaddcon:Disconnect()
                    end)
                end
            end

            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)

            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room)
                end
            end

            table.insert(_G.itemNotificationInstances, flags)

        else
            if _G.itemNotificationInstances then
                _G.itemNotificationInstances = nil
            end
        end
    end
})

getgenv().midd = false

Tab3:AddToggle({
    Name = "点击范围 (大)",
    Default = false,
    Callback = function(state)
        getgenv().midd = state

        if state then
            -- 监听 CurrentRooms 中的子对象添加事件
            game:GetService("Workspace").CurrentRooms.DescendantAdded:Connect(function(v)
                -- 如果 midd 变量为 false，则直接返回
                if not getgenv().midd then return end
                
                -- 检查是否是 ProximityPrompt 对象
                if v:IsA("ProximityPrompt") then
                    -- 如果 midd 为 true，将 MaxActivationDistance 设置为 20
                    if getgenv().midd then
                        v.MaxActivationDistance = 20
                    end
                end
            end)
        end
    end
})
local lasfToggle = false  -- 用于控制是否启用销毁物体的功能
-- 定义一个 Toggle，用于控制 lasfToggle 的状态
Tab3:AddToggle({
    Name = "销毁吊灯",
    Default = false,
    Callback = function(state)
        lasfToggle = state
    end
})

-- 使用 RenderStepped 来监听房间的改变并执行销毁操作
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if lasfToggle then
            local latestRoomNumber = tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)
            local latestRoom = game.workspace.CurrentRooms:FindFirstChild(latestRoomNumber)
            
            if latestRoom then
                local assets = latestRoom:FindFirstChild("Assets")
                
                if assets then
                    -- 尝试销毁吊灯
                    local chandelier = assets:FindFirstChild("Chandelier")
                    if chandelier then
                        chandelier:Destroy()
                    end

                    -- 尝试销毁灯具
                    local lightFixtures = assets:FindFirstChild("Light_Fixtures")
                    if lightFixtures then
                        lightFixtures:Destroy()
                    end
                end
            end
        end
    end)
end)
_G.Gates = false
-- 添加 Toggle 用于 Gates
Tab3:AddToggle({
    Name = "Gate删除",
    Default = false,
    Callback = function(state)
        _G.Gates = state
        
        -- 当 Gates 为 true 时，运行 RenderStepped 事件
        if state then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if _G.Gates then
                        local latestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                        local currentRoom = game.workspace.CurrentRooms[tostring(latestRoom)]
                        
                        -- 销毁 Gate 对象
                        if currentRoom:FindFirstChild("Gate") then
                            currentRoom.Gate:Destroy()
                        end
                    end
                end)
            end)
        end
    end
})

local ScreechModule
Tab3:AddToggle({
    Name = "无害的Screech",
    Default = false,
    Callback = function(state)
        if state then
            -- 确保找到 ScreechModule
            if not ScreechModule then
                ScreechModule = plr.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Screech")
            end
            -- 移除 ScreechModule
            if ScreechModule then
                ScreechModule.Parent = nil
            end
        else
            -- 恢复 ScreechModule
            if ScreechModule then
                ScreechModule.Parent = plr.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
            end
        end
    end
})

_G.SeekES = false
-- 添加 Toggle 用于 SeekES
Tab3:AddToggle({
    Name = "销毁 稀客胳膊/火",
    Default = false,
    Callback = function(state)
        _G.SeekES = state
        
        -- 当 SeekES 为 true 时，运行 RenderStepped 事件
        if state then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if _G.SeekES then
                        local latestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                        local currentRoom = game.workspace.CurrentRooms[tostring(latestRoom)]
                        local assets = currentRoom:WaitForChild("Assets")

                        -- 销毁 ChandelierObstruction 和 Seek_Arm
                        if assets:FindFirstChild("ChandelierObstruction") then
                            assets.ChandelierObstruction:Destroy()
                        end

                        for i = 1, 15 do
                            if assets:FindFirstChild("Seek_Arm") then
                                assets.Seek_Arm:Destroy()
                            end
                        end
                    end
                end)
            end)
        end
    end
})

Tab3:AddToggle({
    Name = "金币视奸👁️",
    Default = false,
    Callback = function(state)
        if state then
            _G.lockESPInstances = {}
            local esptable = {lock = {}}
            local flags = {esplock = true}

            local function check(v)
                if v:IsA("Model") then
                    task.wait(0.1)
                    if v.Name == "GoldPile" then
                        local hitbox = v:WaitForChild("Hitbox")
                        if hitbox then
                            local goldValue = v:GetAttribute("GoldValue") or 0
                            local formattedGoldValue = string.format("%04d", goldValue) -- Format the gold value as a four-digit number
                            local displayText = string.format("Gold [%s]", formattedGoldValue)
                            local h = esp(hitbox, Color3.fromRGB(255, 255, 255), hitbox, displayText)
                            table.insert(esptable.lock, h)
                        end
                    end
                end
            end

            local function setup(room)
                local assets = room:WaitForChild("Assets")

                if assets then
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)

                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end

                    task.spawn(function()
                        repeat task.wait() until not flags.esplock
                        subaddcon:Disconnect()  
                    end) 
                end 
            end

            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)

            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.lockESPInstances, esptable)

        else
            if _G.lockESPInstances then
                for _, instance in pairs(_G.lockESPInstances) do
                    for _, v in pairs(instance.lock) do
                        v.delete()
                    end
                end
                _G.lockESPInstances = nil
            end
        end
    end
})

Tab3:AddToggle({
	Name = "箱子视奸👁️",
	Default = false,
	Callback = function(state)
        if state then
            _G.lockeESPInstances = {}
            local esptable = {locke = {}}
            local flags = {esplocke = true}

	    local function check(v)
                if v:IsA("Model") then
                    task.wait(0.1)
                    if v.Name == "ChestBox" then
                        local h = esp(v.PrimaryPart, Color3.fromRGB(255, 0, 0), v.PrimaryPart, "ChestBox [Unlocked]")
                        table.insert(esptable.locke, h) 
                    elseif v.Name == "ChestBoxLocked" then
                        local h = esp(v.PrimaryPart, Color3.fromRGB(255, 0, 0), v.PrimaryPart, "ChestBox [Locked]")
                        table.insert(esptable.locke, h) 
                    end
                end
            end
                
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                if assets then
                    local subaddcon
                    subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v) 
                    end)
                    
                    for i, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                    
                    task.spawn(function()
                        repeat task.wait() until not flags.esplocker
                        subaddcon:Disconnect()  
                    end) 
                end 
            end
            
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.lockeESPInstances, esptable)

	else
            if _G.lockeESPInstances then
                for _, instance in pairs(_G.lockeESPInstances) do
                    for _, v in pairs(instance.locke) do
                        v.delete()
                    end
                end
                _G.lockeESPInstances = nil
            end
        end
    end
})

local Tab11 = Window:MakeTab({
	Name = "IA script",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab11:AddButton({
	Name = "开自瞄(Only Gun)",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/Aimbot%20Pro(AI%20Create).lua?raw=true"))()
  	end    
})

Tab11:AddToggle({
	Name = "Player esp",
	Default = false,
	Callback = function(state)
        if state then
            _G.espInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local espInstance = esp(player.Character, Color3.new(1, 0.25, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.espInstances, espInstance)
                end
            end
        else
            if _G.espInstances then
                for _, espInstance in pairs(_G.espInstances) do
                    espInstance.delete()
                end
                _G.espInstances = nil
            end
        end
    end
})

Tab11:AddToggle({
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

Tab11:AddTextbox({
	Name = "speed",
	Default = "box input",
	TextDisappear = true,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end	  
})
Tab11:AddTextbox({
	Name = "fov",
	Default = "default box input",
	TextDisappear = true,
	Callback = function(Value)
		game:GetService("Workspace").CurrentCamera.FieldOfView = Value
	end	  
})

Tab11:AddLabel("前情提要")
Tab11:AddLabel("作者不玩IA")
Tab11:AddLabel("如果被禁止")
Tab11:AddLabel("并且在下一次进入游戏")
Tab11:AddLabel("观看你当小丑的画面")
Tab11:AddLabel("我们不负责----By nys195")

local isA1000Enabled = false

local function startA1000Script()
    if game.PlaceId ~= 6839171747 or game.ReplicatedStorage.GameData.Floor.Value ~= "Rooms" then
        Notification:Notify(
            {Title = "Auto A1000", Description = "Script initiation failed: Incorrect Place or Floor."},
            {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 3, Type = "image"},
            {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
        )
        return
    end

    local PathfindingService = game:GetService("PathfindingService")
    local LocalPlayer = game.Players.LocalPlayer
    local LatestRoom = game.ReplicatedStorage.GameData.LatestRoom
    local Folder = Instance.new("Folder", workspace)
    Folder.Name = "PathFindPartsFolder"

    local function disableIdle()
        local GC = getconnections or get_signal_cons
        if GC then
            for _,v in pairs(GC(LocalPlayer.Idled)) do
                if v["Disable"] then
                    v["Disable"](v)
                elseif v["Disconnect"] then
                    v["Disconnect"](v)
                end
            end
        end
    end

    disableIdle()

    local function getLocker()
        local Closest
        for _,v in pairs(workspace.CurrentRooms:GetDescendants()) do
            if v.Name == "Rooms_Locker" and v:FindFirstChild("Door") and v:FindFirstChild("HiddenPlayer") then
                if v.HiddenPlayer.Value == nil and v.Door.Position.Y > -3 then
                    if not Closest or (LocalPlayer.Character.HumanoidRootPart.Position - v.Door.Position).Magnitude < (Closest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
                        Closest = v.Door
                    end
                end
            end
        end
        return Closest
    end

    local function getPath()
        local Entity = workspace:FindFirstChild("A60") or workspace:FindFirstChild("A120")
        if Entity and Entity.Main.Position.Y > -4 then
            return getLocker()
        else
            return workspace.CurrentRooms[LatestRoom.Value].Door.Door
        end
    end

    LatestRoom:GetPropertyChangedSignal("Value"):Connect(function()
        if LatestRoom.Value >= 1000 then
            Notification:Notify(
                {Title = "Auto A1000", Description = "Reached Room 1000!"},
                {OutlineColor = Color3.fromRGB(0, 255, 0), Time = 5, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
            )
            Folder:ClearAllChildren()
            isA1000Enabled = false
            return
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        LocalPlayer.Character.HumanoidRootPart.CanCollide = false
        LocalPlayer.Character.Humanoid.WalkSpeed = 21

        local Entity = workspace:FindFirstChild("A60") or workspace:FindFirstChild("A120")
        if Entity and Entity.Main.Position.Y > -4 then
            local Path = getPath()
            if Path and Path.Parent.Name == "Rooms_Locker" then
                if (LocalPlayer.Character.HumanoidRootPart.Position - Path.Position).Magnitude < 2 then
                    if not LocalPlayer.Character.HumanoidRootPart.Anchored then
                        fireproximityprompt(Path.Parent.HidePrompt)
                    end
                end
            end
        end
    end)

    while LatestRoom.Value < 1000 do
        local Destination = getPath()
        local path = PathfindingService:CreatePath({ AgentRadius = 1, AgentCanJump = false })
        path:ComputeAsync(LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0,2,0), Destination.Position)

        if path.Status ~= Enum.PathStatus.NoPath then
            Folder:ClearAllChildren()
            for _, Waypoint in pairs(path:GetWaypoints()) do
                local part = Instance.new("Part", Folder)
                part.Size = Vector3.new(1,1,1)
                part.Position = Waypoint.Position
                part.Shape = "Cylinder"
                part.Anchored = true
                part.CanCollide = false
            end

            for _, Waypoint in pairs(path:GetWaypoints()) do
                if not LocalPlayer.Character.HumanoidRootPart.Anchored then
                    LocalPlayer.Character.Humanoid:MoveTo(Waypoint.Position)
                    LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
                end
            end
        end
    end
end

Tab3:AddToggle({
    Name = "Auto A1000 Script[出生]",
    Default = false,
    Callback = function(state)
        isA1000Enabled = state
        if state then
            startA1000Script()
        else
            Folder:ClearAllChildren()
            Notification:Notify(
                {Title = "Auto A1000", Description = "Script disabled."},
                {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 3, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
            )
        end
    end
})

OrionLib:Init()
