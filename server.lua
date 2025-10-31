local QBCore = exports['qb-core']:GetCoreObject()

-- デバッグ用print関数
local function DebugPrint(...)
    if Config.Debug then
        print('[BusinessCard]', ...)
    end
end

-- ox_inventoryのアイテム使用登録
if GetResourceState('ox_inventory') == 'started' then
    for itemName, cardData in pairs(Config.BusinessCards) do
        exports.ox_inventory:registerHook('createItem', function(payload)
            local metadata = payload.metadata
            metadata.description = cardData.description
            return metadata
        end, {
            itemFilter = {
                [itemName] = true
            }
        })
        
        DebugPrint('Registered business card:', itemName)
    end
end

-- 名刺使用イベント
RegisterNetEvent('businesscard:server:useCard', function(itemName)
    local src = source
    
    if not Config.BusinessCards[itemName] then
        DebugPrint('Invalid card item:', itemName)
        return
    end
    
    -- プレイヤーがアイテムを持っているか確認
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local item = exports.ox_inventory:GetItem(src, itemName, nil, true)
    if not item or item < 1 then
        TriggerClientEvent('QBCore:Notify', src, '名刺を持っていません', 'error')
        return
    end
    
    -- クライアントに名刺表示を送信
    TriggerClientEvent('businesscard:client:showCard', src, itemName)
    
    DebugPrint('Player', src, 'used business card:', itemName)
end)

-- リソース開始時のメッセージ
CreateThread(function()
    Wait(1000)
    print('^2[BusinessCard]^7 Successfully loaded! ^3' .. #Config.BusinessCards .. '^7 card(s) registered.')
end)
