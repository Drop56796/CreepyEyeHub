local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = getgenv().Linoria.Options
local Toggles = getgenv().Linoria.Toggles

local Window = Library:CreateWindow({
    Title = 'TYL Tool',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 15,
    MenuFadeTime = 0.001
})

local Tabs = {
    Main = Window:AddTab('dev')
}

local TabBox = Tabs.Main:AddLeftTabbox()
local Tab1 = TabBox:AddTab('Part Tool')
local Tab2 = TabBox:AddTab('Model Tool')

Tab1:AddToggle('PartToggle', { Text = 'Enable Part Tool' })
Tab2:AddToggle('ModelToggle', { Text = 'Enable Model Tool' })

local monitoredObjects = {}

local function getFullPath(instance)
    local path = instance.Name
    local parent = instance.Parent
    while parent and parent ~= game do
        path = parent.Name .. "." .. path
        parent = parent.Parent
    end
    return path
end

local function showPathUI(path, instance)
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -100, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = path
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true

    local copyButton = Instance.new("TextButton", frame)
    copyButton.Size = UDim2.new(0, 100, 1, 0)
    copyButton.Position = UDim2.new(1, -100, 0, 0)
    copyButton.BackgroundTransparency = 0.5
    copyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    copyButton.Text = "Copy"
    copyButton.TextColor3 = Color3.new(1, 1, 1)
    copyButton.TextScaled = true

    copyButton.MouseButton1Click:Connect(function()
        setclipboard(path)
    end)

    monitoredObjects[instance] = { frame = frame, selectionBox = nil }
end

local function createOutline(part, color)
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Adornee = part
    selectionBox.LineThickness = 0.05
    selectionBox.SurfaceTransparency = 0.5
    selectionBox.Color3 = color
    selectionBox.Parent = part

    if monitoredObjects[part] then
        monitoredObjects[part].selectionBox = selectionBox
    end
end

local function removeUI(instance)
    if monitoredObjects[instance] then
        monitoredObjects[instance].frame:Destroy()
        if monitoredObjects[instance].selectionBox then
            monitoredObjects[instance].selectionBox:Destroy()
        end
        monitoredObjects[instance] = nil
    end
end

local function showScriptUI(scriptSource)
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Draggable = true
    frame.Active = true

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -20, 1, -20)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = scriptSource
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = false
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Font = Enum.Font.Code
end

local function checkForScripts(instance)
    for _, child in pairs(instance:GetDescendants()) do
        if child:IsA("Script") or child:IsA("LocalScript") then
            showScriptUI(child.Source)
            break
        end
    end
end

local function addClickListener()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        local target = mouse.Target
        if target and (Toggles.PartToggle.Value or Toggles.ModelToggle.Value) then
            if monitoredObjects[target] then
                removeUI(target)
            else
                local path = getFullPath(target)
                showPathUI(path, target)
                createOutline(target, Color3.new(1, 0, 0)) -- Red outline
                checkForScripts(target)
            end
        end
    end)
end

Toggles.PartToggle:OnChanged(function()
    if Toggles.PartToggle.Value then
        addClickListener()
    end
end)

Toggles.ModelToggle:OnChanged(function()
    if Toggles.ModelToggle.Value then
        addClickListener()
    end
end)

local TabBox2 = Tabs.Main:AddRightTabbox()
local Tab1 = TabBox2:AddTab('Remote Event')
Tab1:AddToggle('RemoteToggle', { Text = 'Enable Remote Tool' })

local function listenToRemoteEvents()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local remoteEvents = replicatedStorage:GetChildren()

    for _, remoteEvent in pairs(remoteEvents) do
        if remoteEvent:IsA("RemoteEvent") then
            remoteEvent.OnServerEvent:Connect(function(player, ...)
                local args = {...}
                local eventInfo = "Event: " .. remoteEvent.Name .. "\nPlayer: " .. player.Name .. "\nArguments: " .. table.concat(args, ", ")
                showEventInfoUI(eventInfo)
            end)
        end
    end
end

local function showEventInfoUI(eventInfo)
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(1, 0, 0, 100)
    frame.Position = UDim2.new(0, 0, 0, 50)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -100, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = eventInfo
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true

    local copyButton = Instance.new("TextButton", frame)
    copyButton.Size = UDim2.new(0, 100, 1, 0)
    copyButton.Position = UDim2.new(1, -100, 0, 0)
    copyButton.BackgroundTransparency = 0.5
    copyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    copyButton.Text = "Copy"
    copyButton.TextColor3 = Color3.new(1, 1, 1)
    copyButton.TextScaled = true

    copyButton.MouseButton1Click:Connect(function()
        setclipboard(eventInfo)
    end)
end

Toggles.RemoteToggle:OnChanged(function()
    if Toggles.RemoteToggle.Value then
        listenToRemoteEvents()
    end
end)

local ESPTool = Tabs.Main:AddTab('ESP Tool')
ESPTool:AddToggle('ESPToggle', { Text = 'Enable ESP Tool' })

local function createESP(instance)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = instance
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.OutlineTransparency = 0
    highlight.Parent = instance
end

local function removeESP(instance)
    for _, child in pairs(instance:GetChildren()) do
        if child:IsA("Highlight") then
            child:Destroy()
        end
    end
end

local function toggleESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            if Toggles.ESPToggle.Value then
                createESP(player.Character)
            else
                removeESP(player.Character)
            end
        end
    end
end

Toggles.ESPToggle:OnChanged(toggleESP)

local ScriptEditorTool = Tabs.Main:AddTab('Script Editor Tool')
ScriptEditorTool:AddToggle('ScriptEditorToggle', { Text = 'Enable Script Editor' })

local function createScriptEditorUI()
    local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Draggable = true
    frame.Active = true

    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(1, -20, 0.6, -20)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.BackgroundTransparency = 0.5
    textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.TextScaled = false
    textBox.TextWrapped = true
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.TextYAlignment = Enum.TextYAlignment.Top
    textBox.Font = Enum.Font.Code
    textBox.MultiLine = true
    textBox.ClearTextOnFocus = false

    local executeButton = Instance.new("TextButton", frame)
    executeButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    executeButton.Position = UDim2.new(0.35, 0, 0.7, 0)
    executeButton.BackgroundTransparency = 0.5
    executeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    executeButton.Text = "Execute"
    executeButton.TextColor3 = Color3.new(1, 1, 1)
    executeButton.TextScaled = true
    executeButton.Font = Enum.Font.SourceSansBold

    local consoleBox = Instance.new("TextBox", frame)
    consoleBox.Size = UDim2.new(1, -20, 0.2, -20)
    consoleBox.Position = UDim2.new(0, 10, 0.8, 10)
    consoleBox.BackgroundTransparency = 0.5
    consoleBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    consoleBox.TextColor3 = Color3.new(1, 1, 1)
    consoleBox.TextScaled = false
    consoleBox.TextWrapped = true
    consoleBox.TextXAlignment = Enum.TextXAlignment.Left
    consoleBox.TextYAlignment = Enum.TextYAlignment.Top
    consoleBox.Font = Enum.Font.Code
    consoleBox.MultiLine = true
    consoleBox.ClearTextOnFocus = false
    consoleBox.Text = "Console Output:\n"

    local function logMessage(message)
        consoleBox.Text = consoleBox.Text .. message .. "\n"
    end

    executeButton.MouseButton1Click:Connect(function()
        local scriptSource = textBox.Text
        local newScript = Instance.new("Script")
        newScript.Source = scriptSource
        newScript.Parent = game.Workspace
        newScript.Disabled = false

        newScript.Changed:Connect(function(property)
            if property == "Disabled" and not newScript.Disabled then
                logMessage("Script executed successfully.")
            end
        end)

        newScript.ChildAdded:Connect(function(child)
            if child:IsA("Message") or child:IsA("Hint") then
                logMessage(child.Text)
            end
        end)
    end)
end

Toggles.ScriptEditorToggle:OnChanged(function()
    if Toggles.ScriptEditorToggle.Value then
        createScriptEditorUI()
    end
end)
