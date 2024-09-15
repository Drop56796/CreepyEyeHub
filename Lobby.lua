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
    camfov = nil
}

local flags = {
    tpwalktoggle = false,  -- TP Walk 开关标志
    tpwalkspeed = 16,      -- TP Walk 速度标志
    camfov = 70,           -- FOV 标志
    camfovtoggle = false
}
local Window = Library:CreateWindow({
    Title = 'Hydraulic <Lobby Game> v' .. v .. '  ID: ' .. characterName,
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
