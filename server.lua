local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('md-exchange:server:BlackMarketexchange', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 0
    if Player ~= nil then
        if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
            for k, v in pairs(Player.PlayerData.items) do
                if Player.PlayerData.items[k] ~= nil then
                    for _, v in pairs(Config.BlackMarket) do
                        if v.name == Player.PlayerData.items[k].name then
                            price = price + (v.price * Player.PlayerData.items[k].amount)
                            Player.Functions.RemoveItem(Player.PlayerData.items[k].name,
                            Player.PlayerData.items[k].amount, k)
                        end
                    end
                end
            end
            if price == 0 then
                TriggerClientEvent('QBCore:Notify', src, "You dont have anything to sell")
            else
                Player.Functions.AddItem(Config.CurrencyItem, price, "sold-a lot")
                TriggerClientEvent('QBCore:Notify', src, "You Got Rid Of Some Hot Stuff For A Price Of" .. price)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have items")
        end
    end
end)
