--Comando de invencibilidade criado por iJocker YT https://youtube.com/ijockeroficiall
--Baixado em https://github.com/ijockeroficial/FiveM
RegisterCommand('invii',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
   	if vRP.hasPermission(user_id,"invencibilidade.permissao") then
		SetPlayerInvincible(source, true)
	end
end)
--FIM

--Obs: COMANDO ADICIONADO NO LADO SERVIDOR (SERVER.LUA)
