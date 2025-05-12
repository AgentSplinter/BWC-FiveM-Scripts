fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Splinter'
description 'Basic NPC Treatment Script'
version '1.0.0'

shared_script {
      'config.lua',
      '@es_extended/imports.lua'
}

server_script 'server.lua'
client_script 'client.lua'

dependencies {
    'ox_target',
    'es_extended'
}
