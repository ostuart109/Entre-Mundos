#region Usando Métodos

if (mostrar_salvando)
{
	if (texto_alpha > 0)
	{
		draw_set_alpha(texto_alpha);
		draw_set_font(fnt_aviso) ;
	    draw_set_color(c_white);
	    draw_set_halign(fa_right);
	    draw_set_valign(fa_bottom);
	    draw_text(display_get_gui_width() - 16, display_get_gui_height() - 16, salva_texto);
	    // Resetando
	    draw_set_halign(fa_left);
	    draw_set_valign(fa_top);
		draw_set_font(-1) ;
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
}

#endregion