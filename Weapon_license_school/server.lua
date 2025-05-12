local ESX = exports["es_extended"]:getSharedObject()

-- Check if the player already has a weapon license
ESX.RegisterServerCallback("weaponlicense:checkExistingLicense", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT 1 FROM user_licenses WHERE owner = @owner AND type = @type', {
            ['@owner'] = xPlayer.identifier,
            ['@type'] = 'weapon'
        }, function(result)
            if result then
                -- Player already has the license
                cb(true)
            else
                -- Player doesn't have the license
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("weaponlicense:checkMoney", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getMoney() >= Config.QuizCost then
            xPlayer.removeMoney(Config.QuizCost)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterNetEvent("weaponlicense:grantLicense")
AddEventHandler("weaponlicense:grantLicense", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('INSERT INTO user_licenses (owner, type) VALUES (@owner, @type)', {
            ['@owner'] = xPlayer.identifier,
            ['@type'] = 'weapon'
        }, function(rowsChanged)
            TriggerClientEvent('esx:showNotification', source, "You have been granted a weapon license.")
        end)
    end
end)
