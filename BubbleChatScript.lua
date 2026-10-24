local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remote = Instance.new("RemoteEvent")
remote.Name = "BubbleEvent"
remote.Parent = ReplicatedStorage

remote.OnServerEvent:Connect(function(player, message)
	if typeof(message) ~= "string" then return end
	if #message > 200 then message = message:sub(1, 200) end
	remote:FireAllClients(player, message)
end)
