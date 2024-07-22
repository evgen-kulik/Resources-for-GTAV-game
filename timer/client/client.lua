-- local spawnPos = vector3(686.245, 577.950, 130.461)
-- local reviveTime = Config.ReviveTime -- Время в секундах до автоматического респавна (по умолчанию 5 минут)
-- local isDead = false
-- local reviveTimer = reviveTime
-- local deathCoords = nil -- Координаты места смерти
-- local isHelpCalled = false
-- local instructionText = "TO CALL MEDICAL PRESS ~y~H~s~" -- Начальный текст инструкции

-- -- Обработчик события старта ресурса
-- AddEventHandler('onClientResourceStart', function(resourceName)
--     if resourceName == GetCurrentResourceName() then
--         print("Event onClientResourceStart triggered for resource: " .. resourceName)
        
--         -- Устанавливаем callback для авто-респавна
--         exports.spawnmanager:setAutoSpawnCallback(function()
--             print("Auto spawn callback triggered")
            
--             exports.spawnmanager:spawnPlayer({
--                 x = spawnPos.x,
--                 y = spawnPos.y,
--                 z = spawnPos.z,
--                 model = 's_m_m_movspace_01'
--             }, function()
--                 print("Player spawned successfully")
                
--                 TriggerEvent('chat:addMessage', {
--                     args = { 'Welcome to the party!' }
--                 })
--             end)
--         end)

--         -- Принудительный респавн игрока
--         exports.spawnmanager:forceRespawn()
--         print("Force respawn triggered")
--     end
-- end)

-- print("Script loaded")

-- -- Обработчик события смерти игрока
-- AddEventHandler('baseevents:onPlayerDied', function()
--     isDead = true
--     reviveTimer = reviveTime
--     local playerPed = PlayerPedId()
--     deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
--     print("Player died, revive timer started at coords: ", deathCoords)

--     -- Отключаем авто-респавн
--     exports.spawnmanager:setAutoSpawn(false)
--     print("Auto spawn disabled on player death")

--     Citizen.CreateThread(function()
--         while isDead and reviveTimer > 0 do
--             Citizen.Wait(1000) -- Проверяем каждую секунду
--             reviveTimer = reviveTimer - 1
--             exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
--         end

--         if reviveTimer <= 0 and isDead then
--             respawnPlayer(spawnPos) -- Автоматический респавн по истечении таймера на начальной позиции
--         end
--     end)

--     Citizen.CreateThread(function()
--         while isDead do
--             Citizen.Wait(0) -- Проверка на каждом кадре
--             DrawTimer(reviveTimer)
--         end
--     end)
-- end)

-- -- Обработчик события убийства игрока другим игроком
-- AddEventHandler('baseevents:onPlayerKilled', function()
--     isDead = true
--     reviveTimer = reviveTime
--     local playerPed = PlayerPedId()
--     deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
--     print("Player killed, revive timer started at coords: ", deathCoords)

--     -- Отключаем авто-респавн
--     exports.spawnmanager:setAutoSpawn(false)
--     print("Auto spawn disabled on player killed")

--     Citizen.CreateThread(function()
--         while isDead and reviveTimer > 0 do
--             Citizen.Wait(1000) -- Проверяем каждую секунду
--             reviveTimer = reviveTimer - 1
--             exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
--         end

--         if reviveTimer <= 0 and isDead then
--             respawnPlayer(spawnPos) -- Автоматический респавн по истечении таймера на начальной позиции
--         end
--     end)

--     Citizen.CreateThread(function()
--         while isDead do
--             Citizen.Wait(0) -- Проверка на каждом кадре
--             DrawTimer(reviveTimer)
--         end
--     end)
-- end)

-- -- Функция респавна игрока
-- function respawnPlayer(coords)
--     isDead = false
--     local playerPed = PlayerPedId()
--     ResurrectPed(playerPed)
--     SetEntityCoords(playerPed, coords)
--     ClearPedTasksImmediately(playerPed)
--     print("Player respawned at coords: ", coords)
--     -- Сброс переменных
--     isHelpCalled = false
--     instructionText = "TO CALL MEDICAL PRESS ~y~H~s~"
--     reviveTimer = Config.ReviveTime
--     reviveTime = Config.ReviveTime
-- end

-- -- Команда для ручного респавна игрока (вводится в чат как /respawn)
-- RegisterCommand('respawn', function()
--     if isDead then
--         respawnPlayer(spawnPos) -- Респавн на начальной позиции
--     else
--         print("Player is not dead, respawn not required")
--     end
-- end, false)

-- -- Команда для реанимации игрока (вводится в чат как /revive)
-- RegisterCommand('revive', function()
--     if isDead then
--         respawnPlayer(deathCoords) -- Реанимация на месте смерти
--         print("Player revived at death coords")
--     else
--         print("Player is not dead, revive not required")
--     end
-- end, false)

-- -- Функция для отображения таймера на экране и диаграммы
-- function DrawTimer(time)
--     -- Текст для отображения таймера
--     local text = "RESPAWN IN: " .. time .. " SECONDS"

--     -- Параметры для текста таймера
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0, 255)
--     SetTextEdge(2, 0, 0, 0, 150)
--     SetTextCentre(true)

--     -- Рисуем текст таймера
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(0.5, 0.75)  -- Отображаем текст выше прогресс-бара

--     -- Параметры для текста инструкции
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0, 255)
--     SetTextEdge(2, 0, 0, 0, 150)
--     SetTextCentre(true)

--     -- Рисуем текст инструкции
--     SetTextEntry("STRING")
--     AddTextComponentString(instructionText)
--     DrawText(0.5, 0.78)  -- Отображаем текст выше прогресс-бара

--     -- Расчет ширины текста
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     local textWidth = (GetTextScreenWidth(false) + 0.02) * 1.2  -- Немного шире текста

--     -- Определяем ширину прогресс-бара
--     local barWidth = 3 * textWidth
--     if isHelpCalled then
--         barWidth = barWidth * 2 -- Удлиняем ширину в два раза после нажатия "H"
--     end

--     local barHeight = 0.02
--     local barY = 0.82  -- Бар ближе к тексту

--     -- Рисуем прогресс-бар
--     local progress = time / reviveTime
--     local baseX = 0.5 -- Центр экрана
--     local progressWidth = barWidth * progress
--     local progressX = baseX - (barWidth / 2) + (progressWidth / 2)

--     -- Цвет прогресс-бара
--     local barColorR, barColorG, barColorB = 255, 0, 0  -- Красный цвет по умолчанию
--     if isHelpCalled then
--         barColorR, barColorG, barColorB = 0, 255, 0  -- Зеленый цвет при нажатии "H"
--     end

--     -- Задний прямоугольник (фон)
--     DrawRect(baseX, barY, barWidth, barHeight, 0, 0, 0, 100)
    
--     -- Передний прямоугольник (прогресс)
--     DrawRect(progressX, barY, progressWidth, barHeight, barColorR, barColorG, barColorB, 200)
-- end

-- -- Обработчик нажатия клавиши "H"
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
        
--         if IsControlJustReleased(1, 74) and isDead and not isHelpCalled then -- 74 - это код клавиши "H"
--             reviveTimer = 360 -- Увеличиваем таймер до 360 секунд
--             reviveTime = 360 -- Устанавливаем новый максимальный таймер
--             print("Revive timer increased to 360 seconds")
--             instructionText = "AMBULANCE IS COMING" -- Меняем текст инструкции
--             isHelpCalled = true -- Блокируем повторное нажатие клавиши "H"
--             TriggerServerEvent('hospital:server:HelpRequest', GetEntityCoords(PlayerPedId())) -- Отправляем координаты места смерти
--         end
--     end
-- end)

-- -- Устанавливаем авто-респавн в false при старте ресурса
-- AddEventHandler('onClientResourceStart', function(resourceName)
--     if resourceName == GetCurrentResourceName() then
--         exports.spawnmanager:setAutoSpawn(false)
--         print("Auto spawn disabled on resource start")
--     end
-- end)




-- local spawnPos = vector3(686.245, 577.950, 130.461)
-- local reviveTime = Config.ReviveTime -- Время в секундах до автоматического респавна (по умолчанию 5 минут)
-- local timerAfterAmbulanceCall = Config.TimerAfterAmbulanceCall
-- local isDead = false
-- local reviveTimer = reviveTime
-- local deathCoords = nil -- Координаты места смерти
-- local isHelpCalled = false
-- local instructionText = "TO CALL MEDICAL PRESS ~y~H~s~" -- Начальный текст инструкции

-- -- Обработчик события старта ресурса
-- AddEventHandler('onClientResourceStart', function(resourceName)
--     if resourceName == GetCurrentResourceName() then
--         print("Event onClientResourceStart triggered for resource: " .. resourceName)
        
--         -- Устанавливаем callback для авто-респавна
--         exports.spawnmanager:setAutoSpawnCallback(function()
--             print("Auto spawn callback triggered")
            
--             exports.spawnmanager:spawnPlayer({
--                 x = spawnPos.x,
--                 y = spawnPos.y,
--                 z = spawnPos.z,
--                 model = 's_m_m_movspace_01'
--             }, function()
--                 print("Player spawned successfully")
                
--                 TriggerEvent('chat:addMessage', {
--                     args = { 'Welcome to the party!' }
--                 })
--             end)
--         end)

--         -- Принудительный респавн игрока
--         exports.spawnmanager:forceRespawn()
--         print("Force respawn triggered")

--         -- Скрываем черный экран при старте ресурса
--         HideRespawnScreen()
--     end
-- end)

-- -- Обработчик события смерти игрока
-- AddEventHandler('baseevents:onPlayerDied', function()
--     isDead = true
--     reviveTimer = reviveTime
--     local playerPed = PlayerPedId()
--     deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
--     print("Player died, revive timer started at coords: ", deathCoords)

--     -- Отключаем авто-респавн
--     exports.spawnmanager:setAutoSpawn(false)
--     print("Auto spawn disabled on player death")

--     Citizen.CreateThread(function()
--         while isDead and reviveTimer > 0 do
--             Citizen.Wait(1000) -- Проверяем каждую секунду
--             reviveTimer = reviveTimer - 1
--             exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
--         end

--         if reviveTimer <= 0 and isDead then
--             ShowRespawnScreen() -- Показ черного экрана с кнопкой
--         end
--     end)

--     Citizen.CreateThread(function()
--         while isDead do
--             Citizen.Wait(0) -- Проверка на каждом кадре
--             DrawTimer(reviveTimer)
--         end
--     end)
-- end)

-- -- Обработчик события убийства игрока другим игроком
-- AddEventHandler('baseevents:onPlayerKilled', function()
--     isDead = true
--     reviveTimer = reviveTime
--     local playerPed = PlayerPedId()
--     deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
--     print("Player killed, revive timer started at coords: ", deathCoords)

--     -- Отключаем авто-респавн
--     exports.spawnmanager:setAutoSpawn(false)
--     print("Auto spawn disabled on player killed")

--     Citizen.CreateThread(function()
--         while isDead and reviveTimer > 0 do
--             Citizen.Wait(1000) -- Проверяем каждую секунду
--             reviveTimer = reviveTimer - 1
--             exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
--         end

--         if reviveTimer <= 0 and isDead then
--             ShowRespawnScreen() -- Показ черного экрана с кнопкой
--         end
--     end)

--     Citizen.CreateThread(function()
--         while isDead do
--             Citizen.Wait(0) -- Проверка на каждом кадре
--             DrawTimer(reviveTimer)
--         end
--     end)
-- end)

-- -- Функция респавна игрока
-- function respawnPlayer(coords)
--     print("respawnPlayer called with coords: ", coords)
--     isDead = false
--     local playerPed = PlayerPedId()
--     ResurrectPed(playerPed)
--     SetEntityCoords(playerPed, coords)
--     ClearPedTasksImmediately(playerPed)
--     print("Player respawned at coords: ", coords)
--     -- Сброс переменных
--     isHelpCalled = false
--     instructionText = "TO CALL MEDICAL PRESS ~y~H~s~"
--     reviveTimer = Config.ReviveTime
--     reviveTime = Config.ReviveTime
--     HideRespawnScreen() -- Скрываем черный экран после респавна
-- end

-- -- Команда для ручного респавна игрока (вводится в чат как /respawn)
-- RegisterCommand('respawn', function()
--     if isDead then
--         respawnPlayer(spawnPos) -- Респавн на начальной позиции
--     else
--         print("Player is not dead, respawn not required")
--     end
-- end, false)

-- -- Команда для реанимации игрока (вводится в чат как /revive)
-- RegisterCommand('revive', function()
--     if isDead then
--         respawnPlayer(deathCoords) -- Реанимация на месте смерти
--         print("Player revived at death coords")
--     else
--         print("Player is not dead, revive not required")
--     end
-- end, false)

-- -- Функция для отображения таймера на экране и диаграммы
-- function DrawTimer(time)
--     -- Текст для отображения таймера
--     local text = "RESPAWN IN: " .. time .. " SECONDS"

--     -- Параметры для текста таймера
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0, 255)
--     SetTextEdge(2, 0, 0, 0, 150)
--     SetTextCentre(true)

--     -- Рисуем текст таймера
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(0.5, 0.75)  -- Отображаем текст выше прогресс-бара

--     -- Параметры для текста инструкции
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0, 255)
--     SetTextEdge(2, 0, 0, 0, 150)
--     SetTextCentre(true)

--     -- Рисуем текст инструкции
--     SetTextEntry("STRING")
--     AddTextComponentString(instructionText)
--     DrawText(0.5, 0.78)  -- Отображаем текст выше прогресс-бара

--     -- Расчет ширины текста
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextScale(0.5, 0.5)
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     local textWidth = (GetTextScreenWidth(false) + 0.02) * 1.2  -- Немного шире текста

--     -- Определяем ширину прогресс-бара
--     local barWidth = 3 * textWidth
--     if isHelpCalled then
--         barWidth = barWidth * 2 -- Удлиняем ширину в два раза после нажатия "H"
--     end

--     local barHeight = 0.02
--     local barY = 0.82  -- Бар ближе к тексту

--     -- Рисуем прогресс-бар
--     local progress = time / reviveTime
--     local baseX = 0.5 -- Центр экрана
--     local progressWidth = barWidth * progress
--     local progressX = baseX - (barWidth / 2) + (progressWidth / 2)

--     -- Цвет прогресс-бара
--     local barColorR, barColorG, barColorB = 255, 0, 0  -- Красный цвет по умолчанию
--     if isHelpCalled then
--         barColorR, barColorG, barColorB = 0, 255, 0  -- Зеленый цвет при нажатии "H"
--     end

--     -- Задний прямоугольник (фон)
--     DrawRect(baseX, barY, barWidth, barHeight, 0, 0, 0, 100)
    
--     -- Передний прямоугольник (прогресс)
--     DrawRect(progressX, barY, progressWidth, barHeight, barColorR, barColorG, barColorB, 200)
-- end

-- -- Обработчик нажатия клавиши "H"
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
        
--         if IsControlJustReleased(1, 74) and isDead and not isHelpCalled then -- 74 - это код клавиши "H"
--             reviveTimer = timerAfterAmbulanceCall -- Увеличиваем таймер до 360 секунд
--             reviveTime = timerAfterAmbulanceCall -- Устанавливаем новый максимальный таймер
--             print("Revive timer increased to 360 seconds")
--             instructionText = "AMBULANCE IS COMING" -- Меняем текст инструкции
--             isHelpCalled = true -- Блокируем повторное нажатие клавиши "H"
--             TriggerServerEvent('hospital:server:HelpRequest', GetEntityCoords(PlayerPedId())) -- Отправляем координаты места смерти
--         end
--     end
-- end)

-- -- Функция для показа черного экрана с кнопкой
-- function ShowRespawnScreen()
--     if isDead and reviveTimer <= 0 then
--         print("[DEBUG] ShowRespawnScreen called, player is dead and revive timer has expired")
--         SetNuiFocus(true, true)
--         SendNUIMessage({
--             action = "showRespawnScreen"
--         })
--     end
-- end

-- -- Функция для выключения черного экрана
-- function HideRespawnScreen()
--     print("[DEBUG] HideRespawnScreen called")
--     SetNuiFocus(false, false)
--     SendNUIMessage({
--         action = "hideRespawnScreen"
--     })
--     print("[DEBUG] NUI Message hideRespawnScreen sent")
-- end

-- -- NUI callback
-- RegisterNUICallback('respawn', function(data, cb)
--     print("[DEBUG] NUI callback 'respawn' called with data:", data)
--     if isDead then -- Проверяем, что игрок мёртв перед респавном
--         print("[DEBUG] Player is dead, proceeding with respawn")
--         respawnPlayer(spawnPos)
--         cb('ok')
--     else
--         print("[DEBUG] Player is not dead, cannot respawn")
--         cb('error')
--     end
-- end)





local spawnPos = vector3(686.245, 577.950, 130.461)
local reviveTime = Config.ReviveTime -- Время в секундах до автоматического респавна (по умолчанию 5 минут)
local timerAfterAmbulanceCall = Config.TimerAfterAmbulanceCall
local isDead = false
local reviveTimer = reviveTime
local deathCoords = nil -- Координаты места смерти
local isHelpCalled = false
local instructionText = "TO CALL MEDICAL PRESS ~y~H~s~" -- Начальный текст инструкции

-- Обработчик события старта ресурса
AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        print("Event onClientResourceStart triggered for resource: " .. resourceName)
        
        -- Устанавливаем callback для авто-респавна
        exports.spawnmanager:setAutoSpawnCallback(function()
            print("Auto spawn callback triggered")
            
            exports.spawnmanager:spawnPlayer({
                x = spawnPos.x,
                y = spawnPos.y,
                z = spawnPos.z,
                model = 's_m_m_movspace_01'
            }, function()
                print("Player spawned successfully")
                
                TriggerEvent('chat:addMessage', {
                    args = { 'Welcome to the party!' }
                })
            end)
        end)

        -- Принудительный респавн игрока
        exports.spawnmanager:forceRespawn()
        print("Force respawn triggered")

        -- Скрываем черный экран при старте ресурса
        HideRespawnScreen()
    end
end)

-- Обработчик события смерти игрока
AddEventHandler('baseevents:onPlayerDied', function()
    isDead = true
    reviveTimer = reviveTime
    local playerPed = PlayerPedId()
    deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
    print("Player died, revive timer started at coords: ", deathCoords)

    -- Отключаем авто-респавн
    exports.spawnmanager:setAutoSpawn(false)
    print("Auto spawn disabled on player death")

    Citizen.CreateThread(function()
        while isDead and reviveTimer > 0 do
            Citizen.Wait(1000) -- Проверяем каждую секунду
            reviveTimer = reviveTimer - 1
            exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
        end

        if reviveTimer <= 0 and isDead then
            -- Логирование события окончания таймера
            print("Timer finished, triggering event 'timer:finished'")
            TriggerServerEvent('timer:finished') -- Отправка события об окончании таймера для остановки звука сердца
            ShowRespawnScreen() -- Показ черного экрана с кнопкой
        end
    end)

    Citizen.CreateThread(function()
        while isDead do
            Citizen.Wait(0) -- Проверка на каждом кадре
            DrawTimer(reviveTimer)
        end
    end)
end)

-- Обработчик события убийства игрока другим игроком
AddEventHandler('baseevents:onPlayerKilled', function()
    isDead = true
    reviveTimer = reviveTime
    local playerPed = PlayerPedId()
    deathCoords = GetEntityCoords(playerPed) -- Сохраняем координаты места смерти
    print("Player killed, revive timer started at coords: ", deathCoords)

    -- Отключаем авто-респавн
    exports.spawnmanager:setAutoSpawn(false)
    print("Auto spawn disabled on player killed")

    Citizen.CreateThread(function()
        while isDead and reviveTimer > 0 do
            Citizen.Wait(1000) -- Проверяем каждую секунду
            reviveTimer = reviveTimer - 1
            exports.spawnmanager:setAutoSpawn(false) -- Отключаем авто-респавн на всякий случай
        end

        if reviveTimer <= 0 and isDead then
            -- Логирование события окончания таймера
            print("Timer finished, triggering event 'timer:finished'")
    
            -- Отправка события об окончании таймера
            TriggerServerEvent('timer:finished')
            ShowRespawnScreen() -- Показ черного экрана с кнопкой
        end
    end)

    Citizen.CreateThread(function()
        while isDead do
            Citizen.Wait(0) -- Проверка на каждом кадре
            DrawTimer(reviveTimer)
        end
    end)
end)

-- Функция респавна игрока
function respawnPlayer(coords)
    print("respawnPlayer called with coords: ", coords)
    isDead = false
    local playerPed = PlayerPedId()
    ResurrectPed(playerPed)
    SetEntityCoords(playerPed, coords)
    ClearPedTasksImmediately(playerPed)
    print("Player respawned at coords: ", coords)
    -- Сброс переменных
    isHelpCalled = false
    instructionText = "TO CALL MEDICAL PRESS ~y~H~s~"
    reviveTimer = Config.ReviveTime
    reviveTime = Config.ReviveTime
    HideRespawnScreen() -- Скрываем черный экран после респавна
end

-- Команда для ручного респавна игрока (вводится в чат как /respawn)
RegisterCommand('respawn', function()
    if isDead then
        respawnPlayer(spawnPos) -- Респавн на начальной позиции
    else
        print("Player is not dead, respawn not required")
    end
end, false)

-- Команда для реанимации игрока (вводится в чат как /revive)
RegisterCommand('revive', function()
    if isDead then
        respawnPlayer(deathCoords) -- Реанимация на месте смерти
        print("Player revived at death coords")
    else
        print("Player is not dead, revive not required")
    end
end, false)

-- Функция для отображения таймера на экране и диаграммы
function DrawTimer(time)
    -- Текст для отображения таймера
    local text = "RESPAWN IN: " .. time .. " SECONDS"

    -- Параметры для текста таймера
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextCentre(true)

    -- Рисуем текст таймера
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.75)  -- Отображаем текст выше прогресс-бара

    -- Параметры для текста инструкции
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextCentre(true)

    -- Рисуем текст инструкции
    SetTextEntry("STRING")
    AddTextComponentString(instructionText)
    DrawText(0.5, 0.78)  -- Отображаем текст выше прогресс-бара

    -- Расчет ширины текста
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    local textWidth = (GetTextScreenWidth(false) + 0.02) * 1.2  -- Немного шире текста

    -- Определяем ширину прогресс-бара
    local barWidth = 3 * textWidth
    if isHelpCalled then
        barWidth = barWidth * 2 -- Удлиняем ширину в два раза после нажатия "H"
    end

    local barHeight = 0.02
    local barY = 0.82  -- Бар ближе к тексту

    -- Рисуем прогресс-бар
    local progress = time / reviveTime
    local baseX = 0.5 -- Центр экрана
    local progressWidth = barWidth * progress
    local progressX = baseX - (barWidth / 2) + (progressWidth / 2)

    -- Цвет прогресс-бара
    local barColorR, barColorG, barColorB = 255, 0, 0  -- Красный цвет по умолчанию
    if isHelpCalled then
        barColorR, barColorG, barColorB = 0, 255, 0  -- Зеленый цвет при нажатии "H"
    end

    -- Задний прямоугольник (фон)
    DrawRect(baseX, barY, barWidth, barHeight, 0, 0, 0, 100)
    
    -- Передний прямоугольник (прогресс)
    DrawRect(progressX, barY, progressWidth, barHeight, barColorR, barColorG, barColorB, 200)
end

-- Обработчик нажатия клавиши "H"
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustReleased(1, 74) and isDead and not isHelpCalled then -- 74 - это код клавиши "H"
            reviveTimer = timerAfterAmbulanceCall -- Увеличиваем таймер
            reviveTime = timerAfterAmbulanceCall -- Устанавливаем новый максимальный таймер
            print("Revive timer increased to " .. timerAfterAmbulanceCall .. "seconds")
            instructionText = "AMBULANCE IS COMING" -- Меняем текст инструкции
            isHelpCalled = true -- Блокируем повторное нажатие клавиши "H"
            TriggerServerEvent('hospital:server:HelpRequest', GetEntityCoords(PlayerPedId())) -- Отправляем координаты места смерти
        end
    end
end)

-- Функция для показа черного экрана с кнопкой
function ShowRespawnScreen()
    if isDead and reviveTimer <= 0 then
        TriggerServerEvent('timer:finished')
        print("[DEBUG] ShowRespawnScreen called, player is dead and revive timer has expired")
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showRespawnScreen"
        })
    end
end

-- Функция для выключения черного экрана
function HideRespawnScreen()
    print("[DEBUG] HideRespawnScreen called")
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideRespawnScreen"
    })
    print("[DEBUG] NUI Message hideRespawnScreen sent")
end

-- NUI callback
RegisterNUICallback('respawn', function(data, cb)
    print("[DEBUG] NUI callback 'respawn' called with data:", data)
    if isDead then -- Проверяем, что игрок мёртв перед респавном
        print("[DEBUG] Player is dead, proceeding with respawn")
        respawnPlayer(spawnPos)
        cb('ok')
    else
        print("[DEBUG] Player is not dead, cannot respawn")
        cb('error')
    end
end)
