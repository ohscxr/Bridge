Framework, Core = nil, nil

if GetResourceState('es_extended') == 'started' then
    Framework = 'ESX'
    Core = exports.ex_extended:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = 'QB'
    Core = exports['qb-core']:GetCoreObject()
elseif GetResourceState('qbx_core') == 'started' then
    Framework = 'QBX'
end