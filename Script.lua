loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSuffer/BasicallyAnDoors-EDITED/main/uilibs/Mobile.lua"))()


local GUIWindow = Library:CreateWindow({
    Name = "监狱人生/口渴吸血鬼",
    Themeable = false
})

local GUI = GUIWindow:CreateTab({
    Name = "主功能"
})

local window_player = GUI:CreateSection({
	Name = "玩家"
})

local camfovslider = window_player:AddSlider({
	Name = "FOV",
	Value = 70,
	Min = 50,
	Max = 120,
	Callback = function(FOV)
		game:GetService("Workspace").CurrentCamera.FieldOfView = FOV
	end
})

local PlayerWalkSpeedSlider = window_player:AddSlider({
	Name = "Speed",
	Value = 20,
	Min = 1,
	Max = 75,

	Callback = function(WalkSpeed)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
	end
})

local PlayerGravitySlier = window_player:AddSlider({
	Name = "Gravity",
	Value = 1,
	Min = 1,
	Max = 100,

	Callback = function(Gravity)
		game.Workspace.Gravity = Gravity
	end
})

local camfovslider = window_player:AddSlider({
	Name = "JunpPower",
	Value = 1,
	Min = 1,
	Max = 50,

	Callback = function(JP)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = JP
	end
})

local esphumansbtn = window_player:AddToggle({
	Name = "Player ESP",
	Value = false,
	Callback = function(val, oldval)
		flags.esphumans = val

		if val then
			local function personesp(v)
				if v:IsA("Player") then
					v.CharacterAdded:Connect(function(vc)
						local vh = vc:WaitForChild("Humanoid")
						local torso = vc:WaitForChild("UpperTorso")
						task.wait(0.1)

						local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
						table.insert(esptable.people,h) 
					end)

					if v.Character then
						local vc = v.Character
						local vh = vc:WaitForChild("Humanoid")
						local torso = vc:WaitForChild("UpperTorso")
						task.wait(0.1)

						local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
						table.insert(esptable.people,h) 
					end
				end
			end

			local addconnect
			addconnect = game.Players.PlayerAdded:Connect(function(v)
				if v ~= plr then
					personesp(v)
				end
			end)

			for i,v in pairs(game.Players:GetPlayers()) do
				if v ~= plr then
					personesp(v) 
				end
				task.wait()
			end

			if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
				personesp(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
			end

			repeat task.wait() until NUNEZSCRIPTSLOADED == false or not flags.esphumans
			addconnect:Disconnect()

			for i,v in pairs(esptable.people) do
				v.delete()
			end 
		end
	end
})
buttons.esphumans = esphumansbtn
