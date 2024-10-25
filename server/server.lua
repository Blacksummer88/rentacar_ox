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