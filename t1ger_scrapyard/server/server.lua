-------------------------------------
------- Created by T1GER#9080 -------
-------------------------------------

ESX 					= nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

num 			= 0
NPC_created 	= false
cooldownTimer 	= {}
carList 		= {}

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while not NPC_created do
		local gotData = false
		num = math.random(1,#Config.Scrapyard)
		local scrapList, gotData = ScrambleCarList()
		while not gotData do Wait(5) end
		if gotData then 
			TriggerClientEvent('t1ger_scrapyard:createScrapyard', -1, Config.Scrapyard[num], scrapList)
		end
		NPC_created = true
		Citizen.Wait(60000 * Config.NPC_SwitchMinutes)
		NPC_created = false
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId)
	TriggerClientEvent('t1ger_scrapyard:createScrapyard', playerId, Config.Scrapyard[num], carList)
end)

-- Event for scrap vehicle payment:
RegisterServerEvent('t1ger_scrapyard:getPayment')
AddEventHandler('t1ger_scrapyard:getPayment',function(scrapCar, percent)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.EnableCooldown then
		TriggerEvent('t1ger_scrapyard:startCarListTimer', source)
	end

	-- Money Reward:
	if Config.EnableCashRewards then
		local money = math.floor(scrapCar.price * (percent/100))
		if Config.ReceiveDirtyCash then xPlayer.addAccountMoney('black_money', money) else xPlayer.addMoney(money) end
		TriggerClientEvent('t1ger_scrapyard:ShowNotifyESX',source, Lang['cash_reward']:format(money))
	end

	-- Item Reward:
	if Config.EnableItemRewards then 
		local i = 0
		local maxItems = Config.MaxItemsInReward	
		for k,v in pairs(Config.Materials) do
			if i < maxItems then 
				math.randomseed(GetGameTimer())
				if math.random(0,100) <= v.chance then
					math.randomseed(GetGameTimer())
					local itemAmount = math.random(v.amount.min,v.amount.max)
					local itemName = ''
					if Config.HasItemLabel then itemName = ESX.GetItemLabel(v.item) else itemName = tostring(v.item) end
					xPlayer.addInventoryItem(v.item, itemAmount)
					i = i + 1
				end
				Citizen.Wait(100)
			else
				break
			end
		end
	end
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(cooldownTimer) do
			if v.time <= 0 then
				ResetCooldownTimer(v.identifier)
			else
				v.time = v.time - 1000
			end
		end
	end
end)

-- Callback to get cops count:
ESX.RegisterServerCallback('t1ger_scrapyard:getCopsCount',function(source, cb)
	local xxPlayer = ESX.GetPlayerFromId(source)
	local Players = ESX.GetPlayers()
	local cops = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		for k,v in pairs(Config.PoliceJobs) do
			if xPlayer["job"]["name"] == v then cops = cops + 1 end
		end
	end
	if cops >= Config.MinimumCops then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('t1ger_scrapyard:ShowNotifyESX', xxPlayer.source, Lang['not_enough_police'])
	end
end)

-- Callback to get cooldown timer:
ESX.RegisterServerCallback('t1ger_scrapyard:getCarListTimer',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not CheckCooldownTimer(GetPlayerIdentifier(source)) then
		cb(false)
	else
		TriggerClientEvent('t1ger_scrapyard:ShowNotifyESX', xPlayer.source, Lang['cooldown_msg']:format(GetCooldownTimer(GetPlayerIdentifier(source))))
		cb(true)
	end
end)

-- Callback to check if vehicle is owned:
ESX.RegisterServerCallback('t1ger_scrapyard:isVehicleOwned',function(source, cb, plate)
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate",{['@plate'] = plate}, function(data) 
		if #data > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end)

-- Server Event to add player cooldown:
RegisterServerEvent('t1ger_scrapyard:deleteOwnedVehicle')
AddEventHandler('t1ger_scrapyard:deleteOwnedVehicle',function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate",{['@plate'] = plate}, function(data) 
		if #data > 0 then
			if Config.T1GER_Insurance then 
				if data[1].insurance > 0 then
					MySQL.Sync.execute("UPDATE owned_vehicles SET garage = @garage WHERE plate = @plate", {['@garage'] = "impound", ['@plate'] = id})
				else
					MySQL.Async.execute("DELETE FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
				end
			else
				MySQL.Async.execute("DELETE FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
			end
		end
	end)
end)

-- Usable item to lockpick:
Citizen.CreateThread(function()
	if not Config.T1GER_Keys then 
		for k,v in pairs(Config.UsableLockpick) do 
			ESX.RegisterUsableItem(v.item, function(source)
				local xPlayer = ESX.GetPlayerFromId(source)
				TriggerClientEvent('t1ger_scrapyard:lockpickCL',source,k,v)
				ESX.RegisterServerCallback('t1ger_scrapyard:removeLockpick',function(source,cb)
					local xPlayer = ESX.GetPlayerFromId(source)
					xPlayer.removeInventoryItem(v.item, 1)
					cb(true)
				end)	
			end)
		end
	end
end)

-- Server event to alert police:
RegisterServerEvent('t1ger_scrapyard:PoliceNotifySV')
AddEventHandler('t1ger_scrapyard:PoliceNotifySV', function(targetCoords, streetName)
	local Players = ESX.GetPlayers()
	local cops = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		for k,v in pairs(Config.PoliceJobs) do
			if xPlayer["job"]["name"] == v then
				TriggerClientEvent('t1ger_scrapyard:PoliceNotifyCL', xPlayer.source, Lang['police_notify']:format(streetName))
				TriggerClientEvent('t1ger_scrapyard:PoliceNotifyBlip', xPlayer.source, targetCoords)
			end
		end
	end
end)
  --[[  
██╗░░░██╗██████╗░██╗░░░░░███████╗░█████╗░██╗░░██╗░██████╗
██║░░░██║██╔══██╗██║░░░░░██╔════╝██╔══██╗██║░██╔╝██╔════╝
██║░░░██║██████╔╝██║░░░░░█████╗░░███████║█████═╝░╚█████╗░
██║░░░██║██╔═══╝░██║░░░░░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
╚██████╔╝██║░░░░░███████╗███████╗██║░░██║██║░╚██╗██████╔╝
░╚═════╝░╚═╝░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
█████████████████████████████████████████████████████████
discord.gg/6CRxjqZJFB ]]--