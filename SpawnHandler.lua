local function getthesus(teamName)
	local spawnsFolder = workspace:FindFirstChild("Spawns")
	if not spawnsFolder then
		warn("Spawn Folder Not found in workspace.")
		return nil
	end

	local teamSpawns = spawnsFolder:FindFirstChild(teamName)
	local spawnParts = teamSpawns and teamSpawns:GetChildren() or spawnsFolder:GetChildren()

	local validSpawns = {}
	for _, part in ipairs(spawnParts) do
		if part:IsA("BasePart") then
			table.insert(validSpawns, part)
		end
	end

	if #validSpawns > 0 then
		local randomIndex = math.random(1, #validSpawns)
		local spawnPart = validSpawns[randomIndex]
		return spawnPart.Position
	else
		warn("No valid spawns found for team " .. teamName)
		return nil
	end
end

local function thesus(player, spawnLocation)
	if spawnLocation then
		local character = player.Character or player.CharacterAdded:Wait()
		if character then
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
			if humanoidRootPart then
				humanoidRootPart.CFrame = CFrame.new(spawnLocation)
			end
		end
	else
		warn("No valid spawn location provided.")
	end
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local team = player.Team and player.Team.Name or "Unknown"
		local spawnLocation = getthesus(team)
		thesus(player, spawnLocation)
	end)
end)
