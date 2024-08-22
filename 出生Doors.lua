local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local v = 1.0.0

function oldwarnmessage(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end
if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
	oldwarnmessage("出生v"..v, "You need in Doors execute it script", 10) 
	return
end
local buttons = {
        noclip = nil
}

local flags = {
        noclip = false,
}
Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
local function playSound(soundId, volume, duration)
    -- 创建一个新的Sound对象
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume
    sound.PlayOnRemove = true
    sound.Parent = game:GetService("SoundService") -- 使用SoundService作为父对象

    -- 播放声音
    sound:Play()

    -- 在声音播放完毕后自动销毁
    local function onSoundEnded()
        sound:Destroy()
    end

    sound.Ended:Connect(onSoundEnded)

    -- 如果duration被设置，设置定时器以在duration之后销毁声音
    if duration then
        delay(duration, function()
            if sound.Parent then -- 确保声音对象仍然存在
                sound:Destroy()
            end
        end)
    end
end
-------------------------------------------
local RunService = game:GetService("RunService")

-- 创建 BoxHandleAdornment 实例
local function createBoxAdornment(part, color)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = part.Size
    box.AlwaysOnTop = true
    box.ZIndex = 10  -- 提高 ZIndex 确保在最上层
    box.AdornCullingMode = Enum.AdornCullingMode.Never
    box.Color3 = color
    box.Transparency = 0.5
    box.Adornee = part
    box.Parent = game.CoreGui
    return box
end

-- 创建 Highlight 实例
local function createHighlight(part, color)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0.5
    highlight.FillTransparency = 0.5
    highlight.Parent = part
    return highlight
end

-- 创建 BillboardGui 实例
local function createBillboardGui(core, color, name)
    local bill = Instance.new("BillboardGui", game.CoreGui)
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
    txt.TextStrokeTransparency = 0.5
    txt.TextSize = 18
    txt.Font = Enum.Font.Jura -- 设置字体为 Jura
    Instance.new("UIStroke", txt)

    return bill
end

function esp(what, color, core, name)
    local parts = {}
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            for _, v in ipairs(what:GetChildren()) do
                if v:IsA("BasePart") then
                    table.insert(parts, v)
                end
            end
        elseif what:IsA("BasePart") then
            table.insert(parts, what)
        end
    elseif typeof(what) == "table" then
        for _, v in ipairs(what) do
            if v:IsA("BasePart") then
                table.insert(parts, v)
            end
        end
    end

    -- 创建和管理 BoxHandleAdornment 和 Highlight 实例
    local boxes = {}
    local highlights = {}
    for _, part in ipairs(parts) do
        local box = createBoxAdornment(part, color)
        table.insert(boxes, box)
        
        local highlight = createHighlight(part, color)
        table.insert(highlights, highlight)
    end

    local bill
    if core and name then
        bill = createBillboardGui(core, color, name)
    end

    local function checkAndUpdate()
        -- 检查 BoxHandleAdornment 和 Highlight 是否需要更新
        for _, box in ipairs(boxes) do
            if not box.Adornee or not box.Adornee:IsDescendantOf(workspace) then
                box:Destroy()
            end
        end
        
        for _, highlight in ipairs(highlights) do
            if not highlight.Adornee or not highlight.Adornee:IsDescendantOf(workspace) then
                highlight:Destroy()
            end
        end

        if bill and (not bill.Adornee or not bill.Adornee:IsDescendantOf(workspace)) then
            bill:Destroy()
        end
    end

    RunService.Stepped:Connect(checkAndUpdate)

    local ret = {}

    ret.delete = function()
        for _, box in ipairs(boxes) do
            box:Destroy()
        end
        
        for _, highlight in ipairs(highlights) do
            highlight:Destroy()
        end

        if bill then
            bill:Destroy()
        end
    end

    return ret
end
local window_player = GUI:CreateSection({
	Name = "玩家"
})

task.spawn(function()
	--	repeat task.wait(1) until flags.anticheatbypass == true
	local nocliptoggle = window_player:AddToggle({
		Name = "Noclip",
		Value = false,
		Callback = function(val, oldval)
			flags.noclip = val

			if val then
				local Nocliprun =  nil
				Nocliprun = game:GetService("RunService").Stepped:Connect(function()
					if game.Players.LocalPlayer.Character ~= nil then
						for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
							if v:IsA("BasePart") then
								pcall(function()
									v.CanCollide = false
								end)
							end
						end
					end
					if flags.noclip == false then
						if Nocliprun then Nocliprun:Disconnect() end
					end
				end)
			end
		end
	})
	buttons.noclip = nocliptoggle
end)
