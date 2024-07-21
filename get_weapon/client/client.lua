-- RegisterCommand('weapon', function(source, args)
--     -- Получаем название оружия из аргументов команды или используем "WEAPON_PISTOL" по умолчанию
--     local weaponName = args[1] or 'WEAPON_PISTOL'
--     -- Количество патронов по умолчанию
--     local ammoCount = tonumber(args[2]) or 250

--     -- Проверка наличия оружия в игре
--     if not IsWeaponValid(weaponName) then
--         TriggerEvent('chat:addMessage', {
--             args = { 'NO NO NO, ' .. weaponName .. ' is not a valid weapon!', }
--         })
--         return
--     end

--     -- Получаем идентификатор игрока
--     local playerPed = PlayerPedId()
--     if not playerPed then
--         -- Сообщение только в консоль
--         print('Failed to get player ID!')
--         return
--     end

--     -- Вывод отладочного сообщения с идентификатором игрока
--     print('Player ID is: ' .. playerPed)

--     -- Вывод отладочного сообщения с хэш-ключом оружия
--     local weaponHash = GetHashKey(weaponName)
--     print('Weapon hash for ' .. weaponName .. ' is ' .. weaponHash )

--     -- Дополнительная проверка наличия хэш-ключа
--     if not weaponHash then
--         -- Сообщение только в консоль
--         print('Failed to get weapon hash for ' .. weaponName)
--         return
--     end

--     -- Выдача оружия и патронов
--     GiveWeaponToPed(playerPed, weaponHash, ammoCount, false, true)

--     -- Проверка наличия оружия после выдачи
--     if HasPedGotWeapon(playerPed, weaponHash, false) then
--         TriggerEvent('chat:addMessage', {
--             args = { 'You have received a ' .. weaponName .. ' with ' .. ammoCount .. ' rounds of ammo!', }
--         })
--     else
--         TriggerEvent('chat:addMessage', {
--             args = { 'Failed to give weapon ' .. weaponName }
--         })
--     end
-- end)


local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('weapon', function(source, args)
    -- Получаем название оружия из аргументов команды или используем "WEAPON_PISTOL" по умолчанию
    local weaponName = args[1] or 'WEAPON_PISTOL'
    -- Количество патронов по умолчанию
    local ammoCount = tonumber(args[2]) or 250

    -- Проверка наличия оружия в игре
    if not IsWeaponValid(weaponName) then
        TriggerEvent('chat:addMessage', {
            args = { 'NO NO NO, ' .. weaponName .. ' is not a valid weapon!', }
        })
        return
    end

    -- Получаем идентификатор игрока
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    -- Вывод отладочного сообщения с идентификатором игрока
    print('Player ID is: ' .. playerId)

    -- Проверка наличия лицензии на оружие
    QBCore.Functions.GetPlayerData(function(playerData)
        local hasLicense = playerData.metadata.licences and playerData.metadata.licences.gun
        if not hasLicense then
            print('Player does not have a gun license. Issuing license...')
            
            -- Запрос на сервер для выдачи лицензии
            TriggerServerEvent('get_weapon:server:issueLicense')
            
            -- Пауза для синхронизации (можно изменить по необходимости)
            Citizen.Wait(1000)

            -- Повторная проверка наличия лицензии после выдачи
            QBCore.Functions.GetPlayerData(function(updatedData)
                local updatedHasLicense = updatedData.metadata.licences and updatedData.metadata.licences.gun
                if updatedHasLicense then
                    print('Player now has a gun license.')
                    -- Выдача оружия и патронов
                    local weaponHash = GetHashKey(weaponName)
                    print('Weapon hash for ' .. weaponName .. ' is ' .. weaponHash)
                    GiveWeaponToPed(playerPed, weaponHash, ammoCount, false, true)
                    if HasPedGotWeapon(playerPed, weaponHash, false) then
                        TriggerEvent('chat:addMessage', {
                            args = { 'You have received a ' .. weaponName .. ' with ' .. ammoCount .. ' rounds of ammo!', }
                        })
                    else
                        TriggerEvent('chat:addMessage', {
                            args = { 'Failed to give weapon ' .. weaponName }
                        })
                    end
                else
                    TriggerEvent('chat:addMessage', {
                        args = { 'Failed to receive gun license', }
                    })
                end
            end)
        else
            print('Player already has a gun license.')
            -- Выдача оружия и патронов
            local weaponHash = GetHashKey(weaponName)
            print('Weapon hash for ' .. weaponName .. ' is ' .. weaponHash)
            GiveWeaponToPed(playerPed, weaponHash, ammoCount, false, true)
            if HasPedGotWeapon(playerPed, weaponHash, false) then
                TriggerEvent('chat:addMessage', {
                    args = { 'You have received a ' .. weaponName .. ' with ' .. ammoCount .. ' rounds of ammo!', }
                })
            else
                TriggerEvent('chat:addMessage', {
                    args = { 'Failed to give weapon ' .. weaponName }
                })
            end
        end
    end)
end)
