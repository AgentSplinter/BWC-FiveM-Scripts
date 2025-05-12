ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('doorbell:checkAvailability', function(data)
    local src = source
    local doorJob = data.job
    local doorLocation = data.locationName or "Unknown"
    local doorbellId = data.zoneId

    -- Check for online players with the target job
    local hasOnline = false
    for _, playerId in ipairs(GetPlayers()) do
        local targetPlayer = ESX.GetPlayerFromId(playerId)
        if targetPlayer and targetPlayer.job and targetPlayer.job.name == doorJob then
            hasOnline = true
            break
        end
    end

    if not hasOnline then
        TriggerClientEvent('ox_lib:notify', src, {
            title = "Doorbell",
            description = "No one from " .. doorJob .. " is currently available.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Apply cooldown to the client
    TriggerClientEvent('doorbell:cooldown', src, doorbellId)

    -- Notify all players with that job
    for _, playerId in ipairs(GetPlayers()) do
        local targetPlayer = ESX.GetPlayerFromId(playerId)
        if targetPlayer and targetPlayer.job and targetPlayer.job.name == doorJob then
            TriggerClientEvent('doorbell:notify', playerId, doorLocation)
        end
    end

    -- Notify the player who rang the bell
    TriggerClientEvent('ox_lib:notify', src, {
        title = "Doorbell",
        description = "You rang the doorbell at " .. doorLocation,
        type = "success",
        duration = 5000
    })
end)
