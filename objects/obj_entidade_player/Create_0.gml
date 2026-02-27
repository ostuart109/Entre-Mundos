//====================== VELOCIDADE ======================

//Variáveis velocidade

velh	= 0 ;
velv	= 0 ;

max_vel	= 3 ;


// Transição de Room
tp_cooldown = 0;
transition = 0; // 0 = nada, 1 = fechando, 2 = abrindo
trans_alpha = 0;
next_room   = -1;
next_x      = 0;
next_y      = 0;

// Definindo variaveis de Room
room_name_text  = "";
room_name_timer = 0;
room_name_alpha = 0;

//Delay do Sistema de viagem temporal
delay_tempo_max = 60 * 2; //Multiplicando o valor por segundos.
delay_tempo = delay_tempo_max; //Aplicando delay

//Configs de Barra
opacidade_barra_max = 0.8
opacidade_barra = opacidade_barra_max
cor_barra = c_red


//====================== Animações =======================

//0    - Direita
//1    - Cima
//2    - Esquerda
//3    - Baixo
face = 0 ;

//sprite
sprite = sprite_index ;

//Escala da imagem
xscale = image_xscale ;

sprites = [
//vetor 0
            //Sprites idle
            //0    - Direita
            //1    - Cima
            //2    - Esquerda
            //3    - Baixo
            [spr_player, spr_player, spr_player, spr_player],
			
//vetor 1
            //Sprites Walking
            //0    - Direita
            //1    - Cima
            //2    - Esquerda
            //3    - Baixo
            [spr_player_andando, spr_player_andando, spr_player_andando, spr_player_andando]
			];

//Essa variavel vai alterar as sprites de parado, movimentando e etc.
sprites_index = 0 ;

//====================== Estados =========================

//Estado inicia em nenhum
estado = noone ;

//Texto do estado
estado_txt = noone ;

//====================== Text Box ========================

//inicia sem estar com dialogo
npc_dialogo	= noone ;

//======================== Vida ==========================

//Frame da animação de destruição (image_index manual)
anim_destroi_frame = 0;


//=================== Audio andando ======================


max_tempo	= game_get_speed(gamespeed_fps) * 0.5 ;

tempo_audio = max_tempo;


//====================== Mapeamento ======================


//Mapeando as teclas
keyboard_set_map(ord("W"), vk_up) ;		//Cima
keyboard_set_map(ord("A"), vk_left) ;	//Baixo
keyboard_set_map(ord("S"), vk_down) ;	//Esquerda
keyboard_set_map(ord("D"), vk_right) ;	//Direita

#region Criando Estados
	
//Primeiro Estado
estado_parado    = function()
{
	// SE ESTIVER EM DIÁLOGO, NÃO PROCESSAR INPUTS
	//if (estado == estado_dialogo)
	//{
	//    return; 
	////	// Sai da função sem processar movimento
	//}
	
	
	
	//ele mostra o estado dele parado
	estado_txt = "parado" ;
	
	//meu vetor parado
	sprites_index = 0 ;
		
	//Minha sprite vai ser igual ao meu vetor 0 (parado)
	//[sprites_index]    - vetor parado
	//[face]            - a face que estou olhando
	sprite = sprites[sprites_index][face] ;
	
	//saindo do estado de parado
	//Se a velocidade é maior que 0.1, mudo para estado de movendo
	if (abs(velh) > 0.1 or abs(velv) > 0.1)
	{
		if estado != estado_dialogo
		{
		
		
	    //estou me movendo
	    estado = estado_movendo ;
		
		
		}
		
	}
}
	
//Segundo Estado
estado_movendo	= function()
{
	// SE ESTIVER EM DIÁLOGO, NÃO PROCESSAR INPUTS
	if (estado == estado_dialogo)
	{
	    return; 
		// Sai da função sem processar movimento
	}
	
	//ele mostra o estado dele movendo
	estado_txt = "movendo" ;
	
	//meu vetor movendo
	sprites_index = 1 ;	
	
	//Minha sprite vai ser igual ao meu vetor 1 (andando)
	//[sprites_index]    - vetor andando
	//[face]            - a face que estou olhando
	sprite = sprites[sprites_index][face] ;	
	
	//tempo audio
	tempo_audio -- ;
	
	//Saindo do estado movendo se a velocidade é quase 0
	if (abs(velv) <= 0.1 and abs(velh) <= 0.1)
	{
	    //estou parado
	    estado = estado_parado ;
	}
	
	if (tempo_audio <= 0)
	{
		var _som = random_range(ogg_snd_monk_footstep_01, ogg_snd_monk_footstep_02) ;
		var _ganho =  random_range(1.0, 0.4)
		
		audio_play_sound(_som, 5, 0, _ganho) ;
		
		tempo_audio = max_tempo ;
	}
}

//Terceiro Estado
viaja_tempo		= function()
{
	// SE ESTIVER EM DIÁLOGO, NÃO PROCESSAR INPUTS
	if (estado == estado_dialogo)
	{
	    return; 
		// Sai da função sem processar movimento
	}
	
	if (keyboard_check_released(ord("F")) xor keyboard_check_released(vk_space)) and delay_tempo <= 0
	{
		//SALA
		if (room == rm_sala and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_sala_presente)
			
			delay_tempo = delay_tempo_max //Resetanto o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
			
		}
		else if (room == rm_sala_presente and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_sala) ;
			
			delay_tempo = delay_tempo_max //Resetando o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
		}
		
		//CORREDOR
		if (room == rm_corredor and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_corredor_presente)
			
			delay_tempo = delay_tempo_max //Resetanto o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
			
		}
		else if (room == rm_corredor_presente and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_corredor) ;
			
			delay_tempo = delay_tempo_max //Resetando o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
		}
		
		//QUARTO
		if (room == rm_quarto and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_quarto_presente)
			
			delay_tempo = delay_tempo_max //Resetanto o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
			
		}
		else if (room == rm_quarto_presente and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_quarto) ;
			
			delay_tempo = delay_tempo_max //Resetando o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
		}
		
		//COZINHA
		if (room == rm_cozinha and (!place_meeting(x, y, obj_pode_viajar)))
		{	
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_cozinha_presente)
			
			delay_tempo = delay_tempo_max //Resetanto o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
			
		}
		else if (room == rm_cozinha_presente and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_cozinha) ;
			
			delay_tempo = delay_tempo_max //Resetando o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
		}
		
		//QUINTAL
		if (room == rm_quintal and (!place_meeting(x, y, obj_pode_viajar)))
		{	
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_quintal_presente)
			
			delay_tempo = delay_tempo_max //Resetanto o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
			
		}
		else if (room == rm_quintal_presente and (!place_meeting(x, y, obj_pode_viajar)))
		{
			//Cria o portal
			cria_portal() ;
			
			room_goto(rm_quintal) ;
			
			delay_tempo = delay_tempo_max //Resetando o delay
			opacidade_barra = opacidade_barra_max //Resetando Opacidade
			cor_barra = c_red //Resetando a cor
		}
	}
}

//Quinto Estado
estado_dialogo = function()
{
	//Se eu tenho um npc
	if (npc_dialogo)
	{
		//ele mostra o estado dele parado
		estado_txt = "Dialogo" ;
			
		//player fica parado
		velh = 0 ;
		velv = 0 ;		
		
		//meu vetor movendo
		sprites_index = 0 ;	
		
		//Minha sprite vai ser igual ao meu vetor 1 (andando)
		//[sprites_index]    - vetor andando
		//[face]            - a face que estou olhando
		sprite = sprites[sprites_index][face] ;	
		
		//Criando o diálogo
		//Checando se ele ainda não existe
		if (!instance_exists(obj_text_box))
		{
			//Variavel de criação do objeto "Text Box"
			var _obj_dialogo = instance_create_depth(0, 0, 0, obj_text_box) ;
				
			//Dialogo do objeto dialogo	
			_obj_dialogo.player = id ;
			
			//ligando
			global.dialogo_aberto = true
			
			//Passando o dialogo do npc, para o obj_dialogo
			with(npc_dialogo)
			{
				//O dialogo do objeto dialogo é o dialogo do npc
				//Dialogo do objeto dialogo			Dialogo do NPC
				_obj_dialogo.dialogo				= dialogo ;
			}
		}
	}
}

//inicia no estado parado
estado = estado_parado ;
	
#endregion

#region Criando Métodos

colisao = function()
{
	//Colisão Horizontal
	if (place_meeting(x + velh, y, obj_colisao))
	{
		//Pegando o sinal da minha velocidade horizontal
		var _velh = sign(velh) ;
		
		//Enquanto eu não estar colidindo com a parede
		while(!place_meeting(x + velh, y, obj_colisao))
		{
			//Avanço 1 pixel
			x += _velh ;
		}
		
		//Isso só roda quando o while deixar de rodar
		//Vou zerar a minha velh
		velh = 0 ;
	}
	
	x += velh ;
	
	//Colisão Vertical
	if (place_meeting(x, y + velv, obj_colisao))
	{
		//Pegando o sinal da minha velocidade horizontal
		var _velv = sign(velv) ;
		
		//Enquanto eu não estar colidindo com a parede
		while(!place_meeting(x, y + velv, obj_colisao))
		{
			//Avanço 1 pixel
			y += _velv ;
		}
		
		//Isso só roda quando o while deixar de rodar
		//Vou zerar a minha velh
		velv = 0 ;		
	}
	
	y += velv ;
}

animacao		= function()
{
	//Sistema de animação
	
	if global.dialogo_aberto == false
	{
	//Variáveis de Movimentação
	var _up		= keyboard_check(vk_up) ;
	var _left	= keyboard_check(vk_left) ;
	var _down	= keyboard_check(vk_down) ;
	var _right	= keyboard_check(vk_right) ;
	
	
	//Ajustando a face	
	//A ordem vai definir as prioridades
	//Se ir para cima
	if (_up)
	{	
		//Então
		//Ele olha pra cima
	    face = 1 ;
	}
	//Se ir para baixo
	if (_down)
	{
		//Então
		//Ele olha pra baixo
	    face = 3 ;
	}
	//Se ir pra esquerda
	if (_left)
	{
		//Então
		//Ele olha pra esquerda
	    face    = 2 ;
		
		//E a escala x da imagem é 1
	    xscale  = -1 ;
	}
	//Se ir pra direita
	if (_right)
	{
		//Então
		//Ele olha pra direita
	    face	= 0 ;
		
		//E a escala x da imagem é 1
	    xscale	= 1 ;
	}
	
	//Se eu apertar todos ao mesmo tempo
	//ele da prioridade a direita
	
	//Se voce clicar pra cima/baixo
	//ou clicar pra esquerda/direita
	if ((_up xor _down) or (_left xor _right))
	{
		//Point Direction
	    //x1 - meu ponto inicial de base (0,0)
	    //y1 - meu ponto inicial de base (0,0)
	    //x2 - meu destino (se estou indo para a direita tem que ser 1)
	    //y2 - meu destino (se estou indo para a esquerda tem que ser 0)
	    //é como isso:
	    //    0      -    1        = -1 
	    //(_right - _left) ;
	    //(_down  - _up) ;
	    //Isso vai falar a nossa direção
	    var _dir = point_direction(0,0,(_right - _left),(_down - _up)) ;
	
		//Pegando o valor do velh
	    //len    - distância que ele se move
	    //dir    - distância que ele está indo
	    var _max_velh = lengthdir_x(max_vel, _dir) ; //0 ou 5

	    //velh        - velocidade inicial
	    //_max_velh - velocidade maximo
	    velh = _max_velh ;
	
	    //Pegando o valor do velv
	    //len    - distância que ele se move
	    //dir    - distância que ele está indo
	    var _max_velv = lengthdir_y(max_vel, _dir) ; //0 ou 5
	
	    //velv        - velocidade inicial
	    //_max_velv - velocidade maximo
	    velv = _max_velv ;
	}
	else //Não estou apertando nenhuma tecla de movimento
	{
	    //Perdendo a velocidade
	    velh = 0 ;
	    velv = 0 ;
	}	
}
}


//Desenha o Tempo
desenha_tempo = function()
{
	if (room == rm_sala or room == rm_corredor or room == rm_quarto or room == rm_cozinha or room == rm_quintal or room == Rm_1 or room == Rm_2 or room == rm_sala_presente or room == rm_quintal_presente or room == rm_cozinha_presente or room == rm_corredor_presente)
	{
		if (place_meeting(x, y, obj_pode_viajar))
		{
			draw_set_font(fnt_aviso) ;
			
			draw_text(camera_get_view_width(view_camera[0])/2 + 30, camera_get_view_height(view_camera[0])/2 - 30, "Não posso viajar aqui...")
			
			draw_set_font(-1); // ou -1 pra fonte padrão
		}
	}
	
	if (room == rm_sala or room == rm_corredor or room == rm_quarto or room == rm_cozinha or room == rm_quintal or room == Rm_1 or room == Rm_2 or room == rm_sala_presente or room == rm_quintal_presente or room == rm_cozinha_presente or room == rm_corredor_presente)
	{
		if (place_meeting(x, y, obj_pode_viajar))
		{
			draw_set_font(fnt_aviso) ;
			
			draw_text(camera_get_view_width(view_camera[0])/2 + 30, camera_get_view_height(view_camera[0])/2 - 30, "Não posso viajar aqui...")
			
			draw_set_font(-1); // ou -1 pra fonte padrão
		}
	}	
}

desenha_estado	= function()
{
	//Centralizando
	draw_set_valign(1) ;
	draw_set_halign(1) ;

	//y - sprite_height * 2    - mostra o estado em que o player está
	//em cima da cabeça dele
	draw_text(x, y - sprite_height * 2, estado_txt) ;
	
	//resetando
	//Centralizando
	draw_set_valign(-1) ;
	draw_set_halign(-1) ;
}

//Isso cria o portal
cria_portal = function()
{
	//Layer do Portal
	var _layer_portal = layer_create(depth + 1, "Portal");
			
	//Cria o Portal
	instance_create_layer(x,y, _layer_portal, obj_portal) ;
			
	//toca o som do portal
	audio_play_sound(snd_portal, 5, 0) ;
}

#endregion


