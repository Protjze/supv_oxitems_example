if not supv and not lib then return end
if not Config.handcuff then return end

local cfg <const>, ox_items <const> = Config.handcuff, exports.supv_oxitems

lib.callback.register('supv_oxitems:callback:getSerial', function(source, from)
    local player = ESX.GetPlayerFromId(source)
    if player then
        if (cfg.create.job[player.job.name] and cfg.create.job[player.job.name][player.job.grade_name]) or cfg.create.group[player.group] then
            return from, ox_items:GetCurrentSerialHandcuff(), ox_items:GetOldSerialHandcuff()
        end
    end
    return false
end)

RegisterNetEvent('example_oxitems:give', function(from, data)
    local _source = source
    local player = ESX.GetPlayerFromId(_source)
    if player then
        if from == 'job' then
            if cfg.create.job[player.job.name] and cfg.create.job[player.job.name][player.job.grade_name] then
                if data.select == 'new' then
                    data.select = ox_items:ChangeSerialHandcuff()
                end
                if data.giveMenotte then ox_items:GiveMenotte(cfg.stash[player.job.name], data.quantity, data.select) end
                if data.giveChaine then ox_items:GiveChaine(cfg.stash[player.job.name], data.quantity, data.select) end
                if data.giveKey then ox_items:GiveKey(cfg.stash[player.job.name], data.quantity, data.select) end
            end
        elseif from == 'admin' then
            if cfg.create.group[player.group] then
                if data.select == 'new' then
                    data.select = ox_items:ChangeSerialHandcuff()
                end
                if data.giveMenotte then ox_items:GiveMenotte(_source, data.quantity, data.select) end
                if data.giveChaine then ox_items:GiveChaine(_source, data.quantity, data.select) end
                if data.giveKey then ox_items:GiveKey(_source, data.quantity, data.select) end
            end
        end
    end
end)

lib.addCommand(false, Config.handcuff.command, function(source, args)
    local player = ESX.GetPlayerFromId(source)
    if player and cfg.create.group[player.group] then
        TriggerClientEvent('handcuff:admin', source, 'admin')
    end
end)
