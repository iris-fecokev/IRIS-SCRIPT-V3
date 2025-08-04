--[[
  === КОНФИГУРАЦИЯ ===
  Измените эти параметры перед запуском скрипта
]]
local Config = {
    -- Настройки декалов
    DecalID = 1365169983,          -- ID изображения для декалов
    
    -- Настройки звуков
    SpookySoundID = 93740699051485,      -- ID звука Spooky Scary Skeletons
    SoundDuration = 98,             -- Длительность звука в секундах
    
    -- Настройки полета
    FlyHistorySize = 100,           -- Количество запоминаемых позиций
    TeleportDelayIndex = 5,        -- Индекс в истории для телепорта
    
    -- Настройки спина
    SpinSpeed = 180,                -- Скорость вращения (градусы в секунду)
    SpinInterval = 0.01,            -- Интервал обновления вращения
    
    -- Настройки античита
    AntiCheatCheckInterval = 0.2,     -- Интервал проверки в секундах
    FlyDetectionThreshold = 5,      -- Порог обнаружения полета (метры)
    
    -- Настройки репортов
    ReportSpamCount = 99999,          -- Количество репортов при спаме
    
    -- Настройки интерфейса
    DefaultTheme = "Dark",          -- Стандартная тема (Modern, Dark, Light, Blood, Aqua)
    DefaultLanguage = "ru",         -- Стандартный язык (ru, en, de, fr, es)
    
    -- Безопасность
    ProtectScript = true            -- Защита скрипта от просмотра
}

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

-- Таблица переводов
local Translations = {
    ru = {
        WindowTitle = "Тестовый скрипт",
        MainTab = "Основное",
        Speed = "Скорость",
        JumpPower = "Сила прыжка",
        SpamDecals = "Спам декалами",
        Fly = "Полет",
        Spin = "Спин",
        SoundTab = "Звук",
        SoundID = "ID звука",
        PlaySound = "Включить звук",
        SpookySound = "Spooky Scary Skeletons",
        KindnessTab = "Режим Доброты",
        BanCheaters = "Бан читеров",
        ReportSpam = "Спам репортами",
        AntiCheat = "Включить античит",
        MapTab = "Карта",
        RemoveWater = "Удалить воду",
        IncreaseGravity = "Увеличить гравитацию",
        ObjectID = "ID объекта",
        SettingsTab = "Настройки",
        Theme = "Тема",
        Language = "Язык",
        Success = "Успех!",
        Activated = "Скрипт активирован!",
        Config = "Конфиг",
        DecalID = "ID декала",
        SoundID = "ID звука",
        FlySettings = "Настройки полета",
        SpinSettings = "Настройки спина",
        AntiCheatSettings = "Настройки античита"
    },
    en = {
        WindowTitle = "Test Script",
        MainTab = "Main",
        Speed = "Speed",
        JumpPower = "Jump Power",
        SpamDecals = "Spam Decals",
        Fly = "Fly",
        Spin = "Spin",
        SoundTab = "Sound",
        SoundID = "Sound ID",
        PlaySound = "Play Sound",
        SpookySound = "Spooky Scary Skeletons",
        KindnessTab = "Kindness Mode",
        BanCheaters = "Ban Cheaters",
        ReportSpam = "Spam Reports",
        AntiCheat = "Enable Anti-Cheat",
        MapTab = "Map",
        RemoveWater = "Remove Water",
        IncreaseGravity = "Increase Gravity",
        ObjectID = "Object ID",
        SettingsTab = "Settings",
        Theme = "Theme",
        Language = "Language",
        Success = "Success!",
        Activated = "Script activated!",
        Config = "Config",
        DecalID = "Decal ID",
        SoundID = "Sound ID",
        FlySettings = "Fly Settings",
        SpinSettings = "Spin Settings",
        AntiCheatSettings = "Anti-Cheat Settings"
    },
    de = {
        WindowTitle = "Test-Skript",
        MainTab = "Haupt",
        Speed = "Geschwindigkeit",
        JumpPower = "Sprungkraft",
        SpamDecals = "Decals spammen",
        Fly = "Fliegen",
        Spin = "Drehen",
        SoundTab = "Ton",
        SoundID = "Sound ID",
        PlaySound = "Sound abspielen",
        SpookySound = "Spooky Scary Skeletons",
        KindnessTab = "Freundlichkeitsmodus",
        BanCheaters = "Cheater bannen",
        ReportSpam = "Berichte spammen",
        AntiCheat = "Anti-Cheat aktivieren",
        MapTab = "Karte",
        RemoveWater = "Wasser entfernen",
        IncreaseGravity = "Schwerkraft erhöhen",
        ObjectID = "Objekt ID",
        SettingsTab = "Einstellungen",
        Theme = "Thema",
        Language = "Sprache",
        Success = "Erfolg!",
        Activated = "Skript aktiviert!",
        Config = "Konfiguration",
        DecalID = "Decal-ID",
        SoundID = "Sound-ID",
        FlySettings = "Flugeinstellungen",
        SpinSettings = "Dreheinstellungen",
        AntiCheatSettings = "Anti-Cheat-Einstellungen"
    }
}

-- Текущие настройки
local currentSettings = {
    Theme = Config.DefaultTheme,
    Language = Config.DefaultLanguage
}

-- Применение настроек
local function applySettings()
    Rayfield:SetTheme(currentSettings.Theme)
    return Translations[currentSettings.Language] or Translations.ru
end

-- Создание окна
local t = applySettings()
local Window = Rayfield:CreateWindow({
    Name = t.WindowTitle,
    LoadingTitle = t.WindowTitle,
    LoadingSubtitle = "by Тестер",
    ConfigurationSaving = { 
        Enabled = true, 
        FolderName = "TestConfig", 
        FileName = "Config.json",
        Callback = function(config)
            currentSettings.Theme = config.Theme or Config.DefaultTheme
            currentSettings.Language = config.Language or Config.DefaultLanguage
            t = applySettings()
        end
    }
})

-- Перемещение окна
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
local MainTab = Window:CreateTab(t.MainTab, 4483362458)
local SoundTab = Window:CreateTab(t.SoundTab, 9753762467)
local KindnessTab = Window:CreateTab(t.KindnessTab, 7733960981)
local MapTab = Window:CreateTab(t.MapTab, 1234526789)
local SettingsTab = Window:CreateTab(t.SettingsTab, 7733923451)
local ConfigTab = Window:CreateTab(t.Config, 7733965432) -- Новая вкладка для конфига

--[[ ФУНКЦИИ ]]
-- Декалы
local function spamDecals()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local decal = Instance.new("Decal")
            decal.Texture = "rbxassetid://"..Config.DecalID
            decal.Face = "Top"
            decal.Parent = obj
        end
    end
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local decal = Instance.new("Decal")
                    decal.Texture = "rbxassetid://"..Config.DecalID
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
            if #lastPositions > Config.FlyHistorySize then 
                table.remove(lastPositions) 
            end
            if #lastPositions >= 2 then
                local targetIndex = math.min(Config.TeleportDelayIndex, #lastPositions)
                character.HumanoidRootPart.CFrame = CFrame.new(lastPositions[targetIndex])
            end
        end)
    end
end

-- Спин
local function spinPlayer()
    spinActive = not spinActive
    if spinActive then
        while spinActive do
            local rotation = Config.SpinSpeed * Config.SpinInterval
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(rotation), 0)
            task.wait(Config.SpinInterval)
        end
    end
end

-- Античит
local function initAntiCheat()
    game.Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            local root = char:WaitForChild("HumanoidRootPart")
            local lastY = root.Position.Y
            local timer = 0
            
            game:GetService("RunService").Heartbeat:Connect(function(step)
                timer += step
                if timer > Config.AntiCheatCheckInterval then
                    if root.Position.Y > lastY + Config.FlyDetectionThreshold and 
                       not char.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                        print("Обнаружен FLY: "..plr.Name)
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
MainTab:CreateSlider(t.Speed, 16, 500, 50, function(value)
    humanoid.WalkSpeed = value
end)

MainTab:CreateSlider(t.JumpPower, 50, 500, 100, function(value)
    humanoid.JumpPower = value
end)

MainTab:CreateButton(t.SpamDecals, spamDecals)

MainTab:CreateToggle(t.Fly, fly)

MainTab:CreateToggle(t.Spin, spinPlayer)

-- Звук
local soundIdInput = SoundTab:CreateInputField(t.SoundID, "Enter ID...")
SoundTab:CreateButton(t.PlaySound, function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://"..soundIdInput:GetText()
            sound.Parent = plr.Character.HumanoidRootPart
            sound:Play()
            game:GetService("Debris"):AddItem(sound, Config.SoundDuration)
        end
    end
end)

SoundTab:CreateButton(t.SpookySound, function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://"..Config.SpookySoundID
            sound.Parent = plr.Character.HumanoidRootPart
            sound:Play()
            game:GetService("Debris"):AddItem(sound, Config.SoundDuration)
        end
    end
end)

-- Режим Доброты
KindnessTab:CreateButton(t.BanCheaters, function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then
            print("Бан игрока: "..plr.Name)
        end
    end
end)

KindnessTab:CreateButton(t.ReportSpam, function()
    for i = 1, Config.ReportSpamCount do
        game:GetService("ReplicatedStorage").ReportAbuse:FireServer(
            "Cheating", "Использует читы", game.Players:GetPlayers()[2]
        )
        task.wait(0.1)
    end
end)

KindnessTab:CreateButton(t.AntiCheat, initAntiCheat)

-- Модификатор карты
MapTab:CreateButton(t.RemoveWater, function()
    if workspace:FindFirstChild("Water") then
        workspace.Water:Destroy()
    end
end)

MapTab:CreateButton(t.IncreaseGravity, function()
    workspace.Gravity = 196.2
end)

MapTab:CreateInputField(t.ObjectID, "Enter ID...", function(text)
    local id = tonumber(text)
    if id then
        local obj = game:GetService("InsertService"):LoadAsset(id):GetChildren()[1]
        obj.Parent = workspace
    end
end)

-- Настройки
SettingsTab:CreateDropdown(t.Theme, {"Modern", "Dark", "Light", "Blood", "Aqua"}, function(option)
    currentSettings.Theme = option
    Rayfield:SetTheme(option)
end)

SettingsTab:CreateDropdown(t.Language, {"ru", "en", "de", "fr", "es"}, function(option)
    currentSettings.Language = option
    t = applySettings()
    Rayfield:Notify(t.Success, t.Activated, 5)
end)

-- Конфигурация (новая вкладка)
ConfigTab:CreateInputField(t.DecalID, tostring(Config.DecalID), function(text)
    Config.DecalID = tonumber(text) or Config.DecalID
end)

ConfigTab:CreateInputField(t.SoundID, tostring(Config.SpookySoundID), function(text)
    Config.SpookySoundID = tonumber(text) or Config.SpookySoundID
end)

ConfigTab:CreateSection(t.FlySettings)
ConfigTab:CreateInputField("Размер истории", tostring(Config.FlyHistorySize), function(text)
    Config.FlyHistorySize = tonumber(text) or Config.FlyHistorySize
end)

ConfigTab:CreateInputField("Задержка телепорта", tostring(Config.TeleportDelayIndex), function(text)
    Config.TeleportDelayIndex = tonumber(text) or Config.TeleportDelayIndex
end)

ConfigTab:CreateSection(t.SpinSettings)
ConfigTab:CreateInputField("Скорость вращения", tostring(Config.SpinSpeed), function(text)
    Config.SpinSpeed = tonumber(text) or Config.SpinSpeed
end)

ConfigTab:CreateInputField("Интервал вращения", tostring(Config.SpinInterval), function(text)
    Config.SpinInterval = tonumber(text) or Config.SpinInterval
end)

ConfigTab:CreateSection(t.AntiCheatSettings)
ConfigTab:CreateInputField("Интервал проверки", tostring(Config.AntiCheatCheckInterval), function(text)
    Config.AntiCheatCheckInterval = tonumber(text) or Config.AntiCheatCheckInterval
end)

ConfigTab:CreateInputField("Порог обнаружения", tostring(Config.FlyDetectionThreshold), function(text)
    Config.FlyDetectionThreshold = tonumber(text) or Config.FlyDetectionThreshold
end)

-- Инициализация
Rayfield:Notify(t.Success, t.Activated, 5)

-- Защита скрипта
if Config.ProtectScript then
    coroutine.wrap(function()
        while true do
            local s, err = pcall(function()
                if not Rayfield or not Window then
                    error("Script integrity compromised")
                end
            end)
            if not s then
                game:Shutdown()
            end
            wait(5)
        end
    end)()
end
