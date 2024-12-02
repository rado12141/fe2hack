if true then
    repeat task.wait() until game:IsLoaded()
    local _SL_SUC, ERR = pcall(function()
        local wavesVer = 2.52
        local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        local sfb30BOK32v0 = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/refs/heads/main/bktOV03.lua'))()
        local notifs = loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/random/main/FE2Notifs.lua'))()
        local HttpService = game:GetService('HttpService')
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

        local function alert(text)
            notifs.alert(text, Color3.new(0.8, 0.498039, 2))
        end

        -- Prevent RemoteFunctions from being exploited
        for _, v in ipairs(game:GetService('ReplicatedStorage').Remote:GetDescendants()) do
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
        game:GetService("ReplicatedStorage").Remote.ClientTimelines.Teleport.OnClientEvent:Connect(function()
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

        local function getButton()
            for _, v in ipairs(workspace.Multiplayer:WaitForChild('Map'):GetDescendants()) do
                if (v:IsA('TouchTransmitter') and v.Parent.Name:upper() == v.Parent.Name and not v.Parent:FindFirstChild(randomGen2) and not v.Parent:FindFirstChild('_DoNotTeleportTimelines'))
                or (v:IsA('BasePart') and v.Name == 'ExitRegion') then
                    local btnthinglol = (v:IsA('TouchTransmitter') and v.Parent or 'ExitRegionDoNot')
                    return btnthinglol
                end
            end

            local btnawait = nil
            local btncon = workspace.Multiplayer.Map.DescendantAdded:Connect(function(v)
                if (v:IsA('TouchTransmitter') and v.Parent.Name:upper() == v.Parent.Name and not v.Parent:FindFirstChild(randomGen2) and not v.Parent:FindFirstChild('_DoNotTeleportTimelines'))
                or (v:IsA('BasePart') and v.Name == 'ExitRegion') then
                    btnawait = (v:IsA('TouchTransmitter') and v.Parent or 'ExitRegionDoNot')
                    btncon:Disconnect()
                end
            end)

            repeat
                task.wait(0.15)
                if _autofarmavali then
                    _autofarmdelay = _autofarmdelay + 0.15
                else
                    _autofarmavali = true
                end
            until btnawait ~= nil or not workspace.Multiplayer:FindFirstChild('Map') or exitRegionExists(workspace.Multiplayer:WaitForChild('Map'))

            if btncon then
                btncon:Disconnect()
            end

            if btnawait == nil then
                btnawait = true
            end

            return btnawait
        end

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

        -- Function to handle existing and new maps
        local function initializeAutofarmForMap(map)
            if getgenv().gettingbuttons then
                -- Delay to ensure the new map is fully loaded
                task.wait(2)
                -- Cancel any existing autofarm process
                if FCon and task.is_running(FCon) then
                    task.cancel(FCon)
                end
                -- Start autofarm for the new map
                FCon = task.spawn(startfarm)
            end
        end

        -- Start autofarm for the currently loaded map, if any
        local existingMap = workspace.Multiplayer:FindFirstChild('Map')
        if existingMap then
            initializeAutofarmForMap(existingMap)
        end

        -- Listen for new maps being added
        workspace.Multiplayer.ChildAdded:Connect(function(v)
            if v.Name == 'Map' then
                initializeAutofarmForMap(v)
            end
        end)

        -- Handle descendant additions for water walk and optimization
        workspace.Multiplayer.DescendantAdded:Connect(function(t)
            task.wait()
            if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') and getgenv().waterwalk then
                t.CanCollide = true
            end
            if getgenv().gOpti then
                if t:IsA('BasePart') and not t.Parent:FindFirstChild('TouchTransmitter') and #t.Name < 5 and t.Parent.Name ~= 'Map' and t.Name ~= 'ExitRegion' then
                    t.Transparency = 1
                end
            end
        end)

        local function decimalRandom(minimum, maximum)
            return math.random() * (maximum - minimum) + minimum
        end

        local Synced = true
        local RootPart, RootClone

        local function desync()
            local Char = lplr.Character
            if Synced and Char then
                Synced = false
                -- Desync rootpart
                Char.Parent = game:GetService('ReplicatedStorage')
                RootPart = Char.HumanoidRootPart
                RootPart.CFrame = RootPart.CFrame
                RootPart.Transparency = 0
                RootPart.RootJoint.Enabled = false
                RootClone = RootPart:Clone()
                RootClone.CFrame = RootClone.CFrame
                RootClone.Transparency = 1
                RootClone.Parent = Char
                Char.PrimaryPart = RootClone
                RootClone.RootJoint.Enabled = true
                Char.Parent = workspace
            end
        end

        local function sync()
            local Char = lplr.Character
            if not Synced and Char then
                Synced = true
                Char.Parent = game:GetService('ReplicatedStorage')
                RootPart.CFrame = RootClone.CFrame
                RootClone.Parent = nil
                RootPart.Parent = Char
                Char.PrimaryPart = RootPart
                RootPart.RootJoint.Enabled = true
                Char.Parent = workspace
            end
        end

        local function fetchZipline()
            if workspace.Multiplayer:FindFirstChild('Map') then
                local ziplinePart = false
                for _, v in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                    if v.Name == 'StartPole' and v:IsA('Model') and v:FindFirstChild('Base') then
                        ziplinePart = v.Base
                        break
                    end
                end
                return ziplinePart or false
            else
                return false
            end
        end

        local function tp(cframe, speed, exr)
            local plr = lplr.Character
            local _hum = plr:FindFirstChildOfClass('Humanoid')
            if not exr and _hum and _hum:FindFirstChild('RootPart') then
                task.wait(0.21)
                _hum.RootPart.Anchored = true
            end
            local tweenService = game:GetService("TweenService")
            local TWEEN = tweenService:Create(_hum.RootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = CFrame.new(cframe.Position)
            })
            currtween = TWEEN
            TWEEN:Play()
            local finished = false
            local connect
            connect = TWEEN.Completed:Connect(function()
                if _hum and _hum:FindFirstChild('RootPart') then
                    _hum.RootPart.Anchored = false
                end
                connect:Disconnect()
                finished = true
            end)
            repeat
                if _hum and _hum:FindFirstChild('RootPart') then
                    _hum.RootPart.Velocity = Vector3.zero
                    _hum.RootPart.RotVelocity = Vector3.zero
                end
                RunService.Heartbeat:Wait()
            until finished == true or (currbutton and currbutton:FindFirstChild('_DoNotTeleportTimelines') or false)
            if _hum and _hum:FindFirstChild('RootPart') then
                _hum.RootPart.Anchored = false
            end
            currtween = nil
        end

        -- Handler for player character
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

        -- Check if ExitRegion exists in the map
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

        handler()

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

        local function float()
            task.spawn(function()
                if getgenv().gettingbuttons then
                    local fpart = Instance.new('Part', workspace)
                    fpart.Name = 'floatpart'
                    fpart.Anchored = true
                    while task.wait() and getgenv().gettingbuttons do
                        fpart.CFrame = CFrame.new(lplr.Character:WaitForChild('HumanoidRootPart').Position - Vector3.new(0, 3, 0))
                    end
                end
            end)
        end

        local waypoints
        local DeathConnection, TCon1, TCon2, FCon, alreadyConnected, reconCon, dieDelay
        dieDelay = 0

        -- Reconnect function to handle character removal
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
                    -- Removed code that changes humanoid state to dead
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
        local function startfarm()
            while RunService.Heartbeat:Wait() do
                if not getgenv().gettingbuttons then
                    break
                end
                if not reconCon then
                    reconCon = task.spawn(newreconnect)
                    alert('Disconnected reconCon')
                end
                local map = workspace.Multiplayer:WaitForChild('Map')
                local humanoid = lplr.Character:FindFirstChildOfClass('Humanoid')
                if not humanoid then
                    alert('Humanoid not found!')
                    task.wait(1)
                    continue  -- Skip to next iteration if Humanoid not found
                end
                local hrp = humanoid.RootPart
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                local wConfig, btns, button
                _autofarmdelay = 0

                -- Get the target button
                while btns == nil do
                    local success, err = pcall(function()
                        btns = getButton()
                    end)
                    if not success then
                        warn(err)
                        alert(err)
                    end
                    if btns == 'ExitRegionDoNot' then
                        btns = true
                    end
                    RunService.Heartbeat:Wait()
                end

                -- Check if ExitRegion exists
                local isExitRegion = exitRegionExists(map)
                if isExitRegion then
                    local successEND, errEND = pcall(function()
                        local _remoteCon
                        _remoteCon = dvoR3BO2.OnClientEvent:Connect(function()
                            _remoteCon:Disconnect()
                            dieDelay = dieDelay + 1
                            if dieDelay >= 2 then
                                -- Removed killing user
                                -- humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                            end
                        end)
                        task.wait(0.2)
                        local ExitRegion = isExitRegion
                        local olderegionsize = ExitRegion.Size
                        ExitRegion.Size = Vector3.new(0.1, 0.1, 0.1)
                        tp(ExitRegion.CFrame, Time(ExitRegion.Position, true), true)
                        for i = 0, 5 do
                            hrp.CFrame = CFrame.new(ExitRegion.Position)
                            task.wait(0.01)
                        end
                        task.wait(1.6)
                        ExitRegion.Size = olderegionsize
                    end)
                    if not successEND then
                        -- Removed killing user
                        -- humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                        warn(errEND)
                        alert('FATAL ERROR: ' .. errEND)
                    end
                    break  -- Exit the farming loop as the map has ended
                end

                -- Alert zooming to the button
                local successZoom, errZoom = pcall(function()
                    alert('Zooming to the button ' .. (btns.Name or "Unknown"))
                end)
                if not successZoom then
                    alert('FATAL ERROR: ' .. errZoom)
                    task.wait(1)
                    -- Removed killing user
                    -- humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                end

                -- Handle waves.config folder
                if not map:FindFirstChild('waves.config') then
                    alert('Creating "waves.config" folder')
                    wConfig = Instance.new('Folder', map)
                    wConfig.Name = 'waves.config'
                else
                    wConfig = map:FindFirstChild('waves.config')
                end

                -- Handle InstaPress
                if not wConfig:FindFirstChild('InstaPress') then
                    local InstaPressData = Instance.new('BoolValue', wConfig)
                    InstaPressData.Name = 'InstaPress'
                end

                if not wConfig['InstaPress'].Value then
                    task.wait(1)
                    wConfig['InstaPress'].Value = true
                    hrp.CFrame = CFrame.new(btns.Position)
                    task.wait(0.15)
                    local pdata_lol = Instance.new('BindableFunction', btns)
                    pdata_lol.Name = randomGen2
                end

                -- Move to button
                button = btns
                currbutton = btns
                hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 20, 0))
                btns.CanTouch = false
                local _TPTime = Time(button.Position)
                hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 20, 0))

                if typeof(_TPTime) == 'number' and _TPTime > 65 then
                    -- Removed killing user
                    -- humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                    alert('>65s tp time. cancelling.')
                end

                if _TPTime == 'Teleport' then
                    hrp.CFrame = CFrame.new(button.Position)
                else
                    tp(button.CFrame, _TPTime)
                end

                hrp.CFrame = CFrame.new(button.Position + Vector3.new(0, 5, 0))
                task.wait(0.05)
                btns.CanTouch = true

                if button then
                    for i = 0, 7 do
                        hrp.CFrame = CFrame.new(button.Position + Vector3.new(0.1, math.random(), 0))
                        task.wait(0.05)
                    end
                end

                hrp.CFrame = CFrame.new(button.Position)
                local pdata_lol = Instance.new('BindableFunction', btns)
                pdata_lol.Name = randomGen2
                _autofarmavali = false
                currbutton = nil
            end
        end

        -- **Autofarm is always enabled; no toggle needed**
        -- Start Autofarm on script load
        local FCon = task.spawn(startfarm)

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
                end
            end,
        })

        -- Skip Loading Toggle
        mainTab:CreateToggle({
            Name = 'Skip Loading [✅]',
            CurrentValue = false,
            Callback = function(value)
                getgenv().skipLoading = value
            end,
        })

        -- Water Walk Toggle
        mainTab:CreateToggle({
            Name = 'Water Walk [✅]',
            CurrentValue = false,
            Callback = function(wwalk)
                getgenv().waterwalk = wwalk
                for _, t in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                    if string.match(string.lower(t.Name), 'water') and t:IsA('BasePart') and getgenv().waterwalk then
                        t.CanCollide = true
                    end
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
                            if (lplr.Character.HumanoidRootPart.Position - part.Position).Magnitude > 250 or ((lplr.Character.HumanoidRootPart.Position - part.Position).Magnitude) < -250 then
                                sfb30BOK32v0.cl3C33vbo('b4j09B', 'My Eyes are on You You are like Princess Mononoke', 'Wfu3HG0', nil)
                                lplr.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                            end
                        end
                    end)
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
            end
        })

        -- VIP Emote Bypass Button
        miscTab:CreateButton({
            Name = 'VIP Emote Bypass [✅]',
            Callback = function()
                local Players = game:GetService('Players')
                local function Change(Character)
                    local script = getsenv(Character.Animate)
                    if script and script.changeEmote then
                        script.changeEmote(1584520816)
                    end
                end
                Change(Players.LocalPlayer.Character)
                local function newCharacter(Character)
                    task.wait(1)
                    Change(Character)
                end
                Players.LocalPlayer.CharacterAdded:Connect(newCharacter)
            end
        })

        -- Don't Save Session Data Button
        miscTab:CreateButton({
            Name = "Don't Save Session Data [✅]",
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B', 'My Veins are Tense as if I am on the Edge of Death', 'Wfu3HG0', 'RUNSLIDE', '\255', 'Controls', nil, 'Gamepad')
                alert("✅ After you server hop, you'll have the same stats as of now [Currency, XP, Level]")
            end
        })

        -- Challenges Tab Buttons

        -- Regenerate Air Button
        challengeTab:CreateButton({
            Name = 'Regenerate Air',
            Callback = function()
                sfb30BOK32v0.cl3C33vbo('b4j09B', 'Kiss of Heated Steel Soul Burning with Cold', 'Wfu3HG0', 5000)
            end
        })

        -- Slide Under Barriers Button
        challengeTab:CreateButton({
            Name = 'Slide Under Barriers',
            Callback = function()
                for _, v in ipairs(workspace.Multiplayer.Map:GetDescendants()) do
                    if v.Name == 'SlideBeam' and v:IsA('BasePart') then
                        sfb30BOK32v0.cl3C33vbo('b4j09B', 'Blood Traces Desolator Minamoto Clan of Elders', 'Wfu3HG0', v.Position - Vector3.new(1, 1, 0), v.Position + Vector3.new(0, -1, 1))
                    end
                end
            end
        })

        -- Notify that the script has loaded
        alert('WAVES V' .. wavesVer .. ' loaded')
    end)

    if not _SL_SUC then
        -- Removed the following lines to prevent kicking the user and shutting down the game
        -- game:GetService('Players').LocalPlayer:Kick(ERR)
        -- task.wait(2)
        -- game.Shutdown(game)

        -- Instead, log the error for debugging purposes
        warn("Error loading script: " .. ERR)
    end
end
