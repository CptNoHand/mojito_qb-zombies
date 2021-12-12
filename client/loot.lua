objects = {}

if Config.ObjectDropLoot then
	Citizen.CreateThread(function()
	    while true do
	        Wait(0)
	        for k,v in pairs(Config.ObjectsLoot) do
		        	local player = GetPlayerPed(-1)
		        	local distanceobject = 2.0
		            local obj = GetClosestObjectOfType(GetEntityCoords(player).x, GetEntityCoords(player).y, GetEntityCoords(player).z, distanceobject, v, false, true ,true)
		            local distance = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(obj), true)
		    


			    if distance <= distanceobject then

		            local ObjectCoords = GetEntityCoords(obj)

		            if not objects[obj] then
		            QBCore.Functions.DrawText3D(ObjectCoords + vector3(0.0, 0.0, 0.5), '~b~[E]~c~ TO SEARCH')
		        	end

		            if IsControlJustReleased(0, 38) then
						if not objects[obj] then
							
		                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true)
		                    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
								Citizen.Wait(0)
							end
							TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, 4000, 30, 0, 0, 0, 0)
							Citizen.Wait(0)
							randomChance = math.random(1, 100)
							randomWeapon = Config.WeaponLootObject[math.random(1, #Config.WeaponLootObject)]
							randomItem = Config.ItemLootObject[math.random(1, #Config.ItemLootObject)]

							if randomChance > 0 and randomChance < Config.ProbabilityWeaponLootObject then
								TriggerServerEvent('qb-zombies:itemloot', randomWeapon)
								QBCore.Functions.Notify('You found a ' .. randomWeapon,'success')
							elseif randomChance >= Config.ProbabilityWeaponLootObject and randomChance < Config.ProbabilityMoneyLootObject then
								TriggerServerEvent('qb-zombies:moneyloot')
							elseif randomChance >= Config.ProbabilityMoneyLootObject and randomChance < Config.ProbabilityItemLootObject then
								TriggerServerEvent('qb-zombies:itemloot', randomItem)
							elseif randomChance >= Config.ProbabilityItemLootObject and randomChance < 100 then
								QBCore.Functions.Notify('You found nothing','error')
							end
							objects[obj] = true
		               	end
		            end
		        end
		    end
		end
	end)
end
