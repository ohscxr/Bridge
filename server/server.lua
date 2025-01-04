function GetPlayerById(source)
    if Framework == 'ESX' then
        return Core.GetPlayerById(source)
    elseif Framework ==  'QB' then
        return Core.Functions.GetPlayer(source)
    elseif Framework == 'QBX' then
    end
end

function GetPlayerByIdentifier(identifier)
    if Framework == 'ESX' then
        return Core.GetPlayerFromIdentifier(identifier)
    elseif Framework ==  'QB' then
        return Core.Functions.GetPlayerByCitizenId()
    elseif Framework == 'QBX' then
    end
end

function GetIdentifier(source)
    local Player = Framework.GetPlayerById(source)

    if Framework == "ESX" then
        return Player.identifier
    elseif Framework == "QB" then
        return Player.PlayerData.citizenid
    elseif Framework == "QBX" then
        return Player.PlayerData.citizenid
    elseif Framework == "OX" then
        
    end

end

function GetMoney(source, type)
    local Player = Framework.GetPlayerById(source)
    if Framework == "ESX" then
        return Player.getAccount(type).money
    elseif Framework == "QB" then
        if type == "bank" then
            return Player.PlayerData.money.bank
        elseif type == "money" then
            return Player.PlayerData.money.cash
        end
    elseif Framework == "QBX" then
        if type == "bank" then
            return Player.PlayerData.money.bank
        elseif type == "money" then
            return Player.PlayerData.money.cash
        end
    end
end

function AddMoney(source, type, money)
    local Player = Framework.GetPlayerById(source)
    if Framework == "ESX" then
        Player.addAccountMoney(type, money)
    elseif Framework == "QB" then
        if type == "bank" then
            Player.Functions.AddMoney(type, money)
        elseif type == "money" then
            Player.Functions.AddMoney("cash", money)
        end
    elseif Framework == "QBX" then
    end
end

function RemoveMoney(source, type, money)
    local Player = Framework.GetPlayerById(source)
    if Framework == "ESX" then
        Player.removeAccountMoney(type, money)
    elseif Framework == "QB" then
        if type == "bank" then
            Player.Functions.RemoveMoney(type, money)
        elseif type == "money" then
            Player.Functions.RemoveMoney("cash", money)
        end
    elseif Framework == "QBX" then
    end
end

function GetItemCount(source, item)
    if Inventory == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(source, item, nil, nil)
    elseif Inventory == 'qb_inventory' then
        return exports['qb-inventory']:GetItemCount(source, item)
    else
        if Framework == "ESX" then
            local xPlayer = Framework.GetPlayerById(source)
            return xPlayer.getInventoryItem(item).count
        end
    end
end


function RemoveItem(source, item, amount)
    if Inventory == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(source, item, amount)
    elseif Inventory == 'qb_inventory' then
        exports['qb-inventory']:RemoveItem(source, item, amount, false)
    else
        if Framework == "ESX" then
            local xPlayer = Framework.GetPlayerById(source)
            return xPlayer.removeInventoryItem(item, amount)
        end
    end
end

function AddItem(source, item, amount)
    if Inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(source, item, amount)
    elseif Inventory == 'qb_inventory' then
        exports['qb-inventory']:AddItem(source, item, amount, false)
    else
        if Framework == "ESX" then
            local xPlayer = Framework.GetPlayerById(source)
            return xPlayer.addInventoryItem(item, amount)
        end
    end
end

function GetJobCount(job)
    if Framework == "ESX" then
        return #Core.GetExtendedPlayers('job', job)
    elseif Framework == 'QB' then
        local count = 0
        local Players = Core.Functions.GetQBPlayers()
        for _, Player in pairs(Players) do
            if Player.PlayerData.job.name == job and Player.PlayerData.job.onduty then
                count = count + 1
            end
        end
        return count
    elseif Framework == 'QBX' then

    end
end