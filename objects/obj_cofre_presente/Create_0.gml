#region Iniciando Variáveis

//Começa fechado
//Começa fechado, mas se o player já pegou a chave ele abre
if (global.pegou_chave_porao) image_index = 1 ;
else image_index = 0 ;

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