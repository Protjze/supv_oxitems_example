if not Config.handcuff then return end
if not lib and not supv then return end

local cfg <const>, inside = Config.handcuff, false

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then return end
    LaunchHandcuffThread()
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then return end
    if inside then lib.hideTextUI() end
end)

local function OpenMenu(from)
    local types, serial, oldserial = lib.callback.await('supv_oxitems:callback:getSerial', false, from)
    if not types and not serial then lib.showTextUI('[E] - Gérer les clées') return end
    local list = {}
    list[1] = {value = true, label = ('Par défaut: %s'):format(serial)}
    list[2] = {value = 'new', label = 'Nouvelle série'}
    if oldserial and next(oldserial) then
        for k in pairs(oldserial) do
            list[#list+1] = {value = k, label = k}
        end
    end
    local input = lib.inputDialog('Production Menotte', {
        {type = "checkbox", label = "Commander Menotte", checked = true},
        {type = "checkbox", label = "Commander Chaine", checked = true},
        {type = "checkbox", label = "Commander Clée", checked = true},
        {type = 'select', label = 'Numéro de série', options = list},
        {type = "number", label = "Quantité", default = 1}
    })
    if not input then lib.showTextUI('[E] - Gérer les clées') return end
    local send = {}
    send.giveMenotte = input[1]
    send.giveChaine = input[2]
    send.giveKey = input[3]
    send.select = input[4] == 'true' and true or input[4]
    send.quantity = tonumber(input[5])
    if not send.select or send.quantity < 1 then lib.showTextUI('[E] - Gérer les clées') return end
    TriggerServerEvent('example_oxitems:give', from, send)
    lib.showTextUI('[E] - Gérer les clées')
end

function LaunchHandcuffThread()
    CreateThread(function()
        local player, sleep = supv.player.get()
        while ESX and ESX.PlayerData and ESX.PlayerData.job and cfg.create.job[ESX.PlayerData.job.name] and cfg.create.job[ESX.PlayerData.job.name][ESX.PlayerData.job.grade_name] do
            sleep = 850
            if cfg.zones[ESX.PlayerData.job.name] then
                player:distance(cfg.zones[ESX.PlayerData.job.name])
                if  player.dist < 10 then
                    if player.dist <= 2 then sleep = 0
                        if not inside then
                            inside = true
                            lib.showTextUI('[E] - Gérer les clées')
                        end
                        if IsControlJustPressed(0,51) then
                            lib.hideTextUI()
                            OpenMenu('job')
                        end
                    elseif player.dist > 2 and inside then 
                        inside = false
                        lib.hideTextUI()
                    end
                end
            end
            Wait(sleep)
        end
        if inside then lib.hideTextUI() end
    end)     
end

RegisterNetEvent('handcuff:admin', OpenMenu)