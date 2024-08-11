loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/White%20King%20obfuscate.lua?raw=true"))()
wait(1)

local gui = game:GetService("CoreGui"):FindFirstChild("ScreenGui")

if not gui then
    gui = Instance.new("ScreenGui")
    gui.Name = "ScreenGui"
    gui.Parent = game:GetService("CoreGui")
end

gui.Enabled = true

local toggleGuiScreen = Instance.new("ScreenGui")
toggleGuiScreen.Name = "ToggleGuiScreen"
toggleGuiScreen.Parent = game:GetService("CoreGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 50, 0, 200)
toggleButton.Text = "Toggle GUI"
toggleButton.Parent = toggleGuiScreen
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.TextColor3 = Color3.new(1, 1, 1)

local function toggleGui()
    gui.Enabled = not gui.Enabled
end

toggleButton.MouseButton1Click:Connect(toggleGui)
