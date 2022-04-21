
-- TODO: Properly organize this lua file.
fx_version 'adamant'
game 'gta5'

name 'easyCore Framework'
author 'RAMPAGE Interactive - rampagestudios.org meta.rampage.place'
version '0.0.0.1'

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
    'plugins/**/ui/index.html',
    'plugins/**/ui/script.js',
    'plugins/**/ui/style.css',
    'plugins/**/ui/assets/fonts/chaletlondon1960.woff2',
    'plugins/**/ui/assets/icons/apparel.svg',
    'plugins/**/ui/assets/icons/body.svg',
    'plugins/**/ui/assets/icons/check.svg',
    'plugins/**/ui/assets/icons/features.svg',
    'plugins/**/ui/assets/icons/head.svg',
    'plugins/**/ui/assets/icons/identity.svg',
    'plugins/**/ui/assets/icons/legs.svg',
    'plugins/**/ui/assets/icons/style.svg',
    'plugins/**/ui/assets/icons/symbol-female.svg',
    'plugins/**/ui/assets/icons/symbol-male.svg',
    'plugins/**/ui/pages/apparel.html',
    'plugins/**/ui/pages/features.html',
    'plugins/**/ui/pages/identity.html',
    'plugins/**/ui/pages/style.html',
    'plugins/**/ui/pages/optional/blusher.html',
    'plugins/**/ui/pages/optional/chesthair.html',
    'plugins/**/ui/pages/optional/esxidentity.html',
    'plugins/**/ui/pages/optional/facialhair.html',
    'plugins/**/ui/pages/optional/hair_female.html',
    'plugins/**/ui/pages/optional/hair_male.html',
    'plugins/**/ui/pages/optional/makeup_eye.html',
    'plugins/**/ui/pages/optional/makeup_facepaint.html',
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