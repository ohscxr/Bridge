Framework, Core, Inventory = nil, nil, nil

if GetResourceState('es_extended') == 'started' then
    Framework = 'ESX'
    Core = exports.ex_extended:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = 'QB'
    Core = exports['qb-core']:GetCoreObject()
elseif GetResourceState('qbx_core') == 'started' then
    Framework = 'QBX'
elseif GetResourceState('ox_core') == 'started' then
    Framework = "OX"
end

if GetResourceState('ox_inventory') == 'started' then
    Inventory = "ox_inventory"
end

if GetResourceState('qb-inventory') == 'started' then
    Inventory = "qb-inventory"
end
