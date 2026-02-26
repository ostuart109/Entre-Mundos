#region Iniciando Variáveis

//==================== Música Room =======================

// Variável que guarda qual música está tocando atualmente
// -1 = nenhuma música tocando
// Qualquer outro valor = ID da música que está tocando
current_music = -1;

//======================== SAVE ==========================

//Inicia sem dados
dados	= noone ;

//Ainda não iniciei o jogo
iniciei	= false ;

//========================================================

#endregion

#region Cria Métodos

//======================== FPS ===========================

//FPS
desenha_fps = function()
{
	//Definindo a cor
	draw_set_colour(c_aqua) ;

	//60 FPS
	draw_text(20, 20, fps) ;
	
	//Real FPS
	draw_text(20, 40, fps_real) ;

	//barrinha Debug
	show_debug_overlay(true) ;

	//Resetando
	draw_set_colour(-1) ;
}

//====================== MUSICAS =========================

musica_puzzles = function()
{
    var _checa_room_puzzle = (room == Rm_1 or room == Rm_2);
    //show_debug_message("_checa_room_puzzle: " + string(_checa_room_puzzle));

    if (_checa_room_puzzle and current_music != snd_puzzles)
    {
        //show_debug_message("ENTROU NO IF - vai tocar música");
        audio_play_sound(snd_puzzles, 10, true, 1.0, 0, 1.0);
        audio_sound_gain(snd_puzzles, 1.0, 2000);
        current_music = snd_puzzles;
    }

    var _nao_checa_room_puzzle = (room != Rm_1 and room != Rm_2);
    //show_debug_message("_nao_checa_room_puzzle: " + string(_nao_checa_room_puzzle));

    if (_nao_checa_room_puzzle and current_music == snd_puzzles)
    {
        //show_debug_message("PAROU A MÚSICA");
        audio_stop_sound(snd_puzzles);
        current_music = -1;
    }
}

//======================== SAVE ==========================

//Sistema de Save do Game JSON
salva_jogo		= function(_save)
{
	//Alternando os saves
	var _arquivo = "Meu Save" + string(_save+1) + ".json" ;	
	
	//Criando a Struct com os dados
	var _dados = 
	{
		//Criando uma struct com os dados do player
		player :
		{
			//Salvando a Posição do Player
			meu_x		: obj_player.x,
			meu_y		: obj_player.y,
			
			//Salvando a Room que o Player está
			rm			: room,
			
			//Vida
			m_vida		: global.vida,
			
			//Salvando o dialogo 
			dialogo		:  global.npcs_destruidos
		}, 
	}
	
	//Convertendo os dados em JSON
	var _string = json_stringify(_dados) ;
	
	//Abrindo o meu arquivo
	var _file	= file_text_open_write(_arquivo) ;
	
	//Gravando as informações nele
	file_text_write_string(_file, _string) ;
	
	//Fechando o arquivo
	file_text_close(_file) ;
}

//Carregando o jogo do JSON
carrega_jogo	= function(_save)
{
	//Alternando os saves
	var _arquivo			= "Meu Save" + string(_save+1) + ".json" ;	
	
	//Abrindo o arquivo
	var _file				= file_text_open_read(_arquivo) ;
	
	//Pegando os dados do arquivo
	var _string				= file_text_read_string(_file) ;
	
	//Fechando o arquivo
	file_text_close(_file) ;
	
	//Convertendo a String em um Struct novamente
	var _dados				= json_parse(_string) ;
	
    // Carrega o array de NPCs destruídos ANTES de ir pra room
    // (assim os obj_entidade_npc já checam corretamente no CREATE)
    global.npcs_destruidos	= _dados.player.dialogo ;
	
	//Passando as informações da posição do player
	obj_player.x			= _dados.player.meu_x ;
	obj_player.y			= _dados.player.meu_y ;
	
	//Salvando a Room
	room					= _dados.player.rm ;
			
	//Vida
	global.vida				= _dados.player.m_vida ;
}

//Iniciando o jogo
inicia_jogo		= function(_dados)
{
	//Se eu estou na room inicial
	//vou ver se a sequencia foi terminada

	var _seq	= pega_sequencia("Saves") ;
	
	if (layer_sequence_is_finished(_seq))
	{
		//Rodei a função
		iniciei = true ;
		
		//Se os dados forem inválidos (false)
		//Ele inicia o jogo normalmente da tela inicial
		if (room == rm_saves)
		{
			if (!_dados)
			{
				//vai pra Room 1
				room_goto(Rm_1) ;
				
				//Layer do Player
				var _lay_player	= layer_create(-10000, "Player")
				
				//Cria o Player
				var _player = instance_create_layer(512, 320, _lay_player, obj_player) ;
			}
			else //Se eu tenho dados
			{
			    // Carrega o array ANTES de ir pra room
			    // (assim os NPCs já checam corretamente no CREATE deles)
			    global.npcs_destruidos = _dados.player.dialogo ;
				
			    //Criando ele na room e posição
			    room_goto(_dados.player.rm) ;
				
			    //Layer do Player
			    var _lay_player = layer_create(-10000, "Player") ;
				
			    //Cria Player
			    var _player = instance_create_layer(0, 0, _lay_player, obj_player) ;
				
			    with(_player)
			    {
			        x = _dados.player.meu_x ;	
			        y = _dados.player.meu_y ;				
			    }
			}
		}
	}
			
	//Se os dados forem válidos
	//Ele inicia o jogo com as informações dos dados
	
}

//Usando Saves
usa_save		= function()
{
	//Testando o meu Save
	if (keyboard_check_released(ord("K")))
	{
		salva_jogo(global.save) ;
	}
	
	//Carregando
	//if (keyboard_check_released(ord("L")))
	//{
	//	carrega_jogo(global.save) ;
	//}
}

#endregion