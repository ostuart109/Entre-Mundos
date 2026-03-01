#region Iniciando Váriaveis

texto_visivel = false;
raio_deteccao = 64;
texto = "Funcionou";

#endregion

#region Iniciando Métodos

papo_furado_step	= function()
{
	//Variável Player
	var _player = obj_player ;

	//Se o Player existe
	if (instance_exists(_player))
	{
		var _jogador = instance_nearest(x, y, obj_player);

		if point_distance(x, y, _jogador.x, _jogador.y) < raio_deteccao {
		    texto_visivel = true;
		} else {
		    texto_visivel = false;
		}
}
}

papo_furado_draw	= function()
{
	if texto_visivel 
	{
	    draw_set_halign(fa_center);
	    draw_set_color(c_white);
	    draw_text(x, y - sprite_height, texto);
		draw_circle(x, y, raio_deteccao, true);
	    draw_set_halign(fa_left); // Reseta
	}
}

#endregion