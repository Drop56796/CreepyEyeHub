local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/UI%20Style%20theme.lua?raw=true"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local buttons = {
    tpwalktoggle = nil,  -- TP Walk 开关按钮
    tpwalkspeed = nil --
}

local flags = {
    tpwalktoggle = false,  -- TP Walk 开关标志
    tpwalkspeed = 16,
    AntoJump = false
}

local Window = Library:CreateWindow({
    Title = 'Ly X / Nico nextbots',
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

local MainGroup = Tabs.Main:AddLeftGroupbox('LocalPlayer')

local RunService = game:GetService("RunService")
MainGroup:AddLabel('---------------------', true)
MainGroup:AddSlider('Speed', {
	Text = '>> Speed <<',
	Default = 20,
	Min = 20,
	Max = 40,
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
MainGroup:AddToggle('No Clip', {
    Text = 'Anto Jump',
    Default = false,
    Tooltip = 'Walk through walls',
    Callback = function(val)
        flags.AntoJump = val
    end
})

local LocalPlayer = game.Players.LocalPlayer
game:GetService("RunService").Heartbeat:Connect(function()
    if flags.AntoJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Jump = true
    end
end)
