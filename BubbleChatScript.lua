local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chat = game:GetService("Chat")

local ChatEvent = Instance.new("RemoteEvent")
ChatEvent.Name = "ChatEvent"
ChatEvent.Parent = ReplicatedStorage

local colores = {
	Color3.fromRGB(255, 100, 100),
	Color3.fromRGB(100, 180, 255),
	Color3.fromRGB(100, 220, 120),
	Color3.fromRGB(255, 210, 80),
	Color3.fromRGB(255, 140, 50),
	Color3.fromRGB(200, 130, 255),
}

local colorJugador = {}

game.Players.ChildAdded:Connect(function(plry)
	if plry:IsA("Player") then
		colorJugador[plry.UserId] = colores[(plry.UserId % #colores) + 1]

		plry.Chatted:Connect(function(msg)
			Chat:Chat(plry.Character and plry.Character:FindFirstChild("Head"), msg, Enum.ChatColor.White)
		end)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	colorJugador[player.UserId] = nil
end)

ChatEvent.OnServerEvent:Connect(function(player, mensaje)
	if typeof(mensaje) ~= "string" then return end
	mensaje = mensaje:match("^%s*(.-)%s*$")
	if mensaje == "" or #mensaje > 200 then return end
	local color = colorJugador[player.UserId] or Color3.new(1, 1, 1)

	Chat:Chat(player.Character and player.Character:FindFirstChild("Head"), mensaje, Enum.ChatColor.White)

	ChatEvent:FireAllClients(player.DisplayName, mensaje, color)
end)
