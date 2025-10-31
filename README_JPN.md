# QBCore/ox_inventory 名刺表示システム

## 機能
- 名刺アイテムを使用すると画面に大きく表示
- config.luaで簡単にカスタマイズ可能
- ox_inventory & QBCore対応
- スムーズなアニメーション
- ESCキーまたはクリックで閉じる

## インストール方法

### 1. ファイルを配置
`resources/businesscard/` にファイルを配置(任意のフォルダでも可)

### 2. 画像フォルダに表示させる画像を配置
`html/images/` フォルダに名刺画像を配置
- 推奨サイズ: 1920x1080px または 1280x720px(画像の解像度がそのまま表示されます。例えば1920x1080pxは全画面、1280x720px画面中央に大きく表示。など)
- 形式: PNG (透過対応)

### 3. server.cfgに追加
```cfg
ensure businesscard
```

### 4. ox_inventoryのitems.luaにアイテムを追加、及びexport設定

`ox_inventory/data/items.lua` に以下を追加：

```lua
['business_card_1'] = {
    label = 'business_card_1',
    weight = 10,
    stack = true,
    close = true,
    description = 'businesscard',
    client = {
        export = 'siro_businesscard.useCard'
    }
},
```

## カスタマイズ方法

### config.luaで名刺を追加
```lua
Config.BusinessCards = {
    ['あなたの名刺アイテム名'] = { ※item.luaで設定したアイテム名と合わせてください
        name = '表示名',
        image = 'html/images/あなたの画像.png',
        description = '説明文'
    },
}
```

### 画像ファイルの配置
1. PNG画像を `html/images/` に配置
2. config.luaで画像パスを指定
3. ox_inventoryのitems.luaにアイテムを登録

## 使用方法
1. 名刺アイテムをインベントリで右クリック→使用
2. 画面中央に名刺が大きく表示される
3. ESCキーまたは×ボタンで閉じる

## トラブルシューティング

### 画像が表示されない
- 画像パスが正しいか確認
- 画像ファイルが存在するか確認
- fxmanifest.luaの `files` セクションを確認

### アイテムが使えない
- ox_inventoryのitems.luaに正しく登録されているか確認
- client exportが正しく設定されているか確認
- リソース起動順序を確認（ox_inventory → siro_businesscard）

### デバッグモード
config.luaで `Config.Debug = true` に設定すると詳細ログが表示されます

## 依存スクリプト
- qb-core
- ox_inventory
- ox_lib
