--[[
	KrizFrost Illegal Chop Shop
	Free Release on FiveM Forums [DO NOT SELL NOR RE-RELEASE WITHOUT MY PERMISSION]
	[Aug 29, 2019]
]]

ESX = nil
TriggerEvent('esx:GetObject', function(obj) ESX = obj end)


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- discord webhook --

function dclog(xPlayer, text)
	local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = GetConvar('discord_webhook', Config.DiscordWebhook)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = Config.WebhookName,
	  ["avatar_url"] = Config.WebhookAvatarUrl,
	  ["embeds"] = {{
		["author"] = {
		  ["name"] = playerName .. ' - ' .. xPlayer.identifier
		},
		["color"] = 1942002,
		["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
	  }}
	}
	data['embeds'][1]['description'] = text
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end
---------------------

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_civlife_illegalchop:success')
AddEventHandler('esx_civlife_illegalchop:success', function(pay)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addMoney(pay)
dclog(xPlayer, 'Bir Araç Parçası Parçaladı ve **'..pay..'$** Kazandı.')
dclog(xPlayer, 'Bir Araç Parçası Parçaladı ve **'..pay..'$** Kazandı.')
end)

RegisterServerEvent('z12:reward:kapi')
AddEventHandler('z12:reward:kapi', function()
local src = source 
local xPlayer = ESX.GetPlayerFromId(src)
xPlayer.addInventoryItem('cardoor', 1)
dclog(xPlayer, 'Bir Kapı Parçaladı.')
end)

RegisterServerEvent('z12:reward:jant')
AddEventHandler('z12:reward:jant', function()
local src = source 
local xPlayer = ESX.GetPlayerFromId(src)
xPlayer.addInventoryItem('jant', 1)
dclog(xPlayer, 'Bir Jant Parçaladı.')
end)

RegisterServerEvent('z12:reward:radyo')
AddEventHandler('z12:reward:radyo', function(pay)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addInventoryItem('radyo', 1)
dclog(xPlayer, 'Bir Radyo Parçaladı.')
end)

RegisterServerEvent('z12:reward:kaput')
AddEventHandler('z12:reward:kaput', function(pay)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addInventoryItem('kaput', 1)
dclog(xPlayer, 'Bir Kaput Parçaladı.')
end)

RegisterServerEvent('z12:reward:bagaj')
AddEventHandler('z12:reward:bagaj', function(pay)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addInventoryItem('bagaj', 1)
dclog(xPlayer, 'Bir bagaj Parçaladı.')
end)


RegisterServerEvent('z12:server:reward')
AddEventHandler('z12:server:reward', function(listKey)
    local src = source 
	local xPlayer = ESX.GetPlayerFromId(src)
	local itemAmount1 = math.random(Config.ItemMinAmount1,Config.ItemMaxAmount1)
        for i = 1, math.random(1, 1), 1 do
            local item = Config.Items[math.random(1, #Config.Items)]
            xPlayer.addInventoryItem(item, itemAmount1)
            dclog(xPlayer, '**'..item..'** Eşyasından **'..itemAmount1..' adet ** Arabayı arayarak buldu!')
            Citizen.Wait(500)
        end
        local Luck = math.random(Config.ItemMinAmount1,Config.ItemMaxAmount1)
		local Odd = math.random(Config.ItemMinAmount1,Config.ItemMaxAmount1)
		local item2 = Config.RareItems[math.random(1, #Config.RareItems)]
        if Luck == Odd then
            local random = math.random(Config.LuckItemMinAmount1,Config.LuckItemMaxAmount1)
			xPlayer.addInventoryItem(item2, random)
			dclog(xPlayer, 'Şanslı Gününde! **'..item2..'** Eşyasından **'..random..' adet ** Arabayı arayarak buldu!')
        end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2z12:carchop^0] - Started!')
	end
end)