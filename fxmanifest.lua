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
    'shared/*.lua'
}

server_scripts {
    'Settings.lua',
    'server/*.lua',
    'shared/*.lua'
}