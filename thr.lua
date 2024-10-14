local Library = loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/UI%20Style%20theme.lua?raw=true"))()
local Options = getgenv().Linoria.Options
local Toggles = getgenv().Linoria.Toggles

local v = 1.2

local Window = Library:CreateWindow({
    Title = 'Ly X / Hydraulic v' .. v,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local MainTab = Tabs.Main

local HitboxSection = MainTab:AddLeftGroupbox("Hitbox Controls")

local hitboxSize = 5
local hitboxTransparency = 0.5
local hitboxColor = Color3.fromRGB(255, 0, 0)
local hitboxEnabled = false

HitboxSection:AddInput("HitboxSize", {
    Text = "Hitbox Size",
    Default = "5",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        hitboxSize = tonumber(value)
    end
})

HitboxSection:AddInput("HitboxTransparency", {
    Text = "Hitbox Transparency",
    Default = "0.5",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        hitboxTransparency = tonumber(value)
    end
})
HitboxSection:AddInput("HitboxColor", {
    Text = "Hitbox Color (RGB)",
    Default = "255,0,0",
    Finished = true,
    Callback = function(value)
        local r, g, b = value:match("(%d+),(%d+),(%d+)")
        hitboxColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
    end
})

HitboxSection:AddToggle("EnableHitbox", {
    Text = "Enable Hitbox",
    Default = false,
    Callback = function(state)
        hitboxEnabled = state
        if state then
            -- Enable hitbox expansion
            game:GetService("RunService").RenderStepped:Connect(function()
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if player.Team ~= game.Players.LocalPlayer.Team then
                            local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
                            if hitbox then
                                hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                hitbox.Transparency = hitboxTransparency
                                hitbox.Color = hitboxColor
                            end
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

local MyButton2 = HitboxSection:AddButton({
    Text = 'Join New Server',
    Func = function()
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local JobId = game.JobId

        -- 保存当前服务器ID
        local savedJobId = JobId

        local function teleportToServer()
            -- 检查当前服务器ID是否匹配保存的ID
            if game.JobId == savedJobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, savedJobId, game.Players.LocalPlayer)
            else
                print("No matching server found.")
            end
        end

        -- 运行传送函数
        teleportToServer()
    end,
    DoubleClick = true, -- 需要双击按钮才能触发回调
    Tooltip = 'This is the sub button (double click me!)'
})
Library:SetWatermarkVisibility(true)

local MyButton2 = HitboxSection:AddButton({
	Text = 'Infinite Yield',
	Func = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
		Library:Notify("Script success Execute", nil, 4590657391)
	end,
	DoubleClick = true, -- You will have to click this button twice to trigger the callback
	Tooltip = 'This is the sub button (double click me!)'
})


-- Example of dynamically-updating watermark with common traits (fps and ping)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local runService = game:GetService("RunService")

local hit = false
local connection

-- 定义一个函数来拉近目标玩家
local function pullPlayer(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = localPlayer.Character.HumanoidRootPart.Position + localPlayer.Character.HumanoidRootPart.CFrame.LookVector * 3
        target.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
    end
end

-- 定义一个函数来启用或禁用拉近功能
local function toggleHitbox(state)
    hit = state
    if hit then
        connection = runService.RenderStepped:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.TeamColor ~= localPlayer.TeamColor then
                    pullPlayer(player)
                end
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

-- 示例：添加一个开关来控制拉近功能
HitboxSection:AddToggle({
    Name = "Enable Attack Player",
    Default = false,
    Callback = function(state)
        toggleHitbox(state)
    end
})

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local runService = game:GetService("RunService")

local rotating = false
local connection

-- 定义一个函数来启用或禁用旋转功能
local function toggleRotation(state)
    rotating = state
    if rotating then
        connection = runService.RenderStepped:Connect(function()
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(1), 0)
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

-- 示例：添加一个开关来控制旋转功能
HitboxSection:AddToggle({
    Name = "Enable Fling",
    Default = false,
    Callback = function(state)
        toggleRotation(state)
    end
})
