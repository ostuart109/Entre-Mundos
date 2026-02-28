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

if (mostrar_salvando)
{
    timer_salvando -= 1;

    // Fade out no último segundo (60 frames)
    if (timer_salvando < 60)
        texto_alpha = timer_salvando / 60;
    else
        texto_alpha = 1;

    if (timer_salvando <= 0)
    {
        mostrar_salvando = false;
        texto_alpha      = 1; // reseta pro próximo save
    }
}