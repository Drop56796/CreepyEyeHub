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
local OtherGroup = Tabs.Other:AddLeftGroupbox('Other Hub')
local RightGroup = Tabs.Main:AddRightGroupbox('Fun and other')


MainGroup:AddToggle('Door', {
    Text = 'Door esp',
    Default = false,
    Tooltip = 'esp for Door (if not esp else Open Toggle)',
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/nb/main/n.lua"))()
        else
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

MainGroup:AddToggle('God Mode', {
    Text = 'God Mode(Beta)',
    Default = false,
    Tooltip = 'Become invincible and change position',
    Callback = function(Value)
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local range = 10

        
        local function bypassEntities()
            for _, entity in pairs(workspace:GetDescendants()) do
                if entity:IsA("Model") and entity:FindFirstChild("Humanoid") then
                    local distance = (character.PrimaryPart.Position - entity.PrimaryPart.Position).magnitude
                    if distance <= range then
                        character.PrimaryPart.CFrame = character.PrimaryPart.CFrame + Vector3.new(0, 500, 0)
                    end
                end
            end
        end

        if Value then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
            _G.GodModeEnabled = true
            while _G.GodModeEnabled do
                bypassEntities()
                task.wait(0.1)
            end
        else
            hum.MaxHealth = 100
            hum.Health = 100
            _G.GodModeEnabled = false
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

MainGroup:AddToggle('Look Aura', {
    Text = 'Look Aura',
    Default = false,
    Tooltip = 'Automatically interact with objects in your line of sight',
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local runService = game:GetService("RunService")
        local camera = game.Workspace.CurrentCamera
        local connection

        local function lookAura()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local ray = Ray.new(camera.CFrame.Position, camera.CFrame.LookVector * 10)
                local hit, position = workspace:FindPartOnRay(ray, player.Character)
                
                if hit then
                    local success, err = pcall(function()
                        if hit:IsA("ClickDetector") then
                            fireclickdetector(hit)
                        elseif hit:IsA("ProximityPrompt") then
                            fireproximityprompt(hit)
                        elseif hit:IsA("TouchTransmitter") then
                            firetouchinterest(hit, player.Character.HumanoidRootPart, 0)
                            wait(0.1)
                            firetouchinterest(hit, player.Character.HumanoidRootPart, 1)
                        end
                    end)
                    if not success then
                        warn("Error interacting with object: " .. err)
                    end
                end
            end
        end

        if Value then
            connection = runService.Heartbeat:Connect(function()
                local success, err = pcall(lookAura)
                if not success then
                    warn("Error in lookAura: " .. err)
                end
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
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
            light.Brightness = 10
            light.Range = 30
            light.Color = Color3.fromRGB(255, 255, 255) -- 白色光
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
                player:SendNotification({
                    Title = "Warning",
                    Text = "Eyes is spawn, don't look!",
                    Duration = 5
                })
                createESPBox(child)
            end
        end

        if Value then
            _G.MonitorEyes = workspace.ChildAdded:Connect(onChildAdded)
	    
            for _, child in pairs(workspace:GetChildren()) do
                if child.Name:find("Eyes") then
                    player:SendNotification({
                        Title = "Warning",
                        Text = "Eyes is spawn, don't look!",
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

MainGroup:AddToggle('Monitor Files', {
    Text = 'Monitor Files',
    Default = false,
    Tooltip = 'Monitor for specific files in the workspace',
    Callback = function(Value)
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

        local function createLabel(part)
            local billboard = Instance.new("BillboardGui")
            billboard.Adornee = part
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true

            local textLabel = Instance.new("TextLabel")
            textLabel.Text = part.Name
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.new(1, 1, 1)
            textLabel.Parent = billboard

            billboard.Parent = part
        end

        local function checkForFiles()
            for _, child in pairs(workspace:GetChildren()) do
                if child.Name == "LiveHintBook" or child.Name == "LiveBreakerPolePickup" then
                    createESPBox(child)
                    createLabel(child)
                end
            end
        end

        if Value then
            _G.MonitorFiles = workspace.ChildAdded:Connect(function(child)
                if child.Name == "LiveHintBook" or child.Name == "LiveBreakerPolePickup" then
                    createESPBox(child)
                    createLabel(child)
                end
            end)

            -- Initial check for existing children
            checkForFiles()
        else
            if _G.MonitorFiles then
                _G.MonitorFiles:Disconnect()
                _G.MonitorFiles = nil
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
	Max = 50,
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

