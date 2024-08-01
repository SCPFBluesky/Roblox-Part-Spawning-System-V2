function getthesus(teamName)
	local spawnsFolder = workspace.Spawns:FindFirstChild(teamName)
	if spawnsFolder then
		local spawnParts = spawnsFolder:GetChildren()
		if #spawnParts > 0 then
			local randomIndex = math.random(1, #spawnParts)
			local spawnPart = spawnParts[randomIndex]
			if spawnPart:IsA("BasePart") then
				warn("Spawn part found: " .. spawnPart.Name)
				return spawnPart.Position
			else
				return nil
			end
		else
			warn("[V5] Critical Error! Please report to the devs OR Redsky directly ASAP! : No spawns found in folder for team " .. teamName)
			return nil
		end
	else
		warn("[V5] Critical Error! Please report to the devs OR Redsky directly ASAP! : Spawns folder for team " .. teamName .. " not found in workspace.")
		return nil
	end
end
function thesus(player, spawnLocation)
	if spawnLocation then
		local character = player.Character or player.CharacterAdded:Wait()
		if character then
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
			if humanoidRootPart then
				humanoidRootPart.CFrame = CFrame.new(spawnLocation)
			else
				error("[V5] Critical Error! Please report to the devs OR Redsky directly ASAP! : HumanoidRootPart not found for player " .. player.Name)
			end
		else
			error("[V5] Critical Error! Please report to the devs OR Redsky directly ASAP! : Character not found for player " .. player.Name)
		end
	else
		error("[V5] Critical Error! Please report to the devs OR Redsky directly ASAP! : No valid spawn location provided")
	end
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		game["Run Service"].Heartbeat:wait()
		local team = player.Team and player.Team.Name or "Unknown"
		local spawnLocation = getthesus(team)
		thesus(player, spawnLocation)
	end)
end)
