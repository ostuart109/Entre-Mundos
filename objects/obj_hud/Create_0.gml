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



#endregion