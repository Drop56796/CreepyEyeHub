local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

function getDeviceType()
    if GuiService:IsTenFootInterface() then
        return "Console"
    elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        return "Mobile"
    else
        return "Desktop"
    end
end

local deviceType = getDeviceType()

if deviceType == "Mobile" then
    Notification:Notify(
        {Title = "Pressure", Description = "Not find PC Loaded not successful"},
        {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
    )
    warn("warning that script only pc")
else
    Notification:Notify(
        {Title = "Pressure", Description = "Find PC Loaded successful!"},
        {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 5, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 255, 255)}
    )
    loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/V3/A.lua"))()
end
