ESX.RegisterServerCallback("rentacar:checkMoney", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getInventoryItem("cash").count >= price then
        xPlayer.removeInventoryItem("cash", price)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("rentacar:checkBank", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
        cb(true)
    else
        cb(false)
    end
end)


--[[ RegisterNetEvent('rentacar:starteMiete', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local preis = data.fahrzeug.price * data.zeit.multiplier

    -- Hier kannst du zusätzliche Logik für das Mieten des Fahrzeugs hinzufügen,
    -- z.B. Fahrzeug in die Datenbank einfügen oder den Spieler informieren.

    -- Beispiel: Informationen zum Fahrzeug in der Datenbank speichern
    -- MySQL.Async.execute("INSERT INTO rented_vehicles (player_id, vehicle_model, price) VALUES (@playerId, @model, @price)", {
    --     ['@playerId'] = xPlayer.identifier,
    --     ['@model'] = data.fahrzeug.model,
    --     ['@price'] = preis
    -- })
end) ]]
