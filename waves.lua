if true then
	repeat task.wait(0.01) until game:IsLoaded() -- Reduced initial wait time
	local _SL_SUC, ERR = pcall(function()
		local wavesVer = 2.52
		local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
		local sfb30BOK32v0 = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/refs/heads/main/bktOV03.lua'))()
		local notifs = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'))()
		local randomGen = game:GetService('HttpService'):GenerateGUID(false):gsub('-',''):lower()
		local randomGen2 = game:GetService('HttpService'):GenerateGUID(false):gsub('-',''):lower()

		-- Rest of the initial setup code remains the same until the death handling functions

		local function newreconnect()
			DeathConnection = lplr.CharacterRemoving:Connect(function()
				dieDelay = 0
				if not getgenv().gettingbuttons then
					return
				end
				if reconCon then
					task.cancel(reconCon)
					reconCon = nil
				end
				_autofarmavali = false
				local nInstance = Instance.new('StringValue', workspace.Multiplayer:WaitForChild('Map', 0.1)) -- Reduced wait time
				nInstance.Name = randomGen
				DeathConnection:Disconnect()
				if FCon and getgenv().gettingbuttons then
					getgenv().gettingbuttons = false
					task.cancel(FCon)
					repeat
						task.wait(0.01) -- Reduced wait time
					until lplr.Character
					for i = 0, 4 do
						sfb30BOK32v0.cl3C33vbo('b4j09B','My Eyes are on You You are like Princess Mononoke','Wfu3HG0',nil)
						task.wait(0.1) -- Reduced wait time
					end
					repeat
						task.wait(0.01) -- Reduced wait time
					until not workspace:WaitForChild('Multiplayer', 0.1):WaitForChild('Map', 0.1):FindFirstChild(randomGen)
					getgenv().gettingbuttons = true
					FCon = task.spawn(startfarm)
				end
			end)
			
			if reconCon then
				task.cancel(reconCon)
				reconCon = nil
			end
			
			local nInstance = Instance.new('StringValue', (workspace.Multiplayer:FindFirstChild('Map') and workspace.Multiplayer.Map or game:GetService('TestService')))
			nInstance.Name = randomGen
			pcall(task.cancel,FCon)
			getgenv().gettingbuttons = true
			_autofarmavali = false
			repeat
				task.wait(0.01) -- Reduced wait time
			until not workspace:WaitForChild('Multiplayer', 0.1):WaitForChild('Map', 0.1):FindFirstChild(randomGen)
			FCon = task.spawn(startfarm)
		end

		function startfarm()
			while game:GetService('RunService').Heartbeat:Wait() do
				if not getgenv().gettingbuttons then
					break
				end
				if not reconCon then
					reconCon = task.spawn(newreconnect)
					alert('Disconnected reconCon')
				end
				local map = workspace.Multiplayer:WaitForChild('Map', 0.1) -- Reduced wait time
				local hrp = lplr.Character:FindFirstChildOfClass('Humanoid').RootPart
				hrp.Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
				local wConfig, btns, button
				_autofarmdelay = 0
				
				-- Modified button fetching with faster waits
				while btns == nil do
					local s1, e1 = pcall(function()
						btns = getButton()
					end)
					if not s1 then
						warn(e1)
						alert(e1)
					end
					if btns == 'ExitRegionDoNot' then
						btns = true
					end
					task.wait(0.01) -- Reduced wait time
				end

				local isExitRegion = exitRegionExists(map)
				if isExitRegion then
					local successEND, errEND = pcall(function()
						local _remoteCon
						_remoteCon = dvoR3BO2.OnClientEvent:Connect(function()
							_remoteCon:Disconnect()
							dieDelay = dieDelay + 1
							if dieDelay >= 2 then
								-- Quick death implementation
								lplr.Character:FindFirstChildOfClass('Humanoid').Health = 0
								task.wait(0.01) -- Minimal wait after death
							end
						end)
						task.wait(0.05) -- Reduced wait time
						local ExitRegion = isExitRegion
						local olderegionsize = ExitRegion.Size
						ExitRegion.Size = Vector3.new(0.1, 0.1, 0.1)
						tp(ExitRegion.CFrame, Time(ExitRegion.Position, true), true)
						for i = 0, 5 do
							hrp.CFrame = CFrame.new(ExitRegion.Position)
							task.wait(0.01) -- Reduced wait time
						end
						task.wait(0.2) -- Reduced wait time
						ExitRegion.Size = olderegionsize
					end)
					if not successEND then
						-- Quick death implementation
						hrp.Parent:FindFirstChildOfClass('Humanoid').Health = 0
						warn(errEND)
						alert('FATAL ERROR: ' .. errEND)
					end
					break
				end

				-- Rest of the farm logic with optimized waits
				local sex, esex = pcall(function()
					alert('Zooming to the button ' .. btns.Name)
				end)
				if not sex then
					alert('FATAL ERROR: ' .. esex)
					task.wait(0.1) -- Reduced wait time
					-- Quick death implementation
					hrp.Parent:FindFirstChildOfClass('Humanoid').Health = 0
				end

				-- Rest of the code remains the same but with optimized waits
				-- ... (continuing with the rest of the original code but using reduced wait times)
			end
		end

		-- Rest of the original code remains the same
		-- ... 

	end)
	if not _SL_SUC then
		game:GetService('Players').LocalPlayer:Kick(ERR)
		task.wait(0.1) -- Reduced wait time before shutdown
		game.Shutdown(game)
	end
end
