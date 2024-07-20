local isUnconscious = false
local unconsciousSoundPath = 'sounds/heartbeat.ogg'
local volume = 1.0

-- Функция для начала воспроизведения звука сердца
function PlayNuiSound(filePath, volume)
    print("Playing sound: " .. filePath)
    SendNUIMessage({
        filePath = filePath,
        volume = volume,
        sfx_volume = 1.0
    })
end

-- Функция для остановки воспроизведения звука сердца
function StopNuiSound()
    print("Stopping sound")
    SendNUIMessage({
        filePath = 'stop_sound',
        volume = 0,
        sfx_volume = 0
    })
end

-- Обработчик события смерти игрока
AddEventHandler('baseevents:onPlayerDied', function()
    print("Player died")
    isUnconscious = true
    print("isUnconscious set to true")
    PlayNuiSound(unconsciousSoundPath, volume)
end)

-- Обработчик события убийства игрока другим игроком
AddEventHandler('baseevents:onPlayerKilled', function()
    print("Player killed")
    isUnconscious = true
    print("isUnconscious set to true")
    PlayNuiSound(unconsciousSoundPath, volume)
end)

-- Функция для проверки состояния игрока
function CheckPlayerState()
    local playerPed = PlayerPedId()
    if not IsEntityDead(playerPed) and isUnconscious then
        print("Player is alive, stopping unconscious sound")
        StopNuiSound()
        isUnconscious = false
        print("isUnconscious set to false")
    end
end

-- Запуск функции проверки состояния игрока каждые 1 секунду
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        CheckPlayerState()
    end
end)

RegisterCommand('start_sound', function()
    PlayNuiSound(unconsciousSoundPath, volume)
end)

RegisterCommand('stop_sound', function()
    StopNuiSound()
end)
