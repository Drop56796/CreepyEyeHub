local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 30

-- 创建按钮 UI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.9, -25)
button.Text = "Toggle Fly"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSans
button.TextSize = 24

local function startFlying()
    flying = true
    local bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = character.HumanoidRootPart.CFrame

    local bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    while flying do
        bodyGyro.cframe = workspace.CurrentCamera.CFrame
        local lookVector = workspace.CurrentCamera.CFrame.LookVector
        bodyVelocity.velocity = Vector3.new(lookVector.X, 0, lookVector.Z) * speed
        wait()
    end

    bodyGyro:Destroy()
    bodyVelocity:Destroy()
end

local function stopFlying()
    flying = false
end

-- 按钮点击事件
button.MouseButton1Click:Connect(function()
    if flying then
        stopFlying()
        button.Text = "Toggle Fly"
    else
        startFlying()
        button.Text = "Stop Fly"
    end
end)
