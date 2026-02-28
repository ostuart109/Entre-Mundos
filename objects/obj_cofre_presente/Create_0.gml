#region Iniciando Variáveis

//Começa fechado
image_index = 0 ;

#endregion

#region Iniciando Métodos

//Abrindo Cofre
cofre_abre	= function()
{
	if (keyboard_check_released(vk_space))
	{
		image_index = 1 ;
	}
}

#endregion