ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("database-check-access")
AddEventHandler("database-check-access", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local hasAccess = false
    for _, job in ipairs(Config.PoliceJobs) do
        if xPlayer.job.name == job and xPlayer.job.grade >= Config.AccessRank then
            hasAccess = true
            break
        end
    end

    TriggerClientEvent("database-access-response", src, hasAccess)
end)

RegisterServerEvent("pd_database:fetchCitizens")
AddEventHandler("pd_database:fetchCitizens", function()
    local src = source
    MySQL.Async.fetchAll("SELECT * FROM database_pd", {}, function(result)
        TriggerClientEvent("pd_database:receiveCitizens", src, result)
    end)
end)

-- Fetch Vehicles data from persistent table 'database_pd_car'
RegisterServerEvent("pd_database:fetchVehicles")
AddEventHandler("pd_database:fetchVehicles", function()
    local src = source
    MySQL.Async.fetchAll("SELECT * FROM database_pd_car", {}, function(result)
        TriggerClientEvent("pd_database:receiveVehicles", src, result)
    end)
end)

-- Fetch Warrants data from persistent table 'database_pd_warrants'
RegisterServerEvent("pd_database:fetchWarrants")
AddEventHandler("pd_database:fetchWarrants", function()
    local src = source
    MySQL.Async.fetchAll("SELECT * FROM database_pd_warrants", {}, function(result)
        TriggerClientEvent("pd_database:receiveWarrants", src, result)
    end)
end)

-- Fetch Tickets data from persistent table 'database_pd_ticket'
RegisterServerEvent("pd_database:fetchTickets")
AddEventHandler("pd_database:fetchTickets", function()
    local src = source
    MySQL.Async.fetchAll("SELECT * FROM database_pd_ticket", {}, function(result)
        TriggerClientEvent("pd_database:receiveTickets", src, result)
    end)
end)

RegisterServerEvent("pd_database:addVehicle")
AddEventHandler("pd_database:addVehicle", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.job.name == "police" then
        MySQL.Async.execute(
            "INSERT INTO database_pd_car (model, color, type, plate, owner, impounded, stolen) VALUES (?, ?, ?, ?, ?, ?, ?)", 
            { data.model, data.color, data.type, data.plate, data.owner, data.impounded, data.stolen },
            function(rowsChanged)
                TriggerClientEvent("ox_lib:notify", src, { description = "Vehicle added!", type = "success" })
            end
        )
    end
end)

-- Add Warrant manually into 'database_pd_warrants'
RegisterServerEvent("pd_database:addWarrant")
AddEventHandler("pd_database:addWarrant", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.job.name == "police" then
        MySQL.Async.execute(
            "INSERT INTO database_pd_warrants (suspect_name, reason, notes, date_issued, issued_by, priority) VALUES (?, ?, ?, ?, ?, ?)",
            { data.suspect_name, data.reason, data.notes, data.date_issued, xPlayer.getName(), data.priority },
            function(rowsChanged)
                TriggerClientEvent("ox_lib:notify", src, { description = "Warrant added!", type = "success" })
            end
        )
    end
end)

-- Add Ticket manually into 'database_pd_ticket'
RegisterServerEvent("pd_database:addTicket")
AddEventHandler("pd_database:addTicket", function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.job.name == "police" then
        MySQL.Async.execute(
            "INSERT INTO database_pd_ticket (issued_to, issued_by, incident, amount_due) VALUES (?, ?, ?, ?)",
            { data.issued_to, xPlayer.getName(), data.incident, data.amount_due },
            function(rowsChanged)
                TriggerClientEvent("ox_lib:notify", src, { description = "Ticket issued!", type = "success" })
            end
        )
    end
end)

RegisterCommand("refreshpddata", function(source, args, rawCommand)
    local src = source
    TriggerEvent("pd_database:fetchCitizens")
    TriggerEvent("pd_database:fetchVehicles")
    TriggerEvent("pd_database:fetchWarrants")
    TriggerEvent("pd_database:fetchTickets")
end, false)
