local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 创建一个简单的控制台 GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local consoleFrame = Instance.new("Frame", screenGui)
consoleFrame.Size = UDim2.new(1, 0, 0.5, 0)
consoleFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
consoleFrame.BackgroundColor3 = Color3.new(0, 0, 0)
consoleFrame.Visible = false
consoleFrame.Active = true
consoleFrame.Draggable = true

-- 创建错误、警告和信息区域
local function createScrollingFrame(parent, color)
    local scrollingFrame = Instance.new("ScrollingFrame", parent)
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.ScrollBarThickness = 10
    scrollingFrame.BackgroundColor3 = color
    scrollingFrame.Visible = false

    local textLabel = Instance.new("TextLabel", scrollingFrame)
    textLabel.Size = UDim2.new(1, -10, 0, 0)
    textLabel.Position = UDim2.new(0, 5, 0, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Font = Enum.Font.Code
    textLabel.TextSize = 18
    textLabel.TextWrapped = true
    textLabel.Text = ""
    textLabel.AutomaticSize = Enum.AutomaticSize.Y
    return scrollingFrame, textLabel
end

local errorFrame, errorText = createScrollingFrame(consoleFrame, Color3.new(1, 0, 0))
local warningFrame, warningText = createScrollingFrame(consoleFrame, Color3.new(1, 1, 0))
local infoFrame, infoText = createScrollingFrame(consoleFrame, Color3.new(0.5, 0.5, 0.5))

errorText.Text = "错误:\n"
warningText.Text = "警告:\n"
infoText.Text = "信息:\n"

-- 创建切换按钮
local function createButton(text, position, onClick)
    local button = Instance.new("TextButton", screenGui)
    button.Size = UDim2.new(0.1, 0, 0.05, 0)
    button.Position = position
    button.Text = text
    button.MouseButton1Click:Connect(onClick)
    button.Active = true
    button.Draggable = true
    return button
end

createButton("显示错误", UDim2.new(0.25, 0, 0.9, 0), function()
    errorFrame.Visible = true
    warningFrame.Visible = false
    infoFrame.Visible = false
end)

createButton("显示警告", UDim2.new(0.35, 0, 0.9, 0), function()
    errorFrame.Visible = false
    warningFrame.Visible = true
    infoFrame.Visible = false
end)

createButton("显示信息", UDim2.new(0.45, 0, 0.9, 0), function()
    errorFrame.Visible = false
    warningFrame.Visible = false
    infoFrame.Visible = true
end)

-- 监听日志输出
LogService.MessageOut:Connect(function(message, messageType)
    local icon = ""
    if messageType == Enum.MessageType.MessageError then
        icon = "❌ " -- 错误图标
        errorText.Text = errorText.Text .. "\n" .. icon .. message
        errorFrame.CanvasSize = UDim2.new(1, 0, 0, errorText.TextBounds.Y + 10)
    elseif messageType == Enum.MessageType.MessageWarning then
        icon = "⚠️ " -- 警告图标
        warningText.Text = warningText.Text .. "\n" .. icon .. message
        warningFrame.CanvasSize = UDim2.new(1, 0, 0, warningText.TextBounds.Y + 10)
    else
        infoText.Text = infoText.Text .. "\n" .. message
        infoFrame.CanvasSize = UDim2.new(1, 0, 0, infoText.TextBounds.Y + 10)
    end
end)

-- 创建一个按钮来显示控制台
local showButton = Instance.new("TextButton", screenGui)
showButton.Size = UDim2.new(0.1, 0, 0.05, 0)
showButton.Position = UDim2.new(0.45, 0, 0.85, 0)
showButton.Text = "显示控制台"
showButton.Active = true
showButton.Draggable = true

showButton.MouseButton1Click:Connect(function()
    consoleFrame.Visible = not consoleFrame.Visible
end)

-- 创建一个按钮来打开或关闭所有框
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
toggleButton.Position = UDim2.new(0.55, 0, 0.85, 0)
toggleButton.Text = "切换框"
toggleButton.Active = true
toggleButton.Draggable = true

toggleButton.MouseButton1Click:Connect(function()
    local newState = not (errorFrame.Visible or warningFrame.Visible or infoFrame.Visible)
    errorFrame.Visible = newState
    warningFrame.Visible = newState
    infoFrame.Visible = newState
end)

-- 创建一个按钮来清除日志
local clearButton = Instance.new("TextButton", screenGui)
clearButton.Size = UDim2.new(0.1, 0, 0.05, 0)
clearButton.Position = UDim2.new(0.65, 0, 0.85, 0)
clearButton.Text = "清除日志"
clearButton.Active = true
clearButton.Draggable = true

clearButton.MouseButton1Click:Connect(function()
    errorText.Text = "错误:\n"
    warningText.Text = "警告:\n"
    infoText.Text = "信息:\n"
    errorFrame.CanvasSize = UDim2.new(1, 0, 0, errorText.TextBounds.Y + 10)
    warningFrame.CanvasSize = UDim2.new(1, 0, 0, warningText.TextBounds.Y + 10)
    infoFrame.CanvasSize = UDim2.new(1, 0, 0, infoText.TextBounds.Y + 10)
end)

-- 创建一个按钮来显示或隐藏所有关于日志功能的信息
local logToggleButton = Instance.new("TextButton", screenGui)
logToggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
logToggleButton.Position = UDim2.new(0.75, 0, 0.85, 0)
logToggleButton.Text = "切换日志功能"
logToggleButton.Active = true
logToggleButton.Draggable = true

logToggleButton.MouseButton1Click:Connect(function()
    local newState = not (showButton.Visible or toggleButton.Visible or clearButton.Visible)
    showButton.Visible = newState
    toggleButton.Visible = newState
    clearButton.Visible = newState
end)
