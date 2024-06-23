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
