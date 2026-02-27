
desenha_creditos = function()
{
	draw_set_font(fnt_creditos) ;

	var _width	= camera_get_view_width(view_camera[1])/50 ;
	
	draw_text(_width, 300, "Desenvolvido por:" ) ;

	draw_text(_width, 320, "oStuart - Programação" ) ;
	
	draw_text(_width, 340, "Will Holmes - Artes e Programação" ) ;
	
	draw_set_font(-1) ;		
}