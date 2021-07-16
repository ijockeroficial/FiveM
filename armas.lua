--Criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM

--CÓDIGO PRA SER ADICIONADO NO LADO CLIENT (CLIENT.LUA)
--INICIO COMANDO PEGAR ARMAS CLIENT
RegisterNetEvent("admin:addarmas")
AddEventHandler("admin:addarmas",function(arma, municao)
	local ped = GetPlayerPed(-1)
	GiveWeaponToPed(ped, arma, municao, false, true)
end)
--FIM 

--------------------------------------------------------------
--CÓDIGO PRA SER ADICIONADO NO LADO DO SERVIDOR. (SERVER.LUA)
--LISTA DAS ARMAS
local armas = {
	minigun = 'weapon_minigun', 
	minigun2 = 'weapon_rayminigun',
	lancador = 'weapon_grenadelauncher',
	machado = 'weapon_hatchet',
	pistola = 'weapon_pistol_mk2',
	doze = 'weapon_pumpshotgun_mk2',
	alien = 'weapon_raypistol',
	ak47 = 'weapon_assaultrifle',
	akmini = 'weapon_compactrifle',
	rifle = 'weapon_advancedrifle',
	sniper1 = 'weapon_sniperrifle',
	sniper2 = 'weapon_heavysniper',
	sniper3 = 'weapon_heavysniper_mk2',
	sniper4 = 'weapon_marksmanrifle',
	sniper5 = 'weapon_marksmanrifle_mk2',
	machado = 'weapon_hatchet',
	facao = 'weapon_machete',
	machado2 = 'weapon_battleaxe',
	faca = 'weapon_switchblade',
	lanterna = 'weapon_flashlight',
	colt = 'weapon_doubleaction',
	alien2 = 'weapon_raycarbine',
	doze2 = 'weapon_bullpupshotgun',
	rifle2 = 'weapon_militaryrifle',
	rifle3 = 'weapon_combatmg_mk2',
	bazuca = 'weapon_firework',
	lancador2 = 'weapon_railgun',
	bazuca2 = 'weapon_rpg',
	bazuca3 = 'weapon_hominglauncher',
	granada = 'weapon_grenade',
	molotov = 'weapon_molotov',
	smoke = 'weapon_smokegrenade',
	snowball = 'weapon_snowball',
	gas = 'weapon_bzgas',
	paraquedas = 'gadget_parachute',
	rifle4 = 'weapon_specialcarbine_mk2',
}
--Criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM
--COMANDO DE PEGAR ARMAS
RegisterCommand('tparmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
   	if vRP.hasPermission(user_id,"armasproibidas.permissao") then
		local nomeArma = vRP.prompt(source, "Qual nome da arma?", "")
		
		if armas[nomeArma] then
			local weaponHash = GetHashKey(armas[nomeArma])
			local ammoCount = 1000
			TriggerClientEvent('admin:addarmas', source, weaponHash, ammoCount)
			TriggerClientEvent("Notify", source, "sucesso", "Você pegou: "..nomeArma)
		else 
			TriggerClientEvent("Notify", source, "negado", "Essa arma não existe!")
		end
	end
end)
