fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Your Name'
description 'Business Card Display Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/*.png' -- 名刺画像フォルダ
}
