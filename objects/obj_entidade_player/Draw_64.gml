
//Desenhando a transição
if trans_alpha > 0
{
    draw_set_alpha(trans_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

//desenha Tempo
desenha_tempo() ;