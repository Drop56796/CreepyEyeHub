local UILib = {}

function UILib:CreateWindow(parent, title)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0.4, 0, 0.5, 0)
    window.Position = UDim2.new(0.3, 0, 0.25, 0)
    window.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    window.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleLabel.Text = title or "Window"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = window

    return window
end

function UILib:CreateBackground(parent, imageId)
    local background = Instance.new("ImageLabel")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.Image = imageId or "rbxassetid://12345678" -- 默认图片ID
    background.Parent = parent
    return background
end

function UILib:CreateTab(parent, tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
    tabButton.Text = tabName or "Tab"
    tabButton.Parent = parent

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0.9, 0)
    tabFrame.Position = UDim2.new(0, 0, 0.1, 0)
    tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabFrame.Visible = false
    tabFrame.Parent = parent.Parent

    tabButton.MouseButton1Click:Connect(function()
        for _, sibling in pairs(parent:GetChildren()) do
            if sibling:IsA("TextButton") then
                sibling.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
            end
        end
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
        for _, sibling in pairs(parent.Parent:GetChildren()) do
            if sibling:IsA("Frame") and sibling ~= parent then
                sibling.Visible = false
            end
        end
        tabFrame.Visible = true
    end)

    return tabFrame
end

function UILib:CreateButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 100, 0, 50)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    button.Text = text or "Button"
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

function UILib:CreateToggle(parent, text, position, size, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = size or UDim2.new(0, 100, 0, 50)
    toggle.Position = position or UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
    toggle.Text = text or "Toggle: Off"
    toggle.Parent = parent

    local toggleState = false
    toggle.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        toggle.Text = "Toggle: " .. (toggleState and "On" or "Off")
        if callback then
            callback(toggleState)
        end
    end)

    return toggle
end

function UILib:CreateTextBox(parent, placeholderText, position, size)
    local textBox = Instance.new("TextBox")
    textBox.Size = size or UDim2.new(0, 200, 0, 50)
    textBox.Position = position or UDim2.new(0, 0, 0, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
    textBox.PlaceholderText = placeholderText or "Enter text"
    textBox.Parent = parent

    return textBox
end

function UILib:CreateSlider(parent, position, size, callback)
    local slider = Instance.new("Frame")
    slider.Size = size or UDim2.new(0, 200, 0, 50)
    slider.Position = position or UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = Color3.fromRGB(255, 255, 85)
    slider.Parent = parent

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0.1, 0, 1, 0)
    sliderButton.Position = UDim2.new(0, 0, 0, 0)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    sliderButton.Text = ""
    sliderButton.Parent = slider

    local dragging = false
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    sliderButton.MouseButton1Up:Connect(function()
        dragging = false
    end)

    sliderButton.MouseMoved:Connect(function(x, y)
        if dragging then
            local relativeX = x - slider.AbsolutePosition.X
            local sliderWidth = slider.AbsoluteSize.X
            local newPosition = math.clamp(relativeX / sliderWidth, 0, 1)
            sliderButton.Position = UDim2.new(newPosition, 0, 0, 0)
            if callback then
                callback(newPosition)
            end
        end
    end)

    return slider
end

return UILib
