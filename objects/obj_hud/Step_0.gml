#region Usando Métodos

//Iniciando os dados do jogo
inicia_jogo(dados) ;

//Gerenciador de Músicas (Puzzles e Menus)
controla_musica() ;


#endregion

if (keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen());
}
