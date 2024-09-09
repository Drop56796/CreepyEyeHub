local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/UI%20Style%20theme.lua?raw=true"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local v = 2.7
local Players = game:GetService("Players")
local textChannel = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")  -- Ensure Humanoid exists
local rootPart = char:WaitForChild("HumanoidRootPart")
--------A1000↓---------------------
--local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

local SoundService = game:GetService("SoundService")

-- 添加并播放声音
local function addAndPlaySound(name, soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Name = name
    sound.Parent = SoundService
    sound:Play()
end


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
    txt.TextSize = 25
    txt.Font = Enum.Font.Code -- 设置字体为 Jura
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
    noseek = nil,
    notimothy = nil,
    noscreech = nil
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
    noclip = false,
    getcode = false,
    itemaura = false,
    error = false,
    noa90 = false,
    noseek = false,
    esploc = false,
    r1 = false,
    r2 = false,
    r3 = false,
    notimothy = false,
    noscreech = false,
    sj = false,
    sc = false,
    sd = false,
    eyes = false,
    bypass = false,
    lol = false,
    simplify = false,
    boostFPS = false,
    g = false,
    g2 = false,
    giggleCeiling = false,
    espkeys = false,
    GodMode = false,
    SpeedBypass = false
}
local esptable = {
    entity = {},
    doors = {},
    lockers = {},
    items = {},
    books = {},
    Gold = {},
    keys = {},
    loc = {},
    lol = {}
}
---玩家的角色对象在工作区中
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 获取角色名称
local characterName = character.Name

wait(3)
local val = "User authentication succeeded, and the script was executed"
Library:Notify(val)
addAndPlaySound("ExampleSound", 4590657391)
-- 创建窗口并显示角色名称
local Window = Library:CreateWindow({
    Title = 'Hydraulic <DOORS> v' .. v .. '  ID: ' .. characterName,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    FT = Window:AddTab('Floor2'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
    gs = Window:AddTab('Game Setting'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('player')
local FTGroup = Tabs.FT:AddLeftGroupbox('Floor2')
local RightGroup = Tabs.Main:AddRightGroupbox('esp')
local gsGroup = Tabs.gs:AddLeftGroupbox('optimize fps')

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

	Library:SetWatermark(('Hydraulic <DOORS>  < %s fps ｜ %s ms > '):format(
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
FTGroup:AddToggle('Loop Speed Boost', {
    Text = 'Loop Speed Boost(Seek Chase)',
    Default = false,
    Tooltip = 'Increase speed when SeekMusic Intro plays',
    Callback = function(state)
        local customSuffix = "SpeedBoost" -- 自定义后缀
        local flagsName = "speedBoost" .. customSuffix

        if state then
            _G[flagsName] = state

            local function onSoundPlay(sound)
                if sound.Name == "Intro" and sound.Parent and sound.Parent.Name == "SeekMusic" and sound.Parent.Parent and sound.Parent.Parent.Name == "FloorReplicated" then
                    while _G[flagsName] and sound.IsPlaying do
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 27 -- 设置加速速度
                        task.wait(0.0001)
                    end
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- 恢复正常速度
                end
            end

            local function setup()
                local seekMusic = game.ReplicatedStorage:WaitForChild("FloorReplicated"):WaitForChild("SeekMusic")
                local introSound = seekMusic:WaitForChild("Intro")
                local endSound = seekMusic:WaitForChild("End")

                introSound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                    if introSound.IsPlaying then
                        onSoundPlay(introSound)
                    end
                end)

                endSound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                    if endSound.IsPlaying then
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- 恢复正常速度
                    end
                end)
            end

            setup()
        else
            _G[flagsName] = nil
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- 确保恢复正常速度
        end
    end
})

FTGroup:AddToggle('Fire All FuseObtain Prompts', {
    Text = 'F2 Locker Aura',
    Default = false,
    Tooltip = 'Trigger all FuseObtain prompts and open animations in CurrentRooms',
    Callback = function(state)
        local function firePromptAndOpen(v)
            if v:IsA("Model") and v.Name == "Locker_Small" then
                local openAnim = v:FindFirstChild("open")
                if openAnim then
                    openAnim:Play() -- 启用动画
                end
                local fuseObtain = v:FindFirstChild("FuseObtain")
                if fuseObtain then
                    local prompt = v:FindFirstChild("ModulePrompt")
                    if prompt then
                        prompt:Prompt() -- 自动提示
                    end
                end
            end
        end

        local function check(room)
            local assets = room:FindFirstChild("Assets")
            if assets then
                for _, v in pairs(assets:GetDescendants()) do
                    firePromptAndOpen(v)
                end
            end

            local sideroom = room:FindFirstChild("Sideroom")
            if sideroom then
                local sideroomAssets = sideroom:FindFirstChild("Assets")
                if sideroomAssets then
                    for _, v in pairs(sideroomAssets:GetDescendants()) do
                        firePromptAndOpen(v)
                    end
                end
            end
        end

        if state then
            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                check(room)
            end
        end
    end
})

FTGroup:AddToggle('Monitor MinesGenerator', {
    Text = 'Generator esp',
    Default = false,
    Tooltip = 'all MinesGenerator in CurrentRooms',
    Callback = function(state)
        local customSuffix = "MinesGeneratorMonitor" -- 自定义后缀
        local flagsName = "monitorMinesGenerator" .. customSuffix
        local espTableName = "minesGeneratorESPInstances" .. customSuffix

        if state then
            _G[espTableName] = {}
            _G[flagsName] = state

            local function check(v)
                if v:IsA("Model") and v.Name == "MinesGenerator" then
		    local generatorMain = v:FindFirstChild("GeneratorMain")
                    if generatorMain then
                        local h = esp(generatorMain, Color3.fromRGB(0, 255, 0), generatorMain, "Generator")
                        table.insert(esptable.minesGeneratorESP, h)
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
                        repeat task.wait() until not _G[flagsName]
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

            table.insert(_G[espTableName], esptable)
        else
            if _G[espTableName] then
                for _, instance in pairs(_G[espTableName]) do
                    for _, v in pairs(instance.minesGeneratorESP) do
                        v.delete()
                    end
                end
                _G[espTableName] = nil
            end
        end
    end
})

FTGroup:AddToggle('ESP for FuseObtain', {
    Text = 'FuseObtain ESP',
    Default = false,
    Tooltip = 'Enable ESP for FuseObtain Hitbox',
    Callback = function(state)
        local customSuffix = "FuseObtainESP" -- 自定义后缀
        local flagsName = "espFuseObtain" .. customSuffix
        local espTableName = "fuseObtainESPInstances" .. customSuffix

        if state then
            _G[espTableName] = {}
            _G[flagsName] = state

            local function check(v)
                if v:IsA("Model") and v.Name == "FuseObtain" then
                    local hitbox = v:FindFirstChild("Hitbox")
                    if hitbox then
                        local h = esp(hitbox, Color3.fromRGB(255, 0, 0), hitbox, "FuseKey")
                        table.insert(esptable.fuseESP, h)
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
                        repeat task.wait() until not _G[flagsName]
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

            table.insert(_G[espTableName], esptable)
        else
            if _G[espTableName] then
                for _, instance in pairs(_G[espTableName]) do
                    for _, v in pairs(instance.fuseESP) do
                        v.delete()
                    end
                end
                _G[espTableName] = nil
            end
        end
    end
})

destroy = "Remove Event:Destroy giggle now"
destroy1 = "Remove Event:Destroy GloomPile now"
destroy2 = "Remove Event:Destroy Bat now"
FTGroup:AddToggle('No Clip', {
        Text = 'Destroy GiggleCeiling',
        Default = false,
        Tooltip = 'Remove GiggleCeiling from rooms',
        Callback = function(state)
            flags.giggleCeiling = state

            while flags.giggleCeiling do
                local currentRooms = game.Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in ipairs(currentRooms:GetChildren()) do
                        local giggleCeiling = room:FindFirstChild("GiggleCeiling")
                        if giggleCeiling then
                            giggleCeiling:Destroy()
			    Library:Notify(destroy)
                        end
                    end
                end
                wait(0.1)
            end
        end
    })

    FTGroup:AddToggle('No Clip', {
        Text = 'Destroy GloomPile',
        Default = false,
        Tooltip = 'Remove GloomPile from rooms',
        Callback = function(state)
            flags.g = state

            while flags.g do
                local currentRooms = game.Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in ipairs(currentRooms:GetChildren()) do
                        local gloomPile = room:FindFirstChild("GloomPile")
                        if gloomPile then
                            gloomPile:Destroy()
			    Library:Notify(destroy1)
                        end
                    end
                end
                wait(0.1)
            end
        end
    })

    FTGroup:AddToggle('No Clip', {
        Text = 'Destroy bat',
        Default = false,
        Tooltip = 'Remove GloombatSwarm from rooms',
        Callback = function(state)
            flags.g2 = state

            while flags.g2 do
                local spawned = game.Workspace:FindFirstChild("GloombatSwarm")
                if spawned then
                    spawned:Destroy()
		    Library:Notify(destroy2)
                end
                wait(0.1)
            end
        end
    })



gsGroup:AddToggle('Boost FPS', {
    Text = 'Boost FPS',
    Default = false,
    Tooltip = 'Simplify parts and models to improve FPS',
    Callback = function(state)
        flags.boostFPS = state -- 更新 flag 为当前 state
        
        while flags.boostFPS do
            local function simplify(v)
                if v:IsA("Part") then
                    -- 简化 Part
                    v.Material = Enum.Material.SmoothPlastic
                    v.Anchored = true -- 示例：将对象锚定
                    v.CastShadow = false -- 禁用阴影
                elseif v:IsA("Model") then
                    -- 简化 Model
                    for _, part in pairs(v:GetDescendants()) do
                        if part:IsA("Part") then
                            part.Material = Enum.Material.SmoothPlastic
                            part.Anchored = true
                            part.CastShadow = false
                        end
                    end
                end
            end

            local function setup(workspace)
                for _, v in pairs(workspace:GetDescendants()) do
                    simplify(v)
                end

                local subaddcon
                subaddcon = workspace.DescendantAdded:Connect(function(v)
                    simplify(v)
                end)

                task.spawn(function()
                    repeat task.wait() until not flags.boostFPS
                    subaddcon:Disconnect()
                end)
            end

            setup(game.Workspace)
            wait(1) -- 等待一秒后再次检查
        end
    end
})

gsGroup:AddToggle('Simplify Parts and Models', {
    Text = 'Xray Part / Model',
    Default = false,
    Tooltip = 'Simplify all parts and models in the workspace',
    Callback = function(state)
        flags.simplify = state -- 更新 flag 为当前 state
        
        while flags.simplify do
            local function simplify(v)
                if v:IsA("Part") or v:IsA("Model") then
                    -- 在这里添加你想对 Part 和 Model 执行的简化操作
                    v.Transparency = 0.5 -- 示例：将透明度设置为 50%
                    v.Anchored = true -- 示例：将对象锚定
                end
            end

            local function setup(workspace)
                for _, v in pairs(workspace:GetDescendants()) do
                    simplify(v)
                end

                local subaddcon
                subaddcon = workspace.DescendantAdded:Connect(function(v)
                    simplify(v)
                end)

                task.spawn(function()
                    repeat task.wait() until not flags.simplify
                    subaddcon:Disconnect()
                end)
            end

            setup(game.Workspace)
            wait(1) -- 等待一秒后再次检查
        end
    end
})

local RunService = game:GetService("RunService")
MainGroup:AddLabel('---------------------', true)
MainGroup:AddSlider('Speed', {
	Text = 'Speed',
	Default = 20,
	Min = 20,
	Max = 23,
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
MainGroup:AddToggle('Speed Bypass', {
    Text = 'Anti Speed Cheat',
    Default = false,
    Tooltip = 'Toggle Speed Bypass',
    Callback = function(state)
        flags.SpeedBypass = state
        if state then
            -- 启用 Speed Bypass
            local character = game.Players.LocalPlayer.Character
            local collision = character:WaitForChild("Collision")
            local collisionClone

            if collision then
                collisionClone = collision:Clone()
                collisionClone.CanCollide = false
                collisionClone.Massless = true
                collisionClone.Name = "CollisionClone"
                if collisionClone:FindFirstChild("CollisionCrouch") then
                    collisionClone.CollisionCrouch:Destroy()
                end
                collisionClone.Parent = character

                while flags.SpeedBypass and collisionClone do
                    collisionClone.Massless = not collisionClone.Massless
                    task.wait(0.220005555)
                end
            end
        else
            -- 禁用 Speed Bypass
            local character = game.Players.LocalPlayer.Character
            local collisionClone = character:FindFirstChild("CollisionClone")
            if collisionClone then
                collisionClone.Massless = true
            end
        end
    end
})

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
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Variables to manage third-person view state
local thirdPersonEnabled = false

-- Function to toggle third-person view
local function toggleThirdPerson(state)
    thirdPersonEnabled = state
    
    if state then
        -- Enable third-person view
        RunService:BindToRenderStep('ThirdPersonView', Enum.RenderPriority.Camera.Value, function()
            if character and humanoidRootPart then
                Camera.CameraType = Enum.CameraType.Scriptable
                -- Adjust the camera position to be higher
                local cameraPosition = humanoidRootPart.Position - humanoidRootPart.CFrame.LookVector * 10 + Vector3.new(0, 5, 0)
                Camera.CFrame = CFrame.new(cameraPosition, humanoidRootPart.Position)
            end
        end)
    else
        -- Disable third-person view
        RunService:UnbindFromRenderStep('ThirdPersonView')
        Camera.CameraType = Enum.CameraType.Custom
    end
end

-- Integrate into MainGroup:AddToggle
MainGroup:AddToggle('Third Person View', {
    Text = 'Third View',
    Default = false,
    Tooltip = 'Switch to third person view',
    Callback = function(state)
        toggleThirdPerson(state)
    end
})



local MainGroup2 = Tabs.Main:AddLeftGroupbox('Prompt Aura')
MainGroup2:AddToggle('No Clip', {
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
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if flags.r1 then
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

MainGroup2:AddToggle('No Clip', {
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
game:GetService("Workspace").CurrentRooms.DescendantAdded:Connect(function(v)
    if not big then return end
    if v.IsA(v,"ProximityPrompt") then
       if big then
        v.MaxActivationDistance = 20
       end
    end
end)

local big = false
MainGroup2:AddToggle('No Clip', {
    Text = 'big Range',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        big = state
    end
})

MainGroup2:AddToggle('No Clip', {
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

MainGroup2:AddToggle('No Clip', {
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



MainGroup2:AddToggle('No Clip', {
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

local MainGroup3 = Tabs.Main:AddLeftGroupbox('Bypass Enity')
MainGroup3:AddToggle('No Clip', {
    Text = 'Nil A90',
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
MainGroup3:AddToggle('No Clip', {
    Text = 'Destory A90',
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

MainGroup3:AddToggle('No Clip', {
    Text = 'Destory Spider jumpscare',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.sj = state -- 更新 flag 为当前 state
        
        if flags.sj then
            local sj = game.ReplicatedStorage.RemotesFolder:FindFirstChild("SpiderJumpscare")
            if sj then
                -- 当 noa90 为 true 且 A90 存在时，删除 A90
                sj:Destroy()
            end
        end
    end
})

MainGroup3:AddToggle('No Clip', {
    Text = 'Destroy Eyes',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.eyes = state -- 更新 flag 为当前 state
        
        while flags.eyes do
            local eyes = game.Workspace:FindFirstChild("Eyes")
            if eyes then
                eyes:Destroy()
            end
            wait(0.001) -- 等待一秒后再次检查
        end
    end
})

MainGroup3:AddToggle('No Clip', {
    Text = 'Destroy Screech',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.sc = state -- 更新 flag 为当前 state
        
        if flags.sc then
            local entities = game.ReplicatedStorage.Entities
            local remotes = game.ReplicatedStorage.RemotesFolder
            
            local targets = {
                remotes:FindFirstChild("Screech"),
                entities:FindFirstChild("ScreechRetro"),
                entities:FindFirstChild("Screech")
            }
            
            for _, target in ipairs(targets) do
                if target then
                    target:Destroy()
                end
            end
        end
    end
})

MainGroup3:AddToggle('No Clip', {
    Text = 'Destroy Snare',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.sd = state -- 更新 flag 为当前 state
        
        while flags.sd do
            local currentRooms = game.Workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, room in ipairs(currentRooms:GetChildren()) do
                    local assets = room:FindFirstChild("Assets")
                    if assets then
                        local snare = assets:FindFirstChild("Snare")
                        if snare then
                            snare:Destroy()
                        end
                    end
                end
            end
            wait(0.1) -- 等待一秒后再次检查
        end
    end
})
--------
-- 添加切换按钮
MainGroup3:AddToggle('No Clip', {
    Text = 'Anti Seek',
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
-- 添加切换按钮
MainGroup:AddToggle('God Mode', {
    Text = 'God(if open pls close Anti Speed Cheat)',
    Default = false,
    Tooltip = 'Toggle God Mode',
    Callback = function(state)
        flags.GodMode = state
        if state then
            -- 启用 God Mode
            local character = game.Players.LocalPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local rootPart = character:WaitForChild("HumanoidRootPart")
            local collision = character:WaitForChild("Collision")
            local collisionClone
            local savedHumanoidState = humanoid:Clone()
            local savedAnimations = {}

            -- 保存当前动画
            for _, animTrack in pairs(humanoid:GetPlayingAnimationTracks()) do
                table.insert(savedAnimations, animTrack)
            end

            if collision then
                collisionClone = collision:Clone()
                collisionClone.CanCollide = false
                collisionClone.Massless = true
                collisionClone.Name = "CollisionClone"
                if collisionClone:FindFirstChild("CollisionCrouch") then
                    collisionClone.CollisionCrouch:Destroy()
                end
                collisionClone.Parent = character

                -- 禁用伤害
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)

                    -- 监控健康状态
                    humanoid.HealthChanged:Connect(function(health)
                        if health <= 0 then
                            -- 克隆并恢复健康
                            local newHumanoid = savedHumanoidState:Clone()
                            newHumanoid.Parent = character
                            character.Humanoid:Destroy()
                            character.Humanoid = newHumanoid
                            newHumanoid.Health = newHumanoid.MaxHealth

                            -- 恢复动画
                            for _, animTrack in pairs(savedAnimations) do
                                newHumanoid:LoadAnimation(animTrack.Animation):Play()
                            end
                        end
                    end)
                end

                -- 使用 RunService 来持续更新 collisionClone 的位置
                local runService = game:GetService("RunService")
                local connection
                connection = runService.Stepped:Connect(function()
                    if not flags.GodMode or not collisionClone then
                        connection:Disconnect()
                        return
                    end
                    -- 将 collisionClone 的位置设置为 rootPart 的下面
                    collisionClone.CFrame = rootPart.CFrame * CFrame.new(0, -3, 0)
                end)
            end
        else
            -- 禁用 God Mode
            local character = game.Players.LocalPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local collisionClone = character:FindFirstChild("CollisionClone")
            if collisionClone then
                collisionClone:Destroy()
            end

            -- 恢复伤害
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            end
        end
    end
})

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
                    if v.Name == "Wardrobe" or v.Name == "Locker_Large" then
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
    Text = 'Lever ESP',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.espkeys = state
        
        if state then
            local function check(v)
                if v:IsA("Model") and (v.Name == "LeverForGate" or v.Name == "KeyObtain") then
                    task.wait(0.1)
                    if v.Name == "KeyObtain" then
                        local hitbox = v:WaitForChild("Hitbox")
                        local parts = hitbox:GetChildren()
                        table.remove(parts, table.find(parts, hitbox:WaitForChild("PromptHitbox")))
                        
                        local h = esp(parts, Color3.fromRGB(145, 100, 75), hitbox, "Key")
                        table.insert(esptable.keys, h)
                        
                    elseif v.Name == "LeverForGate" then
                        local h = esp(v, Color3.fromRGB(90, 255, 40), v.PrimaryPart, "Lever")
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
            
            repeat task.wait() until not flags.espkeys
            addconnect:Disconnect()
            
            for i, v in pairs(esptable.keys) do
                v.delete()
            end
        end
    end
})

RightGroup:AddToggle('pe', {
    Text = 'Gold esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

RightGroup:AddToggle('pe', {
    Text = 'Book / Breaker esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

RightGroup:AddToggle('pe', {
    Text = 'Item esp',
    Default = false,
    Tooltip = 'Walk through walls',
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

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local markedTargets = {}

-- Function to create a BillboardGui
local function createBillboardGui(core, color, name)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = core
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 2000

    local frame = Instance.new("Frame", billboard)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = color
    frame.Size = UDim2.new(0, 8, 0, 8)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", frame)

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = color
    textLabel.Size = UDim2.new(1, 0, 0, 20)
    textLabel.Position = UDim2.new(0.5, 0, 0.7, 0)
    textLabel.Text = name
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextSize = 18
    textLabel.Font = Enum.Font.Jura
    Instance.new("UIStroke", textLabel)

    return billboard
end

-- Function to mark a target
local function markTarget(target, customName)
    if not target then return end
    local existingBillboard = target:FindFirstChildOfClass("BillboardGui")
    if existingBillboard then
        existingBillboard:Destroy()
    end
    local keyObtainBillboard = target:FindFirstChild("KeyObtain")
    if keyObtainBillboard then
        keyObtainBillboard:Destroy()
    end
    local billboard = createBillboardGui(target, Color3.fromRGB(255, 255, 255), customName)
    billboard.Parent = target
    markedTargets[target] = customName
end

-- Function to recursively find all instances with a specific name
local function findAllInstances(parent, name, targets)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name == name then
            table.insert(targets, child)
        end
        findAllInstances(child, name, targets)
    end
end

-- Function to mark all instances with a specific name
local function markInstancesByName(name, customName)
    local targets = {}
    findAllInstances(game, name, targets)
    for _, target in ipairs(targets) do
        markTarget(target, customName)
    end
end

-- Function to mark a specific player's head
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

-- Connect events to handle new players and instances
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
        if target and target:FindFirstChildOfClass("BillboardGui") then
            local billboard = target:FindFirstChildOfClass("BillboardGui")
            if billboard and billboard:FindFirstChildOfClass("TextLabel") then
                billboard.TextLabel.Text = customName
            else
                markTarget(target, customName)
            end
        end
    end
end)

-- Toggle function
RightGroup:AddToggle('pe', {
    Text = 'Key esp',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        if state then
            -- Enable ESP
            markPlayerHead("PlayerName", "Player")
            markInstancesByName("Key", "Key")
            markInstancesByName(".", ".")
        else
            -- Disable ESP
            for target, _ in pairs(markedTargets) do
                if target and target:FindFirstChildOfClass("BillboardGui") then
                    target:FindFirstChildOfClass("BillboardGui"):Destroy()
                end
            end
            markedTargets = {}
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
    Callback = function(v)
        if v then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            game:GetService("Lighting").Brightness = 3
            game:GetService("Lighting").ClockTime = 20
            game:GetService("Lighting").FogEnd = 1.1111111533265e+16
            game:GetService("Lighting").GlobalShadows = true
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(0.5, 0.5, 0.5)
        end		
    end
})

MainGroup:AddLabel('---------------------')
MainGroup:AddToggle('pe', {
    Text = 'Remove Light [Anti Lag]',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(v)
        flags.r1 = v	
    end
})



MainGroup:AddToggle('pe', {
    Text = 'Remove Gate',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.r2 = state
        
        -- 当 Gates 为 true 时，运行 RenderStepped 事件
        if state then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if flags.r2 then
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

MainGroup:AddToggle('pe', {
    Text = 'Remove Seek Arm / Fire',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(v)
	flags.r3 = v
	
        if v then
            game:GetService("RunService").RenderStepped:Connect(function()
                pcall(function()
                    if flags.r3 then
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
local RightGroup1 = Tabs.Main:AddRightGroupbox('Event')
RightGroup1:AddToggle('pe', {
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
		    addAndPlaySound("ExampleSound", 4590657391)
                else
                    entityMessage = "Entity Event: " .. entity.Name:gsub("Moving", ""):lower() .. " Spawned!"
		    addAndPlaySound("ExampleSound", 4590657391)
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
RightGroup1:AddToggle('pe', {
    Text = 'Library Code Event',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(state)
        flags.getcode = state
        
        if state then
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
                        Library:Notify("Are you sure you got all the books?")
                        addAndPlaySound("ExampleSound", 4590657391)
                    else
                        Library:Notify("Code is " .. code)
                    end
                end
            end)
            
            repeat task.wait() until not flags.getcode
            addconnect:Disconnect()
        end
    end
})


RightGroup1:AddToggle('pe', {
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
		addAndPlaySound("ExampleSound", 4590657391)
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

RightGroup1:AddToggle('pe', {
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
