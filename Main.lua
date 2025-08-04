--[[
  Тестовый скрипт для Roblox (ТОЛЬКО ДЛЯ ОБРАЗОВАТЕЛЬНЫХ ЦЕЛЕЙ)
  Включение: выполнить в консоли (F9 -> Execute)
]]

-- ASCII-арт при запуске
print([[
███─████─███─███────███─████─████─███─████─███
─█──█──█──█──█──────█───█──█─█──█──█──█──█──█─
─█──████──█──███────███─█────████──█──████──█─
─█──█─█───█────█──────█─█──█─█─█───█──█─────█─
███─█─-█─███─███────███─████─█─█──███─█─────█─
]])

loadstring(game:HttpGet("https://raw.githubusercontent.com/RayfieldUI/Rayfield/main/source", true))()

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "Тестовый скрипт",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "by Тестер",
    ConfigurationSaving = { Enabled = true, FolderName = "TestConfig", FileName = "Config.json" }
})

-- Добавляем возможность перемещения окна
local Drag = Window:CreateDrag()
Drag:Set(Window.Main)

-- Основные переменные
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flyActive = false
local spinActive = false
local lastPositions = {}

-- Вкладки
local MainTab = Window:CreateTab("Основное", 4483362458)
local SoundTab = Window:CreateTab("Звук", 9753762467)
local KindnessTab = Window:CreateTab("Режим Доброты", 7733960981)
local MapTab = Window:CreateTab("Карта", 1234526789)

--[[ ФУНКЦИИ ]]
-- Декалы
local function spamDecals()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local decal = Instance.new("Decal")
            decal.Texture = "rbxassetid://1365169983"
            decal.Face = "Top"
            decal.Parent = obj
        end
    end
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local decal = Instance.new("Decal")
                    decal.Texture = "rbxassetid://1365169983"
                    decal.Face = "Front"
                    decal.Parent = part
                end
            end
        end
    end
end

-- Полет
local function fly()
    flyActive = not flyActive
    if flyActive then
        lastPositions = {}
        local flyLoop
        flyLoop = game:GetService("RunService").Heartbeat:Connect(function()
            table.insert(lastPositions, 1, character.HumanoidRootPart.Position)
            if #lastPositions > 100 then table.remove(lastPositions) end
            if #lastPositions >= 2 then
                character.HumanoidRootPart.CFrame = CFrame.new(lastPositions[10] or lastPositions[1])
            end
        end)
    end
end

-- Спин
local function spinPlayer()
    spinActive = not spinActive
    if spinActive then
        while spinActive do
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)
            wait(0.01)
        end
    end
end

-- Античит (тестовый)
local function initAntiCheat()
    game.Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            local root = char:WaitForChild("HumanoidRootPart")
            local lastY = root.Position.Y
            local timer = 0
            
            game:GetService("RunService").Heartbeat:Connect(function(step)
                timer += step
                if timer > 1 then
                    if root.Position.Y > lastY + 5 and not char.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                        print("Обнаружен FLY: "..plr.Name)
                        -- Здесь будет "бан" (имитация)
                    end
                    lastY = root.Position.Y
                    timer = 0
                end
            end)
        end)
    end)
end

--[[ ГУИ ]]
-- Основное
MainTab:CreateSlider("Скорость", 16, 500, 50, function(value)
    humanoid.WalkSpeed = value
end)

MainTab:CreateSlider("Сила прыжка", 50, 500, 100, function(value)
    humanoid.JumpPower = value
end)

MainTab:CreateButton("Спам декалами", spamDecals)

MainTab:CreateToggle("Полет", fly)

MainTab:CreateToggle("Спин", spinPlayer)

-- Звук
local soundIdInput = SoundTab:CreateInputField("ID звука", "Введите ID...")
SoundTab:CreateButton("Включить звук", function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://"..soundIdInput:GetText()
            sound.Parent = plr.Character.HumanoidRootPart
            sound:Play()
        end
    end
end)

SoundTab:CreateButton("Spooky Scary Skeletons", function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://376943451"
            sound.Parent = plr.Character.HumanoidRootPart
            sound:Play()
        end
    end
end)

-- Режим Доброты
KindnessTab:CreateButton("Бан читеров", function()
    -- Имитация бана (тестовая)
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then
            print("Бан игрока: "..plr.Name)
        end
    end
end)

KindnessTab:CreateButton("Спам репортами", function()
    -- Имитация репортов
    for i = 1, 100 do
        game:GetService("ReplicatedStorage").ReportAbuse:FireServer(
            "Cheating", "Использует читы", game.Players:GetPlayers()[2]
        )
        wait(0.1)
    end
end)

KindnessTab:CreateButton("Включить античит", initAntiCheat)

-- Модификатор карты
MapTab:CreateButton("Удалить воду", function()
    if workspace:FindFirstChild("Water") then
        workspace.Water:Destroy()
    end
end)

MapTab:CreateButton("Увеличить гравитацию", function()
    workspace.Gravity = 196.2
end)

MapTab:CreateInputField("ID объекта", "Введите ID...", function(text)
    local id = tonumber(text)
    if id then
        local obj = game:GetService("InsertService"):LoadAsset(id):GetChildren()[1]
        obj.Parent = workspace
    end
end)

-- Инициализация
Rayfield:Notify("Успех!", "Скрипт активирован!", 5)
