local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local v = 1

function warnNofiy(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 0, 0)}
	)
end
---if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
--	warnNofiy("出生Doors v"..v, "Go doors to run", 10) 
--	return
--end
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
	espbooks = false,
	espgold = false,
	targetKeyObtain = false
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
	Name = "出生Doors v".. v,
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
    txt.Font = Enum.Font.Oswald -- 设置字体为 Jura
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
                    {Title = "出生Doors[Enity Event]", Description = entity.Name:gsub("Moving", ""):lower() .. " Spawned!"},
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
                    {Title = "出生[Item Event]", Description = itemName .. " 已生成"},
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


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
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
    Name = "Anti Key ESP",
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
