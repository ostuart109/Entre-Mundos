function termina_jogo()
{

	var _arquivo = "Meu Save" + string(global.save + 1) + ".json";
    
	if (file_exists(_arquivo))
	{
	    file_delete(_arquivo);
	}
    
	game_end();

}