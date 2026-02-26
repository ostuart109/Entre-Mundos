//======================= SAVE ===========================

//Localizar os saves
enum saves 
{
	save_01,
	save_02,
	save_03
}

//Iniciou Jogo
global.iniciou = false ;

//Variável para saber qual o save do jogo
global.save = saves.save_01 ;

//salvando
global.saves_destruidos = [] ;

function pega_sequencia(_nome)
{
	//Pegando a minha layer
	var _lay	= layer_get_id(_nome) ;
			
	//Pegando a sequence dentro da Layer
	var _seq	= layer_get_all_elements(_lay) ;
			
	//Encontra dentro do array o elemento que é a sequence
	//Rodando pelo vetor
	for (var _i = 0; _i < array_length(_seq); _i++)
	{
		//Checando se o elemento atual é uma sequencia
		var _atual	= _seq[_i] ;
				
		if (layer_get_element_type(_atual) == layerelementtype_sequence)
		{
			//Se o elemento atual for a minha sequencia
			//Eu salvo ele na variável sq e termino o loop 
			return _atual ;
		}
	}
	
	return false ;
}