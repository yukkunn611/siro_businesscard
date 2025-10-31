local QBCore = exports['qb-core']:GetCoreObject()
local isCardOpen = false
local currentCard = nil

-- デバッグ用print関数
local function DebugPrint(...)
    if Config.Debug then
        print('[BusinessCard]', ...)
    end
end

-- 名刺を表示
RegisterNetEvent('businesscard:client:showCard', function(itemName)
    if isCardOpen then
        QBCore.Functions.Notify('既に名刺を表示中です', 'error')
        return
    end
    
    local cardData = Config.BusinessCards[itemName]
    if not cardData then
        DebugPrint('Card data not found for:', itemName)
        return
    end
    
    isCardOpen = true
    currentCard = itemName
    
    -- NUIに表示データを送信
    SendNUIMessage({
        action = 'showCard',
        image = cardData.image,
        name = cardData.name
    })
    
    -- フォーカスを有効化（マウス操作用）
    SetNuiFocus(false, false)
    
    DebugPrint('Showing card:', itemName)
    
    -- 自動クローズタイマー（設定されている場合）
    if Config.UI.displayTime > 0 then
        SetTimeout(Config.UI.displayTime, function()
            if isCardOpen and currentCard == itemName then
                CloseCard()
            end
        end)
    end
end)

-- 名刺を閉じる
function CloseCard()
    if not isCardOpen then return end
    
    isCardOpen = false
    currentCard = nil
    
    SendNUIMessage({
        action = 'hideCard'
    })
    
    SetNuiFocus(false, false)
    DebugPrint('Card closed')
end

-- ESCキーで閉じる
CreateThread(function()
    while true do
        Wait(0)
        if isCardOpen then
            if IsControlJustPressed(0, 322) then -- ESCキー
                CloseCard()
            end
        else
            Wait(500)
        end
    end
end)

-- NUIコールバック（閉じるボタン用）
RegisterNUICallback('closeCard', function(data, cb)
    CloseCard()
    cb('ok')
end)

-- リソース停止時にクリーンアップ
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if isCardOpen then
        CloseCard()
    end
end)

-- ox_inventory用のエクスポート関数
exports('useCard', function(data, slot)
    local itemName = data.name
    TriggerServerEvent('businesscard:server:useCard', itemName)
end)
