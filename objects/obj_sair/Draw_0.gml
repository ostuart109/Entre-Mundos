draw_self() ;

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