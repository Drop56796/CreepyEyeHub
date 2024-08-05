local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix"))()

-- Create a new window
local window = library:new({
    textsize = 15,
    font = Enum.Font.Jura,
    name = "Pressure",
    color = Color3.fromRGB(225, 255, 255)
})

-- Create a new tab
local tab = window:page({
    name = "Pressure"
})

-- Create a section in the tab
local section1 = tab:section({
    name = "ESP",
    side = "left",
    size = 250
})

local section2 = tab:section({
    name = "Functional Class",
    side = "right",
    size = 250
})
local autoInteract = false
local autoInteractConnection

local function fireAllProximityPrompts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            local parentModel = descendant:FindFirstAncestorOfClass("Model")
            if parentModel and parentModel.Name ~= "MonsterLocker" and parentModel.Name ~= "Locker" then
                fireproximityprompt(descendant)
            end
        end
    end
end

local function removeSpecificObjects()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("Model") and (descendant.Name == "MonsterLocker" or descendant.Name == "Locker" or descendant.Name == "TricksterRoom") then
            descendant:Destroy()
        end
    end
end

section2:toggle({
    name = "lookaura",
    def = false,
    callback = function(state)
        autoInteract = state
        if autoInteract then
            -- Start the auto-interact process
            autoInteractConnection = task.spawn(function()
                while autoInteract do
                    removeSpecificObjects()
                    fireAllProximityPrompts()
                    task.wait(0.25) -- Adjust the wait time as needed
                end
            end)
        else
            -- Stop the auto-interact process
            if autoInteractConnection then
                task.cancel(autoInteractConnection)
                autoInteractConnection = nil
            end
        end
    end
})

section1:toggle({
    name = "Money/Item esp",
    def = false,
    callback = function(state)
        if state then
            _G.nahESPInstances = {}
            local itemTypes = {
                FlashBeacon = Color3.new(0, 1, 0),
                CodeBreacher = Color3.new(0, 0, 1),
                ["25Currency"] = Color3.new(1, 1, 0),
                ["50Currency"] = Color3.new(1, 0.5, 0),
                ["15Currency"] = Color3.new(0.5, 0.5, 0.5),
                ["100Currency"] = Color3.new(1, 0, 1),
                ["200Currency"] = Color3.new(0, 1, 1),
                Flashlight = Color3.new(0.1, 0.1, 0.1),
                Lantern = Color3.new(0.39, 0.39, 0.39),
                Blacklight = Color3.new(0.02, 0.06, 0.06),
                Gummylight = Color3.new(35, 25, 25),
                DwellerPiece = Color3.new(2, 6, 0.06),
                Medkit = Color3.new(0.2, 16, 0.6),
                WindupLight = Color3.new(0.2, 0.06, 6),
                Splorglight = Color3.new(12, 6, 56)
            }

            local function createBillboard(instance, name, color)
                if not instance or not instance:IsDescendantOf(workspace) then return end

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
                    while bill and bill.Adornee do
                        if not bill.Adornee:IsDescendantOf(workspace) then
                            bill:Destroy()
                            return
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorItems()
                for name, color in pairs(itemTypes) do
                    -- Check existing instances
                    for _, instance in pairs(workspace:GetDescendants()) do
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end

                    -- Monitor for new instances
                    workspace.DescendantAdded:Connect(function(instance)
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end)
                end
            end

            monitorItems()

            table.insert(_G.nahESPInstances, esptable)
        else
            if _G.nahESPInstances then
                for _, instance in pairs(_G.nahESPInstances) do
                    for _, v in pairs(instance.nah) do
                        v.delete()
                    end
                end
                _G.nahESPInstances = nil
            end
        end
    end
})
section2:toggle({
    name = "Enity Bypass",
    def = false,
    callback = function(state)
        local entityNames = {"Angler", "Blitz", "Pinkie", "Froger", "Chainsmoker", "Pandemonium"}
        local platformHeight = 900
        local platformSize = Vector3.new(1000, 1, 1000)
        local platform
        local entityTriggerMap = {}
        local playerOriginalPositions = {}
        local monitoring = false
        local addConnection, removeConnection

        -- Function to create or update the safe platform
        local function createSafePlatform()
            if platform then
                platform:Destroy()
            end

            platform = Instance.new("Part")
            platform.Size = platformSize
            platform.Position = Vector3.new(0, platformHeight, 0)
            platform.Anchored = true
            platform.Parent = workspace
        end

        -- Function to teleport a player to the safe platform
        local function teleportPlayerToPlatform(player)
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = platform.Position + Vector3.new(0, platform.Size.Y / 2 + 5, 0)
                playerOriginalPositions[player.UserId] = player.Character.HumanoidRootPart.CFrame
                player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end

        -- Function to teleport a player back to their original position
        local function teleportPlayerBack(player)
            if playerOriginalPositions[player.UserId] then
                player.Character.HumanoidRootPart.CFrame = playerOriginalPositions[player.UserId]
                playerOriginalPositions[player.UserId] = nil
            end
        end

        -- Function to handle entity detection
        local function onChildAdded(child)
            if table.find(entityNames, child.Name) then
                createSafePlatform()
                entityTriggerMap[child] = true
                for _, player in pairs(game.Players:GetPlayers()) do
                    teleportPlayerToPlatform(player)
                end
            end
        end

        -- Function to handle entity removal
        local function onChildRemoved(child)
            if entityTriggerMap[child] then
                entityTriggerMap[child] = nil
                for _, player in pairs(game.Players:GetPlayers()) do
                    teleportPlayerBack(player)
                end
            end
        end

        -- Start or stop monitoring based on toggle state
        if state then
            if not monitoring then
                monitoring = true
                addConnection = workspace.ChildAdded:Connect(onChildAdded)
                removeConnection = workspace.ChildRemoved:Connect(onChildRemoved)
                
                -- Initial check for existing entities
                for _, instance in pairs(workspace:GetDescendants()) do
                    onChildAdded(instance)
                end
            end
        else
            if monitoring then
                monitoring = false
                if platform then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        teleportPlayerBack(player)
                    end
                    platform:Destroy()
                end
                if addConnection then addConnection:Disconnect() end
                if removeConnection then removeConnection:Disconnect() end
            end
        end
    end
})

section1:toggle({
    name = "Player esp",
    def = false,
    callback = function(state)
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

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local tpWalkThread

local function tpWalk(speed)
    while true do
        task.wait()
        if Humanoid.MoveDirection.Magnitude > 0 then
            -- Move the player in the direction they are facing, including vertical movement
            local moveDirection = Humanoid.MoveDirection * speed

            -- Adjust for swimming: add upward movement if the player is in water
            if Humanoid:GetState() == Enum.HumanoidStateType.Swimming then
                moveDirection = moveDirection + Vector3.new(0, speed, 0)
            end

            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + moveDirection
        end
    end
end

-- Add a slider to the section
section2:slider({
    name = "speed",
    def = 1,
    max = 3,
    min = 1,
    rounding = true,
    callback = function(value)
        if tpWalkThread then
            tpWalkThread:Disconnect()
        end

        -- Start a new tpWalk thread
        tpWalkThread = coroutine.wrap(function()
            tpWalk(value)
        end)
        tpWalkThread()
    end
})


section1:toggle({
    name = "Door ESP",
    def = false,
    callback = function(state)
        if state then
            _G.doorInstances = {}
            local door = {
                BigRoomDoor = Color3.new(11, 45, 14),
                NormalDoor  = Color3.new(91, 78, 91)
            }

            local function createBillboard(instance, name, color)
                if not instance or not instance:IsDescendantOf(workspace) then return end

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
                    while bill and bill.Adornee do
                        if not bill.Adornee:IsDescendantOf(workspace) then
                            bill:Destroy()
                            return
                        end
                        task.wait()
                    end
                end)
            end

            local function monitordoor()
                for name, color in pairs(door) do
                    -- Check existing instances
                    for _, instance in pairs(workspace:GetDescendants()) do
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end

                    -- Monitor for new instances
                    workspace.DescendantAdded:Connect(function(instance)
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end)
                end
            end

            monitordoor()

            table.insert(_G.doorInstances, esptable)
        else
            if _G.doorInstances then
                for _, instance in pairs(_G.doorInstances) do
                    for _, v in pairs(instance.door) do
                        v.delete()
                    end
                end
                _G.dooeInstances = nil
            end
        end
    end
})

section1:toggle({
    name = "Key ESP",
    def = false,
    callback = function(state)
        if state then
            _G.KInstances = {}
            local K = {
                InnerKeyCard = Color3.new(11, 45, 14),
                NormalKeyCard  = Color3.new(91, 78, 91)
            }

            local function createBillboard(instance, name, color)
                if not instance or not instance:IsDescendantOf(workspace) then return end

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
                    while bill and bill.Adornee do
                        if not bill.Adornee:IsDescendantOf(workspace) then
                            bill:Destroy()
                            return
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorK()
                for name, color in pairs(K) do
                    -- Check existing instances
                    for _, instance in pairs(workspace:GetDescendants()) do
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end

                    -- Monitor for new instances
                    workspace.DescendantAdded:Connect(function(instance)
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end)
                end
            end

            monitorK()

            table.insert(_G.KInstances, esptable)
        else
            if _G.KInstances then
                for _, instance in pairs(_G.KInstances) do
                    for _, v in pairs(instance.K) do
                        v.delete()
                    end
                end
                _G.KInstances = nil
            end
        end
    end
})


section1:toggle({
    name = "Enity ESP",
    def = false,
    callback = function(state)
        if state then
            _G.EnityInstances = {}
            local Enity = {
                Angler = Color3.new(11, 45, 14),
                Eyefestation = Color3.new(91, 78, 91),
                Blitz = Color3.new(91, 78, 91),
                Pinkie = Color3.new(91, 78, 91),
                Froger = Color3.new(91, 78, 91),
                Chainsmoker = Color3.new(91, 78, 91),
                Pandemonium = Color3.new(91, 78, 91),
                Body = Color3.new(91, 78, 91)
            }

            local function createBillboard(instance, name, color)
                if not instance or not instance:IsDescendantOf(workspace) then return end

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
                    while bill and bill.Adornee do
                        if not bill.Adornee:IsDescendantOf(workspace) then
                            bill:Destroy()
                            return
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorEnity()
                for name, color in pairs(Enity) do
                    -- Check existing instances
                    for _, instance in pairs(workspace:GetDescendants()) do
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end

                    -- Monitor for new instances
                    workspace.DescendantAdded:Connect(function(instance)
                        if instance:IsA("Model") and instance.Name == name then
                            createBillboard(instance, name, color)
                        end
                    end)
                end
            end

            monitorEnity()

            table.insert(_G.EnityInstances, esptable)
        else
            if _G.EnityInstances then
                for _, instance in pairs(_G.EnityInstances) do
                    for _, v in pairs(instance.Enity) do
                        v.delete()
                    end
                end
                _G.EnityInstances = nil
            end
        end
    end
})

section2:toggle({
    name = "FullBright",
    def = false,
    callback = function(state)
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

section2:toggle({
    name = "No Cilp",
    def = false,
    callback = function(state)
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

local section2 = {} -- Assuming section2 is some library or framework you're using

-- Initialization
local running = false

section2:toggle({
    name = "Entity Message",
    def = false,
    callback = function(state)
        if state then
            local entityNames = {"Angler", "Eyefestation", "Blitz", "Pinkie", "Froger", "Chainsmoker", "Pandemonium", "Body"} -- Entity names
            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() -- Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() -- Lib2

            local flags = flags or {} -- Prevent Error
            local plr = game.Players.LocalPlayer -- Prevent Error2

            local function notifyEntitySpawn(entity)
                Notification:Notify(
                    {Title = "Pressure", Description = entity.Name:gsub("Moving", ""):lower() .. " Spawned!"},
                    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=18148044143", ImageColor = Color3.fromRGB(255, 255, 255)}
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

            -- Start monitoring
            running = true
            local connection
            connection = workspace.ChildAdded:Connect(function(child)
                if running then
                    onChildAdded(child)
                end
            end)

            -- Stop monitoring when the toggle is turned off
            while running do
                task.wait(1) -- Check every second
                if not section2:GetToggleState("Entity Message") then
                    running = false
                    connection:Disconnect()
                end
            end
        else
            -- Stop the notifications if toggle is off
            running = false
            if connection then
                connection:Disconnect()
            end
        end
    end
})
