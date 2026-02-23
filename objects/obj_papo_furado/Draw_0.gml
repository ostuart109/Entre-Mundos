draw_self();

if texto_visivel {
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(x, y - sprite_height, texto);
	draw_circle(x, y, raio_deteccao, true);
    draw_set_halign(fa_left); // Reseta
}