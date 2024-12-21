fx_version "adamant"

description "Mg Store | mg-radioanim"
author "MG"
version "1.0.0"
lua54 "yes"
game "gta5"

escrow_ignore { 
    "Settings.lua"
}

shared_script {
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'locales/en.lua'
}

client_script {
    'client/client.lua',
    'Settings.lua'
}

server_script {
    'server/server.lua'
}

files {
    "stream/*.ycd"
}

data_file 'ANIM_DICT' 'stream/anim@cop_radio_pose.ycd'
data_file 'ANIM_DICT' 'stream/anim@hand_rest_holster.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_pose_escorting.ycd'
data_file 'ANIM_DICT' 'stream/anim@hand_rest_belt.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_pose.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_mic_pose_001.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_mic_pose_002.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_mic_pose_002_1.ycd'
data_file 'ANIM_DICT' 'stream/anim@cop_mic_pose_002_2.ycd'
data_file 'ANIM_DICT' 'stream/anim@belt_pose_hlstr.ycd'
data_file 'ANIM_DICT' 'stream/anim@male@holding_radio.ycd'
data_file 'ANIM_DICT' 'stream/anim@radio_left.ycd'
