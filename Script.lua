loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/player.lua?raw=true"))()
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
end)

if not success then
    warn("Failed to load UI library")
    return
end

local GUIWindow = Library:CreateWindow({
    Name = "Creepy Client V2.01",
    Themeable = false
})

local GUI = GUIWindow:CreateTab({
    Name = "主功能"
})

local window_player = GUI:CreateSection({
    Name = "玩家"
})

local camfovslider = window_player:AddSlider({
    Name = "FOV",
    Value = 70,
    Min = 50,
    Max = 120,
    Callback = function(Value)
        game:GetService("Workspace").CurrentCamera.FieldOfView = Value
    end
})

local PlayerWalkSpeedSlider = window_player:AddSlider({
    Name = "Speed",
    Value = 20,
    Min = 1,
    Max = 75,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local PlayerGravitySlider = window_player:AddSlider({
    Name = "Gravity",
    Value = 1,
    Min = 1,
    Max = 100,
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end
})

local PlayerJumpPowerSlider = window_player:AddSlider({
    Name = "JumpPower",
    Value = 1,
    Min = 1,
    Max = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

local playerESP = window_player:AddToggle({
    Name = "Freecam",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        local camera = workspace.CurrentCamera
        local speed = 1
        local touchControls = {}

        local function isMobile()
            return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
        end

        if state then
            camera.CameraType = Enum.CameraType.Scriptable
            if isMobile() then
                _G.Freecam = runService.RenderStepped:Connect(function()
                    local moveDirection = Vector3.new()
                    if touchControls["MoveForward"] then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if touchControls["MoveBackward"] then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if touchControls["MoveLeft"] then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if touchControls["MoveRight"] then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if touchControls["MoveUp"] then
                        moveDirection = moveDirection + camera.CFrame.UpVector
                    end
                    if touchControls["MoveDown"] then
                        moveDirection = moveDirection - camera.CFrame.UpVector
                    end

                    camera.CFrame = camera.CFrame + moveDirection * speed
                end)

                UserInputService.TouchStarted:Connect(function(touch, gameProcessedEvent)
                    if not gameProcessedEvent then
                        if touch.Position.Y < workspace.CurrentCamera.ViewportSize.Y / 2 then
                            touchControls["MoveForward"] = true
                        else
                            touchControls["MoveBackward"] = true
                        end
                    end
                end)

                UserInputService.TouchEnded:Connect(function(touch, gameProcessedEvent)
                    if not gameProcessedEvent then
                        touchControls["MoveForward"] = false
                        touchControls["MoveBackward"] = false
                    end
                end)
            else
                _G.Freecam = runService.RenderStepped:Connect(function()
                    local moveDirection = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                        moveDirection = moveDirection - camera.CFrame.UpVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                        moveDirection = moveDirection + camera.CFrame.UpVector
                    end

                    camera.CFrame = camera.CFrame + moveDirection * speed
                end)
            end
        else
            if _G.Freecam then
                _G.Freecam:Disconnect()
                _G.Freecam = nil
            end
            camera.CameraType = Enum.CameraType.Custom
        end
    end
})

local vampire = GUI:CreateSection({
    Name = "thirsy Vampire"
})

local playerESP = vampire:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
})

local playerESP = vampire:AddToggle({
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

local invisibilityToggle = vampire:AddToggle({
    Name = "Invisibility",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if state then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                player.Character.Head.Transparency = 1
                player.Character.Torso.Transparency = 1
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            else
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                player.Character.Head.Transparency = 0
                player.Character.Torso.Transparency = 0
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                        part.CanCollide = true
                    end
                end
            end
        else
            warn("Humanoid not found!")
        end
    end
})

local prison = GUI:CreateSection({
    Name = "Prison life"
})

local teleportLocations = {
    ["Yard"] = CFrame.new(50, 10, 50),
    ["Cafeteria"] = CFrame.new(100, 10, 100),
    ["Cells"] = CFrame.new(150, 10, 150),
    ["Armory"] = CFrame.new(200, 10, 200)
}

for location, cframe in pairs(teleportLocations) do
    prison:AddButton({
        Name = "Teleport to " .. location,
        Callback = function()
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = cframe
        end
    })
end

-- Adding buttons to switch teams
prison:AddButton({
    Name = "Switch to Inmate",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Bright orange")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

prison:AddButton({
    Name = "Switch to Guards",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Bright blue")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

prison:AddButton({
    Name = "Switch to Neutral",
    Callback = function()
        local player = game.Players.LocalPlayer
        workspace.Remote.TeamEvent:FireServer("Medium stone grey")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

-- Adding button to switch to Criminal
prison:AddButton({
    Name = "Switch to Criminal",
    Callback = function()
        local player = game.Players.LocalPlayer
        player.Character.HumanoidRootPart.CFrame = CFrame.new(500, 10, 500)
        wait(1)
        workspace.Remote.TeamEvent:FireServer("Bright red")
        workspace.Remote.loadchar:InvokeServer(player.Name)
    end
})

local killAuraToggle = prison:AddToggle({
    Name = "Kill Aura(May be invalid)",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            while state do
                for _, target in pairs(game.Players:GetPlayers()) do
                    if target ~= player and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
                        local distance = (player.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).magnitude
                        if distance < 10 then
                            target.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(10)
                        end
                    end
                end
                wait(0.1)
            end
        else
            warn("Humanoid not found!")
        end
    end
})

local playerESP = prison:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end
})

local playerESP = prison:AddToggle({
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

local itemESPEnabled = false
local goldESPEnabled = false

local function toggleItemESP(state)
    itemESPEnabled = state
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Tool") or item:IsA("Part") then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Parent = item
                highlight.Adornee = item
            else
                if item:FindFirstChildOfClass("Highlight") then
                    item:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
end

local GUI = GUIWindow:CreateTab({
    Name = "Doors"
})

local Doors = GUI:CreateSection({
    Name = "Function"
})

local lookauraToggle = Doors:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = function(state)
        toggleItemESP(state)
    end
})            

Doors:AddButton({
    Name = "Player name (Lazy XD)",
    Callback = function()
        function playerEsp()
           for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                  esp(player.Character, Color3.new(0, 1, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
		  playerEsp()
	       end
	   end
       end
   end
})			

local playerESP = Doors:AddToggle({
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

vampire:AddLabel({ Name = "Tip:开的时候不要开演都不带演" })

local window_credits_tab = GUIWindow:CreateTab({ Name = "创作者" })
local window_credits = window_credits_tab:CreateSection({
	Name = "创作/公告"
})
window_credits:AddLabel({ Name = "UI:MrWhite" })
window_credits:AddLabel({ Name = "QQ:3756646428" })
window_credits:AddLabel({ Name = "目前版本2.01 正式" })
window_credits:AddLabel({ Name = "欢迎使用我的朋友:"..game.Players.LocalPlayer.Name.."" })
window_credits:AddLabel({ Name = "注入器:"..identifyexecutor"" })
window_credits:AddLabel({ Name = "你正处在游戏:"..game.GameId.."" })

local playerESP = Doors:AddToggle({
    Name = "Look aura",
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

local playerESP = Doors:AddToggle({
    Name = "Enity Message",
    Default = false,
    Callback = function(state)
        if state then
            local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90"}  --enity
            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2

            -- Ensure flags and plr are defined
            local flags = flags or {} --Prevent Error
            local plr = game.Players.LocalPlayer --Prevent Error2

            local function notifyEntitySpawn(entity)
                Notification:Notify(
                    {Title = "Creepy client V2", Description = entity.Name:gsub("Moving", ""):lower() .. " Spawned!"},
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

            -- Infinite loop to keep the script running and check for hintrush flag
            local running = true
            while running do
                local connection = workspace.ChildAdded:Connect(onChildAdded)
                
                repeat
                    task.wait(1) -- Adjust the wait time as needed
                until not flags.hintrush or not running
                
                connection:Disconnect()
            end 
        else 
            -- Close message or any other cleanup if needed
            running = false
        end
    end
})

local itemESPToggle = Doors:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.espInstances = {}
            local esptable = {items = {}}
            local flags = {espitems = true}

            local function esp(what, color, core, name)
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
                        box.Transparency = 1
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
                    bill.Size = UDim2.new(0, 400, 0, 100)
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

            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, v in pairs(assets:GetDescendants()) do
                        if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                            task.wait(0.1)
                            local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop")
                            if part then
                                local h = esp(part, Color3.fromRGB(255, 255, 255), part, v.Name)
                                table.insert(esptable.items, h)
                            end
                        end
                    end)
                end
            end

            workspace.CurrentRooms.ChildAdded:Connect(function(room)
                local assets = room:WaitForChild("Assets")
                if assets then
                    for _, v in pairs(assets:GetDescendants()) do
                        if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                            task.wait(0.1)
                            local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop")
                            if part then
                                local h = esp(part, Color3.fromRGB(255, 255, 255), part, v.Name)
                                table.insert(esptable.items, h)
                            end
                        end
		    end
			
		    assets.DescendantAdded:Connect(function(v)
                        if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                            task.wait(0.1)
                            local part = v:FindFirstChild("Handle") or v:FindFirstChild("Prop")
                            if part then
                                local h = esp(part, Color3.fromRGB(255, 255, 255), part, v.Name)
                                table.insert(esptable.items, h)
                            end
                        end
                    end)
                end
            end)

            table.insert(_G.espInstances, esptable)

        else
            if _G.espInstances then
                for _, instance in pairs(_G.espInstances) do
                    for _, v in pairs(instance.items) do
                        v.delete()
                    end
                end
                _G.espInstances = nil
            end
        end
    end
})

local libraryCodeToggle = Doors:AddToggle({
    Name = "Library Code ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.codeInstances = {}
            local char = game.Players.LocalPlayer.Character
            local plr = game.Players.LocalPlayer

            local function notify(title, description)
                Notification:Notify(
                    {Title = title, Description = description},
                    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                )
            end

            local function deciphercode()
                local paper = char:FindFirstChild("LibraryHintPaper")
                local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
                
                local code = {[1]="_", [2]="_", [3]="_", [4]="_", [5]="_"}
                
                if paper then
                    for _, v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                        if v:IsA("ImageLabel") and v.Name ~= "Image" then
                            for _, img in pairs(hints:GetChildren()) do
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
                        notify("Creepy client V2", "You need go to collect book")
                    else
                        notify("Creepy client V2", "Code = " .. code)
                    end
                end
            end)

            table.insert(_G.codeInstances, addconnect)
        else
            if _G.codeInstances then
                for _, instance in pairs(_G.codeInstances) do
                    instance:Disconnect()
                end
                _G.codeInstances = nil
            end
        end
    end
})

local entityESPToggle = Doors:AddToggle({
    Name = "Entity ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.espInstances = {}
            local esptable = {entity = {}}
            local flags = {esprush = true}
            local entitynames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120"}  -- 请根据实际情况替换

            local function esp(what, color, core, name)
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
                        box.Transparency = 1
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
                    bill.Size = UDim2.new(0, 400, 0, 100)
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

            local addconnect
            addconnect = workspace.ChildAdded:Connect(function(v)
                if table.find(entitynames, v.Name) then
                    task.wait(0.1)
                    
                    local h = esp(v, Color3.fromRGB(255, 25, 25), v.PrimaryPart, v.Name:gsub("Moving", ""))
                    table.insert(esptable.entity, h)
                end
            end)

            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
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

	    workspace.CurrentRooms.ChildAdded:Connect(function(room)
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
            end)

	    table.insert(_G.espInstances, esptable)

        else
            if _G.espInstances then
                for _, instance in pairs(_G.espInstances) do
                    for _, v in pairs(instance.entity) do
                        v.delete()
                    end
                end
                _G.espInstances = nil
            end
        end
    end
})
Doors:AddLabel({ Name = "Can send Message enity:" })
Doors:AddLabel({ Name = "Rush Ambush" })
Doors:AddLabel({ Name = "Snare A60" })
Doors:AddLabel({ Name = "A90 A120" })
Doors:AddLabel({ Name = "------------------------------" })
Doors:AddLabel({ Name = "Can esp enity:" })
Doors:AddLabel({ Name = "Rush Ambush" })
Doors:AddLabel({ Name = "Snare A60" })
Doors:AddLabel({ Name = "A120" })
Doors:AddLabel({ Name = "Tip:有些功能可能失效" })
