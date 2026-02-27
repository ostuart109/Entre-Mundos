
//Desenhando a transição
if trans_alpha > 0
{
    draw_set_alpha(trans_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}


//Desenhando o nome da room
if room_name_alpha > 0
{
    draw_set_alpha(room_name_alpha);
    draw_set_color(c_white);
    draw_set_font(fnt_text_box); // ou -1 pra fonte padrão
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(16, 16, room_name_text);
    draw_set_alpha(1);
	draw_set_font(-1); // ou -1 pra fonte padrão
}

//desenha Tempo
desenha_tempo() ;