local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/Ohio/UI-Lib.lua"))()

local win = lib:Window("ohio",Color3.fromRGB(1, 0.5, 0), Enum.KeyCode.RightControl)

local tab1 = win:Tab("公告")
local tab2 = win:Tab("main")

tab1:Label("本脚本为Ohio 为题")
tab1:Label("script edit by nys195")
tab1:Label("version = 1.0b")

tab2:Button("先开这个", function()
loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/Aimbot%20Pro(AI%20Create).lua?raw=true"))()
end)

-- Assuming this is part of a larger script in Roblox
tab2:Toggle("开自瞄(2)", false, function(t)
    -- 获取CoreGui中的ToggleGuiScreen对象
    local gui = game:GetService("CoreGui"):FindFirstChild("MyCustomScreenGui")
    
    -- 启动或停止自瞄功能
    if t then
        -- 如果开自瞄被启用
        if gui then
            gui.Enabled = true  -- 启用GUI
        end
        -- 这里可以添加启动自瞄功能的逻辑
    else
        -- 如果开自瞄被禁用
        if gui then
            gui.Enabled = false  -- 禁用GUI
        end
        -- 这里可以添加停止自瞄功能的逻辑
    end
end)

local a = 0
tab2:Dropdown("Dropdown", {"all look aura", "coming soon"}, function(t)
    if t == "all look aura" then
        local ProximityPromptService = game:GetService("ProximityPromptService")

        -- 当ProximityPrompt被显示时自动触发点击
        ProximityPromptService.PromptShown:Connect(function(prompt)
            if prompt.Enabled then
                prompt:Trigger() -- 直接触发点击
            end
        end)
    elseif t == "coming soon" then
        print(a)
    else
        print("未知选项")
    end
end)

tab2:Button("帧率:114514", function()
setfpscap(100000)
end)
