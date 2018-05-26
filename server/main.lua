-----------------------------------------
-- Criado por iKaoticx
-- Para o Infinty Roleplay
-----------------------------------------
ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local vinho = 1
local suco = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'refinaria', Config.MaxInService)
end

--TriggerEvent('esx_phone:registerNumber', 'refinaria', _U('refinador_client'), true, true)
--TriggerEvent('esx_society:registerSociety', 'refinaria', 'Refinador', 'society_refinaria', 'society_refinaria', 'society_refinaria', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "Mina" then
			local itemQuantity = xPlayer.getInventoryItem('petroleo').count
			if itemQuantity >= 50 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(5000, function()
					xPlayer.addInventoryItem('petroleo', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_refinadorjob:startHarvest')
AddEventHandler('esx_refinadorjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('uva_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_refinadorjob:stopHarvest')
AddEventHandler('esx_refinadorjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TratamentoEtanol" then
			local itemQuantity = xPlayer.getInventoryItem('petroleo').count			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_petroleo'))
				return
			else
				SetTimeout(10000, function()
						xPlayer.removeInventoryItem('petroleo', 1)
						xPlayer.addInventoryItem('etanol', 1)
				
						Transform(source, zone)
						end)
					end
			
		elseif zone == "TratamentoDiesel" then
			local itemQuantity = xPlayer.getInventoryItem('petroleo').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_petroleo'))
				return
			else
				SetTimeout(18000, function()
					xPlayer.removeInventoryItem('petroleo', 2)
					xPlayer.addInventoryItem('diesel', 1)
		  
					Transform(source, zone)	  
					end)
				end
				
		elseif zone == "TratamentoGasolina" then
			local itemQuantity = xPlayer.getInventoryItem('petroleo').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_petroleo'))
				return
			else
				SetTimeout(25000, function()
					xPlayer.removeInventoryItem('petroleo', 3)
					xPlayer.addInventoryItem('gasolina', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_refinadorjob:startTransform')
AddEventHandler('esx_refinadorjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_refinadorjob:stopTransform')
AddEventHandler('esx_refinadorjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre petroleo')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'Venda' then
			if xPlayer.getInventoryItem('etanol').count <= 0 then
				etanol = 0
			else
				etanol = 1
			end			
			if xPlayer.getInventoryItem('diesel').count <= 0 then
				diesel = 0
			else
				diesel = 1
			end			
			if xPlayer.getInventoryItem('gasolina').count <= 0 then
				gasolina = 0
			else
				gasolina = 1
			end			
								
			if etanol == 0 and diesel == 0 and gasolina == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('etanol').count <= 0 and diesel == 0 and gasolina == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_etanol_sale'))
				etanol = 0
				return
			elseif xPlayer.getInventoryItem('diesel').count <= 0 and etanol == 0 and gasolina == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_diesel_sale'))
				diesel = 0
				return
			elseif xPlayer.getInventoryItem('gasolina').count <= 0 and diesel == 0 and etanol == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_gasolina_sale'))
				gasolina = 0
				return
			else
				if (etanol == 1) then
					SetTimeout(2500, function()
						local money = math.random(48,96)
						xPlayer.removeInventoryItem('etanol', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_refinaria', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (diesel == 1) then
					SetTimeout(2500, function()
						local money = math.random(96,192)
						xPlayer.removeInventoryItem('diesel', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_refinaria', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (gasolina == 1) then
					SetTimeout(3000, function()
						local money = math.random(176,315)
						xPlayer.removeInventoryItem('gasolina', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_refinaria', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				end
			end
		end
	end
end

RegisterServerEvent('esx_refinadorjob:startSell')
AddEventHandler('esx_refinadorjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_refinadorjob:stopSell')
AddEventHandler('esx_refinadorjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_refinadorjob:getStockItem')
AddEventHandler('esx_refinadorjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_refinaria', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_refinadorjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_refinaria', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_refinadorjob:putStockItems')
AddEventHandler('esx_refinadorjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_refinaria', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_refinadorjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)