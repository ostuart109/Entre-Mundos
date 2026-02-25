#region Iniciando Variáveis

//==================== Música Room =======================

// Variável que guarda qual música está tocando atualmente
// -1 = nenhuma música tocando
// Qualquer outro valor = ID da música que está tocando
current_music = -1;

//========================================================

#endregion

#region Cria Métodos

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

/*
//Musicas
musica_puzzles = function()
{
	//Se for essas room
	var _checa_room_puzzle = (room == Rm_1 and room == Rm_2) ;
	
	// Verifica se está na sala do menu E se a música do menu ainda não está tocando
    if (_checa_room_puzzle and current_music != snd_puzzles)
    {
        // Para todas as músicas que estiverem tocando
        //audio_stop_all();
		
        //Toca a música do menu
        // Parâmetros: (som, prioridade, loop, volume, offset, pitch)
        // prioridade 10 = evita que seja cortada por outros sons
        // true = música fica em loop (repete infinitamente)
        // 1.0 = volume 100%, 0 = começa do início, 1.0 = velocidade normal
        audio_play_sound(snd_puzzles, 10, true, 1.0, 0, 1.0);

        // Para fade in suave:
        // Faz o volume da música subir gradualmente de 0 até 1.0 (100%)
        audio_sound_gain(snd_puzzles, 1.0, 2000); // Volume sobe em 2 segundos

        // Marca que a música do menu está tocando agora
        // Isso evita que a música toque várias vezes seguidas
        current_music = snd_puzzles;
    }
	
	//Se não for essas room
	var _nao_checa_room_puzzle	= (room != Rm_1 or room != Rm_2) ;
	
    // Parar música quando sair do menu
    // Verifica se NÃO está no menu E se a música do menu ainda está tocando
    if ( _nao_checa_room_puzzle and current_music == snd_puzzles)
    {
        //A música do menu para de tocar
        audio_stop_sound(snd_puzzles);

        // Reseta a variável para -1 (nenhuma música tocando)
        // Isso permite que a música toque novamente quando voltar ao menu
        current_music = -1;
    }
}
*/

musica_puzzles = function()
{
    show_debug_message("=== musica_puzzles chamada ===");
    show_debug_message("room atual: " + string(room));
    show_debug_message("Rm_1: " + string(Rm_1));
    show_debug_message("Rm_2: " + string(Rm_2));
    show_debug_message("current_music: " + string(current_music));
    show_debug_message("snd_puzzles: " + string(snd_puzzles));

    var _checa_room_puzzle = (room == Rm_1 or room == Rm_2);
    show_debug_message("_checa_room_puzzle: " + string(_checa_room_puzzle));

    if (_checa_room_puzzle and current_music != snd_puzzles)
    {
        show_debug_message("ENTROU NO IF - vai tocar música");
        audio_play_sound(snd_puzzles, 10, true, 1.0, 0, 1.0);
        audio_sound_gain(snd_puzzles, 1.0, 2000);
        current_music = snd_puzzles;
    }

    var _nao_checa_room_puzzle = (room != Rm_1 and room != Rm_2);
    show_debug_message("_nao_checa_room_puzzle: " + string(_nao_checa_room_puzzle));

    if (_nao_checa_room_puzzle and current_music == snd_puzzles)
    {
        show_debug_message("PAROU A MÚSICA");
        audio_stop_sound(snd_puzzles);
        current_music = -1;
    }
}





#endregion