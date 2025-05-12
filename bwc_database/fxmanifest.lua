fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Splinter'
description 'Police Database System'
version '0.1.3'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua'
}

client_scripts {
  'ox_input.lua',
  'client.lua'
}

shared_scripts{
    '@ox_lib/init.lua',
    'config.lua'
}

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/assets/*'
}

dependencies {
    'ox_lib'
}