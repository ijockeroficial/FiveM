-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMANDO DE PEGAR ARMAS CLIENT ]------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:addarmas")
AddEventHandler("admin:addarmas",function(arma, municao)
	local ped = GetPlayerPed(-1)
	GiveWeaponToPed(ped, arma, municao, false, true)
--Criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMANDO DE PEGAR ARMAS  ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tparmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
   	if vRP.hasPermission(user_id,"dono.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
		local nomeArma = vRP.prompt(source, "Qual nome da arma?", "")
		local armas = {
			minigun = 'weapon_minigun', 
			minigun2 = 'weapon_rayminigun',
			micro = 'weapon_microsmg',
			smg = 'weapon_smg', 
			smg2 = 'weapon_smg_mk2', 
			smg3 = 'weapon_assaultsmg', 
			smg4 = 'weapon_combatpdw', 
			smg5 = 'weapon_machinepistol', 
			smg6 = 'weapon_minismg', 
			smg7 = 'weapon_raycarbine', 
			fuzi = 'weapon_assaultrifle_mk2', 
			fuzi2 = 'weapon_carbinerifle', 
			fuzi3 = 'weapon_carbinerifle_mk2', 
			fuzi4 = 'weapon_advancedrifle', 
			fuzi5 = 'weapon_specialcarbine', 
			fuzi6 = 'weapon_specialcarbine_mk2', 
			fuzi7 = 'weapon_bullpuprifle', 
			fuzi8 = 'weapon_bullpuprifle_mk2', 
			fuzi9 = 'weapon_militaryrifle', 
			fuzi10 = 'weapon_mg', 
			fuzi11 = 'weapon_combatmg', 
			fuzi12 = 'weapon_combatmg_mk2', 
			fuzi13 = 'weapon_gusenberg',
			bomba = 'weapon_stickybomb',
			extintor = 'weapon_fireextinguisher',
			lancador = 'weapon_grenadelauncher',
			machado = 'weapon_hatchet',
			pistola = 'weapon_pistol',
			pistola2 = 'weapon_pistol_mk2',
			pistola3 = 'weapon_combatpistol',
			pistola4 = 'weapon_stungun',
			pistola5 = 'weapon_pistol50',
			pistola6 = 'weapon_snspistol_mk2',
			colt = 'weapon_doubleaction',
			revolver = 'weapon_revolver',
			revolver2 = 'weapon_revolver_mk2',
			canivete = 'weapon_switchblade',
			alien = 'weapon_raypistol',
			ak47 = 'weapon_assaultrifle',
			akmini = 'weapon_compactrifle',
			sniper1 = 'weapon_sniperrifle',
			sniper2 = 'weapon_heavysniper',
			sniper3 = 'weapon_heavysniper_mk2',
			sniper4 = 'weapon_marksmanrifle',
			sniper5 = 'weapon_marksmanrifle_mk2',
			machado = 'weapon_hatchet',
			facao = 'weapon_machete',
			machado2 = 'weapon_battleaxe',
			faca = 'weapon_knife',
			lanterna = 'weapon_flashlight',
			colt = 'weapon_doubleaction',
			alien2 = 'weapon_raycarbine',
			doze = 'weapon_pumpshotgun',
			doze2 = 'weapon_pumpshotgun_mk2',
			doze3 = 'weapon_sawnoffshotgun',
			doze4 = 'weapon_assaultshotgun',
			doze5 = 'weapon_bullpupshotgun',
			doze6 = 'weapon_musket',
			doze7 = 'weapon_heavyshotgun',
			doze8 = 'weapon_dbshotgun',
			doze9 = 'weapon_autoshotgun',
			doze10 = 'weapon_combatshotgun',
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
		}
--Criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM
		if armas[nomeArma] then
			local weaponHash = GetHashKey(armas[nomeArma])
			local ammoCount = 250
			TriggerClientEvent('admin:addarmas', source, weaponHash, ammoCount)
			TriggerClientEvent("Notify", source, "sucesso", "Você pegou: "..nomeArma)
		else 
			TriggerClientEvent("Notify", source, "negado", "Essa arma não existe!")
		end
	end
end)

--Para usar basta digitar: /tparmas
