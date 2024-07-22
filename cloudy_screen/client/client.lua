local isUnconscious = false  -- Переменная для отслеживания состояния сознания, false = в сознании
local isPlayerDead = false  -- Переменная для отслеживания состояния игрока, false = жив

local screenEffectThread = nil
local audioSceneThread = nil

-- Функция для активации эффекта потери сознания
function startUnconsciousEffect()
    if isUnconscious then 
        print("Effect already active, returning.")
        return 
    end  -- Проверяем, активен ли уже эффект

    isUnconscious = true  -- Устанавливаем состояние в "потеря сознания"
    local playerPed = PlayerPedId()

    -- Применяем экранный эффект только если игрок мертв
    if isPlayerDead then
        print("Starting unconscious effect: applying screen effects")
        StartScreenEffect("DrugsMichaelAliensFight", 0, true)
        SetTimecycleModifier("hud_def_blur")
        SetTimecycleModifierStrength(0.5)
    else
        print("Player is not dead, cannot start unconscious effect.")
        return
    end

    -- Создаем поток для постоянного глушения звуков
    audioSceneThread = Citizen.CreateThread(function()
        print("Started audio scene.")
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        while isUnconscious do
            Citizen.Wait(100)
        end
        StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        print("Stopped audio scene.")
    end)

    -- Создаем поток для управления экранными эффектами
    screenEffectThread = Citizen.CreateThread(function()
        -- Переход от мутного экрана к темному и обратно
        while isUnconscious do
            Citizen.Wait(5000)  -- период мутного экрана
            if isUnconscious then
                -- Затенение экрана только если состояние isUnconscious все еще true
                DoScreenFadeOut(1000)  -- длительность затенения экрана
                Citizen.Wait(1500)  -- время темного экрана
                DoScreenFadeIn(1000)  -- длительность восстановления экрана
            end
        end

        -- Очищаем эффекты, если эффект закончился
        ClearTimecycleModifier()
        StopScreenEffect("DrugsMichaelAliensFight")
        print("Stopping unconscious effect: clearing screen effects")
    end)

end

-- Функция для отключения эффекта потери сознания
function stopUnconsciousEffect()
    if not isUnconscious then 
        print("Effect not active, returning.")
        return
    end

    isUnconscious = false  -- Устанавливаем состояние в "сознание"

    -- Добавляем лог для отладки
    print("Stopping unconscious effect: clearing screen effects")

    -- Немедленно завершаем потоки
    if screenEffectThread then
        TerminateThread(screenEffectThread)
        screenEffectThread = nil
    end

    if audioSceneThread then
        TerminateThread(audioSceneThread)
        audioSceneThread = nil
    end

    ClearTimecycleModifier()
    StopScreenEffect("DrugsMichaelAliensFight")
    StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    print("Unconscious effect stopped.")
end

-- Обработчик события для смерти игрока
AddEventHandler('baseevents:onPlayerDied', function()
    print("Event handler 'baseevents:onPlayerDied' triggered.")
    isPlayerDead = true
    print("Player died event triggered, starting unconscious effect.")
    startUnconsciousEffect()
end)

-- Функция для ручного респавна игрока
function respawnPlayer(coords)
    isPlayerDead = false  -- Сбрасываем состояние "мертв"
    isUnconscious = false  -- Сбрасываем состояние "потеря сознания"
    
    local playerPed = PlayerPedId()
    ResurrectPed(playerPed)
    SetEntityCoords(playerPed, coords)
    ClearPedTasksImmediately(playerPed)
    print("Player respawned at coords: ", coords)

    -- Удаляем эффекты
    ClearTimecycleModifier()
    StopScreenEffect("DrugsMichaelAliensFight")
    StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    print("Forcibly stopping unconscious effect after respawn.")
end

-- Команда для тестовой активации эффекта
RegisterCommand('cloudy', function()
    isPlayerDead = true  -- Считаем, что игрок мертв
    isPlayerDeadFromCommand = true  -- Устанавливаем флаг, что команда активирована
    print("Testing: simulating player death, starting unconscious effect.")
    startUnconsciousEffect()
end, false)


-- Обработчик события для респавна игрока
AddEventHandler('baseevents:onPlayerSpawned', function()
    print("Event handler 'baseevents:onPlayerSpawned' triggered.")
    if not isPlayerDead then
        print("Player is alive, stopping unconscious effect.")
        stopUnconsciousEffect()
    end
end)

-- Обработчик состояния игрока для проверки жив ли игрок
AddEventHandler('playerStateCheck', function()
    if not IsEntityDead(PlayerPedId()) then
        if not isPlayerDeadFromCommand then  -- Добавлено условие, что не активирована команда 'cloudy'
            if isPlayerDead then
                isPlayerDead = false
                print("Player is alive, stopping unconscious effect.")
                stopUnconsciousEffect()
            end
        end
    end
end)

-- Запуск потока для регулярной проверки состояния игрока
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Проверяем каждую 0.1 секунду
        TriggerEvent('playerStateCheck')
    end
end)

-- Команда для ручного отключения эффекта
RegisterCommand('uncloudy', function()
    isPlayerDead = false
    isPlayerDeadFromCommand = false  -- Устанавливаем флаг, что команда деактивирована
    print("Manual command: stopping unconscious effect.")
    stopUnconsciousEffect()
end)

-- Устанавливаем авто-респавн в false при старте ресурса
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        exports.spawnmanager:setAutoSpawn(false)
        print("Auto spawn disabled on resource start")
    end
end)

-- Обработчик события окончания таймера
RegisterNetEvent('timer:finished')
AddEventHandler('timer:finished', function()
    print("[Cloudy_screen Resource] Received event 'timer:finished'")
    timerFinished = true
    stopUnconsciousEffect()  -- Oстановкa мутного при завершении таймера
end)
