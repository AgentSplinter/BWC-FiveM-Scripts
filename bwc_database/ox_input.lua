RegisterCommand("database-edit", function()
    TriggerServerEvent("database-check-access")
end, false)

RegisterNetEvent("database-access-response")
AddEventHandler("database-access-response", function(hasAccess)
    if hasAccess then
        local options = {
            { title = "Manage Vehicles", value = "vehicles" },
            { title = "Manage Warrants", value = "warrants" },
            { title = "Manage Tickets", value = "tickets" }
        }

        -- Register Main Menu Context
        lib.registerContext({
            id = "database_main",
            title = "Database Edit Menu",
            options = options,
            onSelect = function(selected)
                if selected.value == "vehicles" then
                    manageVehicles()
                elseif selected.value == "warrants" then
                    manageWarrants()
                elseif selected.value == "tickets" then
                    manageTickets()
                end
            end
        })
        lib.showContext("database_main")
    else
        TriggerClientEvent("ox_lib:notify", source, { description = "You do not have permission to access this menu.", type = "error" })
    end
end)

-- Vehicle Management Menu
function manageVehicles()
    local options = {
        { title = "Add Vehicle", value = "add_vehicle" },
        { title = "Modify Vehicle", value = "modify_vehicle" }
    }
    lib.registerContext({
        id = "database_vehicle_menu",
        title = "Vehicle Management",
        options = options,
        onSelect = function(selected)
            if selected.value == "add_vehicle" then
                addVehicle()
            elseif selected.value == "modify_vehicle" then
                modifyVehicle()
            end
        end
    })
    lib.showContext("database_vehicle_menu")
end

-- Warrant Management Menu
function manageWarrants()
    local options = {
        { title = "Add Warrant", value = "add_warrant" },
        { title = "Modify Warrant", value = "modify_warrant" }
    }
    lib.registerContext({
        id = "database_warrant_menu",
        title = "Warrant Management",
        options = options,
        onSelect = function(selected)
            if selected.value == "add_warrant" then
                addWarrant()
            elseif selected.value == "modify_warrant" then
                modifyWarrant()
            end
        end
    })
    lib.showContext("database_warrant_menu")
end

function manageTickets()
    local options = {
        { title = "Add Ticket", value = "add_ticket" },
        { title = "Modify Ticket", value = "modify_ticket" }
    }

    lib.registerContext({
        id = "database_ticket_menu",
        title = "Ticket Management",
        options = options,
        onSelect = function(selected)
            if selected.value == "add_ticket" then
                addTicket()
            elseif selected.value == "modify_ticket" then
                modifyTicket()
            end
        end
    })

    lib.showContext("database_ticket_menu")
end

-- Work In Progress
function addVehicle()
    print("Vehicle added.")
end

function modifyVehicle()
    print("Vehicle modified.")
end

function addWarrant()
    print("Warrant added.")
end

function modifyWarrant()
    print("Warrant modified.")
end

function addTicket()
    print("Ticket added.")
end

function modifyTicket()
    print("Ticket modified.")
end
