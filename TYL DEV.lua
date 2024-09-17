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

local function getFullPath(instance)
    local path = instance.Name
    local parent = instance.Parent
    while parent and parent ~= game do
        path = parent.Name .. "." .. path
        parent = parent.Parent
    end
    return path
end

local function showPathUI(path)
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
end

local function createOutline(part, color)
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Adornee = part
    selectionBox.LineThickness = 0.05
    selectionBox.SurfaceTransparency = 0.5
    selectionBox.Color3 = color
    selectionBox.Parent = part
end

local function addClickListener()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        local target = mouse.Target
        if target and (Toggles.PartToggle.Value or Toggles.ModelToggle.Value) then
            local path = getFullPath(target)
            showPathUI(path)
            createOutline(target, Color3.new(1, 0, 0)) -- 红色轮廓
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
