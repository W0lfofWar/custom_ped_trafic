local zones = {
    {
        
        name = "miltary camp",
        coords = vector3(-2050.31, 3079.34, 32.27),
        radius = 500.0,
        pedMultiplier = 1.0,
        vehicleMultiplier = 1.0,
        parkedVehicleMultiplier = 1.0,
        scenarioPedMultiplier = 1.0
    },
    {
        name = "miltary camp2",
        coords = vector3(-2637.86, 3222.11, 32.27),
        radius = 300.0,
        pedMultiplier = 1.0,
        vehicleMultiplier = 1.0,
        parkedVehicleMultiplier = 1.0,
        scenarioPedMultiplier = 1.0
    },
    -- Add more zones as needed
}

function getCurrentZoneMultipliers()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, zone in ipairs(zones) do
        local distance = #(playerCoords - zone.coords)
        if distance < zone.radius then
            return zone.pedMultiplier, zone.vehicleMultiplier, zone.parkedVehicleMultiplier, zone.scenarioPedMultiplier
        end
    end
    return 0.0, 0.0, 0.0, 0.0 -- Default to no traffic, peds, parked vehicles, or scenario peds outside defined zones
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local pedMultiplier, vehicleMultiplier, parkedVehicleMultiplier, scenarioPedMultiplier = getCurrentZoneMultipliers()
        
        SetPedDensityMultiplierThisFrame(pedMultiplier)
        SetVehicleDensityMultiplierThisFrame(vehicleMultiplier)
        SetRandomVehicleDensityMultiplierThisFrame(vehicleMultiplier)
        SetParkedVehicleDensityMultiplierThisFrame(parkedVehicleMultiplier)
        SetScenarioPedDensityMultiplierThisFrame(scenarioPedMultiplier, scenarioPedMultiplier)
    end
end)