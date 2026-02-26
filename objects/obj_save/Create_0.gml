
//Salvando a posição inicial do meu x
meu_x_inicial			= 350 ;

//Opacidade transparente
opacidade_transparente	= 0.5 ;

//Opacidade visivel
opacidade_visivel		= 1 ;

//Mudando o alpha deles
image_alpha		= opacidade_transparente ;

meus_dados		= 0 ;

global.iniciou	= false ;

//Numerando save
meu_save = instance_number(obj_save) ;

meu_efeito = function()
{
	//Se o mouse está em cima do id do save
	var _mouse_sobre	= position_meeting(mouse_x, mouse_y, id) ;
	
	//Se o mouse clicar
	var _mouse_click	= mouse_check_button_released(mb_left) ;
	
	//Se o mouse está em cima
	if (_mouse_sobre)
	{
		//Efeito
		x				= lerp(x, meu_x_inicial - 10, 0.1) ;
		
		//Ficando visivel
		image_alpha		= lerp(image_alpha, opacidade_visivel, 0.1) ;
		
		//Checando se clicou e ainda não iniciou
		if (_mouse_click and global.iniciou == false)
		{
			//Inicia
			global.iniciou	= true ;
			
			//Defininfo o save do Jogo
			global.save		= meu_save-1 ;
			
			var _seq		= pega_sequencia("Saves") ;
			
			//Pausando a sequence
			layer_sequence_play(_seq) ;
			
			//Passando os meus dados para o obj_hud
			if (instance_exists(obj_hud))
			{
				//Adiciona os dados
				obj_hud.dados = meus_dados ;
			}
		}
	}
	else
	{
		//Efeito
		x				= lerp(x, meu_x_inicial, 0.1) ;
		
		//Ficando transparente
		image_alpha		= lerp(image_alpha, opacidade_transparente, 0.1) ;
	}
}

//Pega Save
pega_save	= function(_save)
{
	//Tentar abrir o arquivo do jogo
	//Se ele conseguir ele retorna o arquivo
	//Se não conseguir ele retorna false
	
	//Nome do arquivo
	var _meu_arquivo	= "Meu save" + string(_save) + ".json" ;
	
	//Abrindo o arquivo
	var _arquivo		= file_text_open_read(_meu_arquivo) ;
	
	//Se o arquivo for invalido 
	if (_arquivo == -1)
	{
		//Eu retorno false
		return false ;
	}
	
	//salvando a informação em algum lugar
	var _string			= file_text_read_string(_arquivo) ;
	
	//Convertendo a string em uma struct
	var _dados			= json_parse(_string) ;
	
	//retorna os dados
	return	_dados ;
}

meus_dados = pega_save(meu_save) ;
