local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local uiPrompt = Instance.new("TextLabel")
uiPrompt.Text = "Rush is coming"
uiPrompt.Size = UDim2.new(0, 200, 0, 50)
uiPrompt.Position = UDim2.new(0.5, -100, 0.9, -25)
uiPrompt.BackgroundTransparency = 0.5
uiPrompt.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
uiPrompt.Visible = false
uiPrompt.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local function checkRushMovingEntity()
    local found = false
    for _, entity in pairs(game.Workspace:GetDescendants()) do
        if entity.Name:lower() == "rushmoving" then  
            found = true
            break
        end
    end
    
    uiPrompt.Visible = found
end

while true do
    checkRushMovingEntity()
    wait(1)
end
