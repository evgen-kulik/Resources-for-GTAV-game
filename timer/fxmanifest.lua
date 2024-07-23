fx_version 'cerulean'
game 'gta5'

author 'Yevhen Kulyk'
description 'Revive Timer Script'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'

dependencies {
    'spawnmanager',
    'baseevents'
}
