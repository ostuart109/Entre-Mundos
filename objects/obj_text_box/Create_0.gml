#region Cria Variáveis

//====================== TEXT BOX ========================

//A estrutura do dialogo inicia sem nada
//(A estrutura do dialogo ta sendo criada no npc)
dialogo			= noone ;

//Efeito escrevaninha nas palavras
indice			= 1 ;

//Pagina do texto
pag				= 0 ;

//variavel pra liberar o querido Gemaplys
player			= noone ;

//Animação da caixa
//Escala da caixa pra iniciar animando
escala_caixa	= 0 ;

//Animação fundo da caixa
offset_x = 0;
offset_y = 0;
surf_fundo = -1;

//========= CONTROLE DE ANIMAÇÃO DAS SPRITES =============

sprite_timer = 0;           // Timer para controlar a animação do personagem
sprite_frame = 0;           // Frame atual da sprite do personagem
sprite_speed = 8;           // Muda de frame a cada X steps (quanto maior, mais lento)

//====== Controle da animação da CAIXA DE DIÁLOGO ========

caixa_timer = 0;            // Timer para a caixa
caixa_frame = 0;            // Frame atual da caixa
caixa_speed = 10;           // Velocidade da animação da caixa (ajuste conforme preferir)

//========================================================

#endregion

#region Criando Métodos

//liberando o player depois que o dialogo acaba
libera_player = function()
{
	//Se eu tenho um player
	if (player)
	{
		with(player)
		{
			//Deleta o NPC após o diálogo e salva na lista para não voltar
			if (instance_exists(npc_dialogo))
            {
                //Salva o ID fixo (posição) em vez do ID de instância
                array_push(global.npcs_destruidos, npc_dialogo.meu_id) ;
                instance_destroy(npc_dialogo) ;
                npc_dialogo = noone ;
            }
			
			//Ele vai pro estado parado
			estado = estado_parado ;
			
			//Ligando
			global.dialogo_aberto = false ;
		}
	}
	//Se destruindo
	instance_destroy() ;
}

//Cria o dialogo
cria_dialogo = function(_dialogo)
{
	//Se não tem dialogo eu saio
	if (_dialogo == noone) return ;
	
	//================ Variaveis Gerais 1 ===================	

	//Altura e largura da Text Box
	static _spr_w = sprite_get_width(spr_text_box) ;
	static _spr_h = sprite_get_height(spr_text_box) ;
	
	//================ Texto Variaveis ======================
	
	var _txt		= _dialogo.texto[pag] ;	
	var _txt_atual	= string_copy(_txt, 1, indice) ;
	var _txt_tam	= string_length(_txt);
	var _txt_vel	= _dialogo.txt_vel ;
	
	var _qtd_pag	= array_length(_dialogo.texto) - 1;
	
	//================ Caixa de Texto Variaveis =============
	
	static _gui_w	= display_get_gui_width() ;
	static _gui_h	= display_get_gui_height() ;
	
	var _escala_x	= ((_gui_w - 140) / _spr_w) * escala_caixa ;
	var _escala_y	= ((_gui_h * 0.2) / _spr_h) * escala_caixa ;
	
	var _margem		= string_height("I") ;
	
	//================ Variáveis Gerais 2 ===================
	
	var _yy			= _gui_h - (_escala_y * _spr_h) ;
	var _xx			= display_get_width() ;

	//================= Animação Text Box ===================	

	escala_caixa = lerp(escala_caixa, 1, 0.1) ;

	//=======================================================

	//Fonte
	draw_set_font(fnt_text_box) ;
	
	//Desenhando a caixa de texto
	draw_sprite_ext(spr_text_box, caixa_frame, 70, _yy - 10, _escala_x, _escala_y, image_angle, c_white, image_alpha) ;

	if (escala_caixa > .99)
	{
		escala_caixa = 1 ;
	}
	
	//Só faço tudo que estar em baixo, se eu já terminei a animação
	if (escala_caixa >= 1)
	{
		//Sempre que eu apertar Enter, Espaço ou F
		var _avancar = keyboard_check_released(vk_enter) or keyboard_check_released(vk_space) or keyboard_check_released(ord("F")) ;
		
		if (_avancar)
		{
			//Se eu ainda não terminei a página atual
			if (indice < _txt_tam)
			{
				//O Texto chega no final
				indice = _txt_tam ;
			}
			//Se eu ainda tenho paginas
			else if (pag < _qtd_pag)
			{
				indice = 0 ;
				pag++ ;
				sprite_frame = 0;
			}
			else //Acabei todas as páginas
			{
				libera_player() ;
			}
		}

		//=================== VOICES ===========================
		
		//Efeito Escrivaninha
		if (indice <= _txt_tam)
		{
		    indice += _txt_vel ;

		    if (floor(indice) != floor(indice - _txt_vel))
		    {
		        var _char = string_char_at(_txt, floor(indice)) ;

		        if (_char != " ")
		        {
		            if (audio_is_playing(_dialogo.sound[pag]))
		            {
		                audio_stop_sound(_dialogo.sound[pag]) ;
		            }

		            var _inst = audio_play_sound(_dialogo.sound[pag], 10, false) ;
		            audio_sound_pitch(_inst, random_range(0.9, 1.0)) ;
		        }
		    }
		}
		
		//==================================================
		
		//Desenhando o meu texto
		draw_text_ext(100, _yy - 3, _txt_atual, _margem, _gui_w - 180 ) ;
	}
	
	//Resetando
	draw_set_font(-1) ;
}

//liberando a surface quando o objeto for destruído
libera_surface = function()
{
	//Libera a surface quando o objeto for destruído
	if (surface_exists(surf_fundo)) 
	{
		surface_free(surf_fundo);
	}	
}

//Controle de animação do personagem
controle_animacao_personagem = function()
{						//&& dialogo.sprite[pag] != undefined
	if (dialogo != noone) 
	{
	    sprite_timer++;
		
	    if (sprite_timer >= sprite_speed) 
		{
	        sprite_timer = 0;
	        sprite_frame++;
			
			/*
	        // Reseta o frame quando chega no final da animação
	        var _sprite_atual = dialogo.sprite[pag];
			
	        if (sprite_frame >= sprite_get_number(_sprite_atual)) 
			{
	            sprite_frame = 0;
	        }
			*/
	    }
	}	
}

//Controle de animação da Caixa de dialogo
controle_animacao_text_box = function()
{
	caixa_timer++;
	if (caixa_timer >= caixa_speed) 
	{
	    caixa_timer = 0;
	    caixa_frame++;
    
	    // Reseta quando chega no final
	    if (caixa_frame >= sprite_get_number(spr_text_box)) 
		{
	        caixa_frame = 0;
	    }
	}
}

//Anima o fundo movendo na diagonal
anima_fundo = function()
{
	// Anima o fundo movendo na diagonal DESCENDO
	offset_x -= 0.5;  // Move para a esquerda
	offset_y += 0.5;  // Move para BAIXO

	// Loop infinito X (quando sair pela esquerda, volta)
	if (offset_x <= -sprite_get_width(spr_text_box)) {
		offset_x = 0;
	}

	// Loop infinito Y (quando sair por baixo, volta)
	if (offset_y >= sprite_get_height(spr_text_box)) {
		offset_y = 0;
	}	
}

#endregion




