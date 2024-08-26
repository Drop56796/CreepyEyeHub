local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local v = 1.2
local Players = game:GetService("Players")
local textChannel = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")  -- Ensure Humanoid exists
local rootPart = char:WaitForChild("HumanoidRootPart")
--local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

function warnNofiy(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 0, 0)}
	)
end
function Nofiy(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
	)
end
--function newNofiy(title, text, text2, id)
--    achievementGiver({
--        Title = title,   
--        Desc = text,     
--        Reason = text2,  
--        Image = id 
--    })
--end

----- 示例调用 NewNotify 函数
--newNofiy("Hydraulic Doors", "hi", "Welcome to use", "rbxassetid://12309073114")

local buttons = {
    tpwalktoggle = nil,  -- TP Walk 开关按钮
    tpwalkspeed = nil,   -- TP Walk 速度滑块
    camfov = nil,   -- FOV 滑块
    noclip = nil
}

local flags = {
    tpwalktoggle = false,  -- TP Walk 开关标志
    tpwalkspeed = 16,      -- TP Walk 速度标志
    camfov = 70,           -- FOV 标志
    camfovtoggle = false,  -- FOV 开关标志（添加这个以匹配开关功能）
    esprush = false,
    espdoors = false,
    esplocker = false,
    espitems = false,
    espbooks = false,
    espgold = false,
    targetKeyObtain = false,
    noclip = false,
    speedThreshold = 2,
    getcode = false,
    itemaura = false
}
local esptable = {
        entity = {},
	doors = {},
	lockers = {},
	items = {},
	books = {},
	Gold = {},
	key = {}
}

Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
local GUIWindow = Library:CreateWindow({
	Name = "Hydraulic Doors v".. v,
	Themeable = false
})
local GUI = GUIWindow:CreateTab({
	Name = "主功能"
})
local window_player = GUI:CreateSection({
	Name = "Player"
})

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
local Camera = game:GetService("Workspace").CurrentCamera

local function createBorder(part, color)
    local border = Drawing.new("Line")
    border.Color = color
    border.Thickness = 2
    border.Transparency = 0.5
    border.Visible = false

    local function updateBorder()
        if part and part:IsDescendantOf(workspace) then
            local partPos = part.Position
            local partSize = part.Size

            -- 计算部件的世界坐标系的四个角
            local corners = {
                partPos + Vector3.new(partSize.X / 2, partSize.Y / 2, partSize.Z / 2),
                partPos + Vector3.new(-partSize.X / 2, partSize.Y / 2, partSize.Z / 2),
                partPos + Vector3.new(-partSize.X / 2, -partSize.Y / 2, partSize.Z / 2),
                partPos + Vector3.new(partSize.X / 2, -partSize.Y / 2, partSize.Z / 2),
                partPos + Vector3.new(partSize.X / 2, partSize.Y / 2, -partSize.Z / 2),
                partPos + Vector3.new(-partSize.X / 2, partSize.Y / 2, -partSize.Z / 2),
                partPos + Vector3.new(-partSize.X / 2, -partSize.Y / 2, -partSize.Z / 2),
                partPos + Vector3.new(partSize.X / 2, -partSize.Y / 2, -partSize.Z / 2),
            }

            local function toScreenSpace(pos)
                local screenPos = Camera:WorldToViewportPoint(pos)
                return Vector2.new(screenPos.X, screenPos.Y)
            end

            -- 计算屏幕坐标系下的角点
            local screenCorners = {}
            for _, corner in ipairs(corners) do
                table.insert(screenCorners, toScreenSpace(corner))
            end

            -- 绘制边框（连接角点）
            local function drawLine(from, to)
                border.From = from
                border.To = to
                border.Visible = true
            end

            drawLine(screenCorners[1], screenCorners[2])
            drawLine(screenCorners[2], screenCorners[3])
            drawLine(screenCorners[3], screenCorners[4])
            drawLine(screenCorners[4], screenCorners[1])

            drawLine(screenCorners[5], screenCorners[6])
            drawLine(screenCorners[6], screenCorners[7])
            drawLine(screenCorners[7], screenCorners[8])
            drawLine(screenCorners[8], screenCorners[5])

            drawLine(screenCorners[1], screenCorners[5])
            drawLine(screenCorners[2], screenCorners[6])
            drawLine(screenCorners[3], screenCorners[7])
            drawLine(screenCorners[4], screenCorners[8])
        else
            border.Visible = false
        end
    end

    RunService.RenderStepped:Connect(updateBorder)

    return border
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
    txt.Font = Enum.Font.Oswald -- 设置字体为 Oswald
    Instance.new("UIStroke", txt)

    return bill
end

-- 创建 Tracer 实例
local function createTracer(target, color)
    local line = Drawing.new("Line")
    line.Color = color
    line.Thickness = 2
    line.Transparency = 1

    local function updateTracer()
        if target and target:IsDescendantOf(workspace) then
            local targetPos = Camera:WorldToViewportPoint(target.Position)
            local screenPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- 从屏幕中心底部开始

            line.From = screenPos
            line.To = Vector2.new(targetPos.X, targetPos.Y)
            line.Visible = true
        else
            line.Visible = false
        end
    end

    RunService.RenderStepped:Connect(updateTracer)

    return line
end

-- 主 ESP 函数
function esp(what, color, core, name, enableTracer)
    -- 检查是否传入 enableTracer 参数，如果未传入，则默认为 false
    if enableTracer == nil then
        enableTracer = false
    end

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

    -- 创建和管理 Border、Highlight 和 Tracer 实例
    local borders = {}
    local highlights = {}
    local tracers = {}

    for _, part in ipairs(parts) do
        local border = createBorder(part, color)
        table.insert(borders, border)
        
        local highlight = createHighlight(part, color)
        table.insert(highlights, highlight)

        --追踪线仅针对第一个有效部件
        if enableTracer and #tracers == 0 then
            local tracer = createTracer(part, color)
            table.insert(tracers, tracer)
        end
    end

    local bill
    if core and name then
        bill = createBillboardGui(core, color, name)
    end

    local function checkAndUpdate()
        -- 检查 Border 和 Highlight 是否需要更新
        for _, border in ipairs(borders) do
            if not border or not border.Visible then
                border:Remove()
            end
        end
        
        for _, highlight in ipairs(highlights) do
            if not highlight.Adornee or not highlight:IsDescendantOf(workspace) then
                highlight:Destroy()
            end
        end

        if bill and (not bill.Adornee or not bill.Adornee:IsDescendantOf(workspace)) then
            bill:Destroy()
        end

        -- 检查 Tracer 是否需要更新
        for _, tracer in ipairs(tracers) do
            if not tracer or not tracer.Visible then
                tracer:Remove()
            end
        end
    end

    RunService.Stepped:Connect(checkAndUpdate)

    local ret = {}

    ret.delete = function()
        for _, border in ipairs(borders) do
            border:Remove()
        end
        
        for _, highlight in ipairs(highlights) do
            highlight:Destroy()
        end

        for _, tracer in ipairs(tracers) do
            if tracer then
                tracer:Remove()
            end
        end

        if bill then
            bill:Destroy()
        end
    end

    return ret
end
-----------
--Example:
--     local espObject = esp(workspace.Part, Color3.new(1, 0, 0), workspace.Part, "Test Object")
--     local espObject = esp(workspace.Part, Color3.new(1, 0, 0), workspace.Part, "Test Object", true)
---end
-----------
task.spawn(function()
	--	repeat task.wait(1) until flags.anticheatbypass == true
	local nocliptoggle = window_player:AddToggle({
		Name = "Noclip",
		Value = false,
		Callback = function(val, oldval)
			flags.noclip = val

			if val then
				local Nocliprun =  nil
				Nocliprun = game:GetService("RunService").Stepped:Connect(function()
					if game.Players.LocalPlayer.Character ~= nil then
						for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
							if v:IsA("BasePart") then
								pcall(function()
									v.CanCollide = false
								end)
							end
						end
					end
					if flags.noclip == false then
						if Nocliprun then Nocliprun:Disconnect() end
					end
				end)
			end
		end
	})
	buttons.noclip = nocliptoggle
end)
local RunService = game:GetService("RunService")
local tpwalkspeedslider = window_player:AddSlider({
    Name = "WalkSpeed",
    Value = 16,
    Min = 16,
    Max = 22,
    Callback = function(val, oldval)
        flags.tpwalkspeed = val
        if flags.tpwalktoggle then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val  -- Directly set WalkSpeed if toggle is on
        end
    end
})
buttons.tpwalkspeed = tpwalkspeedslider

local tpwalktglbtn = window_player:AddToggle({
    Name = "Toggle Walk",
    Value = false,
    Callback = function(val, oldval)
        flags.tpwalktoggle = val
        if val then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = flags.tpwalkspeed  -- Apply selected WalkSpeed when enabled
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16  -- Reset to default WalkSpeed when disabled
        end
    end
})
buttons.tpwalktoggle = tpwalktglbtn

-- Create a loop using RunService to enforce WalkSpeed
RunService.RenderStepped:Connect(function()
    if flags.tpwalktoggle then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = flags.tpwalkspeed  -- Enforce the selected WalkSpeed
    end
end)

local camfovslider = window_player:AddSlider({
    Name = "FOV",
    Value = 70,
    Min = 50,
    Max = 120,
    Callback = function(val, oldval)
        flags.camfov = val
    end
})
buttons.camfov = camfovslider

local togglefovbtn = window_player:AddToggle({
    Name = "Toggle FOV",
    Value = false,
    Callback = function(val, oldval)
        flags.camfovtoggle = val
        if not val then
            waitframes(2)
            game:GetService("Workspace").CurrentCamera.FieldOfView = 70
        end
    end
})
buttons.camfovtoggle = togglefovbtn

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if not rootPart or not hum then return end

        -- Update FOV
        if flags.camfovtoggle then
            pcall(function()
                game:GetService("Workspace").CurrentCamera.FieldOfView = flags.camfov
            end)
        end
    end)
end)

local window_esp = GUI:CreateSection({
	Name = "esp"
})


local Player = window_esp:AddToggle({
	Name = "Player esp",
	Value = false,
	Callback = function(state)
	if state then
            _G.espInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local espInstance = esp(player.Character, Color3.new(1, 0.5, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
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

local Enity = window_esp:AddToggle({
	Name = "Enity esp",
	Value = false,
	Callback = function(state)
	if state then
            _G.entityESPInstances = {}
            flags.esprush = state
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

local DE = window_esp:AddToggle({
	Name = "Door esp",
	Value = false,
	Callback = function(state)
	if state then
            _G.doorESPInstances = {}
            flags.espdoors = state
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

local LWESP = window_esp:AddToggle({
	Name = "locker/Wardrobe esp",
	Value = false,
	Callback = function(state)
	if state then
            _G.lockerESPInstances = {}
	    flags.esplocker = state
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

local fb = window_player:AddToggle({
	Name = "fullbright",
	Value = false,
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

local Player = window_esp:AddToggle({
	Name = "item esp",
	Value = false,
	Callback = function(state)
	if state then
            _G.itemESPInstances = {}
            flags.espitems = state

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

local Player = window_esp:AddToggle({
    Name = "Book/Breaker esp",
    Value = false,
    Callback = function(state)
        if state then
            -- Initialize or reset ESP instances
            _G.bookESPInstances = {}
            flags.espbooks = state

            -- Function to check and handle new models
            local function check(v)
                if v:IsA("Model") then
                    local name = ""
                    if v.Name == "LiveHintBook" then
                        name = "Book"
                    elseif v.Name == "LiveBreakerPolePickup" then
                        name = "Breaker"
                    end
                    
                    if name ~= "" then
                        task.wait(0.1)
                        
                        local h = esp(v, Color3.fromRGB(255, 255, 255), v.PrimaryPart, name)
                        table.insert(esptable.books, h)
                        
                        v.AncestryChanged:Connect(function()
                            if not v:IsDescendantOf(room) then
                                h.delete() 
                            end
                        end)
                    end
                end
            end

            -- Function to set up ESP for rooms
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

            -- Connect to new rooms being added
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            
            -- Set up existing rooms
            for i, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            -- Store the ESP instances
            table.insert(_G.bookESPInstances, esptable)

        else
            -- Remove all ESP instances if disabled
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
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local markedTargets = {}

-- Define translation dictionary
local translationDictionary = {
    ["钥匙"] = "Key",  -- Example translation
    ["玩家"] = "Player",
    -- Add more translations as needed
}

-- Function to translate Chinese to English
local function translate(text)
    return translationDictionary[text] or text
end

-- Function to create a circular UI element
local function createCircularUI(parent, color)
    local circularUI = Instance.new("Frame")
    circularUI.AnchorPoint = Vector2.new(0.5, 0.5)
    circularUI.BackgroundColor3 = color
    circularUI.Size = UDim2.new(0, 12, 0, 12)
    circularUI.Position = UDim2.new(0.5, 0, 0.5, 0)
    circularUI.Parent = parent
    local corner = Instance.new("UICorner", circularUI)
    corner.CornerRadius = UDim.new(0.5, 0)
    local stroke = Instance.new("UIStroke", circularUI)
    stroke.Thickness = 2

    return circularUI
end

-- Function to mark a target with a tag and highlight
local function markTarget(target, customName)
    if not target then return end
    
    -- Remove old tags and highlights if they exist
    local oldTag = target:FindFirstChild("Tag")
    if oldTag then
        oldTag:Destroy()
    end
    
    local oldHighlight = target:FindFirstChild("Highlight")
    if oldHighlight then
        oldHighlight:Destroy()
    end
    
    -- Translate customName
    local translatedName = translate(customName)
    
    -- Create new tag
    local tag = Instance.new("BillboardGui")
    tag.Name = "Tag"
    tag.Size = UDim2.new(0, 200, 0, 50)
    tag.StudsOffset = Vector3.new(0, 2, 0)
    tag.AlwaysOnTop = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextScaled = true
    textLabel.Text = translatedName
    textLabel.Parent = tag
    tag.Parent = target
    
    -- Create highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.Adornee = target
    highlight.FillColor = Color3.fromRGB(0, 0, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.Parent = target
    
    markedTargets[target] = translatedName
    
    -- Create circular UI
    createCircularUI(tag, Color3.fromRGB(0, 255, 0))
end

-- Function to recursively find all instances by name
local function recursiveFindAll(parent, name, targets)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name == name then
            table.insert(targets, child)
        end
        recursiveFindAll(child, name, targets)
    end
end

-- Function to mark all instances of a specific name
local function markInstancesByName(name, customName)
    local targets = {}
    recursiveFindAll(game, name, targets)
    for _, target in ipairs(targets) do
        markTarget(target, customName)
    end
end

-- Function to mark a specific player's character head
local function markPlayerHead(playerName, customName)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name == playerName and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                markTarget(head, customName)
            end
        end
    end
end

-- Callback function to handle ESP toggle
local function togglePlayerESP(state)
    if state then
        -- Enable ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                markTarget(player.Character.Head, player.Name)
            end
        end

        -- Connect PlayerAdded event to create ESP for new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                local head = character:FindFirstChild("Head")
                if head then
                    markTarget(head, player.Name)
                end
            end)
        end)

        -- Update ESP every frame
        RunService.RenderStepped:Connect(function()
            for target, customName in pairs(markedTargets) do
                if target and target:FindFirstChild("Tag") then
                    target.Tag.TextLabel.Text = translate(customName)
                else
                    if target then
                        markTarget(target, customName)
                    end
                end
            end
        end)
    else
        -- Disable ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local head = player.Character.Head
                if head:FindFirstChild("Tag") then
                    head.Tag:Destroy()
                end
                if head:FindFirstChild("Highlight") then
                    head.Highlight:Destroy()
                end
            end
        end
        markedTargets = {}
    end
end

-- Bind the toggle function to the player ESP toggle button
local PlayerESP_Toggle = window_esp:AddToggle({
    Name = "Player ESP",
    Value = false,
    Callback = function(state)
        togglePlayerESP(state)
    end
})


local window_event = GUI:CreateSection({
	Name = "Event"
})

local LWES = window_event:AddToggle({
    Name = "Enity Event",
    Value = false,
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
                    {Title = "Enity Event", Description = entity.Name:gsub("Moving", ""):lower() .. " Spawned!"},
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

local LWES = window_event:AddToggle({
    Name = "Item Event",
    Value = false,
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
                    {Title = "Item Event", Description = itemName .. " 已生成"},
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

local Player = window_player:AddToggle({
	Name = "Look aura",
	Value = false,
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

local window_remove = GUI:CreateSection({
	Name = "Remove class"
})
local lasfToggle = false
local PlayerESP_Toggle = window_remove:AddToggle({
    Name = "Remove Light [Anti Lag]",
    Value = false,
    Callback = function(state)
        lasfToggle = state
    end
})

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
local PlayerESP_Toggle = window_remove:AddToggle({
    Name = "Remove Gate",
    Value = false,
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
_G.SeekES = false
local PlayerESP_Toggle = window_remove:AddToggle({
    Name = "Remove SeekArm/Fire",
    Value = false,
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

local PlayerESP_Toggle = window_esp:AddToggle({
    Name = "Gold esp",
    Value = false,
    Callback = function(state)
        if state then
            _G.goldESPInstances = {}
            flags.espgold = state

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
                            table.insert(_G.esptable.Gold, h)
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

                    for _, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end

                    task.spawn(function()
                        repeat task.wait() until not _G.flags.espgold
                        subaddcon:Disconnect()  
                    end) 
                end 
            end

            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)

            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room) 
            end

            table.insert(_G.goldESPInstances, _G.esptable)

        else
            if _G.goldESPInstances then
                for _, instance in pairs(_G.goldESPInstances) do
                    for _, v in pairs(instance.Gold) do
                        v.delete()
                    end
                end
                _G.goldESPInstances = nil
            end
        end
    end
})
local markedTargets = {}

-- 创建 BillboardGui
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

-- 标记目标
local function markTarget(target, customName)
    if not target then return end
    local oldBillboard = target:FindFirstChild("BillboardGui")
    if oldBillboard then
        oldBillboard:Destroy()
    end
    local bill = createBillboardGui(target, Color3.fromRGB(255, 255, 255), customName)
    bill.Parent = target
    markedTargets[target] = customName
end

-- 递归查找所有实例
local function recursiveFindAll(parent, name, targets)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name == name then
            table.insert(targets, child)
        end
        recursiveFindAll(child, name, targets)
    end
end

-- 根据名称标记所有实例
local function Itemlocationname(name, customName)
    local targets = {}
    recursiveFindAll(game, name, targets)
    for _, target in ipairs(targets) do
        markTarget(target, customName)
    end
end

-- 标记指定玩家的头部
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

-- Anti Key ESP 功能
local Player = window_esp:AddToggle({
    Name = "Key ESP[Anti Bypass]",
    Value = false,
    Callback = function(state)
        if state then
            -- 连接事件以处理新玩家和新实例
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    local head = character:FindFirstChild("Head")
                    if head then
                        markTarget(head, player.Name)
                    end
                end)
            end)

            game.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "Key" or descendant.Name == "KeyObtain" then
                    markTarget(descendant, descendant.Name)
                end
            end)

            RunService.RenderStepped:Connect(function()
                for target, customName in pairs(markedTargets) do
                    if target and target:FindFirstChild("BillboardGui") then
                        local bill = target.BillboardGui
                        if bill and bill:FindFirstChild("TextLabel") then
                            bill.TextLabel.Text = customName
                        else
                            if target then
                                markTarget(target, customName)
                            end
                        end
                    end
                end
            end)

            -- 立即处理现有实例和玩家
            Invalidplayername("玩家名称", "玩家")
            Itemlocationname("Key", "Key")
            Itemlocationname(".", ".")
        else
            -- 清理标记
            for target, _ in pairs(markedTargets) do
                if target:FindFirstChild("BillboardGui") then
                    target.BillboardGui:Destroy()
                end
            end
            markedTargets = {}
        end
    end
})

_G.Banana = false
local PlayerESP_Toggle = window_remove:AddToggle({
    Name = "Remove BananaPeel",
    Value = false,
    Callback = function(state)
        _G.Banana = state
        
        -- 当 SeekES 为 true 时，运行 RenderStepped 事件
        if state then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if _G.Banana then
                        -- 查找并删除 Workspace 中的所有 BananaPeel 对象
                        for _, object in pairs(game.workspace:GetDescendants()) do
                            if object.Name == "BananaPeel" then
                                object:Destroy()
                            end
                        end
                    end
                end)
            end)
        end
    end
})
local window_chat = GUI:CreateSection({
	Name = "Setting chat notification"
})
local SaveCurrentEntityName = window_chat:AddTextbox({
    Name = 'Entity Message',
    Value = "stop watch entity spawned!!!",
    Multiline = false
})

local SaveCurrentItemName = window_chat:AddTextbox({
    Name = 'Item Message',
    Value = "is spawned in this time",
    Multiline = false
})

local LWES_TextChannel = window_chat:AddToggle({
    Name = "Chat Notify",
    Value = false,
    Callback = function(state)
        local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90", "Eyes", "JeffTheKiller"}
        local plr = game.Players.LocalPlayer

        if state then
            -- 实体生成消息发送函数
            local function sendEntityMessage(entity)
                local suffix = SaveCurrentEntityName.Value or "stop watch entity spawned!!!"
                local message = "Entity: " .. entity.Name:gsub("Moving", ""):lower() .. " " .. suffix
                textChannel:SendAsync(message)
            end

            -- 监控实体生成
            local function onChildAdded(child)
                if table.find(entityNames, child.Name) then
                    repeat task.wait() until plr:DistanceFromCharacter(child:GetPivot().Position) < 1000 or not child:IsDescendantOf(workspace)
                    if child:IsDescendantOf(workspace) then
                        sendEntityMessage(child)
                    end
                end
            end

            -- 物品生成消息发送函数
            local function sendItemMessage(itemName)
                local suffix = SaveCurrentItemName.Value or "is spawned in this time"
                local message = "Item: " .. itemName .. " " .. suffix
                textChannel:SendAsync(message)
            end

            -- 监控物品生成
            local function check(v)
                if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                    task.wait(0.1)
                    local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop") or v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local itemName = v.Name
                        sendItemMessage(itemName)
                    end
                end
            end

            local function setup(room)
                local assets = room:WaitForChild("Assets")
                if assets then
                    local subaddcon = assets.DescendantAdded:Connect(function(v)
                        check(v)
                    end)
                    for _, v in pairs(assets:GetDescendants()) do
                        check(v)
                    end
                    task.spawn(function()
                        repeat task.wait() until not state
                        subaddcon:Disconnect()
                    end)
                end
            end

            -- 监听房间变化
            local addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                if room:FindFirstChild("Assets") then
                    setup(room)
                end
            end

            -- 监听实体生成
            local connection = workspace.ChildAdded:Connect(onChildAdded)

            -- 关闭时断开连接
            task.spawn(function()
                repeat task.wait(1) until not state
                connection:Disconnect()
                addconnect:Disconnect()
            end)
        end
    end
})

_G.RemoveJeff = false
local RemoveJeff_Toggle = window_remove:AddToggle({
    Name = "Remove JeffTheKiller",
    Value = false,
    Callback = function(state)
        _G.RemoveJeff = state
        
        if state then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if _G.RemoveJeff then
                        -- 遍历工作区中的所有房间
                        for _, room in pairs(game.workspace.CurrentRooms:GetChildren()) do
                            -- 遍历房间中的所有对象
                            for _, object in pairs(room:GetDescendants()) do
                                if (object:IsA("Model") or object:IsA("Part")) and object.Name == "JeffTheKiller" then
                                    -- 如果 JeffTheKiller 是模型或部件，且包含 Humanoid（仅针对模型），则删除整个对象
                                    if object:IsA("Model") and object:FindFirstChildOfClass("Humanoid") then
                                        object:Destroy()  -- 删除 JeffTheKiller 模型本体
                                    elseif object:IsA("Part") then
                                        object:Destroy()  -- 直接删除 JeffTheKiller 部件
                                    end

                                    wait(0.5)  -- 等待 0.5 秒
                                    
                                    -- 删除 JeffTheKiller 对象的所有子对象
                                    for _, child in pairs(object:GetDescendants()) do
                                        child:Destroy()
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
        end
    end
})

local Troll = GUIWindow:CreateTab({
	Name = "恶搞"
})
local window_troll = Troll:CreateSection({
	Name = "好玩的"
})

_G.PrankJeffWithBanana = false
local PrankJeffWithBanana_Toggle = window_troll:AddToggle({
    Name = "give jeff gift",
    Value = false,
    Callback = function(state)
        _G.PrankJeffWithBanana = state

        if state then
            -- 关闭 RemoveJeff 和 Banana 脚本
            _G.RemoveJeff = false
            _G.Banana = false

            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if _G.PrankJeffWithBanana then
                        -- 遍历工作区中的所有房间
                        for _, room in pairs(game.workspace.CurrentRooms:GetChildren()) do
                            -- 找到房间中的 JeffTheKiller
                            local jeff = room:FindFirstChild("JeffTheKiller", true)

                            -- 如果找到 JeffTheKiller
                            if jeff then
                                -- 在工作区中查找 BananaPeel
                                local bananaPeel = game.workspace:FindFirstChild("BananaPeel", true)

                                -- 如果找到 BananaPeel，将其传送到 JeffTheKiller 的位置
                                if bananaPeel then
                                    bananaPeel.CFrame = jeff:FindFirstChild("HumanoidRootPart").CFrame
                                end
                            end
                        end
                    end
                end)
            end)
        end
    end
})

-- Original function to decipher code from LibraryHintPaper
local function decipherCode()
    local paper = char:FindFirstChild("LibraryHintPaper")
    local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

    local code = {[1]="_",[2]="_",[3]="_",[4]="_",[5]="_"}

    if paper then
        for i, v in pairs(paper:WaitForChild("UI"):GetChildren()) do
            if v:IsA("ImageLabel") and v.Name ~= "Image" then
                for j, img in pairs(hints:GetChildren()) do
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

-- Original function to notify code
local function notifyCode(code)
    if apart == nil then
        apart = Instance.new("Part", game.ReplicatedStorage)
        apart.CanCollide = false
        apart.Anchored = true
        apart.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
        apart.Transparency = 1
        Nofiy("ROOM 50", "The code is '" .. code .. "'.", "", 5)
        repeat task.wait(.1) until game:GetService("ReplicatedStorage").GameData.LatestRoom.Value ~= 50
        apart:Destroy()
        apart = nil
    end
end

-- Original Toggle Button Logic
local getcodebtn = window_player:AddToggle({
    Name = "Auto Library Code",
    Value = false,
    Callback = function(val, oldval)
        flags.getcode = val

        if val then
            local addconnect
            addconnect = char.ChildAdded:Connect(function(v)
                if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
                    task.wait()
                    local code = table.concat(decipherCode())

                    if code:find("_") then
                        warnNofiy("ROOM 50", "You are still missing some books!", "The current code is: '" .. code .. "'", 7)
                    else
                        notifyCode(code)
                    end
                end
            end)
        else
            -- Disconnect the event if the toggle is turned off
            if addconnect then
                addconnect:Disconnect()
            end
        end
    end
})

-- Initialize flags table
-- Function to handle proximity prompts
local function handlePrompt(prompt)
    local interactions = prompt:GetAttribute("Interactions")
    if not interactions then
        task.spawn(function()
            while flags.itemaura and not prompt:GetAttribute("Interactions") do
                task.wait(0.1)
                if game.Players.LocalPlayer:DistanceFromCharacter(prompt.Parent.PrimaryPart.Position) <= 12 then
                    fireproximityprompt(prompt)
                end
            end
        end)
    end
end

-- Function to check items and handle prompts
local function check(v)
    if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
        task.wait(0.1)
        local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop")
        if part then
            -- Check if the item has a ModulePrompt
            local prompt = v:FindFirstChild("ModulePrompt")
            if prompt then
                handlePrompt(prompt)
            end
        end
    end
end

-- Function to setup items in a room
local function setup(room)
    local assets = room:WaitForChild("Assets")
    
    if assets then  
        local subaddcon
        subaddcon = assets.DescendantAdded:Connect(function(v)
            check(v)
        end)
        
        for _, v in pairs(assets:GetDescendants()) do
            check(v)
        end
        
        -- Manage the disconnect when item aura is turned off
        return subaddcon
    end
end

-- Function to start room detection
local function startRoomDetection()
    -- Connect to detect new rooms being added
    local roomAddedConnection
    roomAddedConnection = workspace.CurrentRooms.ChildAdded:Connect(function(room)
        if flags.itemaura then
            setup(room)
        end
    end)
    
    -- Setup existing rooms
    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
        if room:FindFirstChild("Assets") then
            setup(room)
        end
    end
    
    -- Return the connection to manage its lifecycle
    return roomAddedConnection
end

-- Toggle for item aura (playerESP)
local playerESP = window_player:AddToggle({
    Name = "Item aura",
    Default = false,
    Callback = function(state)
        flags.itemaura = state
        
        if flags.itemaura then
            -- Start room detection
            local roomAddedConnection = startRoomDetection()
            
            -- Manage disconnection when item aura is turned off
            task.spawn(function()
                repeat task.wait() until not flags.itemaura
                roomAddedConnection:Disconnect()
            end)
        else
            -- Stop room detection
            if roomAddedConnection then
                roomAddedConnection:Disconnect()
            end
            -- Clear or reset any related data here if needed
        end
    end
})

local Player = window_player:AddToggle({
	Name = "Gold aura",
	Value = false,
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
                        if descendant.Name == "GoldPile" then
                            prompt = descendant:WaitForChild("LootPrompt")
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
                        if descendant.Name == "GoldPile" then
                            prompt = descendant:WaitForChild("LootPrompt")
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
