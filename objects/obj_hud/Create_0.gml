#region Cria Métodos

//FPS
desenha_fps = function()
{
	//Definindo a cor
	draw_set_colour(c_aqua) ;

	//60 FPS
	draw_text(20, 20, fps) ;
	
	//Real FPS
	draw_text(20, 40, fps_real) ;

	//barrinha Debug
	show_debug_overlay(true) ;

	//Resetando
	draw_set_colour(-1) ;
}

//Desesnha o Tempo
desenha_tempo = function()
{
	if (room == Rm_1)
	{
		draw_text(550, 20, "Presente")
	}

	if (room == Rm_2)
	{
		draw_text(550, 20, "Passado")
	}	
}

#endregion