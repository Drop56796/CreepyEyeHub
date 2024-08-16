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
function esp(what, color, core, name)
    local parts
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what, table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end

    local bill
    local boxes = {}

    for i, v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = v.Size
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.AdornCullingMode = Enum.AdornCullingMode.Never
            box.Color3 = color
            box.Transparency = 0.7
            box.Adornee = v
            box.Parent = game.CoreGui

            table.insert(boxes, box)

            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end
                    task.wait()
                end
            end)
        end
    end

    if core and name then
        bill = Instance.new("BillboardGui", game.CoreGui)
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
        Instance.new("UIStroke", txt)

        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy()
                end
                task.wait()
            end
        end)
    end

    local ret = {}

    ret.delete = function()
        for i, v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end

        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy()
        end
    end

    return ret
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 
local Window = OrionLib:MakeWindow({Name = "出生脚本 V1.1", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "公告",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("本脚本为 游戏 制作")
Tab:AddLabel("不怕banned和被骂没母和被挂你就用")
Tab:AddLabel("开始你的表演")

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
                        local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
			local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
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
	Name = "开自瞄",
	Callback = function()
      		loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/bedwars.lua?raw=true"))()
  	end    
})

OrionLib:Init()
