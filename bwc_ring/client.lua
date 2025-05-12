local cooldowns = {}

RegisterNetEvent('doorbell:trigger', function(data)
    local doorbellId = data.zoneId
    local currentTime = GetGameTimer()

    if cooldowns[doorbellId] and (currentTime - cooldowns[doorbellId]) < 60000 then
        local remaining = math.ceil((60000 - (currentTime - cooldowns[doorbellId])) / 1000)
        exports.ox_lib:notify({
            title = "Doorbell",
            description = "Please wait " .. remaining .. " more seconds before ringing again.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Check with server if someone from that job is available
    TriggerServerEvent('doorbell:checkAvailability', data)
end)

RegisterNetEvent('doorbell:cooldown', function(doorbellId)
    cooldowns[doorbellId] = GetGameTimer()
end)

RegisterNetEvent('doorbell:notify', function(locationName)
    local message = string.format(Config.Notification.message, locationName)
    exports.ox_lib:notify({
        title = Config.Notification.title,
        description = message,
        type = "info",
        duration = Config.Notification.duration
    })
end)

-- Create doorbell interactive zones based on the configuration.
Citizen.CreateThread(function()
    for job, locations in pairs(Config.Jobs) do
        for _, loc in ipairs(locations) do
            local zoneName = "doorbell_" .. job .. "_" .. loc.id
            exports.ox_target:addSphereZone({
                coords = vec3(loc.x, loc.y, loc.z),
                radius = loc.radius or 1.0,
                debug = false,
                options = {
                    {
                        name = zoneName,
                        event = 'doorbell:trigger',
                        icon = 'fas fa-bell',
                        label = 'Ring Doorbell',
                        job = job,
                        locationName = loc.name,
                        zoneId = zoneName
                    }
                }
            })
        end
    end
end)
