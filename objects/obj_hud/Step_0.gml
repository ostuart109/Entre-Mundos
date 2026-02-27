#region Usando Métodos

//Iniciando os dados do jogo
inicia_jogo(dados) ;

//Musica das room dos puzzles
musica_puzzles() ;

//Musica para Menu
musica_menu() ;

#endregion

if (keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen());
}
