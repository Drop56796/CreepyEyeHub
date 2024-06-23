local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/inceldom/kinx/main/ui'))()
local win = UILib:Window("CreepyHub",Color3.fromRGB(255, 0, 0), Enum.KeyCode.RightControl)
local MainSection = win:Tab("Main")

MainSection:Button("item esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/item.lua"))()
end)

MainSection:Button("highlight", function()
loadstring(game:HttpGet("https://pastebin.com/raw/4LDKiJ5a"))()
end)

MainSection:Button("Door esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/door.lua"))()
end)

MainSection:Button("Key esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/Key.lua"))()
end)

MainSection:Textbox("FOV:   (70-120)",true, function(value)
game.Workspace.CurrentCamera.FieldOfView = value
end)

MainSection:Textbox("Speed:",true, function(value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

MainSection:Button("Died", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

MainSection:Button("回血", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 100
end)

MainSection:Label("Doors hub")

MainSection:Button("Bobhub(China)", function()    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

MainSection:Button("FFJ1", function()    
loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua"))()
end)

MainSection:Button("MSHUB", function()    loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/MSDOORS/main/MSHUB_Loader.lua"),true))()
end)

MainSection:Label("Doors script mode")

MainSection:Button("Munciseek", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/munciseek/Script-Mode/main/V3/Main-Scipt"))()
end)

local Other = win:Tab("Other")

Other:Label("Other script")

Other:Button("情云", function()
loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
end)

Other:Button("北约", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/USA868/114514-55-646-114514-88-61518-618-840-1018-634-10-4949-3457578401-615/main/Protected-36.lua"))()
end)

Other:Button("Shark", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/sharksharksharkshark/potential-rotary-phone/main/bei%20ji%20shark.lua", true))()
end)

Settings = win:Tab("Settings")

Settings:Label("Copy Create QQ")

Settings:Button("Copy", function()
    setclipboard("3756646428")
    UILib:Notification("Copied!")
end)

Settings:Button("Close UI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CloseButton/main/A.lua"))()
    win.Enabled = false 
    for _, v in pairs(win:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
end)    
