-- -- Инициализация QBCore
-- local QBCore = exports['qb-core']:GetCoreObject()

-- if QBCore ~= nil then
--     print('QBCore initialized: ' .. tostring(QBCore ~= nil))
-- else
--     print('QBCore initialization failed: QBCore object not found')
-- end

-- -- Обработчик события 'hospital:server:HelpRequest'
-- RegisterNetEvent('hospital:server:HelpRequest')
-- AddEventHandler('hospital:server:HelpRequest', function(coords)
--     local src = source
--     print('Help request received from source: ' .. tostring(src))

--     if QBCore == nil then
--         print('QBCore is not initialized when handling HelpRequest event.')
--         return
--     end

--     local xPlayer = QBCore.Functions.GetPlayer(src)
--     if xPlayer then
--         print('Player found: ' .. tostring(src))
--         TriggerClientEvent('chat:addMessage', -1, {
--             args = { '[EMS]', 'A player needs help at coordinates: ' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z }
--         })
--         print('Help request sent to EMS at coordinates: ' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z)
--     else
--         print('Player not found for source: ' .. tostring(src))
--         local players = QBCore.Functions.GetPlayers()
--         print('QBCore players: ' .. json.encode(players))
--     end
-- end)

-- -- Обработчик события 'QBCore:Server:PlayerLoaded'
-- RegisterNetEvent('QBCore:Server:PlayerLoaded')
-- AddEventHandler('QBCore:Server:PlayerLoaded', function()
--     local src = source
--     print('QBCore:Server:PlayerLoaded event triggered for source: ' .. tostring(src))

--     if QBCore == nil then
--         print('QBCore is not initialized when handling PlayerLoaded event.')
--         return
--     end

--     local xPlayer = QBCore.Functions.GetPlayer(src)
--     if xPlayer then
--         print('Player successfully registered: ' .. tostring(src))
--     else
--         print('Failed to register player: ' .. tostring(src))
--     end
-- end)

-- -- Обработчик события подключения игрока
-- AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
--     local src = source
--     print('Player connecting: ' .. tostring(src))
-- end)

-- -- Обработчик события отключения игрока
-- AddEventHandler('playerDropped', function(reason)
--     local src = source
--     print('Player dropped: ' .. tostring(src) .. ' Reason: ' .. reason)
-- end)

-- -- Команда для вывода списка текущих игроков
-- RegisterCommand('listplayers', function()
--     if QBCore == nil then
--         print('QBCore is not initialized when handling listplayers command.')
--         return
--     end

--     local players = QBCore.Functions.GetPlayers()
--     print('Current players: ' .. json.encode(players))
-- end, false)

-- -- Команда для проверки инициализации QBCore
-- RegisterCommand('checkQBCore', function()
--     print('QBCore initialized: ' .. tostring(QBCore ~= nil))
-- end, false)

-- -- Обработчик для проверки успешной регистрации игрока в QBCore
-- RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
-- AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
--     local src = source
--     print('Player loaded: ' .. tostring(src))
--     local xPlayer = QBCore.Functions.GetPlayer(src)
--     if xPlayer then
--         print('Player data: ' .. json.encode(xPlayer))
--     else
--         print('Player not found in QBCore after loading: ' .. tostring(src))
--     end
-- end)

-- -- Обработчик для остановки звука сердца по окончании таймера
-- RegisterNetEvent('timer:finished')
-- AddEventHandler('timer:finished', function()
--     print("[Server] Received event 'timer:finished', broadcasting to all clients")
--     TriggerClientEvent('timer:finished', -1)  -- Отправляем всем клиентам
-- end)




-- -- Функция для удаления ножа и записи изменений в базу данных
-- local function DropKnife(src)
--     local xPlayer = QBCore.Functions.GetPlayer(src)
    
--     if xPlayer then
--         local weapon = 'WEAPON_KNIFE'
--         local knifeItem = xPlayer.Functions.GetItemByName(weapon)

--         if knifeItem then
--             xPlayer.Functions.RemoveItem(weapon, 1)
--             TriggerClientEvent('QBCore:Notify', src, 'Knife dropped')
--             print('Knife dropped for player: ' .. tostring(src))

--             MySQL.Async.execute('UPDATE player_weapons SET count = count - 1 WHERE citizenid = @citizenid AND weapon = @weapon', {
--                 ['@citizenid'] = xPlayer.PlayerData.citizenid,
--                 ['@weapon'] = weapon
--             })
--         end
--     else
--         print('Player not found for source: ' .. tostring(src))
--     end
-- end

-- -- Обработчик события смерти игрока
-- RegisterNetEvent('baseevents:onPlayerDied')
-- AddEventHandler('baseevents:onPlayerDied', function()
--     local src = source
--     DropKnife(src)
-- end)

-- -- Обработчик события убийства игрока другим игроком
-- RegisterNetEvent('baseevents:onPlayerKilled')
-- AddEventHandler('baseevents:onPlayerKilled', function()
--     local src = source
--     DropKnife(src)
-- end)

-- -- Команда для сброса ножа
-- RegisterCommand('dropknife', function(source, args, rawCommand)
--     DropKnife(source)
-- end, false)







-- Инициализация QBCore
local QBCore = exports['qb-core']:GetCoreObject()

if QBCore ~= nil then
    print('QBCore initialized: ' .. tostring(QBCore ~= nil))
else
    print('QBCore initialization failed: QBCore object not found')
end

-- Обработчик события 'hospital:server:HelpRequest'
RegisterNetEvent('hospital:server:HelpRequest')
AddEventHandler('hospital:server:HelpRequest', function(coords)
    local src = source
    print('Help request received from source: ' .. tostring(src))

    if QBCore == nil then
        print('QBCore is not initialized when handling HelpRequest event.')
        return
    end

    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        print('Player found: ' .. tostring(src))
        TriggerClientEvent('chat:addMessage', -1, {
            args = { '[EMS]', 'A player needs help at coordinates: ' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z }
        })
        print('Help request sent to EMS at coordinates: ' .. coords.x .. ', ' .. coords.y .. ', ' .. coords.z)
    else
        print('Player not found for source: ' .. tostring(src))
        local players = QBCore.Functions.GetPlayers()
        print('QBCore players: ' .. json.encode(players))
    end
end)

-- Обработчик события 'QBCore:Server:PlayerLoaded'
RegisterNetEvent('QBCore:Server:PlayerLoaded')
AddEventHandler('QBCore:Server:PlayerLoaded', function()
    local src = source
    print('QBCore:Server:PlayerLoaded event triggered for source: ' .. tostring(src))

    if QBCore == nil then
        print('QBCore is not initialized when handling PlayerLoaded event.')
        return
    end

    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        print('Player successfully registered: ' .. tostring(src))
    else
        print('Failed to register player: ' .. tostring(src))
    end
end)

-- Обработчик события подключения игрока
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    print('Player connecting: ' .. tostring(src))
end)

-- Обработчик события отключения игрока
AddEventHandler('playerDropped', function(reason)
    local src = source
    print('Player dropped: ' .. tostring(src) .. ' Reason: ' .. reason)
end)

-- Команда для вывода списка текущих игроков
RegisterCommand('listplayers', function()
    if QBCore == nil then
        print('QBCore is not initialized when handling listplayers command.')
        return
    end

    local players = QBCore.Functions.GetPlayers()
    print('Current players: ' .. json.encode(players))
end, false)

-- Команда для проверки инициализации QBCore
RegisterCommand('checkQBCore', function()
    print('QBCore initialized: ' .. tostring(QBCore ~= nil))
end, false)

-- Обработчик для проверки успешной регистрации игрока в QBCore
RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    print('Player loaded: ' .. tostring(src))
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        print('Player data: ' .. json.encode(xPlayer))
    else
        print('Player not found in QBCore after loading: ' .. tostring(src))
    end
end)

-- Обработчик для остановки звука сердца по окончании таймера
RegisterNetEvent('timer:finished')
AddEventHandler('timer:finished', function()
    print("[Server] Received event 'timer:finished', broadcasting to all clients")
    TriggerClientEvent('timer:finished', -1)  -- Отправляем всем клиентам
end)




-- Функция для удаления оружия и записи изменений в базу данных
local function DropWeapons(src, weapon, ammo)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    if xPlayer then
        xPlayer.Functions.RemoveItem(weapon, 1)
        TriggerClientEvent('QBCore:Notify', src, weapon .. ' dropped with ' .. ammo .. ' ammo')
        print(weapon .. ' dropped for player: ' .. tostring(src) .. ' with ' .. ammo .. ' ammo')

        MySQL.Async.execute('UPDATE player_weapons SET count = count - 1 WHERE citizenid = @citizenid AND weapon = @weapon', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
            ['@weapon'] = weapon
        })

        if ammo > 0 then
            MySQL.Async.execute('UPDATE player_ammo SET count = count - @ammo WHERE citizenid = @citizenid AND weapon = @weapon', {
                ['@ammo'] = ammo,
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
                ['@weapon'] = weapon
            })
        end
    else
        print('Player not found for source: ' .. tostring(src))
    end
end

-- Обработчик события смерти игрока
RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function()
    local src = source
    DropWeapons(src)
end)

-- Обработчик события убийства игрока другим игроком
RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function()
    local src = source
    DropWeapons(src)
end)

-- Обработчик события сброса оружия
RegisterNetEvent('player:dropWeapon')
AddEventHandler('player:dropWeapon', function(weapon, ammo)
    local src = source
    DropWeapons(src, weapon, ammo)
end)

-- Команда для сброса оружия
RegisterCommand('dropweapons', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local weapon = GetSelectedPedWeapon(playerPed)
    local ammo = GetAmmoInPedWeapon(playerPed, weapon)
    DropWeapons(source, weapon, ammo)
end, false)
