fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Blacksummer88'
description 'ESX Rent A Car with OX_lib'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

file{
    'html/**/*.*',
} 

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}