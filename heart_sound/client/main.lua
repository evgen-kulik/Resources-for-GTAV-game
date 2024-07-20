--- Воспроизводит звук от интерфейса\
--- **Обязательно:** загрузить ваш звук в папку `html/ll_sound/sounds`, именно от туда и будет браться звук!
---@param filePath string Путь до файла со звуком (Из папки `html/ll_sound/sounds`)
---@param volume number Громкость звука от 0.0 до 1.0
function PlayNuiSound(filePath, volume)
	local sfx_volume = GetProfileSetting(300) -- Получение звука игрока.
	SendNUIMessage(
		{
			filePath = filePath,
			volume = volume,
			sfx_volume = sfx_volume
		}
	)
end

-- Экспортируем функцию для использования в других скриптах
exports("PlayNuiSound", PlayNuiSound)
