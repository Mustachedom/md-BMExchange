local QBCore = exports['qb-core']:GetCoreObject()

local function spawnPeds()
    if not Config.Peds or not next(Config.Peds) or pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        current.model = type(current.model) == 'string' and joaat(current.model) or current.model
        RequestModel(current.model)
        while not HasModelLoaded(current.model) do
            Wait(0)
        end
        local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        current.pedHandle = ped
    end
    pedsSpawned = true
end

local function deletePeds()
    if not Config.Peds or not next(Config.Peds) or not pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        if current.pedHandle then
            DeletePed(current.pedHandle)
        end
    end
end

Citizen.CreateThread(function()
    spawnPeds()
end)
CreateThread(function()
     exports['qb-target']:AddBoxZone("BlackMarketexchange",vector3(755.63, -1863.9, 28.29), 1, 1, {
        name = "BlackMarketexchange",
        heading = 11,
        debugPoly = false,
        minZ = 26,
        maxZ = 30,
        }, {
        options = {
            {
                type = "server",
                event = "md-exchange:server:BlackMarketexchange",
                targeticon = 'fas fa-sign-in-alt',
                label = "exchange"
            },
        },
        distance = 3.0
 })
 
 end)
