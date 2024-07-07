local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Creepy Eye V2 Welcome..game.Players.LocalPlayer.Name..Executor:..identifyexecutor()',
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
local OtherGroup = Tabs.Other:AddLeftGroupbox('Other Hub')
local RightGroup = Tabs.Main:AddRightGroupbox('Fun and other')

MainGroup:AddToggle('Fly', {
    Text = 'Fly',
    Default = false,
    Tooltip = 'Bro Think he in minecraft Create mode',
    Callback = function(Value)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local flying = false
        local speed = 15
        local direction = Vector3.new(0, 0, 0)

        local function onInputBegan(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Touch then
                local touch = input.Position
                if touch.Y < workspace.CurrentCamera.ViewportSize.Y / 2 then
                    direction = direction + Vector3.new(0, 1, 0)
                else
                    direction = direction + Vector3.new(0, -1, 0)
                end
            elseif input.KeyCode == Enum.KeyCode.W then
                direction = direction + Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                direction = direction + Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                direction = direction + Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                direction = direction + Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Space then
                direction = direction + Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                direction = direction + Vector3.new(0, -1, 0)
            end
        end

        local function onInputEnded(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Touch then
                local touch = input.Position
                if touch.Y < workspace.CurrentCamera.ViewportSize.Y / 2 then
                    direction = direction - Vector3.new(0, 1, 0)
                else
                    direction = direction - Vector3.new(0, -1, 0)
                end
            elseif input.KeyCode == Enum.KeyCode.W then
                direction = direction - Vector3.new(0, 0, -1)
            elseif input.KeyCode == Enum.KeyCode.S then
                direction = direction - Vector3.new(0, 0, 1)
            elseif input.KeyCode == Enum.KeyCode.A then
                direction = direction - Vector3.new(-1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.D then
                direction = direction - Vector3.new(1, 0, 0)
            elseif input.KeyCode == Enum.KeyCode.Space then
                direction = direction - Vector3.new(0, 1, 0)
            elseif input.KeyCode == Enum.KeyCode.LeftShift then
                direction = direction - Vector3.new(0, -1, 0)
            end
        end

        if Value then
            flying = true
            UserInputService.InputBegan:Connect(onInputBegan)
            UserInputService.InputEnded:Connect(onInputEnded)
            loopConnection = RunService.RenderStepped:Connect(function()
                if flying then
                    humanoidRootPart.Velocity = direction * speed
                end
            end)
        else
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            flying = false
        end
    end
})

MainGroup:AddToggle('Door', {
    Text = 'Door esp',
    Default = false,
    Tooltip = 'esp for Door (if not esp else Open Toggle)',
    Callback = function(Value)
        local RunService = game:GetService("RunService")
        local loopConnection

        if Value then
            loopConnection = RunService.RenderStepped:Connect(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/nb/main/n.lua"))()
            end)
        else
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/nb/main/h.lua"))()
        end
    end
})

MainGroup:AddToggle('PlayerESP', {
    Text = 'Player ESP(Beta)',
    Default = false,
    Callback = function(Value)
        if Value then
            if not _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = true
                
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                        local espUI = Instance.new("BillboardGui", player.Character.Head)
                        espUI.Name = "ESPUI"
                        espUI.Size = UDim2.new(0, 100, 0, 25)
                        espUI.Adornee = player.Character.Head
                        espUI.AlwaysOnTop = true
                        espUI.StudsOffset = Vector3.new(0, 2, 0)

                        local nameLabel = Instance.new("TextLabel", espUI)
                        nameLabel.Text = player.Name
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.TextColor3 = Color3.new(1, 1, 1)

                        local box = Instance.new("BoxHandleAdornment", player.Character)
                        box.Name = "ESPBox"
                        box.Adornee = player.Character
                        box.Size = player.Character:GetExtentsSize()
                        box.Color3 = Color3.new(1, 0, 0)
                        box.Transparency = 0.5
                        box.AlwaysOnTop = true
                    end
                end
            end
        else
            if _G.PlayerESPEnabled then
                _G.PlayerESPEnabled = false
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local espUI = player.Character.Head:FindFirstChild("ESPUI")
                        if espUI then
                            espUI:Destroy()
                        end

                        local box = player.Character:FindFirstChild("ESPBox")
                        if box then
                            box:Destroy()
                        end
                    end
                end
            end
        end
    end
})

MainGroup:AddToggle('No Clip', {
    Text = 'No Clip(Beta)',
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

MainGroup:AddToggle('Rush Alert', {
    Text = 'Rush Alert',
    Default = false,
    Tooltip = 'Alert when Rush is coming',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local GuiService = game:GetService("GuiService")

        local uiPrompt = Instance.new("TextLabel")
        uiPrompt.Text = "Rush is coming"
        uiPrompt.Size = UDim2.new(0, 200, 0, 50)
        uiPrompt.Position = UDim2.new(0.5, -100, 0.9, -25)
        uiPrompt.BackgroundTransparency = 0.5
        uiPrompt.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        uiPrompt.Visible = false
        uiPrompt.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	
        local function checkRushMovingEntity()
            local found = false
            for _, entity in pairs(game.Workspace:GetDescendants()) do
                if entity.Name:lower() == "RushMoving" then
                    found = true
                    break
                end
            end
            
            uiPrompt.Visible = found
        end

        if Value then
            _G.RushAlertEnabled = true
            while _G.RushAlertEnabled do
                checkRushMovingEntity()
                task.wait(1) 
            end
        else
            _G.RushAlertEnabled = false
            uiPrompt.Visible = false
        end
    end
})


MainGroup:AddToggle('Auto Jump', {
    Text = 'Auto Jump',
    Default = false,
    Callback = function(Value)
        if Value then
            local player = game.Players.LocalPlayer
            local hum = player.Character:WaitForChild("Humanoid")
            _G.AutoJumpEnabled = true
            while _G.AutoJumpEnabled do
                if hum.FloorMaterial ~= Enum.Material.Air then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(0.1) 
            end
        else
            _G.AutoJumpEnabled = false
        end
    end
})

MainGroup:AddToggle('GodMode', {
    Text = 'God Mode',
    Default = false,
    Tooltip = 'Toggle god mode on or off',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local originalPosition = humanoidRootPart.Position
        local offset = Vector3.new(0, 200, 0)
        local antiCheatBypass = false

        local function moveParts(offset)
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Position = part.Position + offset
                end
            end
        end

        if Value then
            antiCheatBypass = true
            moveParts(offset)
            RunService.RenderStepped:Connect(function()
                if antiCheatBypass then
                    humanoidRootPart.CFrame = CFrame.new(originalPosition)
                end
            end)
        else
            antiCheatBypass = false
            moveParts(-offset)
        end
    end
})

MainGroup:AddToggle('ESP LeverForGate', {
    Text = 'ESP LeverForGate(Beta)',
    Default = false,
    Tooltip = 'Highlight LeverForGate objects',
    Callback = function(Value)
        local runService = game:GetService("RunService")
        local function createESP(part)
            local box = Instance.new("BoxHandleAdornment")
            box.Size = part.Size
            box.Adornee = part
            box.Color3 = Color3.new(1, 1, 1) 
            box.Transparency = 0.5
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = part
        end

        local function removeESP(part)
            for _, child in pairs(part:GetChildren()) do
                if child:IsA("BoxHandleAdornment") then
                    child:Destroy()
                end
            end
        end

        local function updateESP()
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Name == "LeverForGate" then
                    if not part:FindFirstChildOfClass("BoxHandleAdornment") then
                        createESP(part)
                    end
                else
                    removeESP(part)
                end
            end
        end

        if Value then
            _G.ESPLeverForGate = runService.RenderStepped:Connect(updateESP)
        else
            if _G.ESPLeverForGate then
                _G.ESPLeverForGate:Disconnect()
                _G.ESPLeverForGate = nil
            end
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Name == "LeverForGate" then
                    removeESP(part)
                end
            end
        end
    end
})


MainGroup:AddToggle('AutoClick', {
    Text = 'Auto Click (Doors)',
    Default = false,
    Callback = function(Value)
        if Value then
            _G.AutoClickEnabled = true
            local clickInterval = 0.1

            local function autoClick()
                while _G.AutoClickEnabled do
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            local ray = Ray.new(humanoidRootPart.Position, humanoidRootPart.CFrame.LookVector * 5)
                            local target, position = workspace:FindPartOnRayWithIgnoreList(ray, {character})
                            if target and target:IsA("ClickDetector") then
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                                game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                            end
                        end
                    end
                    wait(clickInterval)
                end
            end

            spawn(autoClick)
        else
            _G.AutoClickEnabled = false
        end
    end
})

MainGroup:AddToggle('Entity ESP', {
    Text = 'Entity ESP',
    Default = false,
    Tooltip = 'Highlight entities in the game',
    Callback = function(Value)
        if Value then
            for _, entity in pairs(workspace:GetChildren()) do
                if entity:IsA("Model") and entity:FindFirstChild("Humanoid") then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = entity
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.Parent = entity
                    entity.Highlight = highlight
                end
            end
        else
            for _, entity in pairs(workspace:GetChildren()) do
                if entity:IsA("Model") and entity:FindFirstChild("Humanoid") and entity:FindFirstChild("Highlight") then
                    entity.Highlight:Destroy()
                end
            end
        end
    end
})

MainGroup:AddToggle('AutoOpendoor', {
    Text = 'Auto Open Door (Doors)',
    Default = false,
    Callback = function(Value)
        if Value then
            _G.AutoOpendoorEnabled = true

            local function autoOpendoor()
                while _G.AutoOpendoorEnabled do
                    for _, door in pairs(workspace.Doors:GetChildren()) do
                        if door:IsA("Model") and door:FindFirstChild("door") then
                            local proximityPrompt = door.door:FindFirstChildOfClass("ProximityPrompt")
                            if proximityPrompt then
                                proximityPrompt.MaxActivationDistance = 10
                                local distance = (door.door.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                if distance < 10 then 
                                    fireproximityprompt(proximityPrompt)
                                end
                            end
                        end
                    end
                    wait(0.1)
                end
            end

            spawn(autoOpendoor)
        else
            _G.AutoOpendoorEnabled = false
            for _, door in pairs(workspace.Doors:GetChildren()) do
                if door:IsA("Model") and door:FindFirstChild("door") then
                    local proximityPrompt = door.door:FindFirstChildOfClass("ProximityPrompt")
                    if proximityPrompt then
                        proximityPrompt.MaxActivationDistance = 3
                    end
                end
            end
        end
    end
})


MainGroup:AddToggle('Highlight Player', {
    Text = 'Highlight Player(Beta)',
    Default = false,
    Tooltip = 'Create a light on player\'s head',
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local head = char:WaitForChild("Head")

        if Value then
            local light = Instance.new("PointLight")
            light.Brightness = 5
            light.Range = 15
            light.Color = Color3.fromRGB(255, 255, 255)
            light.Parent = head
            _G.PlayerLight = light
        else
            if _G.PlayerLight then
                _G.PlayerLight:Destroy()
                _G.PlayerLight = nil
            end
        end
    end
})

MainGroup:AddToggle('Monitor Eyes', {
    Text = 'Monitor Eyes(Beta)',
    Default = false,
    Tooltip = 'Monitor for Eyes objects',
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local runService = game:GetService("RunService")

        local function createESPBox(part)
            local box = Instance.new("BoxHandleAdornment")
            box.Size = part.Size
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Transparency = 0.5
            box.Color3 = Color3.new(1, 0, 0)
            box.Parent = part
        end

        local function onChildAdded(child)
            if child.Name:find("Eyes") then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Warning",
                    Text = "Eyes has spawned, don't look!",
                    Duration = 5
                })
                createESPBox(child)
            end
        end

        if Value then
            _G.MonitorEyes = workspace.ChildAdded:Connect(onChildAdded)
	    
            for _, child in pairs(workspace:GetChildren()) do
                if child.Name:find("Eyes") then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Warning",
                        Text = "Eyes has spawned, don't look!",
                        Duration = 5
                    })
                    createESPBox(child)
                end
            end
        else
            if _G.MonitorEyes then
                _G.MonitorEyes:Disconnect()
                _G.MonitorEyes = nil
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

MainGroup:AddSlider('WalkSpeed', {
    Text = 'Speed',
    Default = 0,
    Min = 0, 
    Max = 100, 
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

RightGroup:AddButton({
    Text = 'Health = 0',
    Func = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end,
    Tooltip = 'Death'
})

RightGroup:AddButton({
    Text = 'Health = 100',
    Func = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 100
    end,
    Tooltip = 'Restore your health'
})

RightGroup:AddButton({
    Text = 'Floor2 Package',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/iCherryKardes/Doors/main/Floor%202%20Mod"))()
    end,
    Tooltip = 'Floor2 Package'
})

RightGroup:AddButton({
    Text = 'Keyboard',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end,
    Tooltip = 'PC Keyboard'
})

RightGroup:AddButton({
    Text = 'Crucifix',
    Func = function()
        local shadow=game:GetObjects("rbxassetid://11498423088")[1]
shadow.Parent = game.Players.LocalPlayer.Backpack
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local RightArm = Char:WaitForChild("RightUpperArm")
local LeftArm = Char:WaitForChild("LeftUpperArm")
local RightC1 = RightArm.RightShoulder.C1
local LeftC1 = LeftArm.LeftShoulder.C1
        local function setupCrucifix(tool)
        RightArm.Name = "R_Arm"
        LeftArm.Name = "L_Arm"
        
        RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)
        LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))
        for _, v in next, Hum:GetPlayingAnimationTracks() do
            v:Stop()
        end
        end
shadow.Equipped:Connect(function()
setupCrucifix(shadow)
game.Players.LocalPlayer:SetAttribute("Hidden", true)
end)
    end,
    Tooltip = 'XD'
})

RightGroup:AddButton({
    Text = 'Show Time',
    Func = function()
        local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("China time:"..os.date("%H").."H"..os.date("%M").."M"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
    end,
    Tooltip = 'Bro'
})

RightGroup:AddButton({
    Text = 'Floor2 candle',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Floor-2-candle-By-icherryKardess-/The-Floor-2-candle-(By-icherryKardess)/Floor2%20candle%20(The%20candle%20by%20icherrykardess).lua"))()
    end,
    Tooltip = 'Floo2 Candle'
})

RightGroup:AddButton({
    Text = 'Endless Flashlight',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/InsanemodeV5/main/Endless.lua"))()
    end,
    Tooltip = 'Original item by Doors Endless mode'
})

OtherGroup:AddButton({
    Text = 'Script mode V3',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/munciseek/Script-Mode/main/V3/Main-Scipt"))()
    end,
    Tooltip = 'By munciseek'
})

OtherGroup:AddButton({
    Text = '白',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/obf_jZ7fGQTwd7mnRF8EL2N6UNhCXC746GdxQVEEP0ZgkC2zrf6xpXodn9h9kTjU491J.lua"))()
    end,
    Tooltip = 'By XingKong'
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

OtherGroup:AddButton({
    Text = 'Dex V3',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end,
    Tooltip = 'Mobile only(Android Executor)'
})

OtherGroup:AddButton({
    Text = 'Silence Hub V2(Warn:Old Version)',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/Moonsec/moonsec/moonsec.lua"))()
    end,
    Tooltip = 'By Drop'
})

OtherGroup:AddButton({
    Text = 'FFJ1',
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua"))()
    end,
    Tooltip = 'By FFJ1'
})
