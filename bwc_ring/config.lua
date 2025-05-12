Config = {}

Config.Notification = {
    title = "Doorbell",
    message = "Someone is ringing the doorbell at %s",
    duration = 8000, -- duration in milliseconds
}

-- Define doorbell locations for each job.
Config.Jobs = {
    police = {
        {
            id = 1,
            name = "Police Station",
            x = 441.81,
            y = -981.92,
            z = 30.69,
            radius = 1.0
        },
        {
            id = 2,
            name = "Sandy Shores Sheriff",
            x = 1829.86,
            y = 3681.54,
            z = 34.39,
            radius = 1.0
        },
        {
            id = 3,
            name = "Paleto Bay Sheriff",
            x = -448.83,
            y = 6013.90,
            z = 31.75,
            radius = 1.0
        },
        {
            id = 4,
            name = "Chilliad Sheriff",
            x = 487.36,
            y = 5413.03,
            z = 671.76,
            radius = 1.0
        }

    },
    ambulance = {
        {
            id = 1,
            name = "Aldore Hospital",
            x = -488.31,
            y = -988.31,
            z = 24.45,
            radius = 1.0
        }
    },
    fd = {
        {
            id = 1,
            name = "Fire Department",
            x = 1173.59,
            y = -1475.87,
            z = 34.97,
            radius = 1.0
        }
    },
    usms = {
        {
            id = 1,
            name = "USMS Office",
            x = 16.18,
            y = -929.06,
            z = 29.72,
            radius = 1.0
        },
        {
            id = 2,
            name = "Prison", --1840.37, 2578.62, 46.05
            x = 1840.37,
            y = 2578.62,
            z = 46.05,
            radius = 1.5
        }
    },
    doj = {
        {
            id = 1,
            name = "Gericht",
            x = -554.50,
            y = -185.79,
            z = 38.32,
            radius = 1.0
        }
    },
    mechanic = {
        {
            id = 1,
            name = "Cardealer",
            x = 109.60,
            y = -149.80,
            z = 55.00,
            radius = 1.0
        },
        {
            id = 2,
            name = "Mechanic",
            x = 155.60,
            y = -3019.10,
            z = 7.10,
            radius = 1.0
        }
    }
}
