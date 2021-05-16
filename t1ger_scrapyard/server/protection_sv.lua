local authoriseID = 'https://discord.gg/a5Pg5DrTwR'

function ScrambleCarList()
    carList = {}
    local scrambler = {}
    local amountOfCars = Config.CarListAmount
    for i = 1, amountOfCars do 
        local num = math.random(1, #Config.CarListCars)
        Citizen.Wait(1)
        math.randomseed(GetGameTimer())
        while scrambler[num] == num do
            num = math.random(1, #Config.CarListCars)
        end
        scrambler[num] = num
        local car = Config.CarListCars[num]
        table.insert(carList, {label = car.label, hash = car.hash, price = car.price})
    end
    return carList, true
end

-- Server Event to add player cooldown:
RegisterServerEvent('t1ger_scrapyard:startCarListTimer')
AddEventHandler('t1ger_scrapyard:startCarListTimer',function(source)
    table.insert(cooldownTimer, {identifier = GetPlayerIdentifier(source), time = (Config.CooldownTime * 60000)}) -- cooldown timer for doing missions
end)

-- Functions for List Cooldown:
function ResetCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            table.remove(cooldownTimer,k)
        end
    end
end
function GetCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            return math.ceil(v.time/60000)
        end
    end
end
function CheckCooldownTimer(source)
    for k,v in pairs(cooldownTimer) do
        if v.identifier == source then
            return true
        end
    end
    return false
end

RegisterServerEvent('loaf_test:getAccess')
AddEventHandler('loaf_test:getAccess', function()
    local src = source
    TriggerClientEvent('loaf_test:setAccess', src, true)
end)  --[[  
██╗░░░██╗██████╗░██╗░░░░░███████╗░█████╗░██╗░░██╗░██████╗
██║░░░██║██╔══██╗██║░░░░░██╔════╝██╔══██╗██║░██╔╝██╔════╝
██║░░░██║██████╔╝██║░░░░░█████╗░░███████║█████═╝░╚█████╗░
██║░░░██║██╔═══╝░██║░░░░░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
╚██████╔╝██║░░░░░███████╗███████╗██║░░██║██║░╚██╗██████╔╝
░╚═════╝░╚═╝░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
█████████████████████████████████████████████████████████
discord.gg/6CRxjqZJFB ]]--