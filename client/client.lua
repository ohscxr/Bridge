
--- This function requests PlayerData from the determined framework, returning a table of data.
function GetPlayerData()
    local data = {}

    if Framework == "ESX" then
        local playerData = Core.GetPlayerData()

        data.identifier = playerData.identifier
        data.name = string.format("%s %s", playerData.firstName, playerData.firstName)
        data.dob = playerData.dateofbirth
        data.gender = playerData.sex

        -- todo: new feat - hook into server side ESX.GetJobs() to determine if grade is highest for compatibility with qb-core jobs isboss boolean.
        data.job = {
            name = playerData.job.name,
            label = playerData.job.label,
            grade = playerData.job.grade,
            gradeName = playerData.job.grade_name,
            onDuty = true, -- todo: look into if ESX has a duty feature, can't remember but iirc it doesn't?
        }
        
        -- Player economy data, will probably not reference it much, but could come in use for some edge cases.
        local accounts = {}
        for i = 1, #playerData.accounts do
            local account = playerData[i].accounts
            accounts[account.name] =  account.money
        end

        data.accounts = accounts
    elseif Framework == "QB" then
        local playerData = Core.Functions.GetPlayerData()

        data.identifier = playerData.citizenid
        data.name = string.format("%s %s", playerData.charinfo.firstname, playerData.charinfo.lastname)
        data.dob = playerData.charinfo.birthdate
        data.gender = playerData.charinfo.gender

        data.job = {
            name = playerData.job.name,
            label = playerData.job.label,
            grade = playerData.job.grade.level,
            gradeName = playerData.job.grade.name,
            isBoss = playerData.job.isboss,
            onDuty = playerData.job.onduty
        }

        data.accounts = {
            money = playerData.money['cash'],
            bank = playerData.money['bank'],
            crypto = playerData.money['crypto']
        }

    elseif Framework == "QBX" then
        local playerData = exports.qbx_core:GetPlayerData()

        data.identifier = playerData.citizenid
        data.name = string.format("%s %s", playerData.charinfo.firstname, playerData.charinfo.lastname)
        data.dob = playerData.charinfo.birthdate
        data.gender = playerData.charinfo.gender

        data.job = {
            name = playerData.job.name,
            label = playerData.job.label,
            grade = playerData.job.grade.level,
            gradeName = playerData.job.grade.name,
            isBoss = playerData.job.isboss,
            onDuty = playerData.job.onduty
        }

        data.accounts = {
            money = playerData.money['cash'],
            bank = playerData.money['bank'],
            crypto = playerData.money['crypto']
        }
    elseif Framework == "OX" then
        local player = Core.getPlayer()

        data.identifier = player.charId
        data.name = player.get('name')
        data.dob = player.get('dateOfBirth')
        data.gender = player.get('gender')

        local activeGroup = player.get('activeGroup')
        print(json.encode(activeGroup), {indent = true})
    else
        -- Other frameworks
    end

    return data
end

function HasItem(item)
    if Inventory == "ox_inventory" then
        local ox_inventory = exports.ox_inventory
        local count = ox_inventory:Search('count', item, nil)
        return count >= 1
    elseif Inventory == "qb-inventory" then
        return exports['qb-inventory']:HasItem(item, 1)
    end
end