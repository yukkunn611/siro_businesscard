Config = {}

-- 名刺アイテム設定/Business Card Item Settings
-- アイテム名をキーとして、表示する画像パスを設定/Set the image path to be displayed as the item name key
Config.BusinessCards = {
    ['business_card_1'] = { -- must match the item name in items.lua
        name = 'Display Name',
        image = 'html/images/your_image.png',
        description = 'Your description here'
    },
    ['business_card_2'] = { -- must match the item name in items.lua
        name = 'Display Name',
        image = 'html/images/your_image.png',
        description = 'Your description here'
    },
}
    -- 必要に応じて追加/Add as needed

-- UI設定
Config.UI = {
    closeKey = 'ESC', -- 閉じるキー（ESCキー）/ Key to close (ESC key)
    displayTime = 0, -- 自動で閉じるまでの時間（ミリ秒、0の場合は自動で閉じない）/ Time until it closes automatically (milliseconds, 0 means it won't close automatically)
}

-- デバッグモード
Config.Debug = false
