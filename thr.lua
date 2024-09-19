local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = getgenv().Linoria.Options
local Toggles = getgenv().Linoria.Toggles

local v = 1.2

local Window = Library:CreateWindow({
    Title = 'Ly X / Hydraulic v' .. v,
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

local MainTab = Tabs.Main

local HitboxSection = MainTab:AddLeftGroupbox("Hitbox Controls")

local hitboxSize = 5
local hitboxTransparency = 0.5
local hc = Color3.fromRGB(255, 255, 255)
local hitboxEnabled = false

HitboxSection:AddInput("HitboxSize", {
    Text = "Hitbox Size",
    Default = "5",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        hitboxSize = tonumber(value)
    end
})

HitboxSection:AddInput("HitboxTransparency", {
    Text = "Hitbox Transparency",
    Default = "0.5",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        hitboxTransparency = tonumber(value)
    end
})

HitboxSection:AddToggle("EnableHitbox", {
    Text = "Enable Hitbox",
    Default = false,
    Callback = function(state)
        hitboxEnabled = state
        if state then
            -- Enable hitbox expansion
            game:GetService("RunService").RenderStepped:Connect(function()
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if player.Team ~= game.Players.LocalPlayer.Team then
                            local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
                            if hitbox then
                                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                hitbox.Transparency = hitboxTransparency
                                hitbox.Color = hitboxColor
                            end
                        end
                    end
                end
            end)
        else
            -- Disable hitbox expansion
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
                    if hitbox then
                        hitbox.Size = Vector3.new(2, 2, 1) -- Default size
                        hitbox.Transparency = 0
                        hitbox.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
    end
}):AddColorPicker('ColorPicker3', {
	Default = Color3.new(255, 255, 255),
	Title = 'hc (Hitbox Color)',
	Transparency = 0,

	Callback = function(value)
		hc = value
	end
})


local MyButton2 = HitboxSection:AddButton({
    Text = 'Join New Server',
    Func = function()
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local JobId = game.JobId

        -- 保存当前服务器ID
        local savedJobId = JobId

        local function teleportToServer()
            -- 检查当前服务器ID是否匹配保存的ID
            if game.JobId == savedJobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, savedJobId, game.Players.LocalPlayer)
            else
                print("No matching server found.")
            end
        end

        -- 运行传送函数
        teleportToServer()
    end,
    DoubleClick = true, -- 需要双击按钮才能触发回调
    Tooltip = 'This is the sub button (double click me!)'
})
Library:SetWatermarkVisibility(true)

local MyButton2 = HitboxSection:AddButton({
	Text = 'Infinite Yield',
	Func = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
		Library:Notify("Script success Execute", nil, 4590657391)
	end,
	DoubleClick = true, -- You will have to click this button twice to trigger the callback
	Tooltip = 'This is the sub button (double click me!)'
})


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

	Library:SetWatermark(('Ly X / Hydraulic | %s fps | %s ms'):format(
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
