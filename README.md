# GTAV FiveM Modification (QBCore Framework)

## Introduction

This repository contains resources created as part of a test task to develop a GTAV modification on the FiveM platform using the QBCore framework.

## Summary

The task was completed over 8 days. A local server was set up under QBCore for the work. The ox_inventory package was connected to work with the inventory. To ensure the correct functioning of the resources developed according to the task, instructions were written for stubbing QBCore code blocks.

## Implemented Features:

1. Upon player death, a timer appears on the screen, during which the player can be revived. The time is configurable in `config.lua`. For testing purposes, the time is set to 4 seconds. The timer is represented by a text countdown and a rectangular time depletion diagram. During the timer's duration, testing commands "/revive" (revives the player at the death location) and "/respawn" (revives the player at coordinates specified in `config.lua`) are available.
2. The player's screen becomes blurred, with a blackout effect and a sound of slowing heartbeat.
3. During the timer, the player can press the "H" key to call an ambulance. Calling the ambulance extends the death time to 360 seconds (set to 8 seconds in test mode). Upon calling the ambulance, the timer diagram changes from red to green and extends slightly. If the button is not pressed, the player dies when the timer runs out. When the ambulance call button is pressed, information is sent to the EMS (hospital) faction about the player's location, and all faction members see the signal on their tablet. During the "green" timer, the test commands "/revive" and "/respawn" are also available.
4. Upon death, the player drops the weapon and ammunition they were holding at the time of death. The weapon list is specified in `config.lua`.
5. If the timer expires, the screen goes completely dark, and the text "Too much time has passed and you lost consciousness. A passing police officer took you to the emergency room." appears in the center of the screen. Below the text is a "Continue" button. Pressing the button respawns the player. Respawn occurs on the hospital porch. Respawn coordinates are specified in `config.lua`.

## Unimplemented Features:

1. Reducing the character's health to 50% of the maximum after respawn.
2. Gradual awakening as if the player is regaining consciousness.

## Suggested Code Improvements:

1. Save the dropped weapon at the player's death location.
2. Implement a smooth animation transition to the screen with the "Continue" button.

---

# Модификация GTAV FiveM (Фреймворк QBCore)

## Введение

В этом репозитории находятся ресурсы, созданные в рамках выполнения тестового задания на разработку модификации GTAV на платформе the FiveM под фреймворком QBCore.

## Выводы

ТЗ выполнялось в течение 8 дней. Для работы был настроен локальный сервер под QBCore. Для работы с инвентарем подключен пакет ox_inventory. Для корректного функционирования разработанных согласно ТЗ ресурсов, написана инструкция по заглушке блоков кода QBCore.

## Реализованный функционал:

1. При смерти игрока, на экране показывается таймер, в течение которого игрока можно реанимировать. Время настраивается в `config.lua`. Для упрощения тестировки время выставлено на 4 секунды. Таймер представляет из себя текст с отсчетом времени и прямоугольную диаграмму убывания времени. В течение действия таймера действуют тестировочные команды "/revive" (возрождает игрока на месте смерти) и "/respawn" (возрождает игрока на заданных в `config.lua` координатах).
2. Экран игрока становится размытым, с эффектом потери сознания (мутный экран переходящий в темноту и опять в мутный) и звуком замедляющегося сердцебиения.
3. Во время действия таймера игрок может нажатием кнопки "H" вызвать скорую. Вызов скорой увеличивает время смерти до 360 секунд (в тестовом режиме настроено 8 секунд). При вызове скорой диаграмма таймера из красной становится зеленой и несколько удлиняется. Если кнопка не нажата, то по окончании таймера игрок умирает. При нажатии кнопки вызова скорой помощи, передается информация во фракцию EMS (больница) о местоположении игрока, все члены фракции видят сигнал в планшете. Во время действия "зеленого" таймера также действуют тестовые команды "/revive" и "/respawn".
4. В случае смерти игрок выбрасывает оружие с патронами на пол, если он держал их во время смерти. Список оружия прописан в `config.lua`.
5. Если таймер проходит, экран темнеет полностью, появляется посредине экрана надпись: "Too much time has passed and you lost consciousness. A passing police officer took you to the emergency room." Под текстом кнопка "Continue". Нажатие кнопки приводит к респавну. Респавн происходит на крыльце госпиталя. Координаты респавна прописаны в `config.lua`.

## Нереализованный функционал:

1. Уменьшение здоровья на 50% от максимума персонажа после респавна.
2. Постепенное пробуждение, как будто игрок приходит в сознание.

## Предложения по дальнейшей доработке кода:

1. Сохранение сброшенного во время смерти оружия на месте смерти игрока.
2. Реализовать плавную анимацию перехода к экрану с кнопкой "Continue".
