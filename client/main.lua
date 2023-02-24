RegisterNetEvent('esx:playerLoaded', function(data)
    ESX.PlayerData = data
    if Config.handcuff and data.job and Config.handcuff.create.job[data.job.name] and Config.handcuff.create.job[data.job.name][data.job.grade_name] then LaunchHandcuffThread() end
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
    if Config.handcuff and Config.handcuff.create.job[job.name] and Config.handcuff.create.job[job.name][job.grade_name] then LaunchHandcuffThread() end
end)