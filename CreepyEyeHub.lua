local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("CreepyHub",Color3.fromRGB(255, 0, 0), Enum.KeyCode.RightControl)
local tab = win:Tab("Main")

tab:Button("item esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/item.lua"))()

tab:Button("highlight", function()
loadstring(game:HttpGet("https://pastebin.com/raw/4LDKiJ5a"))()
end)

tab:Button("Door esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/door.lua"))()
end)

tab:Button("Key esp", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/Key.lua"))()
end)

tab:Textbox("FOV:   (70-120)",true, function(t)
game.Workspace.CurrentCamera.FieldOfView = value
end)

tab:Textbox("Speed:",true, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

tab:Button("Died", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

tab:Button("回血", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 100
end)

tab:Button("Bobhub(China)", function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

tab:Button("情云", function()
loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
end)

tab:Textbox("Hardcore Remake",true, function(t)
loadstring(game:HttpGet("https://glot.io/snippets/gp5pu59o7f/raw"))()
end)
