local atmIsShowed = false

-- Trigger event
RegisterNetEvent('lcdv_atm:openATM')
AddEventHandler('lcdv_atm:openATM', function()
  
  -- Get player data & show the UI
  ESX.TriggerServerCallback('esx:getPlayerData',  function(data)
    SendNUIMessage({
      type = "ui",
      player = data,
      display = true,
    })
  end)

  SetNuiFocus(true, true)
end)

RegisterNetEvent('lcdv_atm:closeATM')
AddEventHandler('lcdv_atm:closeATM', function()
  SendNUIMessage({
    type = "ui",
    display = false
  })
  SetNuiFocus(false)
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('lcdv_atm:closeATM')
	cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  TriggerServerEvent('lcdv_atm:withdraw', data.amount)
  TriggerEvent('lcdv_atm:closeATM')
	cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  TriggerServerEvent('lcdv_atm:deposit', data.amount)
  TriggerEvent('lcdv_atm:closeATM')
	cb('ok')
end)

-- Generate ATM location 
CreateThread(function() 
  while true do
    
    local sleep = 1500
    local pedCoords = GetEntityCoords(PlayerPedId())

    for index, location in pairs(Config.ATMLocations) do
      
      local distance = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, location.x, location.y, location.z)
      
      if(distance < 3 and not atmIsShowed) then
        sleep = 0
        ESX.ShowHelpNotification(Message.Action)
        if(IsControlJustReleased(0, 38)) then
          TriggerEvent('lcdv_atm:openATM')
        end
      end

    end

    Citizen.Wait(sleep)
  end 
end)

-- close the menu when script is stopping to avoid being stuck in NUI focus
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if atmIsShowed then
			TriggerEvent('lcdv_atm:closeATM')
		end
	end
end)