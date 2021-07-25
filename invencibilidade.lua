-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMANDO DE INVENCIBILIDADE ]---------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('invii',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
   	if vRP.hasPermission(user_id,"dono.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then
		SetPlayerInvincible(source, true)
		TriggerClientEvent("Notify", source, "sucesso", "Você ficou imortal!")
	end
--Criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM
end)

--Obs: COMANDO ADICIONADO NO LADO SERVIDOR (SERVER.LUA)
--Para usar basta digitar: /invii
