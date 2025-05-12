ESX = nil
ESX = exports["es_extended"]:getSharedObject()

local isInTreatment = false

CreateThread(function()
    local model = GetHashKey("s_m_m_doctor_01")

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    local npc = CreatePed(4, model, Config.NPCLocation.xyz, Config.NPCLocation.w, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

exports['ox_target']:addLocalEntity(npc, {
    {
        name = "npc_treatment",
        icon = "fas fa-hands",
        label = "Request Treatment ($" .. Config.TreatmentCost .. ")",
        canInteract = function(entity, distance, coords, name)
            return not isInTreatment
        end,
        onSelect = function(data)
            ESX.TriggerServerCallback('hospital:checkMedicAvailability', function(medicsOnline)
                if medicsOnline then
                    exports.ox_lib:notify({
                        title = "Treatment Request",
                        description = "Medics are online, please contact them for treatment!",
                        type = "inform"
                    })
                else
                    ESX.TriggerServerCallback('hospital:chargePlayer', function(success)
                        if success then
                            StartTreatment()
                        else
                            -- Change to ox_lib notification
                            exports.ox_lib:notify({
                                title = "Insufficient Funds",
                                description = "Not enough money for treatment!",
                                type = "error"
                            })
                        end
                    end, Config.TreatmentCost)
                end
            end)
        end
    }
})
end)

function StartTreatment()
    isInTreatment = true
    local playerPed = PlayerPedId()

    SetEntityCoords(playerPed, Config.HospitalBedLocation.xyz)
    SetEntityHeading(playerPed, Config.HospitalBedLocation.w)
    FreezeEntityPosition(playerPed, true)

    RequestAnimDict(Config.BedAnimationDict)
    while not HasAnimDictLoaded(Config.BedAnimationDict) do
        Wait(100)
    end
    TaskPlayAnim(playerPed, Config.BedAnimationDict, Config.BedAnimationName, 8.0, 8.0, -1, 1, 0, false, false, false)

    exports.ox_lib:notify({
        title = "Treatment Timer",
        description = "You can cancel the treatment after " .. (Config.TreatmentDuration / 60000) .. " minutes by pressing X.",
        type = "inform"
    })

    CreateThread(function()
        while isInTreatment do
            Wait(0)
            if IsControlJustPressed(0, 73) then -- X key (default)
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
                isInTreatment = false
                exports.ox_lib:notify({
                    title = "Treatment Canceled",
                    description = "You canceled the treatment!",
                    type = "error"
                })
                return
            end
        end
    end)

    local treatmentDuration = Config.TreatmentDuration or 300000
    local timer = 0
    while timer < treatmentDuration and isInTreatment do
        Wait(1000) -- Check every second
        timer = timer + 1000
    end

    if isInTreatment then
        FreezeEntityPosition(playerPed, false) -- Unfreeze the player
        ClearPedTasks(playerPed) -- Stop animations

        TriggerEvent('visn_are:resetHealthBuffer', playerPed)

        exports.ox_lib:notify({
            title = "Treatment Complete",
            description = "You have been revived and all injuries have been treated!",
            type = "success"
        })
        isInTreatment = false
    end
end