-- Rayfield Loader
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
                        if other ~= player and other.
