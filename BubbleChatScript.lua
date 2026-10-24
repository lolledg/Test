local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Debris = game:GetService("Debris")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local gui = script.Parent
local textBox = gui:FindFirstChildWhichIsA("TextBox", true)
local sendButton = gui:FindFirstChild("SendButtonText", true)

TextChatService.ChatInputBarConfiguration.Enabled = false

local function createBubble(message)
	if not message or message:gsub("%s", "") == "" then return end
	if #message > 200 then message = message:sub(1, 200) end

	local head = character:FindFirstChild("Head")
	if not head then return end

	local old = head:FindFirstChild("CustomChatBubble")
	if old then old:Destroy() end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CustomChatBubble"
	billboard.Size = UDim2.new(0, 220, 0, 60)
	billboard.StudsOffset = Vector3.new(0, 3.5, 0)
	billboard.AlwaysOnTop = false
	billboard.ResetOnSpawn = false
	billboard.Parent = head

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 0.05
	frame.BorderSizePixel = 0
	frame.Parent = billboard

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(180, 180, 180)
	stroke.Thickness = 1
	stroke.Parent = frame

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.PaddingTop = UDim.new(0, 4)
	padding.PaddingBottom = UDim.new(0, 4)
	padding.Parent = frame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0, 0, 0)
	label.Text = message
	label.TextWrapped = true
	label.TextScaled = true
	label.Font = Enum.Font.GothamSemibold
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Parent = frame

	local displayTime = math.max(2.5, #message * 0.07)
	Debris:AddItem(billboard, displayTime)

	textBox.Text = ""
end

if sendButton then
	sendButton.MouseButton1Click:Connect(function()
		createBubble(textBox.Text)
	end)
end

if textBox then
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			createBubble(textBox.Text)
		end
	end)
end

localPlayer.CharacterAdded:Connect(function(newChar)
	character = newChar
end)
