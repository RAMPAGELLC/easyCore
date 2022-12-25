fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'easyCore Framework'
author 'RAMPAGE Interactive - rampagestudios.org meta.rampage.place'
version '0.0.0.1'
license 'MIT'

ui_page {
    'html/*.html',
    'plugins/**/html/*.html',
}

files {
	'html/*.html',
	'html/js/*.js', 
	'html/css/*.css',
    'plugins/**/html/*.scss',
    'plugins/**/html/*.css',
    'plugins/**/html/*.js',
    'plugins/**/html/*.html',
    'plugins/**/html/**/*.scss',
    'plugins/**/html/**/*.css',
    'plugins/**/html/**/*.js',
    'plugins/**/html/**/*.html',
    'plugins/**/html/**/*.png',
    'plugins/**/html/**/*.jpg',
    'plugins/**/html/*.png',
    'plugins/**/html/*.jpg',
    'plugins/**/html/**/*.ttf',
    'plugins/**/html/**/*.woff',
    'plugins/**/html/**/*.woff2',
    'plugins/**/html/*.ttf',
    'plugins/**/html/*.woff',
    'plugins/**/html/*.woff2',
    'plugins/**/html/*.min.js',
    'plugins/**/ui/*.html',
    'plugins/**/ui/*.js',
    'plugins/**/ui/*.css',
    'plugins/**/ui/assets/fonts/*.woff2',
    'plugins/**/ui/assets/icons/*.svg',
    'plugins/**/ui/pages/*.html',
    'plugins/**/ui/pages/optional/*.html',
}

client_scripts {
    'client/*.lua',
    'shared/*.lua',
    'plugins/**/shared_*.lua',
    'plugins/**/client_*.lua',
    'plugins/**/client.lua',
    'plugins/**/shared.lua',
}

server_scripts {
    'Settings.lua',
    'modules/*.lua',
    'server/*.lua',
    'shared/*.lua',
    'plugins/**/shared_*.lua',
    'plugins/**/server_*.lua',
    'plugins/**/server.lua',
    'plugins/**/shared.lua',
}