Config ={}
local SelectAnimDict = "anim@cop_mic_pose_001"
local SelectAnimName = "chest_mic"
local radioProp;

RegisterCommand('radioanim', function()
    local animListMenu = {}

    animListMenu[#animListMenu + 1] = {
        title = Lang:t('menu.title'),
        description = Lang:t('menu.description'),
        disabled = true 
    }

    for k, v in ipairs(Config.animList) do
        animListMenu[#animListMenu + 1] = {
            title = v.AnimTitle, 
            icon = 'fa-solid fa-radio', 
            description = '', 
            event = 'mg:radioanim:selectAnim', 
            args = {
                AnimTitle = v.AnimTitle,
                AnimDict = v.AnimDict,
                AnimName = v.AnimName
            },
            image = v.image
        }
    end

    lib.registerContext({
        id = 'radio_anim_menu',
        title = Lang:t('menu.main'),
        options = animListMenu 
    })

    lib.showContext('radio_anim_menu')
end)

RegisterNetEvent('mg:radioanim:selectAnim', function(data)
    SelectAnimDict= data.AnimDict
    SelectAnimName = data.AnimName
end)

RegisterNetEvent('mg:radioanim:animPlay', function()
    local playerPed = PlayerPedId()
    if SelectAnimName == "holding_radio_clip" then 
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13544876595097, 0.051973119787891, -0.029258303514433, -93.78105269127, -7.4997158143199, -36.431763377751, true, true, false, true, 1, true)
    elseif SelectAnimName == "radio_left_clip" then 
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.13544876595097, 0.051973119787891, 0.029258303514433, -93.78105269127, -7.4997158143199, -36.431763377751, true, true, false, true, 1, true)
    end
    local dict = SelectAnimDict
    local anim = SelectAnimName
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
end)

RegisterNetEvent('mg:radioanim:animStop', function()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    if SelectAnimName == "holding_radio_clip" or SelectAnimName == "radio_left_clip" then 
        DeleteObject(radioProp)
    end
end)