#region Iniciando Variáveis

//Salvando a posição inicial do meu x
meu_x_inicial			= 350 ;

//Opacidade transparente
opacidade_transparente	= 0.5 ;

//Opacidade visivel
opacidade_visivel		= 1 ;

//Mudando o alpha deles
image_alpha		= opacidade_transparente ;

escala_x_imagem	= image_xscale ;

escala_y_imagem	= image_yscale ;

#endregion

#region Iniciando Métodos

//Checagem para fechar o game
fecha_jogo			= function()
{
	//Se o mouse está em cima do id do save
	var _mouse_sobre	= position_meeting(mouse_x, mouse_y, id) ;
	
	//Se o mouse clicar
	var _mouse_click	= mouse_check_button_released(mb_left) ;
	
	//Se o mouse está em cima
	if (_mouse_sobre)
	{
		var _scale			= 1.5 ;
		var _image_xscale	= escala_x_imagem * _scale ;
		var _image_yscale	= escala_y_imagem * _scale ;
		
		escala_x_imagem	= clamp(escala_x_imagem, _image_xscale , 0.1) ;
		escala_y_imagem	= clamp(escala_y_imagem, _image_yscale, 0.1) ;
		
		//Ficando visivel
		image_alpha		= lerp(image_alpha, opacidade_visivel, 0.1) ;
		
		if (_mouse_click)
		{
			termina_jogo() ;
		}
		
	}
	else
	{
		escala_x_imagem	= clamp(escala_x_imagem, escala_x_imagem , 0.1) ;
		escala_y_imagem	= clamp(escala_y_imagem, escala_y_imagem, 0.1) ;
		
		//Ficando transparente
		image_alpha		= lerp(image_alpha, opacidade_transparente, 0.1) ;
	}
}

//Desenhando o botão
desenha_fecha_jogo	= function()
{
	var _marg	= 10 ;
	var _x		= x + _marg ;
	var _y		= y + _marg ;

	//Fonte
	draw_set_font(fnt_saves) ;
	//Cor
	draw_set_colour(c_white) ;

	draw_set_halign(fa_center) ;
	draw_set_valign(fa_center) ;
	
	//Save
	draw_text(x + sprite_width/2,y + sprite_height/2, "FECHAR JOGO") ;

	//Resetando
	draw_set_font(-1) ;
	draw_set_colour(c_white) ;
	draw_set_halign(-1) ;
	draw_set_valign(-1) ;
}

#endregion