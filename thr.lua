local v = 1.1
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Hydraulic <thirsy vampire> V" .. v, HidePremium = false, SaveConfig = true, ConfigFolder = "AdvancedHitboxConfig"})

local Tab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})

local Section = Tab:AddSection({Name = "Hitbox Controls"})

local hitboxSize = 5
local hitboxTransparency = 0.5
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitboxEnabled = false

Section:AddTextbox({
    Name = "Hitbox Size",
    Default = "5",
    TextDisappear = true,
    Callback = function(value)
        hitboxSize = tonumber(value)
    end
})

Section:AddTextbox({
    Name = "Hitbox Transparency",
    Default = "0.5",
    TextDisappear = true,
    Callback = function(value)
        hitboxTransparency = tonumber(value)
    end
})

Section:AddTextbox({
    Name = "Hitbox Color (RGB)",
    Default = "255,0,0",
    TextDisappear = true,
    Callback = function(value)
        local r, g, b = value:match("(%d+),(%d+),(%d+)")
        hitboxColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
    end
})

Section:AddToggle({
    Name = "Enable Hitbox",
    Default = false,
    Callback = function(state)
        hitboxEnabled = state
        if state then
            -- Enable hitbox expansion
            game:GetService("RunService").RenderStepped:Connect(function()
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
                        if hitbox then
                            hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                            hitbox.Transparency = hitboxTransparency
                            hitbox.Color = hitboxColor
                        end
                    end
                end
            end)
        else
            -- Disable hitbox expansion
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
                    if hitbox then
                        hitbox.Size = Vector3.new(2, 2, 1) -- Default size
                        hitbox.Transparency = 0
                        hitbox.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
    end
})

-- Infinite Yield Integration
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

Section:AddButton({
    Name = "Open Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
local remote = false

Section:AddToggle({
    Name = "Take the stick remotely.",
    Default = false,
    Callback = function(state)
        remote = state
        if state then
            -- Enable hitbox expansion
            game:GetService("RunService").RenderStepped:Connect(function()
                for _, item in ipairs(game.Workspace:GetDescendants()) do
                    if item:IsA("Model") and item.Name == "BatCollection" then
                        for _, bat in ipairs(item:GetChildren()) do
                            if bat:IsA("Model") and bat:FindFirstChild("HumanoidRootPart") then
                                local hitbox = bat:FindFirstChild("HumanoidRootPart")
                                if hitbox then
                                    hitbox.Size = Vector3.new(350, 350, 350) -- Fixed size
                                    hitbox.Transparency = 1 -- Semi-transparent
                                    hitbox.Color = Color3.fromRGB(255, 0, 0) -- Red color
                                end
                            end
                        end
                    end
                end
            end)
        else
            -- Disable hitbox expansion
            for _, item in ipairs(game.Workspace:GetDescendants()) do
                if item:IsA("Model") and item.Name == "BatCollection" then
                    for _, bat in ipairs(item:GetChildren()) do
                        if bat:IsA("Model") and bat:FindFirstChild("HumanoidRootPart") then
                            local hitbox = bat:FindFirstChild("HumanoidRootPart")
                            if hitbox then
                                hitbox.Size = Vector3.new(2, 2, 1) -- Default size
                                hitbox.Transparency = 0
                                hitbox.Color = Color3.fromRGB(255, 255, 255) -- Default color
                            end
                        end
                    end
                end
            end
        end
    end
})
