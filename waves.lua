if true then
    repeat task.wait() until game:IsLoaded()
    local _SL_SUC, ERR = pcall(function()
        local wavesVer = 2.52
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local sfb30BOK32v0 = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/refs/heads/main/bktOV03.lua'))()
        local notifs = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'))()
        local HttpService = game:GetService('HttpService')
        local Players = game:GetService('Players')
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local lplr = Players.LocalPlayer
        local randomGen = HttpService:GenerateGUID(false):gsub('-', ''):lower()
        local randomGen2 = HttpService:GenerateGUID(false):gsub('-', ''):lower()

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

        -- Create a large, anchored part for safespot
        local safespotPart = Instance.new('Part', workspace)
        safespotPart.Anchored = true
        safespotPart.Size = Vector3.new(500, 1, 500)
        safespotPart.Position = Vector3.new(0, -1000, 0) -- Position safespot out of view

        local dvoR3BO2 = sfb30BOK32v0.eo3VO3v0('vk3Vx8', "Surrounded by this Flame")

        local function alert(text)
            notifs.alert(text, Color3.new(0.8, 0.498039, 2))
        end

        -- Prevent RemoteFunctions from being exploited
        for _, v in ipairs(ReplicatedStorage.Remote:GetDescendants()) do
            if v:IsA('RemoteFunction') then
                v.OnClientInvoke = function()
                    wait(9e9)
                    return {}
                end
            end
        end

        -- Hook metamethods to modify certain behaviors
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

        -- Create the main window using Rayfield
        local lib = Rayfield:CreateWindow({
            Name = "WAVES V" .. wavesVer .. " [FE2: V62.82]",
            LoadingTitle = ltitles[math.random(1, #ltitles)],
            LoadingSubtitle = subs[math.random(1, #subs)],
        })

        -- Handle teleport events
        ReplicatedStorage.Remote.ClientTimelines.Teleport.OnClientEvent:Connect(function()
            if getgenv().gettingbuttons and currtween and currbutton then
                currtween:Pause()
                local _lolteleported = Instance.new('StringValue', currbutton)
                _lolteleported.Name = '_DoNotTeleportTimelines'
            end
        end)

        -- Initialize global variables
        getgenv().godmode = false
        getgenv().waterwalk = false
        getgenv().muteemotes = false
        getgenv().skipLoading = false
        getgenv().changedEmote = 0
        getgenv().walkspeed = 20
        getgenv().jumppower = 50
        getgenv().gettingbuttons = true  -- Autofarm is always enabled
        getgenv().safespot = false       -- Initialize as false; can be controlled if needed

        -- Create UI tabs
        local infoTab = lib:CreateTab("Info")
        local mainTab = lib:CreateTab("Map")
        local lpTab = lib:CreateTab("LocalPlayer")
        local miscTab = lib:CreateTab("Misc")
        local challengeTab = lib:CreateTab("Challenges")

        -- Info Tab Labels
        infoTab:CreateLabel('[⚠️/x] - where x is chance of getting anticheated')
        infoTab:CreateLabel('[✅] - Tested and safe')
        infoTab:CreateLabel("V2.5:")
        infoTab:CreateLabel('[~] Fixed the script after the security update')

        -- Utility Functions
        local function isRandomString(str)
            for i = 1, #str do
                local ltr = str:sub(i, i)
                if ltr:lower() == ltr then
                    return false
                end
            end
            return true
        end

        -- Function to retrieve all buttons
        local function getAllButtons()
            local buttons = {}
            local map = workspace.Multiplayer:FindFirstChild('Map')
            if not map then return buttons end
            for _, v in ipairs(map:GetDescendants()) do
                if (v:IsA('TouchTransmitter') and v.Parent.Name:upper() == v.Parent.Name and not v.Parent:FindFirstChild(randomGen2) and not v.Parent:FindFirstChild('_DoNotTeleportTimelines'))
                or (v:IsA('BasePart') and v.Name == 'ExitRegion') then
                    local btn = (v:IsA('TouchTransmitter') and v.Parent or 'ExitRegionDoNot')
                    table.insert(buttons, btn)
                end
            end
            return buttons
        end

        -- Function to check if all buttons have been pressed
        local function allButtonsPressed()
            local map = workspace.Multiplayer:FindFirstChild('Map')
            if not map then return false end
            for _, v in ipairs(map:GetDescendants()) do
                if v:IsA('TouchTransmitter') and v.Parent.Name:upper() == v.Parent.Name and not v.Parent:FindFirstChild(randomGen2) and not v.Parent:FindFirstChild('_DoNotTeleportTimelines') then
                    return false
                end
            end
            return true
        end

        -- Time calculation function remains unchanged
        local function Time(targetpos, skipComb)
            local Combined = lplr.Character.HumanoidRootPart.Position - targetpos
            local tme = ((Combined * Vector3.new(0.6, 0, 0.6)).Magnitude / 23)
            if skipComb then
                return tme
            end
            if tme - _autofarmdelay <= 0 then
                return 'Teleport'
            end
            return tme - _autofarmdelay
        end

        -- Function to check if ExitRegion exists in the map
        local function exitRegionExists(map)
            local exitReg
            for _, v in ipairs(map:GetChildren()) do
                if v.Name == 'ExitRegion' and v:IsA('BasePart') then
                    exitReg = v
                    break
                end
            end
            if not exitReg then
                for _, v in ipairs(map:GetDescendants()) do
                    if v.Name == 'ExitRegion' and v:IsA('BasePart') then
                        exitReg = v
                        break
                    end
                end
            end
            if exitReg then
                if exitReg:IsA('Model') then
                    return exitReg.PrimaryPart
                elseif exitReg:IsA('BasePart') then
                    return exitReg
                end
            end
            return false
        end

        -- Function to handle player character
        local function handler()
            local char = lplr.Character
            if not char then return end
            char:WaitForChild('Humanoid')
            local humanoid = char.Humanoid
            humanoid:GetPropertyChangedSignal('Health'):Connect(function()
                if getgenv().godmode then
                    humanoid.MaxHealth = 99999
                    humanoid.Health = 99999
                end
            end)
            if getgenv().changedEmote ~= 0 and getsenv then
                local script = getsenv(char.Animate)
                if script and script.changeEmote then
                    script.changeEmote(getgenv().changedEmote)
                end
            end
        end

        handler()

        -- Update character properties upon respawn
        lplr.CharacterAdded:Connect(function(char)
            handler()
            task.wait(5)
            local humanoid = char:WaitForChild('Humanoid')
            humanoid.WalkSpeed = getgenv().walkspeed
            humanoid.JumpPower = getgenv().jumppower
            humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(function()
                if humanoid.WalkSpeed < getgenv().walkspeed then
                    humanoid.WalkSpeed = getgenv().walkspeed
                end
            end)
            humanoid:GetPropertyChangedSignal('JumpPower'):Connect(function()
                if humanoid.JumpPower < getgenv().jumppower then
                    humanoid.JumpPower = getgenv().jumppower
                end
            end)
        end)

        -- Define the _autoget function
        function _autoget()
            task.spawn(function()
                while task.wait(3) and getgenv().misc do
                    if not getgenv().misc then
                        break
                    end
                    local _map = workspace.Multiplayer:WaitForChild('Map')
                    for _, v in ipairs(_map:GetDescendants()) do
                        if string.match(string.lower(v.Name), 'lost') and v:IsA('BasePart') then
                            v.CFrame = CFrame.new(lplr.Character.HumanoidRootPart.Position)
                        elseif string.match(string.lower(v.Name), 'rescue') and v:FindFirstChild('Contact') then
                            v.Contact.CFrame = CFrame.new(lplr.Character.HumanoidRootPart.Position)
                        end
                    end
                end
            end)
        end

        -- Function to handle character removal and reconnection
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
                local nInstance = Instance.new('StringValue', workspace.Multiplayer:WaitForChild('Map'))
                nInstance.Name = randomGen
                DeathConnection:Disconnect()
                if FCon and getgenv().gettingbuttons then
                    getgenv().gettingbuttons = false
                    task.cancel(FCon)
                    repeat
                        task.wait()
                    until lplr.Character
                    for i = 0, 4 do
                        sfb30BOK32v0.cl3C33vbo('b4j09B','My Eyes are on You You are like Princess Mononoke','Wfu3HG0',nil)
                        task.wait(1)
                    end
                    repeat
                        task.wait()
                    until not workspace:WaitForChild('Multiplayer'):WaitForChild('Map'):FindFirstChild(randomGen)
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
            pcall(task.cancel, FCon)
            getgenv().gettingbuttons = true
            _autofarmavali = false
            repeat
                task.wait()
            until not workspace:WaitForChild('Multiplayer'):WaitForChild('Map'):FindFirstChild(randomGen)
            FCon = task.spawn(startfarm)
        end

        -- Define the startfarm function
        function startfarm()
            alert("Autofarm process started.")
            local map = workspace.Multiplayer:WaitForChild('Map')
            local buttons = getAllButtons()
            if #buttons == 0 then
                alert("No buttons found to press.")
                return
            end
            for _, btn in ipairs(buttons) do
                if btn ~= 'ExitRegionDoNot' then
                    local humanoid = lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        local hrp = humanoid.RootPart
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

                        -- Handle waves.config
                        local wConfig = map:FindFirstChild('waves.config') or Instance.new('Folder', map)
                        if wConfig.Name ~= 'waves.config' then
                            wConfig.Name = 'waves.config'
                        end
                        local instaPress = wConfig:FindFirstChild('InstaPress') or Instance.new('BoolValue', wConfig)
                        if instaPress.Name ~= 'InstaPress' then
                            instaPress.Name = 'InstaPress'
                        end
                        if not instaPress.Value then
                            instaPress.Value = true
                            hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                            local pdata_lol = Instance.new('BindableFunction', btn)
                            pdata_lol.Name = randomGen2
                        end

                        -- Teleport to the button
                        hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                        alert("Pressing button: " .. (btn.Name or "Unknown"))

                        -- Mark the button as pressed
                        local pdata_lol = Instance.new('BindableFunction', btn)
                        pdata_lol.Name = randomGen2

                        -- Brief wait to ensure the button is pressed
                        task.wait(0.05)
                    else
                        alert("Humanoid not found for pressing button.")
                    end
                end
            end

            -- After pressing all buttons, kill the character immediately
            alert("All buttons pressed! Initiating automatic death and teleport to lift.")
            if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                lplr.Character.Humanoid.Health = 0 -- Immediate kill
            end

            -- Wait for character to respawn and teleport to lift
            lplr.CharacterAdded:Wait()
            local newChar = lplr.Character
            newChar:WaitForChild('HumanoidRootPart')
            
            -- Teleport to Lift
            -- Replace 'Lift' with the actual name of the lift object in your game
            local lift = workspace.Multiplayer:FindFirstChild('Lift')
            if lift and lift:IsA('BasePart') then
                newChar.HumanoidRootPart.CFrame = CFrame.new(lift.Position + Vector3.new(0, 5, 0))
                alert('Teleported to lift to proceed to the next map.')
            else
                alert('Lift not found! Please ensure the lift exists in the workspace.')
            end
        end

        -- Autofarm Toggle - modified to call 'startfarm' once when toggled on
        mainTab:CreateToggle({
            Name = "Autofarm [✅, EXEC IN THE MAP]",
            CurrentValue = false,
            Callback = function(getbtns)
                getgenv().gettingbuttons = getbtns
                if getbtns then
                    FCon = task.spawn(startfarm)
                else
                    if FCon then
                        task.cancel(FCon)
                        FCon = nil
                        alert("Autofarm stopped.")
                    end
                end
            end,
        })

        -- AutoTP to ExitRegion Toggle
        mainTab:CreateToggle({
            Name = 'AutoTP to ExitRegion [⚠️/very low]',
            CurrentValue = false,
            Callback = function(tper)
                getgenv().tptoexit = tper
                if tper then
                    FConTPExit = task.spawn(function()
                        while task.wait(2) and getgenv().tptoexit do
                            if not getgenv().tptoexit then
                                break
                            end
                            local map = workspace.Multiplayer:WaitForChild('Map')
                            for _, v in ipairs(map:GetDescendants()) do
                                if v.Name == 'ExitRegion' then
                                    tp(v.CFrame, 4.5)
                                    task.wait(4.5)
                                end
                            end
                        end
                    end)
                else
                    if FConTPExit then
                        task.cancel(FConTPExit)
                        FConTPExit = nil
                        alert("AutoTP to ExitRegion disabled.")
                    end
                end
            end,
        })

        -- Auto Get Lost Pages/Escapees Toggle
        mainTab:CreateToggle({
            Name = 'Auto Get Lost Pages/Escapees [✅]',
            CurrentValue = false,
            Callback = function(gr)
                getgenv().misc = gr
                if gr then
                    _autoget()
                    alert("Auto Get Lost Pages/Escapees enabled.")
                else
                    alert("Auto Get Lost Pages/Escapees disabled.")
                end
            end,
        })

        -- Skip Loading Toggle
        mainTab:CreateToggle({
            Name = 'Skip Loading [✅]',
            CurrentValue = false,
            Callback = function(value)
                getgenv().skipLoading = value
                if value then
                    alert("Skip Loading enabled.")
                else
                    alert("Skip Loading disabled.")
                end
            end,
        })

        -- Water Walk Toggle
        mainTab:CreateToggle({
            Name = 'Water Walk [✅]',
            CurrentValue = false,
            Callback = function(wwalk)
                getgenv().waterwalk = wwalk
                if wwalk then
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = true
                        end
                    end
                    alert("Water Walk enabled.")
                else
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = false
                        end
                    end
                    alert("Water Walk disabled.")
                end
            end
        })

        -- Auto Safespot Toggle
        mainTab:CreateToggle({
            Name = 'Auto Safespot [✅]',
            CurrentValue = false,
            Callback = function(Value)
                getgenv().safespot = Value
                if Value then
                    task.spawn(function()
                        while task.wait(5) and getgenv().safespot do
                            if not getgenv().safespot then
                                break
                            end
                            if (lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart') and 
                                (lplr.Character.HumanoidRootPart.Position - safespotPart.Position).Magnitude > 250) then
                                sfb30BOK32v0.cl3C33vbo('b4j09B', 'My Eyes are on You You are like Princess Mononoke', 'Wfu3HG0', nil)
                                lplr.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(safespotPart.Position + Vector3.new(0, 5, 0))
                            end
                        end
                    end)
                    alert("Auto Safespot enabled.")
                else
                    alert("Auto Safespot disabled.")
                end
            end,
        })

        -- LocalPlayer Tab Toggles and Sliders

        -- GodMode Toggle
        lpTab:CreateToggle({
            Name = 'GodMode [✅]',
            CurrentValue = false,
            Callback = function(gm)
                getgenv().godmode = gm
                handler()
                if gm then
                    alert("GodMode Enabled.")
                else
                    alert("GodMode Disabled.")
                end
            end,
        })

        -- WalkSpeed Slider
        lpTab:CreateSlider({
            Name = "WalkSpeed [✅]",
            Range = {
                20,
                31,
            },
            Increment = 1,
            CurrentValue = 20,
            Callback = function(ws)
                getgenv().walkspeed = ws
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = getgenv().walkspeed
                    alert("WalkSpeed set to " .. ws)
                end
            end,
        })

        -- JumpPower Slider
        lpTab:CreateSlider({
            Name = "JumpPower [✅]",
            Range = {
                50,
                100
            },
            Increment = 1,
            CurrentValue = 50,
            Callback = function(jp)
                getgenv().jumppower = jp
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').JumpPower = getgenv().jumppower
                    alert("JumpPower set to " .. jp)
                end
            end,
        })

        -- Misc Tab Toggles and Buttons

        -- Autofarm Optimization Toggle
        miscTab:CreateToggle({
            Name = 'Autofarm Optimization [✅, BE IN THE LIFT]',
            CurrentValue = false,
            Callback = function(ao)
                getgenv().gOpti = ao
                if ao then
                    alert("Autofarm Optimization Enabled.")
                else
                    alert("Autofarm Optimization Disabled.")
                end
            end
        })

        -- VIP Emote Bypass Button
        miscTab:CreateButton({
            Name = 'VIP Emote Bypass [✅]',
            Callback = function()
                local function Change(Character)
                    local script = getsenv and getsenv(Character.Animate)
                    if script and script.changeEmote then
                        script.changeEmote(1584520816)
                    end
                end
                Change(lplr.Character)
                lplr.CharacterAdded:Connect(function(Character)
                    task.wait(1)
                    Change(Character)
                end)
                alert("VIP Emote Bypass Activated.")
            end
        })

        -- Don't Save Session Data Button
        miscTab:CreateButton({
            Name = "Don't Save Session Data [✅]",
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','My Veins are Tense as if I am on the Edge of Death','Wfu3HG0','RUNSLIDE','\255','Controls',nil,'Gamepad')
                alert("✅ After you server hop, you'll have the same stats as of now [Currency, XP, Level]")
            end
        })

        -- Challenges Tab Buttons

        -- Regenerate Air Button
        challengeTab:CreateButton({
            Name = 'Regenerate Air',
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','Kiss of Heated Steel Soul Burning with Cold','Wfu3HG0',5000)
                alert("Regenerate Air Activated.")
            end
        })

        -- Slide Under Barriers Button
        challengeTab:CreateButton({
            Name = 'Slide Under Barriers',
            Callback = function()
                local map = workspace.Multiplayer:FindFirstChild('Map')
                if map then
                    for _, v in ipairs(map:GetDescendants()) do
                        if v.Name == 'SlideBeam' and v:IsA('BasePart') then
                            sfb30BOK32v0.cl3C33vbo('b4j09B','Blood Traces Desolator Minamoto Clan of Elders','Wfu3HG0',v.Position - Vector3.new(1, 1, 0), v.Position + Vector3.new(0, -1, 1))
                        end
                    end
                    alert("Slide Under Barriers Activated.")
                else
                    alert("Map not found!")
                end
            end
        })

        -- Function to teleport the character
        function tp(cframe, speed, exr)
            local plr = lplr.Character
            if not plr or not plr:FindFirstChildOfClass('Humanoid') or not plr:FindFirstChild('HumanoidRootPart') then return end
            local _hum = plr:FindFirstChildOfClass('Humanoid')
            if not exr then
                _hum.RootPart.Anchored = true
            end
            local tween = TweenService
            local TWEEN = tween:Create(_hum.RootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = CFrame.new(cframe.Position)
            })
            currtween = TWEEN
            TWEEN:Play()
            local finished = false
            local connect
            connect = TWEEN.Completed:Connect(function()
                _hum.RootPart.Anchored = false
                connect:Disconnect()
                finished = true
            end)
            repeat
                _hum.RootPart.Velocity = Vector3.zero
                _hum.RootPart.RotVelocity = Vector3.zero
                RunService.Heartbeat:Wait()
            until finished or (currbutton and currbutton:FindFirstChild('_DoNotTeleportTimelines'))
            _hum.RootPart.Anchored = false
            currtween = nil
        end

        -- Function to press all buttons and handle Autofarm completion
        local function pressAllButtons()
            local map = workspace.Multiplayer:FindFirstChild('Map')
            if not map then
                alert("Map not found!")
                return
            end
            local buttons = getAllButtons()
            if #buttons == 0 then
                alert("No buttons found to press.")
                return
            end
            for _, btn in ipairs(buttons) do
                if btn ~= 'ExitRegionDoNot' then
                    local humanoid = lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        local hrp = humanoid.RootPart
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

                        -- Handle waves.config
                        local wConfig = map:FindFirstChild('waves.config') or Instance.new('Folder', map)
                        if wConfig.Name ~= 'waves.config' then
                            wConfig.Name = 'waves.config'
                        end
                        local instaPress = wConfig:FindFirstChild('InstaPress') or Instance.new('BoolValue', wConfig)
                        if instaPress.Name ~= 'InstaPress' then
                            instaPress.Name = 'InstaPress'
                        end
                        if not instaPress.Value then
                            instaPress.Value = true
                            hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                            local pdata_lol = Instance.new('BindableFunction', btn)
                            pdata_lol.Name = randomGen2
                        end

                        -- Teleport to the button
                        hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                        alert("Pressing button: " .. (btn.Name or "Unknown"))

                        -- Mark the button as pressed
                        local pdata_lol = Instance.new('BindableFunction', btn)
                        pdata_lol.Name = randomGen2

                        -- Brief wait to ensure the button is pressed
                        task.wait(0.05)
                    else
                        alert("Humanoid not found for pressing button.")
                    end
                end
            end

            -- After pressing all buttons, kill the character immediately
            alert("All buttons pressed! Initiating automatic death and teleport to lift.")
            if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                lplr.Character.Humanoid.Health = 0 -- Immediate kill
            end

            -- Wait for character to respawn and teleport to lift
            lplr.CharacterAdded:Wait()
            local newChar = lplr.Character
            newChar:WaitForChild('HumanoidRootPart')
            
            -- Teleport to Lift
            -- Replace 'Lift' with the actual name of the lift object in your game
            local lift = workspace.Multiplayer:FindFirstChild('Lift')
            if lift and lift:IsA('BasePart') then
                newChar.HumanoidRootPart.CFrame = CFrame.new(lift.Position + Vector3.new(0, 5, 0))
                alert('Teleported to lift to proceed to the next map.')
            else
                alert('Lift not found! Please ensure the lift exists in the workspace.')
            end
        end

        -- Autofarm Toggle - modified to call 'pressAllButtons' once when toggled on
        mainTab:CreateToggle({
            Name = "Autofarm [✅, EXEC IN THE MAP]",
            CurrentValue = false,
            Callback = function(getbtns)
                getgenv().gettingbuttons = getbtns
                if getbtns then
                    FCon = task.spawn(pressAllButtons)
                else
                    if FCon then
                        task.cancel(FCon)
                        FCon = nil
                        alert("Autofarm stopped.")
                    end
                end
            end,
        })

        -- Auto Get Lost Pages/Escapees Toggle
        mainTab:CreateToggle({
            Name = 'Auto Get Lost Pages/Escapees [✅]',
            CurrentValue = false,
            Callback = function(gr)
                getgenv().misc = gr
                if gr then
                    _autoget()
                    alert("Auto Get Lost Pages/Escapees enabled.")
                else
                    alert("Auto Get Lost Pages/Escapees disabled.")
                end
            end,
        })

        -- Skip Loading Toggle
        mainTab:CreateToggle({
            Name = 'Skip Loading [✅]',
            CurrentValue = false,
            Callback = function(value)
                getgenv().skipLoading = value
                if value then
                    alert("Skip Loading enabled.")
                else
                    alert("Skip Loading disabled.")
                end
            end,
        })

        -- AutoTP to ExitRegion Toggle
        mainTab:CreateToggle({
            Name = 'AutoTP to ExitRegion [⚠️/very low]',
            CurrentValue = false,
            Callback = function(tper)
                getgenv().tptoexit = tper
                if tper then
                    FConTPExit = task.spawn(function()
                        while task.wait(2) and getgenv().tptoexit do
                            if not getgenv().tptoexit then
                                break
                            end
                            local map = workspace.Multiplayer:WaitForChild('Map')
                            for _, v in ipairs(map:GetDescendants()) do
                                if v.Name == 'ExitRegion' then
                                    tp(v.CFrame, 4.5)
                                    task.wait(4.5)
                                end
                            end
                        end
                    end)
                    alert("AutoTP to ExitRegion enabled.")
                else
                    if FConTPExit then
                        task.cancel(FConTPExit)
                        FConTPExit = nil
                        alert("AutoTP to ExitRegion disabled.")
                    end
                end
            end,
        })

        -- Water Walk Toggle
        mainTab:CreateToggle({
            Name = 'Water Walk [✅]',
            CurrentValue = false,
            Callback = function(wwalk)
                getgenv().waterwalk = wwalk
                if wwalk then
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = true
                        end
                    end
                    alert("Water Walk enabled.")
                else
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = false
                        end
                    end
                    alert("Water Walk disabled.")
                end
            end
        })

        -- Auto Safespot Toggle
        mainTab:CreateToggle({
            Name = 'Auto Safespot [✅]',
            CurrentValue = false,
            Callback = function(Value)
                getgenv().safespot = Value
                if Value then
                    task.spawn(function()
                        while task.wait(5) and getgenv().safespot do
                            if not getgenv().safespot then
                                break
                            end
                            if (lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart') and 
                                (lplr.Character.HumanoidRootPart.Position - safespotPart.Position).Magnitude > 250) then
                                sfb30BOK32v0.cl3C33vbo('b4j09B', 'My Eyes are on You You are like Princess Mononoke', 'Wfu3HG0', nil)
                                lplr.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(safespotPart.Position + Vector3.new(0, 5, 0))
                            end
                        end
                    end)
                    alert("Auto Safespot enabled.")
                else
                    alert("Auto Safespot disabled.")
                end
            end,
        })

        -- LocalPlayer Tab Toggles and Sliders

        -- GodMode Toggle
        lpTab:CreateToggle({
            Name = 'GodMode [✅]',
            CurrentValue = false,
            Callback = function(gm)
                getgenv().godmode = gm
                handler()
                if gm then
                    alert("GodMode Enabled.")
                else
                    alert("GodMode Disabled.")
                end
            end,
        })

        -- WalkSpeed Slider
        lpTab:CreateSlider({
            Name = "WalkSpeed [✅]",
            Range = {
                20,
                31,
            },
            Increment = 1,
            CurrentValue = 20,
            Callback = function(ws)
                getgenv().walkspeed = ws
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = getgenv().walkspeed
                    alert("WalkSpeed set to " .. ws)
                end
            end,
        })

        -- JumpPower Slider
        lpTab:CreateSlider({
            Name = "JumpPower [✅]",
            Range = {
                50,
                100
            },
            Increment = 1,
            CurrentValue = 50,
            Callback = function(jp)
                getgenv().jumppower = jp
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').JumpPower = getgenv().jumppower
                    alert("JumpPower set to " .. jp)
                end
            end,
        })

        -- Misc Tab Toggles and Buttons

        -- Autofarm Optimization Toggle
        miscTab:CreateToggle({
            Name = 'Autofarm Optimization [✅, BE IN THE LIFT]',
            CurrentValue = false,
            Callback = function(ao)
                getgenv().gOpti = ao
                if ao then
                    alert("Autofarm Optimization Enabled.")
                else
                    alert("Autofarm Optimization Disabled.")
                end
            end
        })

        -- VIP Emote Bypass Button
        miscTab:CreateButton({
            Name = 'VIP Emote Bypass [✅]',
            Callback = function()
                local function Change(Character)
                    local script = getsenv and getsenv(Character.Animate)
                    if script and script.changeEmote then
                        script.changeEmote(1584520816)
                    end
                end
                Change(lplr.Character)
                lplr.CharacterAdded:Connect(function(Character)
                    task.wait(1)
                    Change(Character)
                end)
                alert("VIP Emote Bypass Activated.")
            end
        })

        -- Don't Save Session Data Button
        miscTab:CreateButton({
            Name = "Don't Save Session Data [✅]",
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','My Veins are Tense as if I am on the Edge of Death','Wfu3HG0','RUNSLIDE','\255','Controls',nil,'Gamepad')
                alert("✅ After you server hop, you'll have the same stats as of now [Currency, XP, Level]")
            end
        })

        -- Challenges Tab Buttons

        -- Regenerate Air Button
        challengeTab:CreateButton({
            Name = 'Regenerate Air',
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','Kiss of Heated Steel Soul Burning with Cold','Wfu3HG0',5000)
                alert("Regenerate Air Activated.")
            end
        })

        -- Slide Under Barriers Button
        challengeTab:CreateButton({
            Name = 'Slide Under Barriers',
            Callback = function()
                local map = workspace.Multiplayer:FindFirstChild('Map')
                if map then
                    for _, v in ipairs(map:GetDescendants()) do
                        if v.Name == 'SlideBeam' and v:IsA('BasePart') then
                            sfb30BOK32v0.cl3C33vbo('b4j09B','Blood Traces Desolator Minamoto Clan of Elders','Wfu3HG0',v.Position - Vector3.new(1, 1, 0), v.Position + Vector3.new(0, -1, 1))
                        end
                    end
                    alert("Slide Under Barriers Activated.")
                else
                    alert("Map not found!")
                end
            end
        })

        -- Function to teleport the character
        function tp(cframe, speed, exr)
            local plr = lplr.Character
            if not plr or not plr:FindFirstChildOfClass('Humanoid') or not plr:FindFirstChild('HumanoidRootPart') then return end
            local _hum = plr:FindFirstChildOfClass('Humanoid')
            if not exr then
                _hum.RootPart.Anchored = true
            end
            local tween = TweenService
            local TWEEN = tween:Create(_hum.RootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = CFrame.new(cframe.Position)
            })
            currtween = TWEEN
            TWEEN:Play()
            local finished = false
            local connect
            connect = TWEEN.Completed:Connect(function()
                _hum.RootPart.Anchored = false
                connect:Disconnect()
                finished = true
            end)
            repeat
                _hum.RootPart.Velocity = Vector3.zero
                _hum.RootPart.RotVelocity = Vector3.zero
                RunService.Heartbeat:Wait()
            until finished or (currbutton and currbutton:FindFirstChild('_DoNotTeleportTimelines'))
            _hum.RootPart.Anchored = false
            currtween = nil
        end

        -- Function to press all buttons and handle Autofarm completion
        local function pressAllButtons()
            local map = workspace.Multiplayer:FindFirstChild('Map')
            if not map then
                alert("Map not found!")
                return
            end
            local buttons = getAllButtons()
            if #buttons == 0 then
                alert("No buttons found to press.")
                return
            end
            for _, btn in ipairs(buttons) do
                if btn ~= 'ExitRegionDoNot' then
                    local humanoid = lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        local hrp = humanoid.RootPart
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

                        -- Handle waves.config
                        local wConfig = map:FindFirstChild('waves.config') or Instance.new('Folder', map)
                        if wConfig.Name ~= 'waves.config' then
                            wConfig.Name = 'waves.config'
                        end
                        local instaPress = wConfig:FindFirstChild('InstaPress') or Instance.new('BoolValue', wConfig)
                        if instaPress.Name ~= 'InstaPress' then
                            instaPress.Name = 'InstaPress'
                        end
                        if not instaPress.Value then
                            instaPress.Value = true
                            hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                            local pdata_lol = Instance.new('BindableFunction', btn)
                            pdata_lol.Name = randomGen2
                        end

                        -- Teleport to the button
                        hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                        alert("Pressing button: " .. (btn.Name or "Unknown"))

                        -- Mark the button as pressed
                        local pdata_lol = Instance.new('BindableFunction', btn)
                        pdata_lol.Name = randomGen2

                        -- Brief wait to ensure the button is pressed
                        task.wait(0.05)
                    else
                        alert("Humanoid not found for pressing button.")
                    end
                end
            end

            -- After pressing all buttons, kill the character immediately
            alert("All buttons pressed! Initiating automatic death and teleport to lift.")
            if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                lplr.Character.Humanoid.Health = 0 -- Immediate kill
            end

            -- Wait for character to respawn and teleport to lift
            lplr.CharacterAdded:Wait()
            local newChar = lplr.Character
            newChar:WaitForChild('HumanoidRootPart')
            
            -- Teleport to Lift
            -- Replace 'Lift' with the actual name of the lift object in your game
            local lift = workspace.Multiplayer:FindFirstChild('Lift')
            if lift and lift:IsA('BasePart') then
                newChar.HumanoidRootPart.CFrame = CFrame.new(lift.Position + Vector3.new(0, 5, 0))
                alert('Teleported to lift to proceed to the next map.')
            else
                alert('Lift not found! Please ensure the lift exists in the workspace.')
            end
        end

        -- Autofarm Toggle - modified to call 'pressAllButtons' once when toggled on
        mainTab:CreateToggle({
            Name = "Autofarm [✅, EXEC IN THE MAP]",
            CurrentValue = false,
            Callback = function(getbtns)
                getgenv().gettingbuttons = getbtns
                if getbtns then
                    FCon = task.spawn(pressAllButtons)
                else
                    if FCon then
                        task.cancel(FCon)
                        FCon = nil
                        alert("Autofarm stopped.")
                    end
                end
            end,
        })

        -- Auto Get Lost Pages/Escapees Toggle
        mainTab:CreateToggle({
            Name = 'Auto Get Lost Pages/Escapees [✅]',
            CurrentValue = false,
            Callback = function(gr)
                getgenv().misc = gr
                if gr then
                    _autoget()
                    alert("Auto Get Lost Pages/Escapees enabled.")
                else
                    alert("Auto Get Lost Pages/Escapees disabled.")
                end
            end,
        })

        -- Skip Loading Toggle
        mainTab:CreateToggle({
            Name = 'Skip Loading [✅]',
            CurrentValue = false,
            Callback = function(value)
                getgenv().skipLoading = value
                if value then
                    alert("Skip Loading enabled.")
                else
                    alert("Skip Loading disabled.")
                end
            end,
        })

        -- AutoTP to ExitRegion Toggle
        mainTab:CreateToggle({
            Name = 'AutoTP to ExitRegion [⚠️/very low]',
            CurrentValue = false,
            Callback = function(tper)
                getgenv().tptoexit = tper
                if tper then
                    FConTPExit = task.spawn(function()
                        while task.wait(2) and getgenv().tptoexit do
                            if not getgenv().tptoexit then
                                break
                            end
                            local map = workspace.Multiplayer:WaitForChild('Map')
                            for _, v in ipairs(map:GetDescendants()) do
                                if v.Name == 'ExitRegion' then
                                    tp(v.CFrame, 4.5)
                                    task.wait(4.5)
                                end
                            end
                        end
                    end)
                    alert("AutoTP to ExitRegion enabled.")
                else
                    if FConTPExit then
                        task.cancel(FConTPExit)
                        FConTPExit = nil
                        alert("AutoTP to ExitRegion disabled.")
                    end
                end
            end,
        })

        -- Water Walk Toggle
        mainTab:CreateToggle({
            Name = 'Water Walk [✅]',
            CurrentValue = false,
            Callback = function(wwalk)
                getgenv().waterwalk = wwalk
                if wwalk then
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = true
                        end
                    end
                    alert("Water Walk enabled.")
                else
                    for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                        if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') then
                            t.CanCollide = false
                        end
                    end
                    alert("Water Walk disabled.")
                end
            end
        })

        -- Auto Safespot Toggle
        mainTab:CreateToggle({
            Name = 'Auto Safespot [✅]',
            CurrentValue = false,
            Callback = function(Value)
                getgenv().safespot = Value
                if Value then
                    task.spawn(function()
                        while task.wait(5) and getgenv().safespot do
                            if not getgenv().safespot then
                                break
                            end
                            if (lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart') and 
                                (lplr.Character.HumanoidRootPart.Position - safespotPart.Position).Magnitude > 250) then
                                sfb30BOK32v0.cl3C33vbo('b4j09B', 'My Eyes are on You You are like Princess Mononoke', 'Wfu3HG0', nil)
                                lplr.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(safespotPart.Position + Vector3.new(0, 5, 0))
                            end
                        end
                    end)
                    alert("Auto Safespot enabled.")
                else
                    alert("Auto Safespot disabled.")
                end
            end,
        })

        -- LocalPlayer Tab Toggles and Sliders

        -- GodMode Toggle
        lpTab:CreateToggle({
            Name = 'GodMode [✅]',
            CurrentValue = false,
            Callback = function(gm)
                getgenv().godmode = gm
                handler()
                if gm then
                    alert("GodMode Enabled.")
                else
                    alert("GodMode Disabled.")
                end
            end,
        })

        -- WalkSpeed Slider
        lpTab:CreateSlider({
            Name = "WalkSpeed [✅]",
            Range = {
                20,
                31,
            },
            Increment = 1,
            CurrentValue = 20,
            Callback = function(ws)
                getgenv().walkspeed = ws
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = getgenv().walkspeed
                    alert("WalkSpeed set to " .. ws)
                end
            end,
        })

        -- JumpPower Slider
        lpTab:CreateSlider({
            Name = "JumpPower [✅]",
            Range = {
                50,
                100
            },
            Increment = 1,
            CurrentValue = 50,
            Callback = function(jp)
                getgenv().jumppower = jp
                if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                    lplr.Character:FindFirstChildOfClass('Humanoid').JumpPower = getgenv().jumppower
                    alert("JumpPower set to " .. jp)
                end
            end,
        })

        -- Misc Tab Toggles and Buttons

        -- Autofarm Optimization Toggle
        miscTab:CreateToggle({
            Name = 'Autofarm Optimization [✅, BE IN THE LIFT]',
            CurrentValue = false,
            Callback = function(ao)
                getgenv().gOpti = ao
                if ao then
                    alert("Autofarm Optimization Enabled.")
                else
                    alert("Autofarm Optimization Disabled.")
                end
            end
        })

        -- VIP Emote Bypass Button
        miscTab:CreateButton({
            Name = 'VIP Emote Bypass [✅]',
            Callback = function()
                local function Change(Character)
                    local script = getsenv and getsenv(Character.Animate)
                    if script and script.changeEmote then
                        script.changeEmote(1584520816)
                    end
                end
                Change(lplr.Character)
                lplr.CharacterAdded:Connect(function(Character)
                    task.wait(1)
                    Change(Character)
                end)
                alert("VIP Emote Bypass Activated.")
            end
        })

        -- Don't Save Session Data Button
        miscTab:CreateButton({
            Name = "Don't Save Session Data [✅]",
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','My Veins are Tense as if I am on the Edge of Death','Wfu3HG0','RUNSLIDE','\255','Controls',nil,'Gamepad')
                alert("✅ After you server hop, you'll have the same stats as of now [Currency, XP, Level]")
            end
        })

        -- Challenges Tab Buttons

        -- Regenerate Air Button
        challengeTab:CreateButton({
            Name = 'Regenerate Air',
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B','Kiss of Heated Steel Soul Burning with Cold','Wfu3HG0',5000)
                alert("Regenerate Air Activated.")
            end
        })

        -- Slide Under Barriers Button
        challengeTab:CreateButton({
            Name = 'Slide Under Barriers',
            Callback = function()
                local map = workspace.Multiplayer:FindFirstChild('Map')
                if map then
                    for _, v in ipairs(map:GetDescendants()) do
                        if v.Name == 'SlideBeam' and v:IsA('BasePart') then
                            sfb30BOK32v0.cl3C33vbo('b4j09B','Blood Traces Desolator Minamoto Clan of Elders','Wfu3HG0',v.Position - Vector3.new(1, 1, 0), v.Position + Vector3.new(0, -1, 1))
                        end
                    end
                    alert("Slide Under Barriers Activated.")
                else
                    alert("Map not found!")
                end
            end
        })

        -- Function to teleport the character
        function tp(cframe, speed, exr)
            local plr = lplr.Character
            if not plr or not plr:FindFirstChildOfClass('Humanoid') or not plr:FindFirstChild('HumanoidRootPart') then return end
            local _hum = plr:FindFirstChildOfClass('Humanoid')
            if not exr then
                _hum.RootPart.Anchored = true
            end
            local tween = TweenService
            local TWEEN = tween:Create(_hum.RootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = CFrame.new(cframe.Position)
            })
            currtween = TWEEN
            TWEEN:Play()
            local finished = false
            local connect
            connect = TWEEN.Completed:Connect(function()
                _hum.RootPart.Anchored = false
                connect:Disconnect()
                finished = true
            end)
            repeat
                _hum.RootPart.Velocity = Vector3.zero
                _hum.RootPart.RotVelocity = Vector3.zero
                RunService.Heartbeat:Wait()
            until finished or (currbutton and currbutton:FindFirstChild('_DoNotTeleportTimelines'))
            _hum.RootPart.Anchored = false
            currtween = nil
        end

        -- Function to press all buttons and handle Autofarm completion
        local function pressAllButtons()
            local map = workspace.Multiplayer:FindFirstChild('Map')
            if not map then
                alert("Map not found!")
                return
            end
            local buttons = getAllButtons()
            if #buttons == 0 then
                alert("No buttons found to press.")
                return
            end
            for _, btn in ipairs(buttons) do
                if btn ~= 'ExitRegionDoNot' then
                    local humanoid = lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        local hrp = humanoid.RootPart
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

                        -- Handle waves.config
                        local wConfig = map:FindFirstChild('waves.config') or Instance.new('Folder', map)
                        if wConfig.Name ~= 'waves.config' then
                            wConfig.Name = 'waves.config'
                        end
                        local instaPress = wConfig:FindFirstChild('InstaPress') or Instance.new('BoolValue', wConfig)
                        if instaPress.Name ~= 'InstaPress' then
                            instaPress.Name = 'InstaPress'
                        end
                        if not instaPress.Value then
                            instaPress.Value = true
                            hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                            local pdata_lol = Instance.new('BindableFunction', btn)
                            pdata_lol.Name = randomGen2
                        end

                        -- Teleport to the button
                        hrp.CFrame = CFrame.new(btn.Position + Vector3.new(0, 5, 0))
                        alert("Pressing button: " .. (btn.Name or "Unknown"))

                        -- Mark the button as pressed
                        local pdata_lol = Instance.new('BindableFunction', btn)
                        pdata_lol.Name = randomGen2

                        -- Brief wait to ensure the button is pressed
                        task.wait(0.05)
                    else
                        alert("Humanoid not found for pressing button.")
                    end
                end
            end

            -- After pressing all buttons, kill the character immediately
            alert("All buttons pressed! Initiating automatic death and teleport to lift.")
            if lplr.Character and lplr.Character:FindFirstChildOfClass('Humanoid') then
                lplr.Character.Humanoid.Health = 0 -- Immediate kill
            end

            -- Wait for character to respawn and teleport to lift
            lplr.CharacterAdded:Wait()
            local newChar = lplr.Character
            newChar:WaitForChild('HumanoidRootPart')
            
            -- Teleport to Lift
            -- Replace 'Lift' with the actual name of the lift object in your game
            local lift = workspace.Multiplayer:FindFirstChild('Lift')
            if lift and lift:IsA('BasePart') then
                newChar.HumanoidRootPart.CFrame = CFrame.new(lift.Position + Vector3.new(0, 5, 0))
                alert('Teleported to lift to proceed to the next map.')
            else
                alert('Lift not found! Please ensure the lift exists in the workspace.')
            end
        end

        -- Autofarm Toggle - modified to call 'pressAllButtons' once when toggled on
        mainTab:CreateToggle({
            Name = "Autofarm [✅, EXEC IN THE MAP]",
            CurrentValue = false,
            Callback = function(getbtns)
                getgenv().gettingbuttons = getbtns
                if getbtns then
                    FCon = task.spawn(pressAllButtons)
                else
                    if FCon then
                        task.cancel(FCon)
                        FCon = nil
                        alert("Autofarm stopped.")
                    end
                end
            end,
        })

        -- Notify that the script has loaded
        alert('WAVES V' .. wavesVer .. ' loaded successfully.')
    end)
    if not _SL_SUC then
        -- Removed the kick and shutdown to allow GUI to load
        warn("Error loading script: " .. ERR)
    end
end
