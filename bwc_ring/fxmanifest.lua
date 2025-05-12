fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Splinter'
description 'Doorbell Script for FiveM'
version '1.1.0'

client_scripts {
    'client.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_target',
    'ox_lib'
}