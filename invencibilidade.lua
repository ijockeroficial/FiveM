--COMANDO ADICIONADO NO LADO SERVIDOR (SERVER.LUA)
--COMANDO DE INVENSIBILIDADE
RegisterCommand('invii',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
   	if vRP.hasPermission(user_id,"invencibilidade.permissao") then
		SetPlayerInvincible(source, true)
	end
end)
