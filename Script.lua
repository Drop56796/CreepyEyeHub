local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

Notification:Notify(
    {Title = "Creepy Client V2.3", Description = "Hi "..game.Players.LocalPlayer.Name.." you game id is "..game.GameId.." you executor is "..identifyexecutor""},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
)
wait(3)

Notification:Notify(
    {Title = "Creepy Client V2.3", Description = "Good bye :D"},
    {OutlineColor = Color3.fromRGB(80, 80, 80),Time = 5, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
)

local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
end)

if not success then
    warn("Failed to load UI library")
    return
end

local GUIWindow = Library:CreateWindow({
    Name = "Creepy Client V2.3",
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

local GUI = GUIWindow:CreateTab({
    Name = "Doors"
})

local Doors = GUI:CreateSection({
    Name = "Function"
})

-- Sliders
local PlayerWalkSpeedSlider = Doors:AddSlider({
    Name = "Speed",
    Value = 20,
    Min = 20,
    Max = 22,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local playerESP = Doors:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.espInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local espInstance = esp(player.Character, Color3.new(0, 1, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
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

-- ESP function definition (assuming it already exists)
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

-- Define Player ESP function
function playerEsp()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            esp(player.Character, Color3.new(0, 1, 0), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
        end
    end
end	

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
window_credits:AddLabel({ Name = "Dev:MrWhite FHOff" })
window_credits:AddLabel({ Name = "QQ:3756646428" })
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
            local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90", "Eyes", "JeffTheKiller"}  --enity
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

local doorESPToggle = Doors:AddToggle({
    Name = "Door ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.doorESPInstances = {}
            local esptable = {doors = {}}
            local flags = {espdoors = true}

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

            local function setup(room)
                local door = room:WaitForChild("Door"):WaitForChild("Door")
                
                task.wait(0.1)
                local h = esp(door, Color3.fromRGB(90, 255, 40), door, "Door")
                table.insert(esptable.doors, h)
                
                door:WaitForChild("Open").Played:Connect(function()
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

local lockerESPToggle = Doors:AddToggle({
    Name = "Locker/Wardrobe ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.lockerESPInstances = {}
            local esptable = {lockers = {}}
            local flags = {esplocker = true}

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

local bookESPToggle = Doors:AddToggle({
    Name = "Book ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.bookESPInstances = {}
            local esptable = {books = {}}
            local flags = {espbooks = true}

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

local codeEventToggle = Doors:AddToggle({
    Name = "Code Event",
    Default = false,
    Callback = function(state)
        if state then
            _G.codeEventInstances = {}
            local flags = {getcode = true}

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
                            {Title = "Creepy client V2", Description = "You need Get all Book"},
                            {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                            {Image = "http://www.roblox.com/asset/?id=10802751252", ImageColor = Color3.fromRGB(255, 255, 255)}
                        )
                    else
                        Notification:Notify(
                            {Title = "Creepy client V2", Description = "Code is " .. code},
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

local itemESPToggle = Doors:AddToggle({
    Name = "Item ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.itemESPInstances = {}
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

local entityESPToggle = Doors:AddToggle({
    Name = "Entity ESP",
    Default = false,
    Callback = function(state)
        if state then
            _G.entityESPInstances = {}
            local esptable = {entity = {}}
            local flags = {esprush = true}
            local entitynames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "Eyes", "JeffTheKiller"} 

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

local brightnessToggle = Doors:AddToggle({
    Name = "Full Bright",
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

local GUI = GUIWindow:CreateTab({
    Name = "mod1"
})

local script = GUI:CreateSection({
    Name = "script"
})

script:AddButton({
    Name = "V.G",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()
    end
})
script:AddButton({
    Name = "DarkHub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init'))()
    end
})
script:AddButton({
    Name = "OwlHub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt'))()
    end
})

script:AddButton({
    Name = "GhostHub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()
    end
})


script:AddButton({
    Name = "Hohohub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoHub/main/Loader'))()
    end
})

local GUI = GUIWindow:CreateTab({
    Name = "Gui Setting"
})

local gui = GUI:CreateSection({
    Name = "Gui"
})

gui:AddButton({
    Name = "gui close",
    Callback = function()
        Library.unload()
    end
})

local keyESPToggle = Doors:AddToggle({
    Name = "Lever ESP(Warn)",
    Default = false,
    Callback = function(state)
        if state then
            _G.keyESPInstances = {}
            local esptable = {keys = {}}
            local flags = {espkeys = true}

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

            local function check(v)
                if v:IsA("Model") and (v.Name == "LeverForGate" or v.Name == "KeyObtain") then
                    task.wait(0.1)
                    if v.Name == "KeyObtain" then
                        local hitbox = v:WaitForChild("Hitbox")
                        local parts = hitbox:GetChildren()
                        table.remove(parts, table.find(parts, hitbox:WaitForChild("PromptHitbox")))
                        
                        local h = esp(parts, Color3.fromRGB(255, 255, 255), hitbox, "Key")
                        table.insert(esptable.keys, h)
                        
                    elseif v.Name == "LeverForGate" then
                        local h = esp(v, Color3.fromRGB(255, 255, 255), v.PrimaryPart, "Lever")
                        table.insert(esptable.keys, h)
                        
                        v.PrimaryPart:WaitForChild("SoundToPlay").Played:Connect(function()
                            h.delete()
                        end) 
                    end
                end
            end
            
            local function setup(room)
                local assets = room:WaitForChild("Assets")
                
                assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                    
                for i, v in pairs(assets:GetDescendants()) do
                    check(v)
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

            table.insert(_G.keyESPInstances, esptable) 
				
	else
            if _G.keyESPInstances then
                for _, instance in pairs(_G.keyESPInstances) do
                    for _, v in pairs(instance.keys) do
                        v.delete()
                    end
                end
                _G.keyESPInstances = nil
            end
        end
    end
})

local removeObstructionsToggle = Doors:AddToggle({
    Name = "Remove SeekArm/Chandelier",
    Default = false,
    Callback = function(state)
        if state then
            _G.removeObstructionsEnabled = true

            local function removeObstructions()
                game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Connect(function()
                    task.wait(0.1)
                    for _, descendant in pairs(game:GetService("Workspace").CurrentRooms:GetDescendants()) do
                        if descendant.Name == "Seek_Arm" or descendant.Name == "ChandelierObstruction" then
                            descendant.Parent = nil
                            descendant:Destroy()
                        end
                    end
                end)
            end

            task.spawn(function()
                while _G.removeObstructionsEnabled do
                    removeObstructions()
                    task.wait(1)
                end
            end)
        else
            _G.removeObstructionsEnabled = false
        end
    end
})

local a90BypassToggle = Doors:AddToggle({
    Name = "Bypass A-90",
    Default = false,
    Callback = function(state)
        local a90remote = game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("A90")
        local plr = game.Players.LocalPlayer
        local flags = {noa90 = state}
        
        local jumpscare = plr.PlayerGui:WaitForChild("MainUI"):WaitForChild("Jumpscare"):FindFirstChild("Jumpscare_A90")
        
        if state then
            if jumpscare then
                jumpscare.Parent = nil
                a90remote.Parent = nil
                
                task.spawn(function()
                    while flags.noa90 do
                        game.SoundService.Main.Volume = 1
                        task.wait()
                    end
                end)
            end
        else
            if jumpscare then
                jumpscare.Parent = plr.PlayerGui.MainUI.Jumpscare
                a90remote.Parent = game.ReplicatedStorage.EntityInfo
            end
        end
    end
})

local playerESP = Doors:AddToggle({
    Name = "Key esp",
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

Doors:AddLabel({ Name = "-------------------------" })
Doors:AddLabel({ Name = "Can send Message enity:" })
Doors:AddLabel({ Name = "Rush Ambush" })
Doors:AddLabel({ Name = "Snare A60" })
Doors:AddLabel({ Name = "A90 A120 Eyes" })
Doors:AddLabel({ Name = "-------------------------" })
Doors:AddLabel({ Name = "Can esp enity:" })
Doors:AddLabel({ Name = "Rush Ambush" })
Doors:AddLabel({ Name = "Snare A60" })
Doors:AddLabel({ Name = "A120 Eyes" })
Doors:AddLabel({ Name = "-------------------------" })
Doors:AddLabel({ Name = "April Fools:" })
Doors:AddLabel({ Name = "Jeff" })
Doors:AddLabel({ Name = "-------------------------" })
Doors:AddLabel({ Name = "Tip:有些功能not work" })
Doors:AddLabel({ Name = "Tip:Key esp work" })
Doors:AddLabel({ Name = "-------------------------" })

local GUI = GUIWindow:CreateTab({
    Name = "Pressure"
})

local Pressure = GUI:CreateSection({
    Name = "esp"
})

local keyCardESPToggle = Pressure:AddToggle({
    Name = "KeyCard ESP(钥匙卡ESP)",
    Default = false,
    Callback = function(state)
        if state then
            _G.keyCardESPInstances = {}
            local esptable = {keyCards = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
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

            local function monitorNormalKeyCard()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "NormalKeyCard" then
                        createBillboard(instance, "NormalKeyCard", Color3.new(1, 0, 0)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "NormalKeyCard" then
                        createBillboard(instance, "NormalKeyCard", Color3.new(1, 0, 0)) -- Change color as needed
                    end
                end)
            end

            local function monitorInnerKeyCard()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "InnerKeyCard" then
                        createBillboard(instance, "InnerKeyCard", Color3.new(255, 255, 255)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "InnerKeyCard" then
                        createBillboard(instance, "InnerKeyCard", Color3.new(255, 255, 255)) -- Change color as needed
                    end
                end)
            end

            monitorNormalKeyCard()
            monitorInnerKeyCard()
            table.insert(_G.keyCardESPInstances, esptable)
				
        else
            if _G.keyCardESPInstances then
                for _, instance in pairs(_G.keyCardESPInstances) do
                    for _, v in pairs(instance.keyCards) do
                        v.delete()
                    end
                end
                _G.keyCardESPInstances = nil
            end
        end
    end
})

local a = GUI:CreateSection({
    Name = "function"
})

local playerESP = a:AddToggle({
    Name = "Enity Message(实体消息)",
    Default = false,
    Callback = function(state)
        if state then
            local entityNames = {"Angler", "Eyefestation", "Blitz", "Pinkie", "Froger", "Chainsmoker"}  --enity
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
                until not flags.hint or not running
                
                connection:Disconnect()
            end 
        else 
            -- Close message or any other cleanup if needed
            running = false
        end
    end
})

local playerESP = Pressure:AddToggle({
    Name = "Player ESP(玩家ESP)",
    Default = false,
    Callback = function(state)
        if state then
            _G.aespInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local aespInstance = esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.aespInstances, aespInstance)
                end
            end
        else
            if _G.aespInstances then
                for _, aespInstance in pairs(_G.aespInstances) do
                    aespInstance.delete()
                end
                _G.aespInstances = nil
            end
        end
    end
})

-- ESP function definition (assuming it already exists)
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
            box.Transparency = 0.75
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

-- Define Player ESP function
function playerEsp()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
        end
    end
end

local brightnessToggle = a:AddToggle({
    Name = "Full Bright(高亮)",
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

local entityESPToggle = Pressure:AddToggle({
    Name = "Entity ESP(实体ESP)",
    Default = false,
    Callback = function(state)
        if state then
            _G.entityInstances = {}
            local esptable = {entities = {}}
            local flags = {esprush = true}
            local entitynames = {"Angler", "Eyefestation", "Blitz", "Pinkie", "Froger", "Chainsmoker"}

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

                for _, v in pairs(parts) do
                    if v:IsA("BasePart") then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Size = v.Size
                        box.AlwaysOnTop = true
                        box.ZIndex = 1
                        box.AdornCullingMode = Enum.AdornCullingMode.Never
                        box.Color3 = color
                        box.Transparency = 0.5
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
                    for _, v in pairs(boxes) do
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

            local function addEntity(instance)
                for _, name in pairs(entitynames) do
                    if instance:IsA("Model") and instance.Name == name then
                        local espEntity = esp(instance, Color3.fromRGB(255, 0, 0), instance.PrimaryPart, name)
                        table.insert(esptable.entities, espEntity)
                    end
                end
            end

            local function monitorEntities()
                for _, instance in pairs(workspace:GetDescendants()) do
                    addEntity(instance)
                end

                workspace.DescendantAdded:Connect(addEntity)
            end

            monitorEntities()
            table.insert(_G.entityInstances, esptable)
        else
            if _G.entityInstances then
                for _, instance in pairs(_G.entityInstances) do
                    for _, entity in pairs(instance.entities) do
                        entity.delete()
                    end
                end
                _G.entityInstances = nil
            end
        end
    end
})

local playerESP = a:AddToggle({
    Name = "No cilp(穿墙)",
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
local lockerESPToggle = Pressure:AddToggle({
    Name = "Locker ESP(柜子ESP)",
    Default = false,
    Callback = function(state)
        if state then
            _G.espToLocker = {}
            local esptable = {lockers = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
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

            local function addLocker(instance)
                if instance:IsA("Model") and instance.Name == "Locker" then
                    createBillboard(instance, "Locker", Color3.new(250, 250, 250)) -- Change color as needed
                    table.insert(esptable.lockers, instance)
                end
            end

            local function monitorLockers()
                for _, instance in pairs(workspace:GetDescendants()) do
                    addLocker(instance)
                end

                workspace.DescendantAdded:Connect(addLocker)
            end

            monitorLockers()
            table.insert(_G.espToLocker, esptable)
				
        else
            if _G.espToLocker then
                for _, instance in pairs(_G.espToLocker) do
                    for _, locker in pairs(instance.lockers) do
                        if locker and locker:FindFirstChildOfClass("BillboardGui") then
                            locker:FindFirstChildOfClass("BillboardGui"):Destroy()
                        end
                    end
                end
                _G.espToLocker = nil
            end
        end
    end
})

local lockerESPToggle = Pressure:AddToggle({
    Name = "NormalDoor ESP(门ESP)",
    Default = false,
    Callback = function(state)
        if state then
            _G.normalDoorESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
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

            local function monitorNormalDoor()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "NormalDoor" then
                        createBillboard(instance, "NormalDoor", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "NormalDoor" then
                        createBillboard(instance, "NormalDoor", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end)
            end

            monitorNormalDoor()
            table.insert(_G.normalDoorESPInstances, esptable)
				
        else
            if _G.normalDoorESPInstances then
                for _, instance in pairs(_G.normalDoorESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.normalDoorESPInstances = nil
            end
        end
    end
})
----------------------------------
-- Initialize the settings table--
----------------------------------
local settings = {
    camfov = 70,
    camfovtoggle = false,
    walkspeed = 16,
    walkspeedtoggle = false,

    -- Function to update the camera FOV based on current flags
    updateCameraFOV = function()
        local camera = game:GetService("Workspace").CurrentCamera
        if camera then
            if settings.camfovtoggle then
                camera.FieldOfView = settings.camfov
            else
                camera.FieldOfView = 70
            end
        end
    end,

    -- Function to update the player's walk speed based on current flags
    updateWalkSpeed = function()
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            local hum = player.Character.Humanoid
            if settings.walkspeedtoggle then
                hum.WalkSpeed = settings.walkspeed
            else
                hum.WalkSpeed = 16
            end
        end
    end
}

-- Create the slider for adjusting FOV
local camfovslider = window_player:AddSlider({
    Name = "FOV",
    Value = settings.camfov,
    Min = 50,
    Max = 120,
    Callback = function(val, oldval)
        settings.camfov = val
        -- Update the camera FOV immediately when slider value changes
        settings.updateCameraFOV()
    end
})

buttons.camfov = camfovslider

-- Create the toggle button for enabling/disabling FOV adjustment
local togglefovbtn = window_player:AddToggle({
    Name = "Toggle FOV",
    Value = settings.camfovtoggle,
    Callback = function(val, oldval)
        settings.camfovtoggle = val
        -- Update the camera FOV immediately based on toggle state
        settings.updateCameraFOV()
    end
})

buttons.camfovtoggle = togglefovbtn

-- Create the slider for adjusting walk speed
local walkspeedslider = window_player:AddSlider({
    Name = "Walkspeed",
    Value = settings.walkspeed,
    Min = 16,
    Max = 22,
    Callback = function(val, oldval)
        settings.walkspeed = val
        -- Update the walk speed immediately when slider value changes
        settings.updateWalkSpeed()
    end
})

buttons.walkspeed = walkspeedslider

-- Create the toggle button for enabling/disabling walk speed adjustment
local walkspeedtglbtn = window_player:AddToggle({
    Name = "Toggle Walkspeed",
    Value = settings.walkspeedtoggle,
    Callback = function(val, oldval)
        settings.walkspeedtoggle = val
        -- Update the walk speed immediately based on toggle state
        settings.updateWalkSpeed()
    end
})

buttons.walkspeedtoggle = walkspeedtglbtn
