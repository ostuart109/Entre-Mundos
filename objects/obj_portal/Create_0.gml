#region Iniciando Variáveis

sprite = sprite_index ;

#endregion

#region Iniciando Métodos

desenha_portal = function()
{
	//Escala da imagem
	var _scale			= 1.5
	var _image_xscale	= image_xscale * _scale ;
	var _image_yscale	= image_yscale * _scale ;

	//Desenhando a sprite do objeto
	draw_sprite_ext(sprite, image_index, x, y, _image_xscale, _image_yscale, image_angle, c_white, image_alpha) ;	
}

#endregion