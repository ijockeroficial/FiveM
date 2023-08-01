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
