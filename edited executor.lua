-- 创建ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 创建主要框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- 深灰色背景
mainFrame.BorderSizePixel = 2 -- 增加边框的粗细
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- 设置边框颜色
mainFrame.Parent = screenGui
mainFrame.Draggable = true -- 使框架可拖动
mainFrame.Active = true -- 使框架可接受输入

-- 创建圆角
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15) -- 圆角半径
corner.Parent = mainFrame

-- 创建输入框
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.7, 0, 0.6, 0)
inputBox.Position = UDim2.new(0.03, 0, 0.03, 0)
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
inputBox.Parent = mainFrame

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

-- 创建输出台
local outputFrame = Instance.new("Frame")
outputFrame.Size = UDim2.new(0.7, 0, 0.3, 0) -- 输出台的大小
outputFrame.Position = UDim2.new(0.03, 0, 0.65, 0) -- 输出台位置在输入框下方
outputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 深灰色背景
outputFrame.BorderSizePixel = 0
outputFrame.Visible = false -- 初始不显示输出台
outputFrame.Parent = mainFrame

-- 创建输出台文本框
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, 0, 1, 0) -- 填满输出台框架
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
outputBox.Parent = outputFrame

-- 创建开关按钮
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.2, 0, 0.1, 0)
toggleButton.Position = UDim2.new(0.75, 0, 0.25, 0)
toggleButton.Text = "Output"
toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- 中灰色
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
toggleButton.Parent = mainFrame

-- 创建图标按钮
local iconButton = Instance.new("TextButton")
iconButton.Size = UDim2.new(0.1, 0, 0.1, 0)
iconButton.Position = UDim2.new(0.45, 0, 0.45, 0)
iconButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250) -- 蓝色背景
iconButton.Text = ""
iconButton.Visible = false
iconButton.Parent = screenGui

-- 创建圆角
local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0.5, 0) -- 完全圆形
iconCorner.Parent = iconButton

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
        oldPrint(...)
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
            local codeFunc, err = loadstring(code)
            if not codeFunc then
                error("Failed to compile code: " .. err)
            end
            local output = capturePrint(function()
                codeFunc()
            end)
            outputBox.Text = output
        end
        executeCode()
    end)

    -- 显示执行结果
    if success then
        outputBox.Text = "<font color='#32CD32'>Executed successfully</font>\n" .. outputBox.Text
    else
        outputBox.Text = "<font color='#FF6347'>Error: " .. message .. "</font>"
    end
end)

-- 清除按钮功能
clearButton.MouseButton1Click:Connect(function()
    inputBox.Text = ""
    outputBox.Text = ""
end)

-- 输出台开关功能
toggleButton.MouseButton1Click:Connect(function()
    outputFrame.Visible = not outputFrame.Visible
end)

-- 创建框架显示/隐藏开关按钮
local frameToggleButton = Instance.new("TextButton")
frameToggleButton.Size = UDim2.new(0.2, 0, 0.1, 0)
frameToggleButton.Position = UDim2.new(0.75, 0, 0.35, 0)
frameToggleButton.Text = "Toggle"
frameToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- 中灰色
frameToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
frameToggleButton.Parent = mainFrame

-- 框架显示/隐藏开关按钮功能
frameToggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    iconButton.Visible = not mainFrame.Visible
end)

-- 图标按钮点击后显示框架
iconButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    iconButton.Visible = false
end)

-- 自动补全功能
local autoCompleteWords = {"function", "local", "end", "if", "then", "else", "elseif", "for", "while", "do", "repeat", "until", "return", "true", "false", "nil"}

local function autoComplete(input)
    local text = input.Text
    local words = {}
    for word in text:gmatch("%S+") do table.insert(words, word) end
    local lastWord = words[#words]

    if lastWord then
        for _, keyword in ipairs(autoCompleteWords) do
            if keyword:sub(1, #lastWord) == lastWord then
                local startPos = input.CursorPosition - #lastWord
                input.Text = text:sub(1, startPos - 1) .. keyword .. text:sub(startPos + #lastWord)
                input.CursorPosition = startPos + #keyword
                break
            end
        end
    end
end

inputBox:GetPropertyChangedSignal("Text"):Connect(function()
    autoComplete(inputBox)
end)

-- 添加一些示例代码，用于展示print和pcall的使用
inputBox.Text = [[
-- print
print("Hello, world!")

--pcall
local function safeDivide(a, b)
    return pcall(function()
        if b == 0 then
            error("Division by zero!")
        else
            return a / b
        end
    end)
end

local success, result = safeDivide(10, 0)
if success then
    print("Result: " .. result)
else
    print("Error: " .. result)
end
]]

-- 为了在打开脚本时显示示例代码的高亮，执行一次高亮处理
inputBox.Text = highlightCode(inputBox.Text)
