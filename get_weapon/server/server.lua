-- Получаем объект QBCore
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('get_weapon:server:issueLicense')
AddEventHandler('get_weapon:server:issueLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        -- Получаем текущие метаданные игрока
        local metadata = Player.PlayerData.metadata
        metadata.licences = metadata.licences or {}
        metadata.licences.gun = true  -- Выдача лицензии на оружие

        -- Обновляем метаданные игрока
        Player.Functions.SetMetaData("licences", metadata.licences)

        -- Уведомляем клиента о выдаче лицензии
        TriggerClientEvent('QBCore:Notify', src, "You have been issued a gun license", "success")
    else
        print("Player not found while issuing gun license")
    end
end)


