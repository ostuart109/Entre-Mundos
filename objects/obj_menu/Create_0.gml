titulo_timer	= 0 ;

creditos_timer	= 0 ;

desenha_titulo = function()
{
    draw_set_font(fnt_titulo_game) ;
    draw_set_halign(fa_center) ;
    draw_set_valign(fa_center) ;
	
    var _width   = camera_get_view_width(view_camera[1])/4 ;
    var _float   = sin(titulo_timer) * 5 ; // oscila 6 pixels pra cima e pra baixo

    var _height  = camera_get_view_height(view_camera[1])/2 - 20 + _float ;
    var _height2 = camera_get_view_height(view_camera[1])/2 + 20 + _float ;
	
	draw_set_colour(c_white) ;
	
    draw_text(_width, _height,  "DE VOLTA" ) ;
    draw_text(_width, _height2, "PARA O PASSADO" ) ;

    // resetando
    draw_set_font(-1) ;
    draw_set_halign(-1) ;
    draw_set_valign(-1) ;
    draw_set_colour(c_white) ;
}

desenha_creditos = function()
{
	//Fonte
	draw_set_font(fnt_creditos) ;
	
	//var _float   = sin(creditos_timer) * 3 ; // oscila 6 pixels pra cima e pra baixo
	
	//Escala da Sprite
	var _escala_sprite	= 1.3 ;
	
	//Largura da camera pra posicionar as informações do save
	var _width			= camera_get_view_width(view_camera[1])/50 ;

	draw_sprite_ext(spr_credits, image_index, _width - 10, 295, image_xscale * _escala_sprite, image_yscale * _escala_sprite, image_angle, c_white, 0.7) ;

	//Cor
	draw_set_colour(c_white) ;
	
	draw_text(_width, 300, "Desenvolvido por:") ;

	draw_text(_width, 320, "oStuart - Programação") ;
	
	draw_text(_width, 340, "Will Holmes - Artes e Programação") ;
	
	//Resetando
	draw_set_font(-1) ;		
	draw_set_colour(c_white) ;
}