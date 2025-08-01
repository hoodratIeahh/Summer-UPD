loadstring(game:HttpGet("https://raw.githubusercontent.com/hoodratIeahh/Summer-UPD/refs/heads/main/source.lua"))()

-- DONT TOUCH THIS PART
local Version = "1.6.31"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()
-- DONT TOUCH THIS PART

-- Freaky Theme
WindUI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b",
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

-- Main Window
local Window = WindUI:CreateWindow({
    Title = "Tool Scripts Hub",
    Icon = "door-open",
    Author = "Summer Update🏖️",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "", -- rbxassetid only
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
})

local Dialog = Window:Dialog({
    Icon = "bird",
    Title = "Thank You For Using Tool Scripts Hub",
    Content = "Apreciatte Your Support",
    Buttons = {
        {
            Title = "Continue",
            Callback = function()
                print("Confirmed!")
            end,
        },
        {
            Title = "Cancel",
            Callback = function()
                print("Cancelled!")
            end,
        },
    },
})

local Tab0 = Window:Tab({
    Title = "Misc",
    Icon = "clock",
    Locked = false,
})

local Paragraph = Tab0:Paragraph({
    Title = "About Us",
    Desc = "You can find us on every social media, 'Tool Scripts', we been making and showcasing scripts for almost half a year now.",
    Color = "Blue",
    Image = "",
    ImageSize = 0,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
    Buttons = {
        {
            Icon = "cloud",
            Title = "Thanks You For Supporting Us",
            Callback = function() print("1 Button") end,
        }
    }
})

local Section = Tab0:Section({ 
    Title = "Speed",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Slider = Tab0:Slider({
    Title = "Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 100,
        Default = 16,
    },
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
        print("Speed set to: " .. value)
    end
})


local Section2 = Tab0:Section({ 
    Title = "Jump Power",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Slider2 = Tab0:Slider({
    Title = "Jump Power",
    Step = 1,
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
        print("Jump Power set to: " .. value)
    end
})


local Tab = Window:Tab({
    Title = "Auto Farm",
    Icon = "clock",
    Locked = false,
})

local Section = Tab:Section({ 
    Title = "Main",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Paragraph = Tab:Paragraph({
    Title = "About AutoFarm",
    Desc = "AutoFarm may kick you if you going too fast so its not a script error just be patient with this autofarm speed because i more stable than last version.",
    Color = "Blue",
    Image = "",
    ImageSize = 0,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
    Buttons = {
        {
            Icon = "cloud",
            Title = "Thank For Your Understanding",
            Callback = function() print("1 Button") end,
        }
    }
})

-- Optimization Tab
local OptimizationTab = Window:Tab({
    Title = "Optimization",
    Icon = "cloud",
    Locked = false,
})

local OptimizationSection = OptimizationTab:Section({
    Title = "Performance",
    TextXAlignment = "Left",
    TextSize = 17,
})

local function flattenTextures()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not (obj:GetAttribute("CoinID") and obj:GetAttribute("CoinID"):lower() == "beachball") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Color = Color3.new(0.5, 0.5, 0.5)
        end
        if (obj:IsA("Decal") or obj:IsA("Texture")) and not (obj.Parent and obj.Parent:GetAttribute("CoinID") and obj.Parent:GetAttribute("CoinID"):lower() == "beachball") then
            obj:Destroy()
        end
    end
    WindUI:Notify({
        Title = "Boost FPS (Make Game Loook Ugly)",
        Content = "Textures flattened to improve FPS",
        Duration = 5,
    })
end

local function reduceLag()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Beam") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
    local lighting = game:GetService("Lighting")
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end
    WindUI:Notify({
        Title = "Reduce Lag (Make Game Loook Ugly)",
        Content = "Particles and effects disabled to reduce lag",
        Duration = 5,
    })
end

OptimizationTab:Button({
    Title = "Boost FPS",
    Icon = "rocket",
    Callback = flattenTextures
})

OptimizationTab:Button({
    Title = "Reduce Lag",
    Icon = "bolt",
    Callback = reduceLag
})

-- Utilities Tab
local UtilitiesTab = Window:Tab({
    Title = "Utilities",
    Icon = "wrench",
    Locked = false,
})

local UtilitiesSection = UtilitiesTab:Section({
    Title = "Tools",
    TextXAlignment = "Left",
    TextSize = 17,
})

local function leaveGame()
    WindUI:Notify({
        Title = "Leaving Game",
        Content = "Disconnecting from the game...",
        Duration = 2,
    })
    task.wait(2) -- Brief delay to show notification
    game:GetService("Players").LocalPlayer:Kick("Disconnected by script")
end

local function rejoinServer()
    WindUI:Notify({
        Title = "Rejoining Server",
        Content = "Attempting to rejoin the server...",
        Duration = 5,
    })
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)
    -- Fallback to joining a new server if the current one is unavailable
    task.wait(1)
    TeleportService:Teleport(game.PlaceId)
end

UtilitiesTab:Button({
    Title = "Leave Game",
    Icon = "door-open",
    Callback = leaveGame
})

UtilitiesTab:Button({
    Title = "Rejoin Server",
    Icon = "refresh",
    Callback = rejoinServer
})

-- Troll Tab
local TrollTab = Window:Tab({
    Title = "Troll",
    Icon = "smile",
    Locked = false,
})

local Paragraph = TrollTab:Paragraph({
    Title = "Important",
    Desc = "Troll Tab is still on development and will be fixed on new update, you can still usew it to tp to selected player.",
    Color = "Blue",
    Image = "",
    ImageSize = 0,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
    Buttons = {
        {
            Icon = "cloud",
            Title = "Thanks You For Supporting Us",
            Callback = function() print("1 Button") end,
        }
    }
})

local TrollSection = TrollTab:Section({
    Title = "Trolling",
    TextXAlignment = "Left",
    TextSize = 17,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local function flingAll()
    local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localHrp then
        WindUI:Notify({
            Title = "Fling Error",
            Content = "Local player character not found!",
            Duration = 5,
        })
        return
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                local targetHrp = player.Character.HumanoidRootPart
                -- Teleport to player
                local tween = TweenService:Create(
                    localHrp,
                    TweenInfo.new(0.5, Enum.EasingStyle.Linear),
                    {CFrame = targetHrp.CFrame}
                )
                tween:Play()
                tween.Completed:Wait()
                -- Apply rapid spin
                local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bodyAngularVelocity.AngularVelocity = Vector3.new(0, 100, 0) -- Insane spin on Y-axis
                bodyAngularVelocity.Parent = targetHrp
                task.delay(2, function()
                    if bodyAngularVelocity then
                        bodyAngularVelocity:Destroy()
                    end
                end)
                task.wait(0.5) -- Delay between players
            end)
        end
    end
    WindUI:Notify({
        Title = "Fling All",
        Content = "Teleported to and spun all players!",
        Duration = 5,
    })
end

local function getPlayerList()
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

local selectedPlayer = nil
local function createFlingDropdown()
    return TrollTab:Dropdown({
        Title = "Select Player to Fling",
        Values = getPlayerList(),
        Value = nil,
        Multi = false,
        AllowNone = true,
        Callback = function(value)
            selectedPlayer = value
        end
    })
end

local flingDropdown = createFlingDropdown()

local function updatePlayerList()
    local newDropdown = createFlingDropdown()
    flingDropdown = newDropdown
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

local function flingSpecificUser()
    if not selectedPlayer then
        WindUI:Notify({
            Title = "Fling Error",
            Content = "No player selected!",
            Duration = 5,
        })
        return
    end
    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localHrp then
        WindUI:Notify({
            Title = "Fling Error",
            Content = "Local player character not found!",
            Duration = 5,
        })
        return
    end
    if targetPlayer and targetPlayer ~= LocalPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            local targetHrp = targetPlayer.Character.HumanoidRootPart
            -- Teleport to player
            local tween = TweenService:Create(
                localHrp,
                TweenInfo.new(0.5, Enum.EasingStyle.Linear),
                {CFrame = targetHrp.CFrame}
            )
            tween:Play()
            tween.Completed:Wait()
            -- Apply rapid spin
            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 100, 0)
            bodyAngularVelocity.Parent = targetHrp
            task.delay(2, function()
                if bodyAngularVelocity then
                    bodyAngularVelocity:Destroy()
                end
            end)
            WindUI:Notify({
                Title = "Fling Player",
                Content = "Teleported to and spun player: " .. selectedPlayer,
                Duration = 5,
            })
        end)
    else
        WindUI:Notify({
            Title = "Fling Error",
            Content = "Selected player not found or invalid!",
            Duration = 5,
        })
    end
end

TrollTab:Button({
    Title = "Fling All",
    Icon = "wind",
    Callback = flingAll
})

TrollTab:Button({
    Title = "Fling Specific User",
    Icon = "user-x",
    Callback = flingSpecificUser
})

-- Initial player list update
updatePlayerList()

-- Variables del autofarm
local AutoFarm = {
    Enabled = false,
    Player = game:GetService("Players").LocalPlayer,
    Character = nil,
    HumanoidRootPart = nil,
    start_position = nil,
    bag_full = false,
    total_collected = 0,
    ToFarm = "BeachBall", -- Cambiar a "Coin" si es necesario
    speed = 24, -- Velocidad inicial (máximo 50)
    CoinCollected = game:GetService("ReplicatedStorage").Remotes.Gameplay.CoinCollected,
    RoundStart = game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundStart,
    RoundEnd = game:GetService("ReplicatedStorage").Remotes.Gameplay.RoundEndFade,
    notification = nil -- Para las notificaciones
}

-- Función para mostrar notificaciones
function AutoFarm:ShowNotification(title, message)
    if self.notification then
        self.notification:Destroy()
    end
    
    self.notification = Instance.new("ScreenGui")
    self.notification.Name = "AutoFarmNotification"
    self.notification.Parent = game.CoreGui
    self.notification.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = self.notification
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 140, 255)
    stroke.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Size = UDim2.new(1, -20, 0, 40)
    messageLabel.Position = UDim2.new(0, 10, 0, 35)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = frame
    
    -- Animación de entrada
    frame.Position = UDim2.new(1, 300, 1, -100)
    local tween = game:GetService("TweenService"):Create(
        frame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
        {Position = UDim2.new(1, -320, 1, -100)}
    )
    tween:Play()
    
    -- Auto-destrucción después de 3 segundos
    task.delay(3, function()
        if self.notification then
            local tweenOut = game:GetService("TweenService"):Create(
                frame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {Position = UDim2.new(1, 300, 1, -100)}
            )
            tweenOut:Play()
            tweenOut.Completed:Wait()
            self.notification:Destroy()
            self.notification = nil
        end
    end)
end

-- Inicializar personaje
AutoFarm.Player.CharacterAdded:Connect(function(newChar)
    AutoFarm.Character = newChar
    AutoFarm.HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    AutoFarm.start_position = AutoFarm.HumanoidRootPart.CFrame
end)

if AutoFarm.Player.Character then
    AutoFarm.Character = AutoFarm.Player.Character
    AutoFarm.HumanoidRootPart = AutoFarm.Character:WaitForChild("HumanoidRootPart")
    AutoFarm.start_position = AutoFarm.HumanoidRootPart.CFrame
end

-- Configurar anti-AFK
AutoFarm.Player.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
end)

task.spawn(function()
    while true do
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0, 0))
        task.wait(60)
    end
end)

-- Función para obtener la moneda más cercana
function AutoFarm:getNearestCoin()
    local closest_coin, min_distance = nil, math.huge
    for _, model in pairs(workspace:GetChildren()) do
        if model:FindFirstChild("CoinContainer") then
            for _, coin in pairs(model.CoinContainer:GetChildren()) do
                if coin:GetAttribute("CoinID") == self.ToFarm and coin:FindFirstChild("TouchInterest") then
                    local distance = (self.HumanoidRootPart.Position - coin.Position).Magnitude
                    if distance < min_distance then
                        closest_coin = coin
                        min_distance = distance
                    end
                end
            end
        end
    end
    return closest_coin, min_distance
end

-- Función para tweenear al objetivo (con control de velocidad)
function AutoFarm:tweenTo(position, baseSpeed)
    local adjustedSpeed = baseSpeed * (30 / self.speed) -- Ajuste inverso (mayor número = más lento)
    local tween = game:GetService("TweenService"):Create(
        self.HumanoidRootPart,
        TweenInfo.new(adjustedSpeed, Enum.EasingStyle.Linear),
        {CFrame = position}
    )
    tween:Play()
    return tween
end

-- Bucle principal del autofarm
function AutoFarm:startFarmingLoop()
    spawn(function()
        while self.Enabled do
            if not self.bag_full and self.Character and self.HumanoidRootPart then
                local coin, distance = self:getNearestCoin()
                if coin then
                    if distance > 150 then
                        self.HumanoidRootPart.CFrame = coin.CFrame
                    else
                        local tween = self:tweenTo(coin.CFrame, distance / 24) -- Base speed 50
                        repeat task.wait() until not coin:FindFirstChild("TouchInterest") or not self.Enabled
                        tween:Cancel()
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- Contador de colección
AutoFarm.CoinCollected.OnClientEvent:Connect(function(coin_type, current, max)
    if coin_type == AutoFarm.ToFarm then
        AutoFarm.total_collected += 1
        if AutoFarm.counterLabel then
            AutoFarm.counterLabel:setText("Eggs Collected: " .. AutoFarm.total_collected)
        end
        if current == max then
            AutoFarm.bag_full = true
            AutoFarm:tweenTo(AutoFarm.start_position, 2).Completed:Wait()
            if AutoFarm.Character:FindFirstChild("Humanoid") then
                AutoFarm.Character.Humanoid.Health = 0
            end
            task.wait(5)
            AutoFarm.bag_full = false
        end
    end
end)

AutoFarm.RoundStart.OnClientEvent:Connect(function()
    if AutoFarm.Enabled then
        AutoFarm.Enabled = true
    end
end)

AutoFarm.RoundEnd.OnClientEvent:Connect(function()
    if AutoFarm.Enabled then
        AutoFarm.Enabled = false
    end
end)



local SafeToggle = Tab:Toggle({
    Title = "Auto Farm (Safe)",
    Desc = "Safe auto farm, stable and the best for afk.",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        AutoFarm.Enabled = state
        if state then
            AutoFarm:startFarmingLoop()
                                WindUI:Notify({
            Title = "Auto Farm Enabled",
            Content = "Autofarm Now is active",
            Duration = 5,
        })
        else
                    WindUI:Notify({
            Title = "Auto Farm Disabled",
            Content = "Autofarm Now is inactive",
            Duration = 5,
        })
        end
    end
})



local Tab2 = Window:Tab({
    Title = "Anti Steal",
    Icon = "container",
    Locked = false,
})


local Toggle = Tab2:Toggle({
    Title = "Anti Steal",
    Desc = "AntiSteal makes your items be safe, by protecting any stealing try from other Scripts with stealers inside",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
    end
})




local MainTab = Window:Tab({ Title = "Esp", Icon = "package", Locked = false })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local murderHasKnife = false
local sheriffHasGun = false
local currentESPOptions = { "Esp All" }
local highlightEnabled = true
local lineESPEnabled = false
local beachBallESPEnabled = false
local beachBallHighlights = {}
local tracers = {}
local lastBeachBallUpdate = 0
local updateInterval = 0.2 -- Reduced to 0.2s for faster response

local function getRole(player)
    local character = player.Character
    if not character then return nil end
    local backpack = player:FindFirstChild("Backpack")
    if character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then return "Murderer" end
    if character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local function isPlayerTargeted(player, selectedOptions)
    local role = getRole(player)
    if not role then return false end
    if table.find(selectedOptions, "Esp All") then return true end
    if table.find(selectedOptions, "Esp Murder") and role == "Murderer" then return true end
    if table.find(selectedOptions, "Esp Sheriff") and role == "Sheriff" then return true end
    if table.find(selectedOptions, "Esp Sheriff / Murder") and (role == "Sheriff" or role == "Murderer") then return true end
    return false
end

local function getHighlightColor(role)
    if role == "Murderer" then
        return Color3.new(1, 0, 0)
    elseif role == "Sheriff" then
        return Color3.new(0, 0, 1)
    elseif murderHasKnife and sheriffHasGun then
        return Color3.new(0, 1, 0)
    end
    return nil
end

local function getTracerColor(role)
    if role == "Murderer" then
        return Color3.new(1, 0, 0)
    elseif role == "Sheriff" then
        return Color3.new(0, 0, 1)
    elseif murderHasKnife and sheriffHasGun then
        return Color3.new(0, 1, 0)
    else
        return Color3.new(1, 1, 1)
    end
end

local function createHighlight(instance, color)
    local highlight = instance:FindFirstChild("ESPHighlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = instance
        highlight.Parent = instance
    end
    highlight.FillColor = color
    return highlight
end

local function removeHighlight(instance)
    local highlight = instance:FindFirstChild("ESPHighlight")
    if highlight then highlight:Destroy() end
end

local function createTracer(player, color)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Color = color or Color3.new(1, 1, 1)
    line.Transparency = 1
    tracers[player] = line
end

local function removeTracer(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end

local function getBeachBalls()
    local beachBalls = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj:GetAttribute("CoinID") and obj:GetAttribute("CoinID"):lower() == "beachball") or obj.Name:lower():find("beachball") then
            table.insert(beachBalls, obj)
        end
    end
    return beachBalls
end

local function updateESP()
    murderHasKnife = false
    sheriffHasGun = false

    -- Update Player ESP
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local role = getRole(player)
            if role == "Murderer" then murderHasKnife = true end
            if role == "Sheriff" then sheriffHasGun = true end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local role = getRole(player)
            local target = isPlayerTargeted(player, currentESPOptions)

            if highlightEnabled and target then
                local color = getHighlightColor(role)
                if color then
                    createHighlight(player.Character, color)
                else
                    removeHighlight(player.Character)
                end
            else
                removeHighlight(player.Character)
            end

            if lineESPEnabled and target then
                local color = getTracerColor(role)
                if not tracers[player] then 
                    createTracer(player, color) 
                else
                    tracers[player].Color = color
                end
            else
                removeTracer(player)
            end
        end
    end

    -- Update BeachBall ESP
    if beachBallESPEnabled and tick() - lastBeachBallUpdate >= updateInterval then
        local beachBalls = getBeachBalls()
        -- Create highlights for current BeachBalls
        for _, ball in ipairs(beachBalls) do
            if not beachBallHighlights[ball] then
                beachBallHighlights[ball] = createHighlight(ball, Color3.new(1, 1, 0))
            end
        end
        -- Remove highlights for BeachBalls that no longer exist
        for ball, highlight in pairs(beachBallHighlights) do
            if not ball.Parent then
                removeHighlight(ball)
                beachBallHighlights[ball] = nil
            end
        end
        lastBeachBallUpdate = tick()
    elseif not beachBallESPEnabled then
        for ball, highlight in pairs(beachBallHighlights) do
            removeHighlight(ball)
        end
        beachBallHighlights = {}
    end
end

RunService.Heartbeat:Connect(function()
    updateESP()
    if not lineESPEnabled then return end
    for player, line in pairs(tracers) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
            local rootGuiSize = workspace.CurrentCamera.ViewportSize
            if onScreen then
                line.From = Vector2.new(rootGuiSize.X / 2, rootGuiSize.Y)
                line.To = Vector2.new(screenPos.X, screenPos.Y)
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end)

local function monitorPlayer(player)
    player.CharacterAdded:Connect(function()
        local backpack = player:WaitForChild("Backpack")
        backpack.ChildAdded:Connect(updateESP)
        backpack.ChildRemoved:Connect(updateESP)
    end)

    if player.Character then
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            backpack.ChildAdded:Connect(updateESP)
            backpack.ChildRemoved:Connect(updateESP)
        end
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if (descendant:GetAttribute("CoinID") and descendant:GetAttribute("CoinID"):lower() == "beachball") or descendant.Name:lower():find("beachball") then
        if beachBallESPEnabled then
            updateESP()
        end
    end
end)

workspace.DescendantRemoving:Connect(function(descendant)
    if beachBallHighlights[descendant] then
        removeHighlight(descendant)
        beachBallHighlights[descendant] = nil
    end
end)

for _, player in ipairs(Players:GetPlayers()) do monitorPlayer(player) end
Players.PlayerAdded:Connect(monitorPlayer)

local Section = MainTab:Section({ 
    Title = "Main",
    TextXAlignment = "Left",
    TextSize = 17,
})

MainTab:Dropdown({
    Title = "ESP Options",
    Values = { "Esp All", "Esp Sheriff", "Esp Murder", "Esp Sheriff / Murder" },
    Value = { "Esp All" },
    Multi = true,
    AllowNone = true,
    Callback = function(selectedOptions)
        currentESPOptions = selectedOptions
        updateESP()
    end
})

MainTab:Toggle({
    Title = "Highlight ESP",
    Icon = "eye",
    Type = "Checkbox",
    Default = true,
    Callback = function(v)
        highlightEnabled = v
        updateESP()
    end
})

MainTab:Toggle({
    Title = "Line ESP",
    Icon = "eye-off",
    Type = "Checkbox",
    Default = false,
    Callback = function(v)
        lineESPEnabled = v
        if not v then
            for _, line in pairs(tracers) do line:Remove() end
            tracers = {}
        end
        updateESP()
    end
})

MainTab:Toggle({
    Title = "BeachBall ESP",
    Icon = "eye",
    Type = "Checkbox",
    Default = false,
    Callback = function(v)
        beachBallESPEnabled = v
        updateESP()
    end
})

-- Customization Tab
local CustomizationTab = Window:Tab({
    Title = "Customization",
    Icon = "palette",
    Locked = false,
})

local CustomizationSection = CustomizationTab:Section({
    Title = "Script Appearance",
    TextXAlignment = "Left",
    TextSize = 17,
})

local colorOptions = {
    { Name = "Sea Blue", Hex = "#4682B4" },
    { Name = "Red", Hex = "#FF3333" },
    { Name = "Green", Hex = "#33CC33" },
    { Name = "Purple", Hex = "#9933CC" },
    { Name = "Orange", Hex = "#FF8C00" },
}

-- Define themes for each color, setting multiple properties
for _, color in ipairs(colorOptions) do
    pcall(function()
        WindUI:AddTheme({
            Name = "Dark_" .. color.Name:gsub(" ", "_"),
            Accent = color.Hex,
            Dialog = color.Hex, -- Apply to dialogs
            Outline = color.Hex, -- Apply to borders
            Text = "#FFFFFF",
            Placeholder = "#999999",
            Background = "#0e0e10",
            Button = color.Hex, -- Apply to buttons
            Icon = color.Hex, -- Apply to icons
        })
    end)
end

local function getColorNames()
    local names = {}
    for _, color in ipairs(colorOptions) do
        table.insert(names, color.Name)
    end
    return names
end

local selectedColor = "Sea Blue"
CustomizationTab:Dropdown({
    Title = "Theme Color",
    Values = getColorNames(),
    Value = selectedColor,
    Multi = false,
    AllowNone = false,
    Callback = function(value)
        selectedColor = value
        pcall(function()
            local themeName = "Dark_" .. value:gsub(" ", "_")
            WindUI:SetTheme(themeName)
            WindUI:Notify({
                Title = "Theme Updated",
                Content = "Changed to " .. value .. " theme! Applied to buttons, icons, borders, and dialogs.",
                Duration = 5,
            })
        end)
    end
})

CustomizationTab:Toggle({
    Title = "Window Transparency",
    Icon = "eye",
    Type = "Checkbox",
    Default = true,
    Callback = function(state)
        pcall(function()
            Window:ToggleTransparency(state)
            WindUI:Notify({
                Title = "Transparency Updated",
                Content = state and "Transparency enabled" or "Transparency disabled",
                Duration = 5,
            })
        end)
    end
})
