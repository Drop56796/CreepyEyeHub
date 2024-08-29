local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local v = 2
local Players = game:GetService("Players")
local textChannel = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")  -- Ensure Humanoid exists
local rootPart = char:WaitForChild("HumanoidRootPart")
--------A1000↓---------------------
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
local Camera = game:GetService("Workspace").CurrentCamera

local function createBoxAdornment(part, color)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = part.Size
    box.AlwaysOnTop = true
    box.ZIndex = 10  -- 提高 ZIndex 确保在最上层
    box.AdornCullingMode = Enum.AdornCullingMode.Never
    box.Color3 = color
    box.Transparency = 0.9178
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

-- 创建追踪线实例
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

    -- 创建和管理 BoxHandleAdornment、Highlight 和 Tracer 实例
    local boxes = {}
    local highlights = {}
    local tracers = {}

    for _, part in ipairs(parts) do
        local box = createBoxAdornment(part, color)
        table.insert(boxes, box)
        
        local highlight = createHighlight(part, color)
        table.insert(highlights, highlight)

        -- 追踪线仅针对第一个有效部件
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
        -- 检查 BoxHandleAdornment 和 Highlight 是否需要更新
        for _, box in ipairs(boxes) do
            if not box.Adornee or not box.Adornee:IsDescendantOf(workspace) then
                box:Destroy()
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
        for _, box in ipairs(boxes) do
            box:Destroy()
        end
        
        for _, highlight in ipairs(highlights) do
            highlight:Destroy()
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
        for _, box in ipairs(boxes) do
            box:Destroy()
        end
        
        for _, highlight in ipairs(highlights) do
            highlight:Destroy()
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

    return ret
end


local buttons = {
    tpwalktoggle = nil,  -- TP Walk 开关按钮
    tpwalkspeed = nil,   -- TP Walk 速度滑块
    camfov = nil,   -- FOV 滑块
    noclip = nil,
    noseek = nil
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
    getcode = false,
    itemaura = false,
    error = false,
    noa90 = false,
    noseek = false,
    esploc = false
}
local esptable = {
    entity = {},
	  doors = {},
	  lockers = {},
	  items = {},
	  books = {},
	  Gold = {},
	  key = {},
	  loc = {}
}

local Window = Library:CreateWindow({
    Title = 'Hydraulic Doors v' .. v,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('player')
local RightGroup = Tabs.Main:AddRightGroupbox('esp')

Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
	FrameCounter += 1;

	if (tick() - FrameTimer) >= 1 then
		FPS = FrameCounter;
		FrameTimer = tick();
		FrameCounter = 0;
	end;

	Library:SetWatermark(('Doors  | %s fps | %s ms'):format(
		math.floor(FPS),
		math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
	));
end);

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
	WatermarkConnection:Disconnect()

	print('Unloaded!')
	Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

local RunService = game:GetService("RunService")
MainGroup:AddLabel('---------------------', true)
MainGroup:AddSlider('Speed', {
	Text = 'Speed',
	Default = 20,
	Min = 20,
	Max = 22,
	Rounding = 1,
	Compact = false,

	Callback = function(val, oldval)
	flags.tpwalkspeed = val
        if flags.tpwalktoggle then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val  -- Directly set WalkSpeed if toggle is on
        end
    end
})
buttons.tpwalkspeed = tpwalkspeedslider
MainGroup:AddToggle('ToggleSpeed', {
    Text = 'Toggle Speed',
    Default = false,
    Tooltip = 'Walk through walls',
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

MainGroup:AddSlider('fov', {
	Text = 'FOV',
	Default = 70,
	Min = 70,
	Max = 120,
	Rounding = 1,
	Compact = false,

	Callback = function(val, oldval)
	flags.camfov = val
    end
})
buttons.camfov = camfovslider
MainGroup:AddToggle('Togglefov', {
    Text = 'Toggle FOV',
    Default = false,
    Tooltip = 'Walk through walls',
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


MainGroup:AddLabel('---------------------', true)
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
MainGroup:AddLabel('---------------------', true)
MainGroup:AddToggle('No Clip', {
    Text = 'Chestbox / Drawers aura',
    Default = false,
    Tooltip = 'Walk through walls',
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

MainGroup:AddToggle('No Clip', {
    Text = 'Item aura',
    Default = false,
    Tooltip = 'Walk through walls',
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

MainGroup:AddToggle('No Clip', {
    Text = 'Gold aura',
    Default = false,
    Tooltip = 'Walk through walls',
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

MainGroup:AddToggle('No Clip', {
    Text = 'Book / Breaker aura',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            -- open
            Bookaura = true

            -- getplayer
            local player = game.Players.LocalPlayer

            -- check
            workspace.CurrentRooms.ChildAdded:Connect(function(room)
                room.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("Model") then
                        local prompt = nil
                        if descendant.Name == "LiveBreakerPolePickup" then
                            prompt = descendant:WaitForChild("ActivateEventPrompt")
			elseif descendant.Name == "LiveHintBook" then
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
                        if descendant.Name == "LiveBreakerPolePickup" then
                            prompt = descendant:WaitForChild("ActivateEventPrompt")
			elseif descendant.Name == "LiveHintBook" then
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
            Bookaura = false
        end
    end
})

MainGroup:AddToggle('No Clip', {
    Text = 'Lever aura',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            -- open
            Leveraura = true

            -- getplayer
            local player = game.Players.LocalPlayer

            -- check
            workspace.CurrentRooms.ChildAdded:Connect(function(room)
                room.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("Model") then
                        local prompt = nil
                        if descendant.Name == "LeverForGate" then
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
                        if descendant.Name == "LeverForGate" then
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
            Leveraura = false
        end
    end
})
MainGroup:AddLabel('---------------------', true)

MainGroup:AddToggle('No Clip', {
    Text = 'Nil A60',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.error = state -- 更新 flag 为当前 state
        
        if flags.error then
            if LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("A90") then
                LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90.Name = "lol"
	    end
        end
    end
})
MainGroup:AddToggle('No Clip', {
    Text = 'Destory A60',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.noa90 = state -- 更新 flag 为当前 state
        
        if flags.noa90 then
            local A90 = game.ReplicatedStorage.RemotesFolder:FindFirstChild("A90")
            if A90 then
                -- 当 noa90 为 true 且 A90 存在时，删除 A90
                A90:Destroy()
            end
        end
    end
})

MainGroup:AddToggle('No Clip', {
    Text = 'Cancel SeekChase',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(val, oldval)
        flags.noseek = val  -- 直接设置 flags.noseek 的值

        if flags.noseek then
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                local trigger = room:WaitForChild("TriggerEventCollision", 2)

                if trigger then
                    trigger:Destroy()
                end
            end)

            -- 等待直到 noseek 被关闭，然后断开连接
            repeat task.wait() until not flags.noseek
            addconnect:Disconnect()
        end
    end
})
buttons.noseek = noseekbtn

RightGroup:AddToggle('pe', {
    Text = 'Player esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

RightGroup:AddToggle('No Clip', {
    Text = 'Lever esp',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            _G.locESPInstances = {}
	    flags.esploc = state

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

RightGroup:AddToggle('pe', {
    Text = 'Closet / Locker esp',
    Default = false,
    Tooltip = 'Walk through walls',
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
RightGroup:AddToggle('ee', {
    Text = 'enity esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

RightGroup:AddToggle('pe', {
    Text = 'Door esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

MainGroup:AddToggle('pe', {
    Text = 'Full bright',
    Default = false,
    Tooltip = 'Walk through walls',
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

RightGroup:AddLabel('---------------------')
RightGroup:AddToggle('pe', {
    Text = 'Enity Event',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90", "Eyes", "JeffTheKiller"}  -- 实体名称

            -- 确保 flags 和 plr 已定义
            local flags = flags or {} -- 防止错误
            local plr = game.Players.LocalPlayer -- 防止错误2

            local function notifyEntitySpawn(entity)
                local entityMessage
                if entity.Name:gsub("Moving", ""):lower() == "Jeffthekiller" then
                    entityMessage = "Entity Event: JeffTheKiller in the next door and be careful of his attack."
                else
                    entityMessage = "Entity Event: " .. entity.Name:gsub("Moving", ""):lower() .. " Spawned!"
                end
                Library:Notify(entityMessage)
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

RightGroup:AddToggle('pe', {
    Text = 'Item Event',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            _G.itemNotificationInstances = {}
            local flags = {notifitems = true}

            -- 发送通知的函数
            local function notifyItem(itemName)
                local itemMessage = "Item Event: " .. itemName .. " is spawned"
                Library:Notify(itemMessage)
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

RightGroup:AddToggle('pe', {
    Text = 'Chat Enity / Item Event',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        local entityNames = {"RushMoving", "AmbushMoving", "Snare", "A60", "A120", "A90", "Eyes", "JeffTheKiller"}
        local plr = game.Players.LocalPlayer

        if state then
            -- 实体生成消息发送函数
            local function sendEntityMessage(entity)
                local suffix = "stop watch entity spawned!!!"
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
                local suffix = "is spawned in this time"
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
