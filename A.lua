local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix"))()

-- Create a new window
local window = library:new({
    textsize = 15,
    font = Enum.Font.Jura,
    name = "Pressure",
    color = Color3.fromRGB(225, 255, 255)
})

-- Create a new tab
local tab = window:page({
    name = "Pressure"
})

-- Create a section in the tab
local section1 = tab:section({
    name = "Function (1)",
    side = "left",
    size = 250
})
local autoInteract = false

local function fireAllProximityPrompts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            local parentModel = descendant:FindFirstAncestorOfClass("Model")
            if parentModel and parentModel.Name ~= "MonsterLocker" and parentModel.Name ~= "Locker" then
                fireproximityprompt(descendant)
            end
        end
    end
end

local function removeSpecificObjects()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("Model") and (descendant.Name == "MonsterLocker" or descendant.Name == "Locker" or descendant.Name == "TricksterRoom") then
            descendant:Destroy()
        end
    end
end

section1:toggle({
    name = "lookaura",
    def = false,
    callback = function(state)
        autoInteract = state
        if autoInteract then
            while autoInteract do
                removeSpecificObjects()
                fireAllProximityPrompts()
                task.wait(0.25) -- Adjust the wait time as needed
            end
        end
    end
})

section1:toggle({
    name = "Money/Item esp",
    def = false,
    callback = function(state)
        if state then
            _G.nahInstances = {}
            local esptable = {nah = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorFlashBeacon()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "FlashBeacon" then
                        createBillboard(instance, "FlashBeacon", Color3.new(0, 1, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "FlashBeacon" then
                        createBillboard(instance, "FlashBeacon", Color3.new(0, 1, 0))
                    end
                end)
            end

            local function monitorCodeBreacher()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "CodeBreacher" then
                        createBillboard(instance, "CodeBreacher", Color3.new(0, 0, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "CodeBreacher" then
                        createBillboard(instance, "CodeBreacher", Color3.new(0, 0, 1))
                    end
                end)
            end

            local function monitor25Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "25Currency" then
                        createBillboard(instance, "25Currency", Color3.new(1, 1, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "25Currency" then
                        createBillboard(instance, "25Currency", Color3.new(1, 1, 0))
                    end
                end)
            end

            local function monitor50Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "50Currency" then
                        createBillboard(instance, "50Currency", Color3.new(1, 0.5, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "50Currency" then
                        createBillboard(instance, "50Currency", Color3.new(1, 0.5, 0))
                    end
                end)
            end

            local function monitor15Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "15Currency" then
                        createBillboard(instance, "15Currency", Color3.new(0.5, 0.5, 0.5))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "15Currency" then
                        createBillboard(instance, "15Currency", Color3.new(0.5, 0.5, 0.5))
                    end
                end)
            end

            local function monitor100Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "100Currency" then
                        createBillboard(instance, "100Currency", Color3.new(1, 0, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "100Currency" then
                        createBillboard(instance, "100Currency", Color3.new(1, 0, 1))
                    end
                end)
            end

            local function monitor200Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "200Currency" then
                        createBillboard(instance, "200Currency", Color3.new(0, 1, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "200Currency" then
                        createBillboard(instance, "200Currency", Color3.new(0, 1, 1))
		                end
                end)
            end

            local function monitorFlashlight()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Flashlight" then
                        createBillboard(instance, "Flashlight", Color3.new(25, 25, 25))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Flashlight" then
                        createBillboard(instance, "Flashlight", Color3.new(25, 25, 25))
                    end
                end)
	          end

	          local function monitorA()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Lantern" then
                        createBillboard(instance, "Lantern", Color3.new(99, 99, 99)) 
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Lantern" then
                        createBillboard(instance, "Lantern", Color3.new(99, 99, 99))
                    end
                end)
            end

            local function monitorB()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Blacklight" then
                        createBillboard(instance, "Blacklight", Color3.new(5, 1, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Blacklight" then
                        createBillboard(instance, "Blacklight", Color3.new(5, 1, 1))
                    end
                end)
	          end

	          local function monitorC()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Gummylight" then
                        createBillboard(instance, "Gummylight", Color3.new(5, 55, 5))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Gummylight" then
                        createBillboard(instance, "Gummylight", Color3.new(5, 55, 5))
                    end
                end)
	          end

	          local function monitorD()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "DwellerPiece" then
                        createBillboard(instance, "DwellerPiece", Color3.new(50, 10, 25))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "DwellerPiece" then 
                        createBillboard(instance, "DwellerPiece", Color3.new(50, 10, 25))
                    end
                end)
	          end

            local function monitorE()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Medkit" then
                        createBillboard(instance, "Medkit", Color3.new(80, 75, 235))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Medkit" then 
                        createBillboard(instance, "Medkit", Color3.new(80, 75, 235))
                    end
                end)
            end

            local function monitorF()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Splorglight" then
                        createBillboard(instance, "Splorglight", Color3.new(50, 100, 55))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Splorglight" then 
                        createBillboard(instance, "Splorglight", Color3.new(50, 100, 55))
                    end
                end)
	          end

	          local function monitorG()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "WindupLight" then
                        createBillboard(instance, "WindupLight", Color3.new(85, 100, 66))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "WindupLight" then 
                        createBillboard(instance, "WindupLight", Color3.new(85, 100, 66))
                    end
                end)
            end

            monitorFlashBeacon()
            monitorCodeBreacher()
            monitor25Currency()
            monitor50Currency()
            monitor15Currency()
            monitor100Currency()
            monitor200Currency()
	          monitorFlashlight()
            monitorA()
            monitorB()
	          monitorC()
	          monitorD()
	          monitorE()
	          monitorF()
	          monitorG()

            table.insert(_G.nahESPInstances, esptable)
                
        else
            if _G.nahInstances then
                for _, instance in pairs(_G.nahESPInstances) do
                    for _, v in pairs(instance.nah) do
                        v.delete()
                    end
                end
                _G.nahInstances = nil
            end
        end
    end
})
section1:toggle({
    name = "Player esp",
    def = false,
    callback = function(state)
        if state then
            _G.aespInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local aespInstance = esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.aespInstances, aespInstance)
                end
            end
        else
            if _G.aespInstances then
                for _, aespInstance in pairs(_G.aespInstances) do
                    aespInstance.delete()
                end
                _G.aespInstances = nil
            end
        end
    end
})
function esp(what, color, core, name)
    local parts
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what, table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end

    local bill
    local boxes = {}

    for i, v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = v.Size
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.AdornCullingMode = Enum.AdornCullingMode.Never
            box.Color3 = color
            box.Transparency = 0.75
            box.Adornee = v
            box.Parent = game.CoreGui

            table.insert(boxes, box)

            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end
                    task.wait()
                end
            end)
        end
    end

    if core and name then
        bill = Instance.new("BillboardGui", game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0, 100, 0, 50)
        bill.Adornee = core
        bill.MaxDistance = 2000

        local mid = Instance.new("Frame", bill)
        mid.AnchorPoint = Vector2.new(0.5, 0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0, 8, 0, 8)
        mid.Position = UDim2.new(0.5, 0, 0.5, 0)
        Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", mid)

        local txt = Instance.new("TextLabel", bill)
        txt.AnchorPoint = Vector2.new(0.5, 0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1, 0, 0, 20)
        txt.Position = UDim2.new(0.5, 0, 0.7, 0)
        txt.Text = name
        Instance.new("UIStroke", txt)

        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy()
                end
                task.wait()
            end
        end)
    end

    local ret = {}

    ret.delete = function()
        for i, v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end

        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy()
        end
    end

    return ret
end

-- Define Player ESP function
function playerEsp()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
        end
    end
end


-- Add a slider to the section
section1:slider({
    name = "Slider Example",
    def = 1,
    max = 100,
    min = 1,
    rounding = true,
    callback = function(value)
        print("Slider value is", value)
    end
})
