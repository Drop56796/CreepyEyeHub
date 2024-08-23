local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local v = 1

function oldwarnmessage(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end
local buttons = {
        noclip = nil,
	speed = nil,
        camfov = nil
}

local flags = {
        noclip = false,
        speed = 0,
        camfov = 70,
	esprush = false,
	espdoors = false,
	esplocker = false,
	espitems = false,
	espbooks = false
}
local esptable = {
        entity = {},
	doors = {},
	lockers = {},
	items = {},
	books = {}
}

Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
local GUIWindow = Library:CreateWindow({
	Name = "出生Doors v".. v,
	Themeable = false
})
local GUI = GUIWindow:CreateTab({
	Name = "主功能"
})
local window_player = GUI:CreateSection({
	Name = "玩家"
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
local walkspeedslider = window_player:AddSlider({
	Name = "Walkspeed(No silder)",
	Value = 16,
	Min = 16,
	Max = 22,

	Callback = function(val, oldval)
		flags.speed = val
		if flags.walkspeedtoggle == true then
			hum.WalkSpeed = val
		end
	end
})
buttons.speed = walkspeedslider

local walkspeedtglbtn = window_player:AddToggle({
	Name = "Toggle Walkspeed(Stop work)",
	Value = false,
	Callback = function(val, oldval)
		flags.walkspeedtoggle = val
		if not val then
			hum.WalkSpeed = 16
		end
	end
})
buttons.walkspeedtoggle = walkspeedtglbtn

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
	game:GetService("RunService").RenderStepped:Connect(function()
		if flags.walkspeedtoggle == true then
			if hum.WalkSpeed < flags.speed then
				hum.WalkSpeed = flags.speed
			end
		end
		if flags.camfovtoggle == true then
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
