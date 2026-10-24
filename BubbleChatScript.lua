local StarterGui = game:GetService("StarterGui")

local existing = StarterGui:FindFirstChild("ExperienceChat")
if existing then existing:Destroy() end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExperienceChat"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = StarterGui

-- appLayout (contenedor principal, esquina inferior izquierda, igual al original)
local appLayout = Instance.new("Frame")
appLayout.Name = "appLayout"
appLayout.Size = UDim2.new(0.4, 0, 0.25, 0)
appLayout.Position = UDim2.new(0, 8, 1, -4)
appLayout.AnchorPoint = Vector2.new(0, 1)
appLayout.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
appLayout.BackgroundTransparency = 1
appLayout.BorderSizePixel = 0
appLayout.ClipsDescendants = false
appLayout.Parent = ScreenGui

local appLayoutList = Instance.new("UIListLayout")
appLayoutList.SortOrder = Enum.SortOrder.LayoutOrder
appLayoutList.FillDirection = Enum.FillDirection.Vertical
appLayoutList.VerticalAlignment = Enum.VerticalAlignment.Bottom
appLayoutList.Parent = appLayout

-- chatWindow (área de mensajes)
local chatWindow = Instance.new("Frame")
chatWindow.Name = "chatWindow"
chatWindow.Size = UDim2.new(1, 0, 1, 0)
chatWindow.Position = UDim2.new(0, 0, 0, 0)
chatWindow.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
chatWindow.BackgroundTransparency = 1
chatWindow.BorderSizePixel = 0
chatWindow.LayoutOrder = 1
chatWindow.AutomaticSize = Enum.AutomaticSize.Y
chatWindow.Parent = appLayout

-- topPadding
local topPadding = Instance.new("Frame")
topPadding.Name = "topPadding"
topPadding.Size = UDim2.new(1, 0, 0, 8)
topPadding.BackgroundTransparency = 1
topPadding.BorderSizePixel = 0
topPadding.Parent = chatWindow

-- scrollingView (contenedor del scroll)
local scrollingView = Instance.new("ImageButton")
scrollingView.Name = "scrollingView"
scrollingView.Size = UDim2.new(1, 0, 1, 0)
scrollingView.BackgroundTransparency = 1
scrollingView.BorderSizePixel = 0
scrollingView.Image = ""
scrollingView.AutoButtonColor = false
scrollingView.Parent = chatWindow

local bottomLockedScrollView = Instance.new("Frame")
bottomLockedScrollView.Name = "bottomLockedScrollView"
bottomLockedScrollView.Size = UDim2.new(1, 0, 1, 0)
bottomLockedScrollView.BackgroundTransparency = 1
bottomLockedScrollView.BorderSizePixel = 0
bottomLockedScrollView.Parent = scrollingView

-- scrollView (ScrollingFrame real)
local scrollView = Instance.new("ScrollingFrame")
scrollView.Name = "scrollView"
scrollView.Size = UDim2.new(1, 0, 1, 0)
scrollView.Position = UDim2.new(0, 0, 0, 0)
scrollView.BackgroundTransparency = 1
scrollView.BorderSizePixel = 0
scrollView.ScrollBarThickness = 0
scrollView.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollView.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollView.ScrollingDirection = Enum.ScrollingDirection.Y
scrollView.ClipsDescendants = true
scrollView.Parent = bottomLockedScrollView

local scrollPad = Instance.new("UIPadding")
scrollPad.Name = "padding"
scrollPad.PaddingLeft = UDim.new(0, 8)
scrollPad.PaddingRight = UDim.new(0, 4)
scrollPad.PaddingTop = UDim.new(0, 4)
scrollPad.PaddingBottom = UDim.new(0, 4)
scrollPad.Parent = scrollView

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.Name = "$layout"
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding = UDim.new(0, 0)
scrollLayout.Parent = scrollView

-- chatInputRow (fila del input)
local chatInputRow = Instance.new("Frame")
chatInputRow.Name = "chatInputRow"
chatInputRow.Size = UDim2.new(1, 0, 0, 0)
chatInputRow.AutomaticSize = Enum.AutomaticSize.Y
chatInputRow.BackgroundTransparency = 1
chatInputRow.BorderSizePixel = 0
chatInputRow.LayoutOrder = 2
chatInputRow.Parent = appLayout

local inputRowList = Instance.new("UIListLayout")
inputRowList.FillDirection = Enum.FillDirection.Horizontal
inputRowList.VerticalAlignment = Enum.VerticalAlignment.Center
inputRowList.SortOrder = Enum.SortOrder.LayoutOrder
inputRowList.Parent = chatInputRow

local inputRowPad = Instance.new("UIPadding")
inputRowPad.PaddingBottom = UDim.new(0, 8)
inputRowPad.Parent = chatInputRow

-- fillArea (contiene el input bar)
local fillArea = Instance.new("Frame")
fillArea.Name = "fillArea"
fillArea.Size = UDim2.new(1, -40, 0, 0)
fillArea.AutomaticSize = Enum.AutomaticSize.Y
fillArea.BackgroundTransparency = 1
fillArea.BorderSizePixel = 0
fillArea.LayoutOrder = 2
fillArea.Parent = chatInputRow

-- chatInputBar
local chatInputBar = Instance.new("Frame")
chatInputBar.Name = "chatInputBar"
chatInputBar.Size = UDim2.new(1, 0, 0, 0)
chatInputBar.AutomaticSize = Enum.AutomaticSize.Y
chatInputBar.BackgroundTransparency = 1
chatInputBar.BorderSizePixel = 0
chatInputBar.Parent = fillArea

local chatInputBarPad = Instance.new("UIPadding")
chatInputBarPad.PaddingLeft = UDim.new(0, 0)
chatInputBarPad.PaddingRight = UDim.new(0, 0)
chatInputBarPad.PaddingTop = UDim.new(0, 4)
chatInputBarPad.PaddingBottom = UDim.new(0, 4)
chatInputBarPad.Parent = chatInputBar

-- InputGroup (fondo redondeado del input, igual al chat de Roblox)
local InputGroup = Instance.new("Frame")
InputGroup.Name = "InputGroup"
InputGroup.Size = UDim2.new(1, 0, 0, 0)
InputGroup.AutomaticSize = Enum.AutomaticSize.Y
InputGroup.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
InputGroup.BackgroundTransparency = 0.12
InputGroup.BorderSizePixel = 0
InputGroup.Parent = chatInputBar

local inputGroupCorner = Instance.new("UICorner")
inputGroupCorner.CornerRadius = UDim.new(0, 8)
inputGroupCorner.Parent = InputGroup

local inputGroupStroke = Instance.new("UIStroke")
inputGroupStroke.Color = Color3.fromRGB(255, 255, 255)
inputGroupStroke.Transparency = 0.85
inputGroupStroke.Thickness = 1
inputGroupStroke.Parent = InputGroup

local inputGroupPad = Instance.new("UIPadding")
inputGroupPad.PaddingLeft = UDim.new(0, 8)
inputGroupPad.PaddingRight = UDim.new(0, 4)
inputGroupPad.PaddingTop = UDim.new(0, 6)
inputGroupPad.PaddingBottom = UDim.new(0, 6)
inputGroupPad.Parent = InputGroup

local inputGroupList = Instance.new("UIListLayout")
inputGroupList.FillDirection = Enum.FillDirection.Horizontal
inputGroupList.VerticalAlignment = Enum.VerticalAlignment.Center
inputGroupList.SortOrder = Enum.SortOrder.LayoutOrder
inputGroupList.Parent = InputGroup

-- TextContainer
local TextContainer = Instance.new("Frame")
TextContainer.Name = "TextContainer"
TextContainer.Size = UDim2.new(1, -36, 0, 0)
TextContainer.AutomaticSize = Enum.AutomaticSize.Y
TextContainer.BackgroundTransparency = 1
TextContainer.BorderSizePixel = 0
TextContainer.LayoutOrder = 1
TextContainer.Parent = InputGroup

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Name = "TextBox"
TextBox.Size = UDim2.new(1, 0, 0, 0)
TextBox.AutomaticSize = Enum.AutomaticSize.XY
TextBox.BackgroundTransparency = 1
TextBox.BorderSizePixel = 0
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Tap here to chat"
TextBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
TextBox.Font = Enum.Font.GothamMedium
TextBox.TextSize = 14
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextWrapped = false
TextBox.ClearTextOnFocus = false
TextBox.Text = ""
TextBox.MultiLine = false
TextBox.Parent = TextContainer

-- SendButtonContainer
local SendButtonContainer = Instance.new("Frame")
SendButtonContainer.Name = "SendButtonContainer"
SendButtonContainer.Size = UDim2.new(0, 36, 0, 36)
SendButtonContainer.BackgroundTransparency = 1
SendButtonContainer.BorderSizePixel = 0
SendButtonContainer.LayoutOrder = 2
SendButtonContainer.Parent = InputGroup

local sendList = Instance.new("UIListLayout")
sendList.Name = "Layout"
sendList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sendList.VerticalAlignment = Enum.VerticalAlignment.Center
sendList.Parent = SendButtonContainer

local SendButton = Instance.new("TextButton")
SendButton.Name = "SendButton"
SendButton.Size = UDim2.new(0, 32, 0, 32)
SendButton.BackgroundColor3 = Color3.fromRGB(208, 217, 251)
SendButton.BackgroundTransparency = 0.88
SendButton.TextColor3 = Color3.fromRGB(27, 42, 53)
SendButton.Text = ""
SendButton.Font = Enum.Font.GothamBold
SendButton.TextSize = 8
SendButton.BorderSizePixel = 0
SendButton.Parent = SendButtonContainer

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 6)
sendCorner.Parent = SendButton

-- Ícono de flecha en el SendButton (TextLabel con RichText)
local SendIcon = Instance.new("TextLabel")
SendIcon.Name = "Icon"
SendIcon.Size = UDim2.new(0, 16, 0, 16)
SendIcon.BackgroundTransparency = 1
SendIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
SendIcon.Text = "▶"
SendIcon.Font = Enum.Font.GothamBold
SendIcon.TextSize = 12
SendIcon.TextXAlignment = Enum.TextXAlignment.Center
SendIcon.Parent = SendButton

local sendIconList = Instance.new("UIListLayout")
sendIconList.Name = "IconLayout"
sendIconList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sendIconList.VerticalAlignment = Enum.VerticalAlignment.Center
sendIconList.Parent = SendButton

-- presetFlyOutWrapper (botón de emoji/preset a la izquierda del input, igual al original)
local presetFlyOutWrapper = Instance.new("Frame")
presetFlyOutWrapper.Name = "presetFlyOutWrapper"
presetFlyOutWrapper.Size = UDim2.new(0, 32, 0, 32)
presetFlyOutWrapper.BackgroundTransparency = 1
presetFlyOutWrapper.BorderSizePixel = 0
presetFlyOutWrapper.LayoutOrder = 1
presetFlyOutWrapper.Parent = chatInputRow

local PresetEntry = Instance.new("ImageButton")
PresetEntry.Name = "PresetEntry"
PresetEntry.Size = UDim2.new(0, 32, 0, 32)
PresetEntry.BackgroundColor3 = Color3.fromRGB(208, 217, 251)
PresetEntry.BackgroundTransparency = 0.88
PresetEntry.Image = ""
PresetEntry.BorderSizePixel = 0
PresetEntry.Parent = presetFlyOutWrapper

local presetCorner = Instance.new("UICorner")
presetCorner.CornerRadius = UDim.new(0, 8)
presetCorner.Parent = PresetEntry

local presetStroke = Instance.new("UIStroke")
presetStroke.Color = Color3.fromRGB(255, 255, 255)
presetStroke.Transparency = 0.85
presetStroke.Thickness = 1
presetStroke.Parent = PresetEntry

local presetIcon = Instance.new("TextLabel")
presetIcon.Name = "Icon"
presetIcon.Size = UDim2.new(0, 20, 0, 20)
presetIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
presetIcon.BackgroundTransparency = 1
presetIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
presetIcon.Text = "😊"
presetIcon.Font = Enum.Font.GothamMedium
presetIcon.TextSize = 14
presetIcon.Parent = PresetEntry

-- LocalScript
local LocalScript = Instance.new("LocalScript")
LocalScript.Name = "ChatClient"
LocalScript.Source = [[
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local screenGui = script.Parent

local appLayout = screenGui:WaitForChild("appLayout")
local chatWindow = appLayout:WaitForChild("chatWindow")
local scrollView = chatWindow:WaitForChild("scrollingView"):WaitForChild("bottomLockedScrollView"):WaitForChild("scrollView")
local TextBox = appLayout:WaitForChild("chatInputRow"):WaitForChild("fillArea"):WaitForChild("chatInputBar"):WaitForChild("InputGroup"):WaitForChild("TextContainer"):WaitForChild("TextBox")
local SendButton = appLayout:WaitForChild("chatInputRow"):WaitForChild("fillArea"):WaitForChild("chatInputBar"):WaitForChild("InputGroup"):WaitForChild("SendButtonContainer"):WaitForChild("SendButton")

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

local ChatEvent = ReplicatedStorage:WaitForChild("ChatEvent", 10)
if not ChatEvent then return end

local messageCount = 0

local function agregarMensaje(nombre, mensaje, color)
	messageCount += 1

	local messageFrame = Instance.new("Frame")
	messageFrame.Name = "MessageFrame"
	messageFrame.Size = UDim2.new(1, 0, 0, 0)
	messageFrame.AutomaticSize = Enum.AutomaticSize.Y
	messageFrame.BackgroundTransparency = 1
	messageFrame.BorderSizePixel = 0
	messageFrame.LayoutOrder = messageCount
	messageFrame.Parent = scrollView

	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 0)
	pad.PaddingRight = UDim.new(0, 0)
	pad.PaddingTop = UDim.new(0, 1)
	pad.PaddingBottom = UDim.new(0, 1)
	pad.Parent = messageFrame

	local TextMessage = Instance.new("Frame")
	TextMessage.Name = "TextMessage"
	TextMessage.Size = UDim2.new(1, 0, 0, 0)
	TextMessage.AutomaticSize = Enum.AutomaticSize.XY
	TextMessage.BackgroundTransparency = 1
	TextMessage.BorderSizePixel = 0
	TextMessage.Parent = messageFrame

	local msgList = Instance.new("UIListLayout")
	msgList.FillDirection = Enum.FillDirection.Horizontal
	msgList.VerticalAlignment = Enum.VerticalAlignment.Top
	msgList.SortOrder = Enum.SortOrder.LayoutOrder
	msgList.Wraps = true
	msgList.Padding = UDim.new(0, 2)
	msgList.Parent = TextMessage

	local PrefixText = Instance.new("TextLabel")
	PrefixText.Name = "PrefixText"
	PrefixText.Size = UDim2.new(0, 0, 0, 0)
	PrefixText.AutomaticSize = Enum.AutomaticSize.XY
	PrefixText.BackgroundTransparency = 1
	PrefixText.TextColor3 = Color3.new(1, 1, 1)
	PrefixText.Font = Enum.Font.GothamMedium
	PrefixText.TextSize = 14
	PrefixText.TextXAlignment = Enum.TextXAlignment.Left
	PrefixText.RichText = true
	PrefixText.LayoutOrder = 1
	PrefixText.Text = string.format(
		'<font color="rgb(%d,%d,%d)"><b>%s:</b></font>',
		math.floor(color.R * 255),
		math.floor(color.G * 255),
		math.floor(color.B * 255),
		nombre
	)
	PrefixText.Parent = TextMessage

	local BodyText = Instance.new("TextLabel")
	BodyText.Name = "BodyText"
	BodyText.Size = UDim2.new(1, 0, 0, 0)
	BodyText.AutomaticSize = Enum.AutomaticSize.XY
	BodyText.BackgroundTransparency = 1
	BodyText.TextColor3 = Color3.fromRGB(212, 212, 212)
	BodyText.Font = Enum.Font.GothamMedium
	BodyText.TextSize = 14
	BodyText.TextXAlignment = Enum.TextXAlignment.Left
	BodyText.TextWrapped = true
	BodyText.RichText = false
	BodyText.LayoutOrder = 2
	BodyText.Text = mensaje
	BodyText.Parent = TextMessage

	task.defer(function()
		scrollView.CanvasPosition = Vector2.new(0, scrollView.AbsoluteCanvasSize.Y)
	end)
end

ChatEvent.OnClientEvent:Connect(function(nombre, mensaje, color)
	agregarMensaje(nombre, mensaje, color)
end)

local function enviar()
	local texto = TextBox.Text:match("^%s*(.-)%s*$")
	if texto ~= "" then
		ChatEvent:FireServer(texto)
		TextBox.Text = ""
	end
end

TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then enviar() end
end)

SendButton.Activated:Connect(enviar)
]]
LocalScript.Parent = ScreenGui

print("ExperienceChat creado correctamente en StarterGui")
