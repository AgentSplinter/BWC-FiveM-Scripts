ESX = exports["es_extended"]:getSharedObject()
local isOpen = false

-- Existing receive data events:
RegisterNetEvent("pd_database:receiveCitizens", function(data)
    SendNUIMessage({ type = "updateCitizens", data = data })
end)

RegisterNetEvent("pd_database:receiveVehicles", function(data)
    SendNUIMessage({ type = "updateVehicles", data = data })
end)

RegisterNetEvent("pd_database:receiveWarrants", function(data)
    SendNUIMessage({ type = "updateWarrants", data = data })
end)

RegisterNetEvent("pd_database:receiveTickets", function(data)
    SendNUIMessage({ type = "updateTickets", data = data })
end)

RegisterNUICallback("closeUI", function(_, cb)
    isOpen = false
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("fetchData", function(data, cb)
    if data.category == "citizens" then
        TriggerServerEvent("pd_database:fetchCitizens")
    elseif data.category == "vehicles" then
        TriggerServerEvent("pd_database:fetchVehicles")
    elseif data.category == "warrants" then
        TriggerServerEvent("pd_database:fetchWarrants")
    elseif data.category == "tickets" then
        TriggerServerEvent("pd_database:fetchTickets")
    end
    cb("ok")
end)

RegisterNUICallback("openAddWarrantMenu", function(_, cb)
    cb("ok")
    SendNUIMessage({ type = "hideUI" })
    SetNuiFocus(false, false)

    local input = exports.ox_lib:inputDialog({
        {
            type = 'input',
            label = 'Suspect Name',
            name = 'suspect_name'
        },
        {
            type = 'input',
            label = 'Reason',
            name = 'reason'
        },
        {
            type = 'textarea',
            label = 'Notes',
            name = 'notes'
        },
        {
            type = 'input',
            label = 'Priority (0=low,1=med,2=high)',
            name = 'priority'
        }
    })

    if input then
        input.date_issued = os.date('%Y-%m-%d %H:%M:%S')
        TriggerServerEvent("pd_database:addWarrant", input)
    end

    Wait(100)
    SendNUIMessage({ type = "openUI" })
    SetNuiFocus(true, true)
end)

RegisterNUICallback("openAddTicketMenu", function(_, cb)
    cb("ok")
    SendNUIMessage({ type = "hideUI" })
    SetNuiFocus(false, false)

    local input = exports.ox_lib:inputDialog({
        {
            type = 'input',
            label = 'Issued To',
            name = 'issued_to'
        },
        {
            type = 'textarea',
            label = 'Incident',
            name = 'incident'
        },
        {
            type = 'input',
            label = 'Amount Due',
            name = 'amount_due'
        }
    })

    if input then
        TriggerServerEvent("pd_database:addTicket", input)
    end

    Wait(100)
    SendNUIMessage({ type = "openUI" })
    SetNuiFocus(true, true)
end)

RegisterCommand("openpdcomputer", function()
    local playerData = ESX.GetPlayerData()
    if playerData.job and playerData.job.name == "police" then
        isOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({ type = "openUI" })
        TriggerServerEvent("pd_database:fetchCitizens")
    else
        exports.ox_lib:notify({ description = "You are not police!", type = "error" })
    end
end)

-- Key mapping
RegisterKeyMapping("openpdcomputer", "Open Police Computer", "keyboard", Config.Keybind)
