fx_version 'adamant'
game 'gta5'

name 'easyCore Framework'
author 'RAMPAGE Interactive - rampagestudios.org meta.rampage.place'
version '0.0.0.1'

ui_page {
    'html/*.html',
}

files {
	'html/*.html',
	'html/js/*.js', 
	'html/css/*.css',
}

client_scripts {
    'client/*.lua',
    'shared/*.lua',
    'plugins/client_*.lua',
    'plugins/client.lua',
    'plugins/shared.lua',
    'plugins/shared_*.lua',
}

server_scripts {
    'Settings.lua',
    'modules/*.lua',
    'server/*.lua',
    'shared/*.lua',
    'plugins/server_*.lua',
    'plugins/server.lua',
    'plugins/shared.lua',
    'plugins/shared_*.lua',
}