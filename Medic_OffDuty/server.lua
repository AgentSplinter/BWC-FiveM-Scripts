ESX = nil
ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('hospital:checkMedicAvailability', function(source, cb)
    local medicsOnline = 0
    local players = ESX.GetExtendedPlayers()

    for _, xPlayer in ipairs(players) do
        if xPlayer.getJob().name == 'ambulance' and xPlayer.getJob().onDuty then
            medicsOnline = medicsOnline + 1
        end
    end

    cb(medicsOnline > 0)
end)

ESX.RegisterServerCallback('hospital:chargePlayer', function(source, cb, cost)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getAccount('money').money >= cost then
            xPlayer.removeAccountMoney('money', cost)
            cb(true)
        else
            cb(false)
        end
    end
end)
