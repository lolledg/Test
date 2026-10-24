-- Pega esto en la BARRA DE COMANDOS de Studio (View > Command Bar) y presiona Enter
-- Crea el chat personalizado en StarterGui y bloquea el ExperienceChat

local StarterGui = game:GetService("StarterGui")

-- Bloquear ExperienceChat
local existingChat = StarterGui:FindFirstChild("ExperienceChat")
if existingChat then
	existingChat:Destroy()
end

-- Crear ScreenGui principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExperienceChat"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 1
ScreenGui.Parent = StarterGui

-- Frame principal del chat
local ChatFrame = Instance.new("Frame")
ChatFrame.Name = "ChatFrame"
ChatFrame.Size = UDim2.new(0.28, 0, 0.32, 0)
ChatFrame.Position = UDim2.new(0, 8, 0.66, 0)
ChatFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ChatFrame.BackgroundTransparency = 0.4
ChatFrame.BorderSizePixel = 0
ChatFrame.ClipsDescendants = true
ChatFrame.Parent = ScreenGui

local ChatCorner = Instance.new("UICorner")
ChatCorner.CornerRadius = UDim.new(0, 8)
ChatCorner.Parent = ChatFrame

-- ScrollingFrame para los mensajes
local scrollView = Instance.new("ScrollingFrame")
scrollView.Name = "scrollView"
scrollView.Size = UDim2.new(1, 0, 1, -36)
scrollView.Position = UDim2.new(0, 0, 0, 0)
scrollView.BackgroundTransparency = 1
scrollView.BorderSizePixel = 0
scrollView.ScrollBarThickness = 0
scrollView.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollView.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollView.ScrollingDirection = Enum.ScrollingDirection.Y
scrollView.SelectionGroup = true
scrollView.Parent = ChatFrame

local scrollPadding = Instance.new("UIPadding")
scrollPadding.PaddingLeft = UDim.new(0, 8)
scrollPadding.PaddingRight = UDim.new(0, 8)
scrollPadding.PaddingTop = UDim.new(0, 6)
scrollPadding.PaddingBottom = UDim.new(0, 4)
scrollPadding.Parent = scrollView

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding = UDim.new(0, 2)
scrollLayout.Parent = scrollView

-- Separador entre mensajes y input
local topBorder = Instance.new("Frame")
topBorder.Name = "topBorder"
topBorder.Size = UDim2.new(1, 0, 0, 1)
topBorder.Position = UDim2.new(0, 0, 1, -37)
topBorder.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
topBorder.BackgroundTransparency = 0.5
topBorder.BorderSizePixel = 0
topBorder.Parent = ChatFrame

-- Barra inferior (input)
local InputBar = Instance.new("Frame")
InputBar.Name = "InputBar"
InputBar.Size = UDim2.new(1, 0, 0, 36)
InputBar.Position = UDim2.new(0, 0, 1, -36)
InputBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
InputBar.BackgroundTransparency = 0.2
InputBar.BorderSizePixel = 0
InputBar.Parent = ChatFrame

local inputPadding = Instance.new("UIPadding")
inputPadding.PaddingLeft = UDim.new(0, 8)
inputPadding.PaddingRight = UDim.new(0, 8)
inputPadding.PaddingTop = UDim.new(0, 4)
inputPadding.PaddingBottom = UDim.new(0, 4)
inputPadding.Parent = InputBar

-- TextBox para escribir
local TextBox = Instance.new("TextBox")
TextBox.Name = "TextBox"
TextBox.Size = UDim2.new(1, -36, 1, 0)
TextBox.Position = UDim2.new(0, 0, 0, 0)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Tap here to chat"
TextBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
TextBox.Font = Enum.Font.GothamMedium
TextBox.TextSize = 14
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextWrapped = false
TextBox.ClearTextOnFocus = false
TextBox.Text = ""
TextBox.Parent = InputBar

-- Botón de enviar
local SendButtonContainer = Instance.new("Frame")
SendButtonContainer.Name = "SendButtonContainer"
SendButtonContainer.Size = UDim2.new(0, 28, 0, 28)
SendButtonContainer.Position = UDim2.new(1, -28, 0.5, -14)
SendButtonContainer.BackgroundTransparency = 1
SendButtonContainer.Parent = InputBar

local SendButton = Instance.new("TextButton")
SendButton.Name = "SendButtonText"
SendButton.Size = UDim2.new(1, 0, 1, 0)
SendButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
SendButton.BackgroundTransparency = 0.3
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.Text = "↑"
SendButton.Font = Enum.Font.GothamBold
SendButton.TextSize = 16
SendButton.BorderSizePixel = 0
SendButton.Parent = SendButtonContainer

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 6)
sendCorner.Parent = SendButton

-- LocalScript del chat
local LocalScript = Instance.new("LocalScript")
LocalScript.Name = "ChatClient"
LocalScript.Source = [[
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local screenGui = script.Parent
local chatFrame = screenGui:WaitForChild("ChatFrame")
local scrollView = chatFrame:WaitForChild("scrollView")
local inputBar = chatFrame:WaitForChild("InputBar")
local textBox = inputBar:WaitForChild("TextBox")
local sendBtn = inputBar:WaitForChild("SendButtonContainer"):WaitForChild("SendButtonText")

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

local ChatEvent = ReplicatedStorage:WaitForChild("ChatEvent", 10)
if not ChatEvent then return end

local messageCount = 0

local function agregarMensaje(nombre, mensaje, color)
	messageCount += 1
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 0)
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14
	label.RichText = true
	label.LayoutOrder = messageCount
	label.Text = string.format(
		'<font color="rgb(%d,%d,%d)"><b>%s</b></font>: %s',
		math.floor(color.R * 255),
		math.floor(color.G * 255),
		math.floor(color.B * 255),
		nombre,
		mensaje
	)
	label.Parent = scrollView
	task.defer(function()
		scrollView.CanvasPosition = Vector2.new(0, scrollView.AbsoluteCanvasSize.Y)
	end)
end

ChatEvent.OnClientEvent:Connect(function(nombre, mensaje, color)
	agregarMensaje(nombre, mensaje, color)
end)

local function enviar()
	local texto = textBox.Text:match("^%s*(.-)%s*$")
	if texto ~= "" then
		ChatEvent:FireServer(texto)
		textBox.Text = ""
	end
end

textBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then enviar() end
end)

sendBtn.Activated:Connect(enviar)
]]
LocalScript.Parent = ScreenGui

print("✅ ChatGui creado en StarterGui correctamente")
