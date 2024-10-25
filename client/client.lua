local ox_target = exports.ox_target
local rentedVehicle = nil
local isRented = false
local endofrentalperiod = nil 

CreateBlips = function()
	for k,v in pairs(Config.Locations) do
		local blip = AddBlipForCoord(v.pedCoords.x,v.pedCoords.y,v.pedCoords.z)
		SetBlipSprite(blip, v.BlipSprite)
		SetBlipColour(blip, v.BlipColour)
		SetBlipAsShortRange(blip,true)
		SetBlipScale(blip, 0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.bliplabel)
		EndTextCommandSetBlipName(blip)
	end
end

function drawDebugBox(coords, size)
    DrawMarker(1, coords.x, coords.y, coords.z - 0.5, 0, 0, 0, 0, 0, 0, size.x, size.y, size.z, 255, 0, 0, 150, false, true, 2, false, nil, nil, false, false, false, false, false)
end

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    return string.format("%02d:%02d", minutes, remainingSeconds)
end

local function updateMietTimer()
    Citizen.CreateThread(function()
        while isRented do
            local currentTime = GetGameTimer()
            local remainingtime = math.max(0, math.floor((endofrentalperiod - currentTime) / 1000))
            local formattedTime = formatTime(remainingtime)

            lib.showTextUI(Config.Locales[Config.Locale].remaining_rental_duration .. formattedTime, { 
                --for more Informationen -- https://overextended.dev/ox_lib/Modules/Interface/Client/notify
                position = 'left-center',
                icon = 'fa-solid fa-key',
                iconColor = 'green',
                iconAnimation = 'fade',
                style = { 
                    color = 'green',
                    fontSize = '15px',
                }
            })

            Wait(1000)

            if remainingtime <= 0 then
                lib.hideTextUI() 
                TriggerEvent('rentacar:returnVehicle')
                break
            end
        end
    end)
end
local function zahlungDurchfuehren(preis, callback)
    local player = ESX.GetPlayerData()
    local zahlungsmethode = nil

    local options = {
        {
            title = "Bank",
            description = Config.Locales[Config.Locale].pay_with_bank,
            icon = 'fa-solid fa-university',
            onSelect = function()
                ESX.TriggerServerCallback("rentacar:checkBank", function(hasMoney)
                    if hasMoney then
                        ESX.ShowNotification(string.format(Config.Locales[Config.Locale].pay_bank, preis))
                        callback(true) 
                    else
                        ESX.ShowNotification(Config.Locales[Config.Locale].not_enough_bank)
                        callback(false) 
                    end
                end, preis) 
            end
        },
        {
            title = "Bar",
            description = Config.Locales[Config.Locale].pay_with_cash,
            icon = 'fa-solid fa-money-bill',
            onSelect = function()
                ESX.TriggerServerCallback("rentacar:checkMoney", function(hasMoney)
                    if hasMoney then
                        ESX.ShowNotification(string.format(Config.Locales[Config.Locale].pay_cash, preis))
                        callback(true)
                    else
                        ESX.ShowNotification(Config.Locales[Config.Locale].not_enough_cash)
                        callback(false) 
                    end
                end, preis)
            end
        }
    }

    lib.registerContext({
        id = 'payment_methods_menu',
        title = Config.Locales[Config.Locale].select_payment,
        options = options
    })
    lib.showContext('payment_methods_menu')
end

local function mietFahrzeug(preis)
    zahlungDurchfuehren(preis)
end
RegisterNetEvent('rentacar:starteMiete', function(data)
    if isRented then
        ESX.ShowNotification(Config.Locales[Config.Locale].vehicle_rented_already)
        return 
    end

    local location = data.location
    local fahrzeug = data.fahrzeug
    local rentalDuration = data.time.multiplier * 60 * 60 * 1000 -- Time in Millisek.

    local preis = fahrzeug.price * data.time.multiplier 

    zahlungDurchfuehren(preis, function(success)
        if success then 
            if not location or not location.class then
                ESX.ShowNotification("Fehler: location oder Fahrzeugklasse fehlen.")
                print("location-Daten: ", json.encode(location))
                print("Debug: Fahrzeug-Klasse: " .. fahrzeug.class)
                return
            end

            local spawnSuccessful = false
            for _, locationSpawn in ipairs(location.vehicleSpawn) do
                if ESX.Game.IsSpawnPointClear(locationSpawn.coords, 1.5) then
                    local vehicleModel = GetHashKey(fahrzeug.model)

                    RequestModel(vehicleModel)
                    while not HasModelLoaded(vehicleModel) do
                        Wait(500)
                    end

                    local spawnedVehicle = CreateVehicle(vehicleModel, locationSpawn.coords.x, locationSpawn.coords.y, locationSpawn.coords.z, locationSpawn.heading, true, false)
                    SetVehicleNumberPlateText(spawnedVehicle, Config.Locales[Config.Locale].plate_name)
                    TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)

                    endofrentalperiod = GetGameTimer() + rentalDuration
                    ESX.ShowNotification(Config.Locales[Config.Locale].rentalNotification .. (rentalDuration / 60000) .. Config.Locales[Config.Locale].minutes)

                    isRented = true
                    rentedVehicle = spawnedVehicle
                    updateMietTimer()
                    spawnSuccessful = true
                    break
                end
            end

            if not spawnSuccessful then
                ESX.ShowNotification(Config.Locales[Config.Locale].spawn_points_blocked)
            end
        else
            ESX.ShowNotification(Config.Locales[Config.Locale].payment_failed)
        end
    end)
end)

-- The red markers are only used to see where the position is
-- if you don't want to see it, simply set Debug_marker = false in Conifg.
if Config.Debug_marker then 
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            for _, location in ipairs(Config.Locations) do
                for _, locationSpawn in ipairs(location.vehicleSpawn) do
                    -- Move the box downwards on the Z-axis by 1.0 units
                    drawDebugBox({
                        x = locationSpawn.coords.x,
                        y = locationSpawn.coords.y,
                        z = locationSpawn.coords.z - 0.3  --Move Z-axis down by 1.0 units
                    }, { 
                        x = 1.0, 
                        y = 1.0, 
                        z = 0.1  -- Keep the box size the same
                    })
                end
            end
        end
    end)
end

RegisterNetEvent('rentacar:returnVehicle', function()
    if isRented and DoesEntityExist(rentedVehicle) then
        DeleteEntity(rentedVehicle)
        rentedVehicle = nil
        isRented = false
        lib.hideTextUI()
        ESX.ShowNotification(Config.Locales[Config.Locale].vehicleReturned)
    else
        ESX.ShowNotification(Config.Locales[Config.Locale].no_rented_vehicle)
    end
end)

RegisterNetEvent('rentacar:openrentalmenu', function(location)
    local menuOptions = {}
    local location = location.location
    local fahrzeug = location.fahrzeug

    for _, fahrzeug in ipairs(Config.VehicleRental) do
        for _, klasse in ipairs(location.class) do
            if fahrzeug.class == klasse then

                local accelerationText = "0-100 in " .. fahrzeug.metadata.acceleration .. " Sek.."
                table.insert(menuOptions, {
                    title = fahrzeug.label,
                    image = fahrzeug.image,
                    description = fahrzeug.description,
                    metadata = {
                        { label = Config.Locales[Config.Locale].acceleration, value = accelerationText },
                        { label = Config.Locales[Config.Locale].drag, value = fahrzeug.metadata.drag },
                        { label = Config.Locales[Config.Locale].maxSpeed, value = fahrzeug.metadata.maxSpeed },
                        { label = Config.Locales[Config.Locale].gears, value = fahrzeug.metadata.gears },
                        --cou can more metdata here
                    },
                    onSelect = function()
                        TriggerEvent('rentacar:rentVehicle', {fahrzeug = fahrzeug, location = location})
                    end
                })
            end
        end
    end

    lib.registerContext({
        {
            id = "openmenu",
            title = Config.Locales[Config.Locale].vehicle_rental,
            description = Config.Locales[Config.Locale].select_vehicle_to_rent,
            options = menuOptions
        }
    })
    lib.showContext('openmenu')
end)

RegisterNetEvent('rentacar:rentVehicle', function(data)
    local fahrzeug = data.fahrzeug
    local location = data.location
    local mietOption = {}

    if location.class == nil then
        print("Fehler: location.class ist nil!")
        print("Debug: location class: ", json.encode(location.class))
    end

    if fahrzeug.class == nil then
        print("Fehler: fahrzeug.class ist nil!")
        print("Debug: Fahrzeug class: ", json.encode(fahrzeug.class))
    end

    for _, time in ipairs(Config.RentalTimes) do
        table.insert(mietOption, {
            title = time.label,
            description = Config.Locales[Config.Locale].vehicle_cost .. (fahrzeug.price * time.multiplier),
            onSelect = function()
                TriggerEvent('rentacar:starteMiete', {fahrzeug = fahrzeug, time = time, location = location})
            end
        })
    end

    lib.registerContext({
        {
            id = "rental_menu",
            title = Config.Locales[Config.Locale].title_select_rental_duration,
            description = Config.Locales[Config.Locale].choose_rental_duration,
            options = mietOption
        }
    })
    lib.showContext('rental_menu')
end)

local function erstelleVerleihPeds()
    for _, location in ipairs(Config.Locations) do
        RequestModel(location.pedModel)
        while not HasModelLoaded(location.pedModel) do
            Wait(1)
        end

        local ped = CreatePed(4, location.pedModel, location.pedCoords.x, location.pedCoords.y, location.pedCoords.z - 1.0, location.pedCoords.w, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        ox_target:addBoxZone({
            coords = location.pedCoords,
            size = vec3(1, 1, 2),
            rotation = 0,
            debug = false,
            options = {
                {
                    name = "Mieten",
                    type = "client",
                    label = Config.Locales[Config.Locale].rent_vehicle,
                    icon = 'fa-solid fa-box',
                    event = 'rentacar:openrentalmenu',
                    location = location, --dont touch this
                },
                {
                    name = "Rückgabe",
                    type = "client",
                    label = Config.Locales[Config.Locale].return_vehicle,
                    icon = "fa-solid fa-undo",
                    event = "rentacar:returnVehicle",
                    location = location,  --dont touch this
                }
            }
        })
    end
end

Citizen.CreateThread(function()
    erstelleVerleihPeds()
    CreateBlips()
end)