
desenha_titulo = function()
{
	draw_set_font(fnt_titulo) ;
	
	draw_set_halign(fa_center) ;
	
	draw_set_valign(fa_center) ;
	
	var _width		= camera_get_view_width(view_camera[1])/4 ;
	
	var _height		= camera_get_view_height(view_camera[1])/2 - 20 ;
	
	var _height2		= camera_get_view_height(view_camera[1])/2 + 20 ;
	
	draw_text(_width, _height, "DE VOLTA" ) ;
		
	draw_text(_width, _height2, "PARA O PASSADO" ) ;
	
	//resetando
	draw_set_font(-1) ;	
	
	draw_set_halign(-1) ;
	
	draw_set_valign(-1) ;
}

desenha_creditos = function()
{
	draw_set_font(fnt_creditos) ;

	var _width	= camera_get_view_width(view_camera[1])/50 ;
	
	draw_text(_width, 300, "Desenvolvido por:" ) ;

	draw_text(_width, 320, "oStuart - Programação" ) ;
	
	draw_text(_width, 340, "Will Holmes - Artes e Programação" ) ;
	
	draw_set_font(-1) ;		
}