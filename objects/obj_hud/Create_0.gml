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

controla_musica = function()
{
    var _musica_alvo = -1;
    
    // Categorizando as salas por música
    var _salas_puzzle = (room == rm_sala or room == rm_corredor or room == rm_quarto or room == rm_cozinha or room == rm_quintal or room == rm_sala_presente or room == rm_quintal_presente or room == rm_cozinha_presente or room == rm_corredor_presente or room == rm_quarto_presente);
    
    if (_salas_puzzle) 
    {
        _musica_alvo = snd_puzzles;
    }
    else if (room == rm_saves)
    {
        _musica_alvo = snd_saves;
    }
    
    // Se a música que deve tocar mudou
    if (current_music != _musica_alvo)
    {
        // Para a música que estiver tocando atualmente (se houver)
        if (current_music != -1)
        {
            audio_stop_sound(current_music);
        }
        
        // Toca a nova música (se houver uma definida para a sala)
        if (_musica_alvo != -1)
        {
            audio_play_sound(_musica_alvo, 10, true, 1.0, 0, 1.0);
            audio_sound_gain(_musica_alvo, 1.0, 2000);
        }
        
        // Atualiza qual música é a atual
        current_music = _musica_alvo;
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
			
			//Salvando o dialogo 
			dialogo		:  global.npcs_destruidos,
			
		    // Salvando os saves usados
		    saves       : global.saves_destruidos
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
	
	global.saves_destruidos = _dados.player.saves ;
	
	//Passando as informações da posição do player
	obj_player.x			= _dados.player.meu_x ;
	obj_player.y			= _dados.player.meu_y ;
	
	//Salvando a Room
	room					= _dados.player.rm ;
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
				room_goto(rm_sala_presente) ;
				
				//Layer do Player
				var _lay_player	= layer_create(-10000, "Player")
				
				//Cria o Player
				var _player = instance_create_layer(523, 380, _lay_player, obj_player) ;
			
			}
			else //Se eu tenho dados
			{
			    // Carrega o array ANTES de ir pra room
			    // (assim os NPCs já checam corretamente no CREATE deles)
			    global.npcs_destruidos = _dados.player.dialogo ;
				
				//Saves destruidos
				global.saves_destruidos = _dados.player.saves ;

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

#endregion