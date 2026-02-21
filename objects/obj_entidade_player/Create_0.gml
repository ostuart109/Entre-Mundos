#region Criando Variáveis

velh	= 0 ;
velv	= 0 ;
vel_max	= 3 ;

#endregion

#region Criando Métodos

movimentacao = function()
{
	//Cima
	if (keyboard_check(vk_up))
	{
		y -= vel_max ;
	}

	//Baixo
	if (keyboard_check(vk_down))
	{
		y += vel_max ;
	}

	//Esquerda
	if (keyboard_check(vk_left))
	{
		x -= vel_max ;
	}

	//Direita
	if (keyboard_check(vk_right))
	{
		x += vel_max ;
	}
}

#endregion 