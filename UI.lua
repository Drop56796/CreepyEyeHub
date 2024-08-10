
local UILib = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/TopBar/UI%20Lib.lua?raw=true"))()
local Players = game:GetService("Players")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local background = UILib:CreateBackground(screenGui, "rbxassetid://12345678")

local window = UILib:CreateWindow(screenGui, "我的窗口")

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0.1, 0)
tabContainer.Position = UDim2.new(0, 0, 0.1, 0)
tabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabContainer.Parent = window

local tab1 = UILib:CreateTab(tabContainer, "Tab 1")
local tab2 = UILib:CreateTab(tabContainer, "Tab 2")

local button = UILib:CreateButton(tab1, "按钮", UDim2.new(0.1, 0, 0.1, 0), UDim2.new(0.8, 0, 0.1, 0), function()
    print("按钮被点击!")
end)

local toggle = UILib:CreateToggle(tab1, "开关: 关", UDim2.new(0.1, 0, 0.25, 0), UDim2.new(0.8, 0, 0.1, 0), function(state)
    print("开关状态: " .. (state and "开" or "关"))
end)

local textBox = UILib:CreateTextBox(tab1, "输入文本", UDim2.new(0.1, 0, 0.4, 0), UDim2.new(0.8, 0, 0.1, 0))

local slider = UILib:CreateSlider(tab1, UDim2.new(0.1, 0, 0.55, 0), UDim2.new(0.8, 0, 0.1, 0), function(value)
    print("滑块值: " .. value)
end)

-- 在Tab 2中添加其他UI元素
local button2 = UILib:CreateButton(tab2, "另一个按钮", UDim2.new(0.1, 0, 0.1, 0), UDim2.new(0.8, 0, 0.1
