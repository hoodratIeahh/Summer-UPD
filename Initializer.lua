--[[ 
MM2 AutoFarm GUI Script
By TestolHub — Full Version
]]--

-- Services
local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        vu:Button2Down(Vector2.new())
        task.wait(1)
        vu:Button2Up(Vector2.new())
    end)
end)

-- Variables
local farmRunning = false
local speedLoop
local autoFlingEnabled = false

-- GUI Setup
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "AutoFarmGUI"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 500)
frame.Position = UDim2.new(0, 20, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local function createButton(text, posY)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BorderSizePixel = 0
    return btn
end

-- Start Farm with Speed
local function startFarmWithSpeed(speedValue)
    if farmRunning then return end
    farmRunning = true

    local delayTime = 1 / speedValue
    speedLoop = coroutine.create(function()
        while farmRunning do
            local char = plr.Character or plr.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targets = {}
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("beach")) then
                        table.insert(targets, v)
                    end
                end
                for _, part in ipairs(targets) do
                    if part and part:IsDescendantOf(workspace) then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.05)
                        firetouchinterest(hrp, part, 0)
                        firetouchinterest(hrp, part, 1)
                        task.wait(delayTime)
                    end
                end
            end
            task.wait(delayTime)
        end
    end)
    coroutine.resume(speedLoop)
end

-- Stop farm
local function stopFarm()
    farmRunning = false
end

-- AutoFarm Speed Input
local speedInput = Instance.new("TextBox", frame)
speedInput.Size = UDim2.new(0, 200, 0, 35)
speedInput.Position = UDim2.new(0, 20, 0, 60)
speedInput.PlaceholderText = "AutoFarm Speed (1-30)"
speedInput.Text = ""
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 18
speedInput.ClearTextOnFocus = false

speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val and val >= 1 and val <= 30 then
        stopFarm()
        startFarmWithSpeed(val)
    else
        speedInput.Text = ""
    end
end)

-- Fastest Autofarm Button (Speed 25)
local fastestBtn = createButton("Enable Fastest AutoFarm", 20)
fastestBtn.MouseButton1Click:Connect(function()
    stopFarm()
    startFarmWithSpeed(25)
end)

-- Coin Detection Toggle
local coinBtn = createButton("Enable Coin Detection", 100)
local coinEnabled = false
coinBtn.MouseButton1Click:Connect(function()
    coinEnabled = not coinEnabled
    coinBtn.Text = coinEnabled and "Coin Detection: ON" or "Enable Coin Detection"
    if coinEnabled then
        startFarmWithSpeed(10)
    else
        stopFarm()
    end
end)

-- Fling Function
local function flingPlayer(targetPlayer)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end
    hrp.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
    for _ = 1, 10 do
        hrp.Velocity = Vector3.new(1000, 1000, 1000)
        hrp.AssemblyAngularVelocity = Vector3.new(9999, 9999, 9999)
        task.wait(0.05)
    end
end

-- Fling Target
local nameBox = Instance.new("TextBox", frame)
nameBox.Size = UDim2.new(0, 200, 0, 35)
nameBox.Position = UDim2.new(0, 20, 0, 140)
nameBox.PlaceholderText = "Enter Player Name"
nameBox.Text = ""
nameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nameBox.TextColor3 = Color3.new(1, 1, 1)
nameBox.Font = Enum.Font.SourceSans
nameBox.TextSize = 18

local flingBtn = createButton("Fling Target", 180)
flingBtn.MouseButton1Click:Connect(function()
    local target = game.Players:FindFirstChild(nameBox.Text)
    if target then
        flingPlayer(target)
    end
end)

-- Kill All (if Murderer)
local killBtn = createButton("☠ Kill All", 220)
killBtn.MouseButton1Click:Connect(function()
    local hasKnife = plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife"))
    if hasKnife then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= plr and p.Character then
                flingPlayer(p)
                task.wait(0.2)
            end
        end
    end
end)

-- Auto Fling Murderer at Max Coins
local autoFlingBtn = createButton("⚙ Auto Fling Murderer: OFF", 260)
autoFlingBtn.MouseButton1Click:Connect(function()
    autoFlingEnabled = not autoFlingEnabled
    autoFlingBtn.Text = autoFlingEnabled and "⚙ Auto Fling Murderer: ON" or "⚙ Auto Fling Murderer: OFF"
    autoFlingBtn.BackgroundColor3 = autoFlingEnabled and Color3.fromRGB(30, 150, 230) or Color3.fromRGB(40, 40, 40)
end)

-- Get Murderer
local function getMurderer()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= plr and player.Character then
            local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
            if hasKnife then return player end
        end
    end
end

-- Bag Full Check
local function isBagFull()
    local container = plr:FindFirstChild("Backpack") and plr.Backpack:FindFirstChild("CoinContainer")
    if not container then return false end
    local coins = container:FindFirstChild("Coins")
    local max = container:FindFirstChild("MaxCoins")
    if coins and max then
        return tonumber(coins.Value) >= tonumber(max.Value)
    end
    return false
end

-- Auto fling logic
task.spawn(function()
    while true do
        task.wait(1)
        if autoFlingEnabled and isBagFull() then
            local murderer = getMurderer()
            if murderer then
                flingPlayer(murderer)
            end
        end
    end
end)
