-------------------------------------
------- Created by Chief -------
------------------------------------- 

Config 						= {}

-- General Settings:
Config.ESXSHAREDOBJECT 	= "esx:getSharedObject"	-- Change your getshared object event here, in case you are using anti-cheat.
Config.HasItemLabel		= true					-- set to false if your ESX doesn't support item labels.
Config.T1GER_Insurance	= true					-- set to false if you don't own t1ger-insurance script.
Config.T1GER_Keys		= false					-- set to false if you don't own t1ger-keys script.

-- Police Settings:
Config.PoliceJobs 	= {"police", "lspd"}		-- Jobs that can't do bankrobberies etc, but can secure the banks.
Config.AllowPolice	= true						-- Set to false to disallow police doing scrapyard jobs.
Config.MinimumCops	= 0 						-- Set minimum required cops online to do jobs for scrapyard
-- Alert Blip
Config.AlertBlipShow = true			-- enable or disable blip on map on police notify
Config.AlertBlipTime = 20			-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.AlertBlipRadius = 50.0		-- set radius of the police notify blip
Config.AlertBlipAlpha = 250			-- set alpha of the blip
Config.AlertBlipColor = 3			-- set blip color

-- Scrapyard Settings:
Config.NPC_SwitchMinutes 	= 48				-- set timer in minutes for when NPC switches location. (48 minutes is 24 hours in game time)
Config.CarListAmount		= 3					-- Adjust amount of cars on the list. 3 cars are default.
Config.UsePhoneMSG 			= true 			-- Enable to receive job msg through phone, disable to use ESX.ShowNotification or anything else you'd like.
Config.ScrapYardNPC 		= "Chief"		
Config.EnableCooldown		= true				-- Enable / disable cooldown feature
Config.CooldownTime 		= 1					-- Set cooldown time to wait before each scrapyard job
Config.AllowScrapOwnedVeh	= true				-- Enable / disable scrapping owned vehicles
Config.DeleteOwnedVehicles	= true				-- Enable/disable deleting owned vehicles (if t1ger-insurance = true and veh got insurance, then veh will be sent to impound)

-- Scrapyards:
Config.Scrapyard = {
	[1] = {
		NPC1 = { ped = 's_m_y_xmech_02_mp', name = "Chief", pos = {-469.42,-1718.28,18.69,281.9}, scenario = "WORLD_HUMAN_AA_SMOKE" },
		NPC2 = {
			ped = 's_m_y_xmech_02_mp', name = "Chief",
			startPos = {-465.77,-1707.58,18.8,252.19},
			endPos = {-459.98,-1712.81,18.67,240.04},
			idleScenario = "WORLD_HUMAN_AA_SMOKE",
			workScenario = "WORLD_HUMAN_CLIPBOARD",
			timer = {walkToCar = 6, decidePrice = 4, walkBack = 5}
		},
		vehPos = {-457.29,-1713.84,18.64},
		marker = {drawDist = 35.0, type = 27, scale = {x = 5.0, y = 5.0, z = 1.0}, color = {r = 240, g = 52, b = 52, a = 100}},
		blip = {enable = true, sprite = 280, color = 5, label = "Scrapyard", scale = 0.8},
	},
	[2] = {
		NPC1 = { ped = 's_m_y_xmech_02_mp', name = "Chief", pos = {483.88,-1311.32,29.22,274.01}, scenario = "WORLD_HUMAN_AA_SMOKE" },
		NPC2 = {
			ped = 's_m_y_xmech_02_mp', name = "Chief",
			startPos = {475.19,-1313.36,29.21,231.3},
			endPos = {478.35,-1316.21,29.2,238.97},
			idleScenario = "WORLD_HUMAN_AA_SMOKE",
			workScenario = "WORLD_HUMAN_CLIPBOARD",
			timer = {walkToCar = 4.5, decidePrice = 4, walkBack = 4.5}
		},
		vehPos = {481.05,-1317.67,29.2},
		marker = {drawDist = 35.0, type = 27, scale = {x = 5.0, y = 5.0, z = 1.0}, color = {r = 240, g = 52, b = 52, a = 100}},
		blip = {enable = true, sprite = 280, color = 5, label = "Scrapyard", scale = 0.8},
	}
}

-- Car List:
Config.CarListCars = {
	[1] = {label = "Prairie", hash = -1450650718, price = 850},
	[2] = {label = "Ingot", hash = -1289722222, price = 650},
	[3] = {label = "Tailgater", hash = -1008861746, price = 950},
	[4] = {label = "F620", hash = -591610296, price = 1250},
	[5] = {label = "Jester", hash = -1297672541, price = 1650},
	[6] = {label = "Massacro", hash = -142942670, price = 1950},
	[7] = {label = "Sultan", hash = 970598228, price = 1000},
	[8] = {label = "Turismo R", hash = 408192225, price = 2200},
	[9] = {label = "Emperor", hash = -685276541, price = 450},
	[10] = {label = "Blista", hash = -344943009, price = 750},
	[11] = {label = "Exemplar", hash = -5153954, price = 1150}
}

-- Materials:
Config.Materials = {
	[1] = {label = "Rubber", item = "rubber", chance = 40, amount = {min = 1, max = 3}},
	[2] = {label = "Scrap Metal", item = "scrap_metal", chance = 70, amount = {min = 5, max = 9}},
	[3] = {label = "Electric Scrap", item = "electric_scrap", chance = 50, amount = {min = 2, max = 7}},
	[4] = {label = "Plastic", item = "plastic", chance = 89, amount = {min = 4, max = 9}},
	[5] = {label = "Glass", item = "glass", chance = 35, amount = {min = 2, max = 3}},
	[6] = {label = "Aluminium", item = "aluminium", chance = 62, amount = {min = 1, max = 6}},
	[7] = {label = "Copper", item = "copper", chance = 45, amount = {min = 2, max = 4}},
	[8] = {label = "Steel", item = "steel", chance = 30, amount = {min = 1, max = 3}}
}

-- Reward Settings:
Config.EnableCashRewards 	= true		-- Enable/disable cash rewards.
Config.ReceiveDirtyCash 	= true		-- Set t ofalse to receive normal cash.
Config.EnableItemRewards 	= true		-- Enable receiving item rewards upon scrapping.
Config.MaxItemsInReward		= 3			-- Maximum amount of items to receive, e.g. 3 means, rubber, glass, plastic. Setting to 5 means two more items.

-- Lockpick:
Config.UsableLockpick = {{
	item			= "lockpick",			-- Item name in database for usable item
	label			= "Lockpick",			-- Item name that is displayed in notifications etc
	timer 			= 10,					-- Lockpicking time in seconds
	alarm = {enable = true, time = 25}, 	-- Enable/Disable car clarm upon lockpicking & set alarm duration in seconds
	policeAlert		= true,					-- Enable/Disable police alert upon lockpicking
	anim_dict		= "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
	anim_name		= "machinic_loop_mechandplayer",
}}  --[[  
██╗░░░██╗██████╗░██╗░░░░░███████╗░█████╗░██╗░░██╗░██████╗
██║░░░██║██╔══██╗██║░░░░░██╔════╝██╔══██╗██║░██╔╝██╔════╝
██║░░░██║██████╔╝██║░░░░░█████╗░░███████║█████═╝░╚█████╗░
██║░░░██║██╔═══╝░██║░░░░░██╔══╝░░██╔══██║██╔═██╗░░╚═══██╗
╚██████╔╝██║░░░░░███████╗███████╗██║░░██║██║░╚██╗██████╔╝
░╚═════╝░╚═╝░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░
█████████████████████████████████████████████████████████
discord.gg/6CRxjqZJFB ]]--