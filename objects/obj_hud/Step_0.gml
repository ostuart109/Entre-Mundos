#region Usando Métodos

musica_puzzles() ;

//Testando o meu Save
if (keyboard_check_released(ord("K")))
{
	salva_jogo() ;
}

if (keyboard_check_released(ord("L")))
{
	carrega_jogo() ;
}

if (global.player_morreu == true)
{
	game_restart() ;
}

//Se o jogo iniciou
//global.player_morreu é false
event_perform(ev_game_start, global.player_morreu = false)


#endregion
