draw_self() ;

//Fonte
draw_set_font(fnt_saves) ;

var _marg	= 10 ;
var _x		= x + _marg ;
var _y		= y + _marg ;

//Save
draw_text(_x, _y, "SAVE 0" + string(meu_save)) ;

//Próximo texto deve variar entre new game ou continue
var _texto2	= meus_dados != false ? "CONTINUE" : "NEW GAME" ; 

//Texto 2
draw_text(_x, _y + 20, _texto2) ;

//Resetando
draw_set_font(-1) ;
