function GetPlayerData()
    local data = {}

    if Framework == "ESX" then
        local playerData = Core.GetPlayerData()

        data.identifier = playerData.identifier
        data.name = string.format("%s %s", playerData.firstName, playerData.firstName)
        data.dob = playerData.dateofbirth
        data.gender = playerData.sex

        local job = {
            name = playerData.job.name,
            label = playerData.job.label,
            grade = playerData.job.grade,
            gradeName = playerData.job.grade_name,
            onDuty = true, -- todo: look into if ESX has a duty feature, can't remember but iirc it doesn't?
        }

        -- todo: new feat - hook into server side ESX.GetJobs() to determine if grade is highest for compatibility with qb-core jobs isboss boolean.

        data.job = job
    elseif Framework == "QB" or Framework == "QBX" then
        local playerData = Framework == "QB" and Core.Functions.GetPlayerData() or Framework == "QBX" and exports.qbx_core:GetPlayerData()

        data.identifier = playerData.citizenid
        data.name = string.format("%s %s", playerData.charinfo.firstname, playerData.charinfo.lastname)
        data.dob = playerData.charinfo.birthdate
        data.gender = playerData.charinfo.gender

        local job = {
            name = playerData.job.name,
            label = playerData.job.label,
            grade = playerData.job.grade.level,
            gradeName = playerData.job.grade.name,
            isBoss = playerData.job.isboss,
            onDuty = playerData.job.onduty
        }

        data.job = job
    else
        -- Other framework bridges
    end


    return data
end

