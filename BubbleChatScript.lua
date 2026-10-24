local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

TextChatService.ChatInputBarConfiguration.Enabled = false
TextChatService.ChatWindowConfiguration.Enabled = false

local remote
if game:GetService("RunContext") == Enum.RunContext.Server then
	remote = Instance.new("RemoteEvent")
	remote.Name = "BubbleEvent"
	remote.Parent = ReplicatedStorage
else
	remote = ReplicatedStorage:WaitForChild("BubbleEvent")
end

local function createBubble(targetCharacter, playerName, message, nameColor)
	local head = targetCharacter:FindFirstChild("Head")
	if not head then return end

	local old = head:FindFirstChild("CustomChatBubble")
	if old then old:Destroy() end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CustomChatBubble"
	billboard.Size = UDim2.new(0, 240, 0, 70)
	billboard.StudsOffset = Vector3.new(0, 3.5, 0)
	billboard.AlwaysOnTop = false
	billboard.ResetOnSpawn = false
	billboard.Parent = head

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BackgroundTransparency = 0.2
	frame.BorderSizePixel = 0
	frame.Parent = billboard

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(80, 80, 80)
	stroke.Thickness = 1
	stroke.Parent = frame

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.PaddingTop = UDim.new(0, 4)
	padding.PaddingBottom = UDim.new(0, 4)
	padding.Parent = frame

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
	nameLabel.Position = UDim2.new(0, 0, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = nameColor or Color3.fromRGB(255, 180, 80)
	nameLabel.Text = playerName
	nameLabel.TextWrapped = false
	nameLabel.TextScaled = true
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextYAlignment = Enum.TextYAlignment.Center
	nameLabel.Parent = frame

	local msgLabel = Instance.new("TextLabel")
	msgLabel.Size = UDim2.new(1, 0, 0.6, 0)
	msgLabel.Position = UDim2.new(0, 0, 0.4, 0)
	msgLabel.BackgroundTransparency = 1
	msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	msgLabel.Text = message
	msgLabel.TextWrapped = true
	msgLabel.TextScaled = true
	msgLabel.Font = Enum.Font.Gotham
	msgLabel.TextXAlignment = Enum.TextXAlignment.Left
	msgLabel.TextYAlignment = Enum.TextYAlignment.Center
	msgLabel.Parent = frame

	local displayTime = math.max(2.5, #message * 0.07)
	Debris:AddItem(billboard, displayTime)
end

local nameColors = {
	Color3.fromRGB(255, 180, 80),
	Color3.fromRGB(80, 200, 255),
	Color3.fromRGB(180, 255, 80),
	Color3.fromRGB(255, 100, 180),
	Color3.fromRGB(180, 130, 255),
}

local function getNameColor(player)
	local index = (player.UserId % #nameColors) + 1
	return nameColors[index]
end

remote.OnClientEvent:Connect(function(player, message)
	local targetChar = player.Character
	if not targetChar then return end
	createBubble(targetChar, player.Name, message, getNameColor(player))
end)

local gui = script.Parent
local textBox = gui:FindFirstChildWhichIsA("TextBox", true)
local sendButton = gui:FindFirstChildWhichIsA("TextButton", true) or gui:FindFirstChildWhichIsA("ImageButton", true)

local function send()
	local msg = textBox.Text
	if not msg or msg:gsub("%s", "") == "" then return end
	if #msg > 200 then msg = msg:sub(1, 200) end
	remote:FireServer(msg)
	textBox.Text = ""
end

if sendButton then
	sendButton.MouseButton1Click:Connect(send)
end

if textBox then
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then send() end
	end)
end

localPlayer.CharacterAdded:Connect(function(newChar)
	character = newChar
end)
