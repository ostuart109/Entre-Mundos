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

// Timer do "Salvando..."
mostrar_salvando = false;
timer_salvando   = 0;
TEMPO_SALVANDO   = game_get_speed(gamespeed_fps) * 3; // 3 segundos
texto_alpha		= 1 ;
salva_texto = "Salvando...";


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
    

    // PORÃO: começa em silêncio, música é ativada pelo obj_colisao ao tocar o NPC
    if (room == rm_porao_presente)
    {
        // Só para a música se a cena do porão ainda não foi ativada
        if (!global.musica_porao_tocando and current_music != -1)
        {
            audio_stop_sound(current_music);
            current_music = -1;
        }
        return; // O porão não usa o sistema automático de música
    }
    
    // Categorizando as salas por música (excluindo o porão)
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
            audio_play_sound(_musica_alvo, 10, true, 0.6, 0, 1.0);
        }
        
        // Atualiza qual música é a atual
        current_music = _musica_alvo;
    }
}

// Função chamada pelo NPC do porão ao ser tocado
ativa_musica_porao = function()
{
    if (!global.musica_porao_tocando)
    {
        global.musica_porao_tocando = true;
        if (current_music != -1) audio_stop_sound(current_music);
        audio_play_sound(snd_saves, 10, true, 0.6, 0, 1.0);
        current_music = snd_saves;
    }
}

//======================== SAVE ==========================

//Sistema de Save do Game JSON
salva_jogo		= function(_save)
{
	var _arquivo = "Meu Save" + string(_save+1) + ".json";
    var _dados =
    {
        player :
        {
            meu_x				: obj_player.x,
            meu_y				: obj_player.y,
            rm					: room,
            dialogo				: global.npcs_destruidos,
            saves				: global.saves_destruidos,
			//Desentupidor
			usou_desentupidor	: global.usou_desentupidor,
			tem_desentupidor	: global.tem_desentupidor,
			visitou_cozinha		: global.visitou_cozinha,
			//Cofre
			lembrou_senha		: global.lembrou_senha,
			pegou_chave_porao	: global.pegou_chave_porao,
			interagiu_cofre		: global.interagiu_cofre,
        },
    }
    var _string = json_stringify(_dados);
    var _file   = file_text_open_write(_arquivo);
    file_text_write_string(_file, _string);
    file_text_close(_file);

    // Reseta o timer ao salvar
    mostrar_salvando = true;
    timer_salvando   = TEMPO_SALVANDO;
}

//Carregando o jogo do JSON
carrega_jogo	= function(_save)
{
	//Alternando os saves
	var _arquivo			= "Meu Save" + string(_save+1) + ".json" ;	
	
	//Abrindo o arquivo
	var _file				= file_text_open_read(_arquivo) ;
	
	//Se o arquivo não existir ou falhar ao abrir
	if (_file == -1) return false;
	
	//Pegando os dados do arquivo
	var _string				= file_text_read_string(_file) ;
	
	//Fechando o arquivo
	file_text_close(_file) ;
	
	//Convertendo a String em um Struct novamente
	var _dados				= json_parse(_string) ;
	
    // Carregando as variáveis globais com segurança (caso não existam no save antigo)
    global.npcs_destruidos	= variable_struct_exists(_dados.player, "dialogo") ? _dados.player.dialogo : [] ;
    global.saves_destruidos = variable_struct_exists(_dados.player, "saves") ? _dados.player.saves : [] ;
	
	//Desentupidor
	global.usou_desentupidor    = variable_struct_exists(_dados.player, "usou_desentupidor") ? _dados.player.usou_desentupidor : false ;
	global.tem_desentupidor		= variable_struct_exists(_dados.player, "tem_desentupidor") ? _dados.player.tem_desentupidor : false ;
	global.visitou_cozinha		= variable_struct_exists(_dados.player, "visitou_cozinha") ? _dados.player.visitou_cozinha : false ;

	//Cofre
	global.lembrou_senha		= variable_struct_exists(_dados.player, "lembrou_senha") ? _dados.player.lembrou_senha : false ;
	global.pegou_chave_porao	= variable_struct_exists(_dados.player, "pegou_chave_porao") ? _dados.player.pegou_chave_porao : false ;				
	global.interagiu_cofre		= variable_struct_exists(_dados.player, "interagiu_cofre") ? _dados.player.interagiu_cofre : false ;
	
	//Passando as informações da posição do player
	if (instance_exists(obj_player))
	{
		obj_player.x			= _dados.player.meu_x ;
		obj_player.y			= _dados.player.meu_y ;
	}
	
	//Salvando a Room
	room_goto(_dados.player.rm) ;
}

//Iniciando o jogo
inicia_jogo		= function(_dados)
{
		//Se eu estou na room inicial
		//vou ver se a sequencia foi terminada
		var _seq = pega_sequencia("Saves") ;
		
		if (layer_sequence_is_finished(_seq))
		{
			//Rodei a função
			iniciei = true ;
			
			//Se não houver dados (Novo Jogo)
			if (!_dados)
			{
				// RESETAR TODAS AS VARIÁVEIS PARA O PADRÃO
				global.npcs_destruidos = [] ;
				global.saves_destruidos = [] ;
				global.usou_desentupidor = false ;
				global.tem_desentupidor = false ;
				global.visitou_cozinha = false ;
				global.lembrou_senha = false ;
				global.pegou_chave_porao = false ;
				global.interagiu_cofre = false ;
				
				//vai pra Room inicial do jogo
				room_goto(rm_sala_presente) ;
				
				//Layer do Player
				var _lay_player	= layer_create(-10000, "Player")
				
				//Cria o Player na posição inicial
				instance_create_layer(523, 380, _lay_player, obj_player) ;
			}
			else //Se eu tenho dados (Carregar Jogo)
			{
				// Carregando todas as informações do struct de dados com segurança
				global.npcs_destruidos		= variable_struct_exists(_dados.player, "dialogo") ? _dados.player.dialogo : [] ;
				global.saves_destruidos		= variable_struct_exists(_dados.player, "saves") ? _dados.player.saves : [] ;
				global.usou_desentupidor	= variable_struct_exists(_dados.player, "usou_desentupidor") ? _dados.player.usou_desentupidor : false ;
				global.tem_desentupidor		= variable_struct_exists(_dados.player, "tem_desentupidor") ? _dados.player.tem_desentupidor : false ;
				global.visitou_cozinha		= variable_struct_exists(_dados.player, "visitou_cozinha") ? _dados.player.visitou_cozinha : false ;
				global.lembrou_senha		= variable_struct_exists(_dados.player, "lembrou_senha") ? _dados.player.lembrou_senha : false ;
				global.pegou_chave_porao	= variable_struct_exists(_dados.player, "pegou_chave_porao") ? _dados.player.pegou_chave_porao : false ;
				global.interagiu_cofre		= variable_struct_exists(_dados.player, "interagiu_cofre") ? _dados.player.interagiu_cofre : false ;

				//Vai para a room salva
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


#endregion