-- 创建ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 创建主要框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- 深灰色背景
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Draggable = true -- 使框架可拖动
mainFrame.Active = true -- 使框架可接受输入

-- 创建圆角
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15) -- 圆角半径
corner.Parent = mainFrame

-- 创建输入框的滚动框架
local inputScrollingFrame = Instance.new("ScrollingFrame")
inputScrollingFrame.Size = UDim2.new(0.94, 0, 0.94, 0)
inputScrollingFrame.Position = UDim2.new(0.03, 0, 0.03, 0)
inputScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 深灰色背景
inputScrollingFrame.BorderSizePixel = 0
inputScrollingFrame.ScrollBarThickness = 12
inputScrollingFrame.Parent = mainFrame

-- 创建输入框
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -12, 1, 0) -- 调整宽度以适应滚动条
inputBox.Position = UDim2.new(0, 0, 0, 0)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 14
inputBox.MultiLine = true
inputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 深灰色背景
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
inputBox.PlaceholderText = "Edited Exploradores V1 beta"
inputBox.ClearTextOnFocus = false
inputBox.TextWrapped = true -- 自动换行
inputBox.RichText = true -- 启用富文本
inputBox.TextXAlignment = Enum.TextXAlignment.Left -- 文本左对齐
inputBox.TextYAlignment = Enum.TextYAlignment.Top -- 文本上对齐
inputBox.Parent = inputScrollingFrame

-- 创建清除按钮
local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0.2, 0, 0.1, 0)
clearButton.Position = UDim2.new(0.75, 0, 0.15, 0)
clearButton.Text = "Clear"
clearButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- 红色
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
clearButton.Parent = mainFrame

-- 创建执行按钮
local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
executeButton.Position = UDim2.new(0.75, 0, 0.03, 0)
executeButton.Text = "Execute"
executeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- 绿色
executeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
executeButton.Parent = mainFrame

-- 创建输出台的滚动框架
local outputScrollingFrame = Instance.new("ScrollingFrame")
outputScrollingFrame.Size = UDim2.new(0.94, 0, 0.94, 0) -- 输出台的大小
outputScrollingFrame.Position = UDim2.new(0.03, 0, 0.03, 0) -- 输出台位置
outputScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 深灰色背景
outputScrollingFrame.BorderSizePixel = 0
outputScrollingFrame.ScrollBarThickness = 12
outputScrollingFrame.Visible = false -- 初始不显示输出台
outputScrollingFrame.Parent = mainFrame

-- 创建输出台文本框
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -12, 1, 0) -- 调整宽度以适应滚动条
outputBox.Position = UDim2.new(0, 0, 0, 0)
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 14
outputBox.MultiLine = true
outputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 深灰色背景
outputBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
outputBox.ClearTextOnFocus = false
outputBox.TextWrapped = true -- 自动换行
outputBox.RichText = true -- 启用富文本
outputBox.TextXAlignment = Enum.TextXAlignment.Left -- 文本左对齐
outputBox.TextYAlignment = Enum.TextYAlignment.Top -- 文本上对齐
outputBox.Parent = outputScrollingFrame

-- 创建开关按钮
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.2, 0, 0.1, 0)
toggleButton.Position = UDim2.new(0.75, 0, 0.25, 0)
toggleButton.Text = "Output"
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- 中灰色
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
toggleButton.Parent = mainFrame

-- 高亮和注释处理函数
local function highlightCode(code)
    -- 定义关键字和注释的颜色
    local keywordColors = {
        ["function"] = "#FF6347", -- 番茄红
        ["local"] = "#87CEEB", -- 天蓝色
        ["end"] = "#FFD700", -- 金色
        ["if"] = "#32CD32", -- 黄绿色
        ["then"] = "#FF4500", -- 橙红色
        ["else"] = "#00BFFF", -- 深天蓝
        ["elseif"] = "#FF1493", -- 深粉色
        ["for"] = "#FF69B4", -- 热粉色
        ["while"] = "#00FA9A", -- 中春绿色
        ["do"] = "#FF8C00", -- 暗橙色
        ["repeat"] = "#7FFF00", -- 草地绿色
        ["until"] = "#FF00FF", -- 洋红色
        ["return"] = "#ADFF2F", -- 黄绿色
        ["true"] = "#FF4500", -- 橙红色
        ["false"] = "#FF4500", -- 橙红色
        ["nil"] = "#8A2BE2", -- 蓝紫色
        ["loadstring"] = "#B0C4DE", -- 鱼肚白
        ["game"] = "#48D1CC", -- 玫瑰绿
        ["HttpGet"] = "#DAA520" -- 金色
    }
    local commentColor = "#00FF00" -- 绿色

    -- 按行处理代码
    local lines = {}
    for line in code:gmatch("[^\r\n]+") do
        -- 处理关键字
        for keyword, color in pairs(keywordColors) do
            line = line:gsub("(%f[%w])("..keyword..")(%f[%W])", function(before, keyword, after)
                return before .. "<font color='" .. color .. "'>" .. keyword .. "</font>" .. after
            end)
        end
        -- 处理注释
        line = line:gsub("(%-%-[^\n]*)", function(comment)
            return "<font color='" .. commentColor .. "'>" .. comment .. "</font>"
        end)
        table.insert(lines, line)
    end

    return table.concat(lines, "\n")
end

-- 捕捉print输出
local function capturePrint(func)
    local oldPrint = print
    local output = {}
    local function newPrint(...)
        table.insert(output, table.concat({...}, " "))
    end
    _G.print = newPrint
    func()
    _G.print = oldPrint
    return table.concat(output, "\n")
end

-- 执行按钮功能
executeButton.MouseButton1Click:Connect(function()
    local code = inputBox.Text
    local highlightedCode = highlightCode(code)
    
    -- 在输入框中显示高亮后的代码
    inputBox.Text = highlightedCode
    
    -- 执行代码并捕捉print输出
    local success, message = pcall(function()
        local function executeCode()
            local f = loadstring(code)
            if f then
                f()
            else
                error("Invalid code")
            end
        end
        return capturePrint(executeCode)
    end)
    
    if success then
        outputBox.Text = message
    else
        outputBox.Text = "Error: " .. message
    end
    
    -- 显示输出台
    outputScrollingFrame.Visible = true
end)

-- 清除按钮功能
clearButton.MouseButton1Click:Connect(function()
    inputBox.Text = ""
end)

-- 开关按钮功能
toggleButton.MouseButton1Click:Connect(function()
    if outputScrollingFrame.Visible then
        outputScrollingFrame.Visible = false
        inputScrollingFrame.Visible = true
    else
        outputScrollingFrame.Visible = true
        inputScrollingFrame.Visible = false
    end
end)
