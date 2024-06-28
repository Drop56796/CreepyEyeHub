local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Creepy Eye V2',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Other = Window:AddTab('other'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Player')
local OtherGroup = Tabs.Other:AddLeftGroupbox('Other') 

MainGroup:AddToggle('Door', {
    Text = 'Door esp',
    Default = false,
    Tooltip = 'esp for Door',
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/nb/main/n.lua"))()
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/nb/main/h.lua"))()
        end
    end
})

MainGroup:AddToggle('PlayerESP', {
    Text = 'Player ESP',
    Default = false,
    Callback = function(Value)
        if Value then
            if not _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = true
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    create3DBox(player)
                end
            end
        else
            if _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = false
                for playerName, box in pairs(ESPBoxes) do
                    if box then
                        box:Remove()
                        ESPBoxes[playerName] = nil
                    end
                end
            end
        end
    end
})

MainGroup:AddSlider('FieldOfView', {
    Text = 'FOV',
    Default = 70,
    Min = 70, 
    Max = 120, 
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        game.Workspace.CurrentCamera.FieldOfView = Value
    end
})

MainGroup:AddSlider('Speed', {
	Text = 'Speed',
	Default = 0,
	Min = 0,
	Max = 25,
  Rounding = 1,
	Compact = false,

	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end
})

MainGroup:AddButton({
    Text = 'Health = 0',
    Func = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end,
    Tooltip = 'Death'
})

MainGroup:AddButton({
    Text = 'Health = 100',
    Func = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 100
    end,
    Tooltip = 'Restore your health'
})

OtherGroup:AddButton({
    Text = 'Script mode V3',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/munciseek/Script-Mode/main/V3/Main-Scipt"))()
    end,
    Tooltip = 'By munciseek'
})

OtherGroup:AddButton({
    Text = 'Shark',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sharksharksharkshark/potential-rotary-phone/main/bei%20ji%20shark.lua", true))()
    end,
    Tooltip = 'By SharkStudio'
})

OtherGroup:AddButton({
    Text = 'Bobhub(会覆盖)',
    Func = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
    end,
    Tooltip = 'Bobhub'
})

OtherGroup:AddButton({
    Text = '情云',
    Func = function()
        loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
    end,
    Tooltip = 'Made by Chinese'
}) 

OtherGroup:AddButton({
    Text = 'USA Hub',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/USA868/114514-55-646-114514-88-61518-618-840-1018-634-10-4949-3457578401-615/main/Protected-36.lua"))()
    end,
    Tooltip = 'Mr.USA'
})

OtherGroup:AddButton({
    Text = 'Mshub (会覆盖)',
    Func = function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/MSDOORS/main/MSHUB_Loader.lua"),true))()
    end,
    Tooltip = 'By msstudio45'
})

OtherGroup:AddButton({
    Text = 'Trauma Hub V4',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Mercury/main/Mercury.lua"))()
    end,
    Tooltip = 'By Drop'
})

OtherGroup:AddButton({
    Text = 'Vape V4',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Vape-V4/main/%E7%94%B5%E5%AD%90%E7%83%9FV4.lua"))()
    end,
    Tooltip = 'Original Mod in Minecraft'
})

