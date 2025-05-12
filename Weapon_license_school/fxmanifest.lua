fx_version 'cerulean'
game 'gta5'

author 'Splinter'
description 'Just something neat that wasnt available for free'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'mysql-async',
    'ox_lib',
    'ox_target'
}