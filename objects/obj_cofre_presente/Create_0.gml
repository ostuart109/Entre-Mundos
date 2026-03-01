#region Iniciando Variáveis

//Começa fechado
image_index = 0 ;

#endregion

#region Iniciando Métodos

//Abrindo Cofre
cofre_abre	= function()
{
	if global.pegou_chave_porao
	{
		image_index = 1 ;
	}
}

#endregion