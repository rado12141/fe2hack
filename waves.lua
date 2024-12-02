if true then
    repeat task.wait() until game:IsLoaded()
    local _SL_SUC, ERR = pcall(function()
        local wavesVer = 2.52
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local sfb30BOK32v0 = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/refs/heads/main/bktOV03.lua'))()
        local notifs = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'))()
        local randomGen = game:GetService('HttpService'):GenerateGUID(false):gsub('-', ''):lower()
        local randomGen2 = game:GetService('HttpService'):GenerateGUID(false):gsub('-', ''):lower()

        local subs = {
            'button instatp!!!!',
            "You're banned for exploiting",
            'hacker',
            'im reporting you',
            'i took a snapshot!'
        }

        local ltitles = {
            'welcome',
            'welcome'
        }

        local part = Instance.new('Part', workspace)
        local lplr = game:GetService('Players').LocalPlayer
        local RunService = game:GetService("RunService")
        local currtween = nil
        local currbutton = nil
        local _autofarmdelay = 0
        local _autofarmavali = false
        part.Anchored = true
        part.Size = Vector3.new(500, 1, 500)
        local dvoR3BO2 = sfb30BOK32v0.eo3VO3v0('vk3Vx8', "Surrounded by this Flame")

        local clmain
        local function alert(text)
            notifs.alert(text, Color3.new(0.8, 0.498039, 2))
        end

        local olds
        olds = hookmetamethod(game, '__namecall', function(self, ...)
            local method = getnamecallmethod()
            local args = { ... }
            if tostring(self) == 'Survived' and method == 'InvokeServer' then
                args[3] = math.random(1, 95) + math.random()
                return olds(self, unpack(args))
            end
            return olds(self, ...)
        end)

        local function desync()
            local Char = lplr.Character
            if Char then
                Char.Parent = game:GetService('ReplicatedStorage')
                local RootPart = Char.HumanoidRootPart
                RootPart.CFrame = RootPart.CFrame
                RootPart.Transparency = 0
                RootPart.RootJoint.Enabled = false
                local RootClone = RootPart:Clone()
                RootClone.CFrame = RootClone.CFrame
                RootClone.Transparency = 1
                RootClone.Parent = Char
                Char.PrimaryPart = RootClone
                RootClone.RootJoint.Enabled = true
                Char.Parent = workspace
            end
        end

        local function dieUser()
            local char = lplr.Character
            if char and char:FindFirstChildOfClass('Humanoid') then
                char:FindFirstChildOfClass('Humanoid'):ChangeState(Enum.HumanoidStateType.Dead)
            end
        end

        workspace.Multiplayer.DescendantAdded:Connect(function(t)
            if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') and getgenv().waterwalk then
                t.CanCollide = true
            end
        end)

        function startfarm()
            while RunService.Heartbeat:Wait() do
                if not getgenv().gettingbuttons then
                    break
                end
                local map = workspace.Multiplayer:WaitForChild('Map')
                local hrp = lplr.Character:FindFirstChildOfClass('Humanoid').RootPart

                while not getButton() do
                    task.wait(0.05) -- Reduce wait time
                end

                if exitRegionExists(map) then
                    local successEND, errEND = pcall(function()
                        local ExitRegion = exitRegionExists(map)
                        tp(ExitRegion.CFrame, 0.2, true) -- Reduce wait during teleport
                        for _ = 1, 5 do
                            hrp.CFrame = CFrame.new(ExitRegion.Position)
                            task.wait(0.01)
                        end
                    end)

                    if not successEND then
                        dieUser() -- Immediate death execution
                        alert('FATAL ERROR: ' .. errEND)
                    end
                    break
                end
            end
        end

        function tp(cframe, speed, exr)
            local plr = lplr.Character
            local _hum = plr:FindFirstChildOfClass('Humanoid')
            if not exr then
                task.wait(0.05) -- Reduced wait
                _hum.RootPart.Anchored = true
            end
            local tween = game:GetService("TweenService")
            local TWEEN = tween:Create(_hum.RootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = CFrame.new(cframe.Position)
            })
            currtween = TWEEN
            TWEEN:Play()
            TWEEN.Completed:Wait()
            _hum.RootPart.Anchored = false
            currtween = nil
        end
    end)

    if not _SL_SUC then
        game:GetService('Players').LocalPlayer:Kick(ERR)
        task.wait(0.5) -- Reduced wait
        game:Shutdown()
    end
end
