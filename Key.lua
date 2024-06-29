local ESP = {} -- Table to hold our ESP functions and data

-- Function to create a BillboardGui and BoxHandleAdornment for ESP
function ESP:CreateESP(object)
    -- Create BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP"
    billboardGui.Adornee = object
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.AlwaysOnTop = true
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = object.Name
    textLabel.TextColor3 = Color3.new(0, 1, 0) -- Green color
    textLabel.TextStrokeTransparency = 0.5

    billboardGui.Parent = object

    -- Create BoxHandleAdornment
    if object:IsA("BasePart") then
        local boxAdornment = Instance.new("BoxHandleAdornment")
        boxAdornment.Size = object.Size
        boxAdornment.Adornee = object
        boxAdornment.Color3 = Color3.fromRGB(0, 255, 0) -- Green color
        boxAdornment.AlwaysOnTop = true
        boxAdornment.ZIndex = 5
        boxAdornment.Transparency = 0.5
        boxAdornment.Parent = object
    end
end

-- Function to find KeyObtain objects and apply ESP
function ESP:ApplyToKeyObtains()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") or object:IsA("Model") then
            if object:FindFirstChild("KeyObtain") then
                self:CreateESP(object)
            end
        elseif object.Name == "KeyObtain" then
            self:CreateESP(object)
        end
    end
end

-- Apply ESP to all KeyObtains initially
ESP:ApplyToKeyObtains()

-- Connect to the DescendantAdded event to apply ESP to new KeyObtains
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") or descendant:IsA("Model") then
        if descendant:FindFirstChild("KeyObtain") then
            ESP:CreateESP(descendant)
        end
    elseif descendant.Name == "KeyObtain" then
        ESP:CreateESP(descendant)
    end
end)

return ESP
