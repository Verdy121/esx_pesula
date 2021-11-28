ESX = nil
TriggerEvent('esx:getSharedObject', function(object) ESX = object end)

RegisterServerEvent('pesuPerkele:perkelePese')
AddEventHandler('pesuPerkele:perkelePese', function()
    local pedi = ESX.GetPlayerFromId(source)
    local mustaraha = pedi.getAccount('black_money').money
    if mustaraha ~= 0 then
        pedi.removeAccountMoney('black_money', mustaraha)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Houkutellaan Pesijöitä Pesemään $'.. tostring(mustaraha) .. '', style = { ['background-color'] = '#077a13', ['color'] = '#ffffff' } })
        Citizen.Wait(5000)
        pedi.addMoney(mustaraha)
        TriggerClientEvent('mythic_notify:client:SendAlert', pedi.source, { type = 'inform', text = 'Houkuttelit pesijät! Rahasi on nyt Pesty!', style = { ['background-color'] = '#077a13', ['color'] = '#ffffff' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Sinulla ei ole enään Pestävää Rahaa!', style = { ['background-color'] = '#5e0707', ['color'] = '#ffffff' } })
    end
end)