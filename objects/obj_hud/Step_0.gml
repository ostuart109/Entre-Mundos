#region Usando Métodos

//Musica das room dos puzzles
musica_puzzles() ;

//Iniciando os dados do jogo
inicia_jogo(dados) ;

#endregion

if (keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen());
}
