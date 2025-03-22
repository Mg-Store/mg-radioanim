Config = {} -- Config'i dışarıdan alacağımızı belirtiyoruz
local SelectAnimDict = "anim@cop_mic_pose_001"
local SelectAnimName = "chest_mic"
local radioProp

RegisterCommand('radioanim', function()
    local animListMenu = {}

    -- Başlık menüsü ekleme
    animListMenu[#animListMenu + 1] = {
        title = Lang:t('menu.title'),
        description = Lang:t('menu.description'),
        disabled = true
    }

    -- Animasyon listesini menüye ekleme
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
            image = v.image -- Buradaki resim bağlantılarını Config'den alacak.
        }
    end

    -- Menü oluşturma ve gösterme
    lib.registerContext({
        id = 'radio_anim_menu',
        title = Lang:t('menu.main'),
        options = animListMenu
    })

    lib.showContext('radio_anim_menu')
end)

-- Seçilen animasyonu alıp ayarlıyoruz
RegisterNetEvent('mg:radioanim:selectAnim', function(data)
    SelectAnimDict = data.AnimDict
    SelectAnimName = data.AnimName
end)

-- Animasyonu oynatmayı başlatıyoruz
RegisterNetEvent('mg:radioanim:animPlay', function()
    local playerPed = PlayerPedId()

    -- Eğer holding_radio_clip ise prop ekle
    if SelectAnimName == "holding_radio_clip" then
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.135, 0.052, -0.029, -93.781, -7.5, -36.431, true, true, false, true, 1, true)

    -- Eğer radio_left_clip ise prop ekle
    elseif SelectAnimName == "radio_left_clip" then
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.135, 0.052, 0.029, -93.781, -7.5, -36.431, true, true, false, true, 1, true)
    end

    -- Animasyonun çalışması için gerekli olan dict'i yükleme
    RequestAnimDict(SelectAnimDict)
    while not HasAnimDictLoaded(SelectAnimDict) do
        Wait(100)
    end

    -- Animasyonu oynat
    TaskPlayAnim(playerPed, SelectAnimDict, SelectAnimName, 8.0, -8.0, -1, 49, 0, false, false, false)
end)

-- Animasyonu durdurma
RegisterNetEvent('mg:radioanim:animStop', function()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)

    -- Eğer prop oluşturulmuşsa sil
    if SelectAnimName == "holding_radio_clip" or SelectAnimName == "radio_left_clip" then
        DeleteObject(radioProp)
    end
end)
