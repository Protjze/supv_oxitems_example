fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'SUP2Ak'
version '1.0'
description 'supv_oxitems_example'

shared_scripts {
    '@es_extended/imports.lua', 
    '@ox_lib/init.lua',
    '@supv_core/import.lua',
    '_g.lua',
}

shared_scripts {
    'config/shared.lua'
}

server_scripts {
    -- '@oxmysql/lib/MySQL.lua',
    'config/server.lua',
    'server/main.lua',
    'server/script/*.lua'
}

client_scripts {
    'config/client.lua',
    'client/main.lua',
    'client/script/*.lua'
}