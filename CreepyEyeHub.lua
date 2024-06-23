local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("CreepyHub",Color3.fromRGB(255, 0, 0), Enum.KeyCode.RightControl)

local tab = win:Tab("Main")

tab:Button("item esp", function()
local ESP = {} -- Table to hold our ESP functions and data

-- Function to create a BillboardGui for ESP
function ESP:CreateESP(object)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.new(0, 1, 0) -- Green color
    textLabel.TextStrokeTransparency = 0.5

    billboardGui.Parent = object
end

-- Function to find objects named "Flashlight" and apply ESP
function ESP:ApplyToFlashlights()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and object.Name == "Flashlight" then
            self:CreateESP(object)
        end
    end
end

-- Apply ESP to all flashlights initially
ESP:ApplyToFlashlights()

-- Optionally, connect to the DescendantAdded event to apply ESP to new flashlights
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") and descendant.Name == "Flashlight" then
        ESP:CreateESP(descendant)
    end
end)
end)

tab:Button("highlight", function()
loadstring(game:HttpGet("https://pastebin.com/raw/4LDKiJ5a"))()
end)

tab:Button("Key esp")
local ESP = {} -- Table to hold our ESP functions and data

-- Function to create a BillboardGui for ESP
function ESP:CreateESP(object)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.new(0, 1, 0) -- Green color
    textLabel.TextStrokeTransparency = 0.5

    billboardGui.Parent = object
end

-- Function to find objects named "KeyObtain" and apply ESP
function ESP:ApplyToKeyObtains()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and object.Name == "KeyObtain" then
            self:CreateESP(object)
        end
    end
end

-- Apply ESP to all KeyObtains initially
ESP:ApplyToKeyObtains()

-- Optionally, connect to the DescendantAdded event to apply ESP to new KeyObtains
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") and descendant.Name == "KeyObtain" then
        ESP:CreateESP(descendant)
    end
end)
end)

tab:Button("Door esp", function()
local ESP = {} -- Table to hold our ESP functions and data

-- Function to create a BillboardGui for ESP
function ESP:CreateESP(object)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.new(0, 1, 0) -- Green color
    textLabel.TextStrokeTransparency = 0.5

    billboardGui.Parent = object
end

-- Function to find objects named "door" and apply ESP
function ESP:ApplyToDoors()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") and object.Name == "door" then
            self:CreateESP(object)
        end
    end
end

-- Apply ESP to all doors initially
ESP:ApplyToDoors()

-- Optionally, connect to the DescendantAdded event to apply ESP to new doors
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") and descendant.Name == "door" then
        ESP:CreateESP(descendant)
    end
end)
end)

tab:Button("Setting FOV 120", function()
game.Workspace.CurrentCamera.FieldOfView = 120
end)

tab:Button("Setting FOV 110", function()
game.Workspace.CurrentCamera.FieldOfView = 110
end)

tab:Button("Setting FOV 100", function()
game.Workspace.CurrentCamera.FieldOfView = 100
end)

tab:Button("Setting FOV 95", function()
game.Workspace.CurrentCamera.FieldOfView = 95
end)

tab:Button("Setting FOV 85", function()
game.Workspace.CurrentCamera.FieldOfView = 85
end)

tab:Button("Setting Speed 20", function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
end)

tab:Button("Setting Speed 35", function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 35
end)

tab:Button("Died", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

tab:Button("Health 100", function()
game.Players.LocalPlayer.Character.Humanoid.Health = 100
end)

tab:Button("Bobhub(China)", function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

tab:Button("情云", function()
loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
end)
