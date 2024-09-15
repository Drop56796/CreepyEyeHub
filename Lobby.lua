local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/UI%20Style%20theme.lua?raw=true"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local v = 2
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")  -- Ensure Humanoid exists
local rootPart = char:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local buttons = {
    tpwalktoggle = nil,  -- TP Walk 开关按钮
    tpwalkspeed = nil,   -- TP Walk 速度滑块
    camfov = nil,
    hitboxtoggle = nil
}

local flags = {
    tpwalktoggle = false,  -- TP Walk 开关标志
    tpwalkspeed = 16,      -- TP Walk 速度标志
    camfov = 70,           -- FOV 标志
    camfovtoggle = false,
    hitbox = 2,
    hitboxtoggle = false
}
local Window = Library:CreateWindow({
    Title = 'Hydraulic <Lobby Game>,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('player')

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

-- Adding a toggle to enable/disable hitbox adjustment
MainGroup:AddToggle('ToggleHitbox', {
    Text = 'Toggle Hitbox',
    Default = false,
    Tooltip = 'Toggle hitbox size adjustment',
    Callback = function(val, oldval)
        flags.hitboxtoggle = val
        if not val then
            -- Reset hitbox size to default when disabled
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1) -- Default size
                    player.Character.HumanoidRootPart.Transparency = 1 -- Default transparency
                end
            end
        end
    end
})
buttons.hitboxtoggle = togglehitboxbtn

-- Adding a slider to adjust hitbox size
MainGroup:AddSlider('HitboxSize', {
    Text = 'Hitbox Size',
    Default = 2,
    Min = 2,
    Max = 10,
    Rounding = 1,
    Compact = false,

    Callback = function(val, oldval)
        flags.hitboxsize = val
        if flags.hitboxtoggle then
            -- Apply hitbox size adjustment when enabled
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(val, val, val)
                    player.Character.HumanoidRootPart.Transparency = 0.5 -- Make hitbox visible
                end
            end
        end
    end
})
buttons.hitboxsize = hitboxsizeslider

-- Create a loop using RunService to enforce hitbox size
RunService.RenderStepped:Connect(function()
    if flags.hitboxtoggle then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = Vector3.new(flags.hitboxsize, flags.hitboxsize, flags.hitboxsize)
                player.Character.HumanoidRootPart.Transparency = 0.5 -- Make hitbox visible
            end
        end
    end  
end)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local flySpeed = 50
local flying = false

-- Create the main UI frame
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Make the UI draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Create the fly speed slider
local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(0, 180, 0, 30)
SpeedSlider.Position = UDim2.new(0, 10, 0, 10)
SpeedSlider.Text = "Speed: 50"
SpeedSlider.Parent = MainFrame

SpeedSlider.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 10
    if flySpeed > 100 then
        flySpeed = 10
    end
    SpeedSlider.Text = "Speed: " .. flySpeed
end)

-- Function to start flying
local function startFlying()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        flying = true
        local humanoidRootPart = character.HumanoidRootPart
        humanoidRootPart.Anchored = true

        RunService.RenderStepped:Connect(function()
            if flying then
                local moveDirection = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
                end

                -- Mobile controls
                local touchInput = UserInputService:GetTouchInputs()
                if #touchInput > 0 then
                    local touch = touchInput[1]
                    local delta = touch.Delta
                    moveDirection = moveDirection + Vector3.new(delta.X, 0, delta.Y) * flySpeed * 0.01
                end

                humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection * RunService.RenderStepped:Wait()
            end
        end)
    end
end

-- Function to stop flying
local function stopFlying()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        flying = false
        character.HumanoidRootPart.Anchored = false
    end
end

-- Create the fly toggle button
local FlyToggleButton = Instance.new("TextButton")
FlyToggleButton.Size = UDim2.new(0, 180, 0, 30)
FlyToggleButton.Position = UDim2.new(0, 10, 0, 50)
FlyToggleButton.Text = "Toggle Fly"
FlyToggleButton.Parent = MainFrame

FlyToggleButton.MouseButton1Click:Connect(function()
    if flying then
        stopFlying()
        FlyToggleButton.Text = "Toggle Fly"
    else
        startFlying()
        FlyToggleButton.Text = "Stop Fly"
    end
end)

-- Adding a toggle to the GUI for showing/hiding the main frame
MainGroup:AddToggle('ToggleFlyUI', {
    Text = 'Toggle Fly UI',
    Default = false,
    Tooltip = 'Show or hide the fly UI',
    Callback = function(val)
        MainFrame.Visible = val
    end
})
