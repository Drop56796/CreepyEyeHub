local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
local v = 1

function oldwarnmessage(title, text)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end
local buttons = {
        noclip = nil
	fullbright = nil
	speed = nil
        camfov = nil,

}

local flags = {
        noclip = false
        fullbright = false
        speed = 0
        camfov = 70,
}
Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()
local GUIWindow = Library:CreateWindow({
	Name = "出生Doors v".. v,
	Themeable = false
})
local GUI = GUIWindow:CreateTab({
	Name = "主功能"
})
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

local cfullbrightbtn = window_player:AddToggle({
	Name = "Fullbright",
	Value = false,
	Callback = function(val, oldval)
		flags.fullbright = val

		if val then
			local oldAmbient = game:GetService("Lighting").Ambient
			local oldColorShift_Bottom = game:GetService("Lighting").ColorShift_Bottom
			local oldColorShift_Top = game:GetService("Lighting").ColorShift_Top

			local function doFullbright()
				if flags.fullbright == true then
					game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
					game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
					game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
				else
					game:GetService("Lighting").Ambient = oldAmbient
					game:GetService("Lighting").ColorShift_Bottom = oldColorShift_Bottom
					game:GetService("Lighting").ColorShift_Top = oldColorShift_Top
				end
			end
			doFullbright()

			local coneee = game:GetService("Lighting").LightingChanged:Connect(doFullbright)
			repeat task.wait() until NUNEZSCRIPTSLOADED == false or not flags.fullbright

			coneee:Disconnect()
			game:GetService("Lighting").Ambient = oldAmbient
			game:GetService("Lighting").ColorShift_Bottom = oldColorShift_Bottom
			game:GetService("Lighting").ColorShift_Top = oldColorShift_Top
		end
	end
})
buttons.fullbright = cfullbrightbtn

local walkspeedslider = window_player:AddSlider({
	Name = "Walkspeed",
	Value = 16,
	Min = 16,
	Max = 21.5,

	Callback = function(val, oldval)
		flags.speed = val
		if flags.walkspeedtoggle == true then
			hum.WalkSpeed = val
		end
	end
})
buttons.speed = walkspeedslider
local walkspeedtglbtn = window_player:AddToggle({
	Name = "Toggle Walkspeed",
	Value = false,
	Callback = function(val, oldval)
		flags.walkspeedtoggle = val
		if not val then
			hum.WalkSpeed = 16
		end
	end
})
buttons.walkspeedtoggle = walkspeedtglbtn
local camfovslider = window_player:AddSlider({
	Name = "FOV",
	Value = 70,
	Min = 50,
	Max = 120,

	Callback = function(val, oldval)
		flags.camfov = val
	end
})
buttons.camfov = camfovslider
local togglefovbrn = window_player:AddToggle({
	Name = "Toggle FOV",
	Value = false,
	Callback = function(val, oldval)
		flags.camfovtoggle = val
		if not val then
			waitframes(2)
			game:GetService("Workspace").CurrentCamera.FieldOfView = 70
		end
	end
})
buttons.camfovtoggle = togglefovbrn
task.spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if flags.walkspeedtoggle == true then
			if hum.WalkSpeed < flags.speed then
				hum.WalkSpeed = flags.speed
			end
		end
		if flags.camfovtoggle == true then
			if flags.tracers == false then
				pcall(function()
					game:GetService("Workspace").CurrentCamera.FieldOfView = flags.camfov
				end)
			else
				if syn or PROTOSMASHER_LOADED then
					pcall(function()
						game:GetService("Workspace").CurrentCamera.FieldOfView = flags.camfov
					end)
				end
			end
		end
	end)
end)
