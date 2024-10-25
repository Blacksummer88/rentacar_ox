Config = {}

Config.Locale = "en" -- language, can be switched to "en" - "de" -- or more

-- Das sind die Roten makierte marker dienen nur zum sehen wo die position ist
-- wenn du es nicht sehen willst einfach in der Conifg.Debug_marker = false setzen
Config.Debug_marker = false

Config.RentalTimes = {
    { label = "15 Minuten",  multiplier = 0.25 },
    { label = "30 Minuten",  multiplier = 0.5 },
    { label = "45 Minuten",  multiplier = 0.75 },
    { label = "1 Stunde",    multiplier = 1.0 },
    { label = "1,5 Stunden", multiplier = 1.5 },
    { label = "2 Stunden",   multiplier = 2.0 }
    -- yo can more..
}

Config.Locations = { 
    {
        name = "Fahrrad",
        bliplabel = "Fahrrad Verleih", --blip name
        BlipSprite = 522, -- blip muster
        BlipColour = 46, -- blip color
        pedModel = "a_m_y_business_01",
        pedCoords = vector4(-1012.5909, -2698.1135, 13.9922, 53.6039), -- Ped-Position
        class = { "bikes" },
        vehicleSpawn = {
            { coords = vector3(-1013.8598, -2695.0654, 13.9821), heading = 147.4067 }
        }
    },
    {
        name = "Autos",
        bliplabel = "Auto Verleih",
        BlipSprite = 523,
        BlipColour = 46,
        pedModel = "a_m_y_business_02",
        pedCoords = vector4(-205.0840, 6228.7847, 31.4898, 228.31),
        class = {"car" },
        vehicleSpawn = {
            { coords = vector3(-205.6057, 6222.3145, 31.1275), heading = 226.102 },
            { coords = vector3(-198.5291, 6229.4180, 31.1374), heading = 224.371 }
        }
    },
    {
        name = "car_and_bike",
        bliplabel = "Auto/Fahrrad Verleih",
        BlipSprite = 523,
        BlipColour = 46,
        pedModel = "a_m_y_business_02",
        pedCoords = vector4(1504.9053, 3769.1023, 34.0929, 190.0944),
        class = {"car", "bikes" },
        vehicleSpawn = {
            { coords = vector3(1497.3926, 3760.3813, 33.9226), heading = 226.102 },
            { coords = vector3(1495.0654, 3758.5723, 33.9006), heading = 224.371 }
        }
    }
    -- You can add further locations
}

Config.VehicleRental = {
    {
        model = "bmx",
        price = 50,
        label = "BMX", 
        class = "bikes", -- Fahrzeugklasse
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/c9bc3aea2be614e38e296836b72047cf', -- externe URL or local = "nui://rentacar_ox/html/image/airtug.png",     
        metadata = {   -- you can add more in the client.lua line 214
            acceleration = 0.16,
            drag = 60,
            maxSpeed = 50,
            gears = 1,
        }
    },
    {
        model = "tribike2",
        price = 100,
        label = "Rennrad",
        class = "bikes",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/974e78da5a4d5dfb3769029bc4c6c0d9',
        metadata = { 
            acceleration = 0.135,
            drag = 20,
            maxSpeed = 63,
            gears = 1,
        }
    },
    {
        model = "inductor",
        price = 250,
        label = "E-Bike",
        class = "bikes",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/71152ef24669d4339161f7d75f92b4c3',
        metadata = { 
            acceleration = 0.112,
            drag = 75,
            maxSpeed = 75,
            gears = 1,
        }
    },
    {
        model = "scorcher",
        price = 100,
        label = "Mountainbike",
        class = "bikes",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/015ed1fc03952611c4602f3e9370e7b9',
        metadata = {
            acceleration = 0.17,
            drag = 60,
            maxSpeed = 55,
            gears = 1,
        }
    },
    {
        model = "serv_electricscooter",
        price = 350,
        label = "E-Scooter",
        class = "bikes",
        description = 'Wähle Zeit und Preis',
        image = 'https://cdn.discordapp.com/attachments/1249289876906578031/1296513760042680373/image.png?ex=67129008&is=67113e88&hm=17a5fc40cf9067b5e3e494fc6777453a00c601be9bf33bce045bd30782c10deb&',
        metadata = {
            acceleration = 0.28,
            drag = 9.5,
            maxSpeed = 151,
            gears = 5,
        }
    },

    --Type car
    {
        model = "baller8",
        price = 350,
        label = "Baller ST-D",
        class = "car",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/f5bc006d1a0147ebff8fa587b7a705ad',
        metadata = {
            acceleration = 0.295,
            drag = 7.85,
            maxSpeed = 140,
            gears = 7,
        }
    },
    {
        model = "postlude",
        price = 350,
        label = "Postlude",
        class = "car",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/d52d69ca5d1262bb5438c16bea878833',
        metadata = {
            acceleration = 0.295,
            drag = 11.45,
            maxSpeed = 131,
            gears = 5,
        }
    },
    {
        model = "kanjosj",
        price = 350,
        label = "Kanjo SJ",
        class = "car",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/125057c212bc15cf0f5bb3b48c3f8484',
        metadata = {
            acceleration = 0.315,
            drag = 10.95,
            maxSpeed = 141,
            gears = 5,
        }
    },
    {
        model = "jackal",
        price = 250,
        label = "Jackal",
        class = "car",
        description = 'Wähle Zeit und Preis',
        image = 'https://gtacars.net/images/133a18f5b210db972c9f6fc1ddbfd0c8',
        metadata = {
            acceleration = 0.22,
            drag = 8.5,
            maxSpeed = 142.5,
            gears = 6,
        }
    },
    {
        model = "eurosx32",
        price = 350,
        label = "Euros X32",
        class = "car",
        image = 'https://gtacars.net/images/c7e1746df0c587a96ebf5905dfeb15d4',
        description = 'Wähle Zeit und Preis',
        metadata = {
            acceleration = 0.28,
            drag = 9.5,
            maxSpeed = 151,
            gears = 5,
        }
    },
    {
        model = "airtug",
        price = 350,
        label = "Airtug",
        class = "car",
        image = "nui://rentacar_ox/html/image/airtug.png", -- Lokaler Bildpfad        
        description = 'Wähle Zeit und Preis',
        metadata = {
            acceleration = 0.28,
            drag = 9.5,
            maxSpeed = 151,
            gears = 5,
        }
    },
--[[  --you can make as many as you want
    {
        model = "eurosx32", -- spawn name
        price = 350,
        label = "Euros X32",
        class = "car", -- you can define a class but this must also be in Config.locations . class
        image = 'https://gtacars.net/images/c7e1746df0c587a96ebf5905dfeb15d4', -- local or url
        description = 'Wähle Zeit und Preis',
        metadata = { -- you can add more in the client.lua line 214
            acceleration = 0.28,
            drag = 9.5,
            maxSpeed = 151,
            gears = 5,
        }
    }, ]]

--[[  --you can make as many as you want
    {
        model = "eurosx32", -- spawn name
        price = 350,
        label = "Euros X32",
        class = "car", -- you can define a class but this must also be in Config.locations . class
       mage = "nui://rentacar_ox/html/image/airtug.png", -- Lokaler Bildpfad    
        metadata = { -- you can add more in the client.lua line 214
            acceleration = 0.28,
            drag = 9.5,
            maxSpeed = 151,
            gears = 5,
        }
    }, ]]
}

Config.Locales = {
    ["de"] = {
        -- Notify
        pay_bank = "Du hast ~y~%s ~s~ $ von deinem ~y~Bankkonto ~s~bezahlt.",
        not_enough_bank = "~r~Nicht genug Geld auf der Bank.",
        pay_cash = "Du hast ~g~%s ~s~ $ in ~y~Bar ~s~bezahlt.",
        not_enough_cash = "~r~Du hast Nicht genug Bargeld.",
        vehicle_rented_already = "Du hast bereits ein Fahrzeug gemietet.",
        rentalNotification = "Du hast das Fahrzeug gemietet. Laufzeit: ~y~",
        minutes = " ~s~Minuten",
        spawn_points_blocked = "Alle Spawn-Punkte sind blockiert. Bitte versuche es später erneut.",
        payment_failed = "Zahlung fehlgeschlagen. Miete abgebrochen.",
        vehicleReturned = "Du hast das Fahrzeug zurückgegeben.",
        no_rented_vehicle = "Du hast momentan kein gemietetes Fahrzeug.",

        --lib menuOptions
        pay_with_bank = "Bezahlen mit Bank",
        pay_with_cash = "Bezahlen mit Bargeld",
        select_payment = "Zahlungsmethode wählen",
        select_vehicle_to_rent = "Wähle ein Fahrzeug zum Mieten",
        vehicle_rental = "Fahrzeugverleih",
        vehicle_cost = "Kostet: $",
        title_select_rental_duration = "Mietdauer wählen",
        choose_rental_duration = "Wähle die Mietdauer",
        rent_vehicle = "Fahrzeug mieten",
        return_vehicle = "Fahrzeug zurückgeben",
        remaining_rental_duration = "Mietdauer verbleibend ",

        -- Metadata Label
        acceleration = "Beschleunigung",
        drag = "Ziehen",
        maxSpeed = "Maximale Geschwindigkeit",
        gears = "Gänge",

        -- Vehicle plate name
        plate_name = "Mieten",
    },
    ["en"] = {
        -- Notify
        pay_bank = "You paid ~g~%s  ~s~ $ from your ~y~bank account~s~.",
        not_enough_bank = "Not enough money in the bank.",
        pay_cash = "You paid ~g~%s $~s~ in ~y~cash~s~.",
        not_enough_cash = "Not enough cash.",
        vehicle_rented_already = "You have already rented a vehicle.",
        rentalNotification = "You have rented the vehicle. Duration: ",
        minutes = " Minutes",
        spawn_points_blocked = "All spawn points are blocked. Please try again later.",
        payment_failed = "Payment failed. Rental cancelled.",
        vehicleReturned = "You have returned the vehicle.",
        no_rented_vehicle = "You currently have no rented vehicle.",

        --lib menuOptions
        pay_with_bank = "Pay with Bank",
        pay_with_cash = "Pay with Cash",
        select_payment = "Choose Payment Method",
        select_vehicle_to_rent = "Select a vehicle to rent",
        vehicle_rental = "Vehicle Rental",
        vehicle_cost = "Cost: $",
        title_select_rental_duration = "Select Rental Duration",
        choose_rental_duration = "Choose the rental duration",
        rent_vehicle = "Rent vehicle",
        return_vehicle = "Return vehicle",
        remaining_rental_duration = "Remaining rental duration ",

        --Metadata Label
        acceleration = "Acceleration",
        drag = "drag",
        maxSpeed = "maxSpeed",
        gears = "Gears",

        -- Vehicle plate name
        plate_name = "Rent",
    }
}