//=================== FINAL DO GAME ======================

function termina_jogo()
{
	//Limpando o save se zerou o jogo
	var _arquivo = "Meu Save" + string(global.save + 1) + ".json";
    
	if (file_exists(_arquivo))
	{
	    file_delete(_arquivo);
	}
    
	//Fechando o jogo
	game_end();
}

//========================================================