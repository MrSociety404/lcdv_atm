RegisterServerEvent('lcdv_atm:deposit')
AddEventHandler('lcdv_atm:deposit', function(amount)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = tonumber(amount)

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		xPlayer.showNotification(Message.InvalidAmount)
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', amount)
		xPlayer.showNotification(Message.DepositMoney)
	end
end)

RegisterServerEvent('lcdv_atm:withdraw')
AddEventHandler('lcdv_atm:withdraw', function(amount)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = tonumber(amount)
	local accountMoney = xPlayer.getAccount('bank').money

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > accountMoney then
		xPlayer.showNotification(Message.InvalidAmount)
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		xPlayer.showNotification(Message.WithdrawMoney)
	end
end)