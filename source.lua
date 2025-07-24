-- Rayfield Loader
-- Window Setup
local Window = Rayfield:CreateWindow({
    Name = "Testol Hub ☀️ | MM2",
    LoadingTitle = "Testol Hub Summer Edition",
    LoadingSubtitle = "by yourname",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TestolHubMM2",
        FileName = "Summer2025"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Variables
local autofarm = false
local autocoin = false
local esp_enabled = false

-- Auto Farm
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        autofarm = Value
        while autofarm and task.wait(0.5) do
            local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame * CFrame.new(math.random(-10,10), 0, math.random(-10,10))
            end
        end
    end,
})

-- Auto Collect Coins + Auto Fling + Auto Kill All
MainTab:CreateToggle({
    Name = "Auto Collect Coins",
    CurrentValue = false,
    Callback = function(Value)
        autocoin = Value
        while autocoin and task.wait(0.25) do
            local player = game.Players.LocalPlayer
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not root then continue end

            for _,v in pairs(workspace:GetChildren()) do
                if v.Name == "Coin" then
                    root.CFrame = v.CFrame
                    task.wait(0.15)
                end
            end

            local gui = player:FindFirstChild("PlayerGui")
            local bag = gui and gui:FindFirstChild("MainGUI") and gui.MainGUI:FindFirstChild("Game") and gui.MainGUI.Game:FindFirstChild("CashBag")
            if bag and bag:FindFirstChild("Full") and bag.Full.Visible == true then

                -- Fling Murderer
                for _,plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= player and plr.Character then
                        if plr.Backpack:FindFirstChild("Knife") or (plr.Character:FindFirstChild("Knife")) then
                            local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")
                            if root and targetHRP then
                                root.CFrame = targetHRP.CFrame + Vector3.new(0, 2, 0)
                                local bv = Instance.new("BodyVelocity", root)
                                bv.Velocity = Vector3.new(0, 200, 0)
                                bv.MaxForce = Vector3.new(99999,99999,99999)
                                game.Debris:AddItem(bv, 0.3)

                                Rayfield:Notify({
                                    Title = "Auto Fling",
                                    Content = "Bag full. Flinged the Murderer!",
                                    Duration = 4,
                                    Image = 4483362458,
                                })
                                break
                            end
                        end
                    end
                end

                -- Kill All (if YOU are the Murderer)
                if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
                    for _,other in pairs(game.Players:GetPlayers()) do
                        if other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
                            local otherHRP = other.Character.HumanoidRootPart
                            root.CFrame = otherHRP.CFrame + Vector3.new(0, 1, 0)
                            task.wait(0.3)
                        end
                    end

                    Rayfield:Notify({
                        Title = "Auto Kill All",
                        Content = "You are Murderer & bag is full. Everyone eliminated!",
                        Duration = 4,
                        Image = 4483362458,
                    })
                end
            end
        end
    end,
})

-- Beachball Dupe
MainTab:CreateButton({
    Name = "🏐 Beachball Dupe",
    Callback = function()
        local player = game.Players.LocalPlayer
        local backpack = player:FindFirstChild("Backpack")
        local ball = backpack and backpack:FindFirstChild("Beachball")

        if not ball then
            Rayfield:Notify({
                Title = "Beachball Dupe",
                Content = "Beachball not found in Backpack!",
                Duration = 4,
                Image = 4483362458,
            })
            return
        end

        for i = 1, 30 do
            local clone = ball:Clone()
            clone.Parent = workspace
            clone.Handle.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-5,5), 2, math.random(-5,5))
            task.wait(0.05)
        end

        Rayfield:Notify({
            Title = "Beachball Dupe",
            Content = "Spawned 30 duplicated beachballs!",
            Duration = 5,
            Image = 4483362458,
        })
    end,
})

-- ESP
MainTab:CreateToggle({
    Name = "ESP: Murderer / Sheriff",
    CurrentValue = false,
    Callback = function(Value)
        esp_enabled = Value
        while esp_enabled and task.wait(1) do
            for _,plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and not plr.Character:FindFirstChild("ESP") then
                    local role = "Innocent"
                    if plr.Backpack:FindFirstChild("Gun") or plr.Character:FindFirstChild("Gun") then
                        role = "Sheriff"
                    elseif plr.Backpack:FindFirstChild("Knife") or plr.Character:FindFirstChild("Knife") then
                        role = "Murderer"
                    end

                    local tag = Instance.new("BillboardGui", plr.Character)
                    tag.Name = "ESP"
                    tag.Size = UDim2.new(0,100,0,40)
                    tag.AlwaysOnTop = true
                    tag.StudsOffset = Vector3.new(0,3,0)

                    local label = Instance.new("TextLabel", tag)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = (role == "Murderer" and Color3.fromRGB(255,0,0)) or (role == "Sheriff" and Color3.fromRGB(0,255,0)) or Color3.fromRGB(255,255,255)
                    label.Text = role
                    label.TextStrokeTransparency = 0.5
                end
            end
        end
    end,
})

-- WalkSpeed & JumpPower
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end,
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 150},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end,
})

PlayerTab:CreateDropdown({
    Name = "Teleport To",
    Options = {"Lobby", "Gun", "Murderer"},
    CurrentOption = "Lobby",
    Callback = function(Option)
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Option == "Lobby" and hrp then
            hrp.CFrame = CFrame.new(Vector3.new(0, 100, 0))
        elseif Option == "Gun" then
            for _,obj in pairs(workspace:GetChildren()) do
                if obj.Name == "GunDrop" and hrp then
                    hrp.CFrame = obj.CFrame
                end
            end
        elseif Option == "Murderer" then
            for _,plr in pairs(game.Players:GetPlayers()) do
                if plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife")) then
                    local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHRP then
                        hrp.CFrame = targetHRP.CFrame + Vector3.new(0,3,0)
                    end
                end
            end
        end
    end,
})

-- Anti-AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
