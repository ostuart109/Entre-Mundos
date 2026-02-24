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
			//Ele vai pro estado parado
			estado = estado_parado ;
			
			//Ligando
			global.dialogo_aberto = false ;
			
		}
	}
	//Se destruindo
	instance_destroy() ;
	
	//destruindo o npv
	instance_destroy(obj_entidade_npc.id) ;
}

pag_dublagem_anterior = -1;

//Cria o dialogo
cria_dialogo = function(_dialogo)
{
	//================ Variaveis Gerais 1 ===================	

	//Altura e largura da Text Box
	static _spr_w = sprite_get_width(spr_text_box) ;
	static _spr_h = sprite_get_height(spr_text_box) ;
	
	//================ Texto Variaveis ======================
	
	//Acessando a estrutura do dialogo
	//(A estrutura do dialogo ta sendo criada no npc)
	//[0]	- Primeiro item do vetor
	//exemplo: texto : [[0] texto 1, [1] texto 2, [2] texto 3.]
	var _txt		= _dialogo.texto[pag] ;	
	//Efeito escrevaninha nas palavras	
	var _txt_atual	= string_copy(_txt, 1, indice) ;
	var _txt_tam	= string_length(_txt);	//Tamanho do Texto
	var _txt_vel	= _dialogo.txt_vel ;	//Velocidade do Texto
	
	//Quantidade de paginas que teremos
	//-1 - Ele começa a contar do 0, então tem que ser isso menos 1
	var _qtd_pag	= array_length(_dialogo.texto) - 1;
	
	//================ Caixa de Texto Variaveis =============

	//Fonte
	draw_set_font(fnt_text_box) ;
	
	//Largura e Altura da GUI
	//Static - Faz com que elas não mudem de valor e chamo elas só uma vez
	static _gui_w	= display_get_gui_width() ;
	static _gui_h	= display_get_gui_height() ;
	//altura e largura da GUI
	//show_message(_gui_w) ; //640
	//show_message(_gui_h) ; //360
	
	//Convertendo a escala da sprite da caixa de texto
	//de pixels para escala (porcentagem)
	//1 = 100% ;
	//_gui_w	- tamanho que eu quero
	//_spr_w - tamanho da sprite
	var _escala_x	= ((_gui_w - 140) / _spr_w) * escala_caixa ;
	//_spr_h - tamanho da sprite
	//Quero que ele ocupe 20% da tela
	var _escala_y	= (_gui_h * 0.2) / _spr_h ;
	
	//Margem do Texto
	var _margem		= string_height("I") ;
	
	//================ Variáveis Gerais 2 ===================
	
	//Pegando a altura da minha tela
	//_gui_h	- Desce até o final da tela
	//(_escala_y * _spr_h)	- Volta a altura da sprite
	var _yy			= _gui_h - (_escala_y * _spr_h) ;
	//Pegando a largura da tela
	var _xx			= display_get_width() ;
	
	//================ Sprites Characters ===================
	
	/*
	//retrato
	var _retrato	= _dialogo.sprite[pag] ; 
	
	//Tamanho da sprite
	//Estamos usando o "Y" como base
	var _ret_escala	= (_gui_h * 0.3 ) / sprite_get_height(_retrato) ;
	//Posição da Sprite
	var _ret_y		= _yy - 50 
	//Ajustando o texto conforme a largura da sprite
	var _ret_larg	= _ret_escala * sprite_get_width(_retrato) ;
	*/

	//================= Animação Text Box ===================	

	//Animação da caixa
	//Aumentando a escala da caixa
	escala_caixa = lerp(escala_caixa, 1, 0.1) ;

	//============== FUNDO ANIMADO COM SURFACE ==============
	/*
	var _box_x = 70;
	var _box_y = _yy - 10;

	// Calcula as dimensões da surface com base na ESCALA ANIMADA
	var _box_largura = (_spr_w * _escala_x) - 6;
	var _box_altura = (_spr_h * _escala_y) - 8;

	// Garante valores mínimos válidos
	_box_largura = max(_box_largura, 1);
	_box_altura = max(_box_altura, 1);

	// Cria a surface se não existir E se as dimensões forem válidas
	if (!surface_exists(surf_fundo) and _box_largura > 1 and _box_altura > 1) {
		surf_fundo = surface_create(_box_largura, _box_altura);
	}
	
	// Recria a surface se o tamanho mudou (durante a animação)
	if (surface_exists(surf_fundo)) {
		if (surface_get_width(surf_fundo) != _box_largura || surface_get_height(surf_fundo) != _box_altura) {
			surface_free(surf_fundo);
			if (_box_largura > 1 and _box_altura > 1) {
				surf_fundo = surface_create(_box_largura, _box_altura);
			}
		}
	}

	// Só desenha se a surface existir e for válida
	if (surface_exists(surf_fundo)) {
		// Desenha o fundo na surface
		surface_set_target(surf_fundo);
		draw_clear_alpha(c_black, 0);
		
		// Desenha um grid 3x3 de sprites
		var _spr_w_back = sprite_get_width(spr_text_box);
		var _spr_h_back = sprite_get_height(spr_text_box);
		for (var _i = -1; _i <= 1; _i++) {
			for (var _j = -1; _j <= 1; _j++) {
				draw_sprite_ext(
					spr_text_box, 
					0, 
					offset_x + (_i * _spr_w_back), 
					offset_y + (_j * _spr_h_back), 
					1, 1, 0, c_white, 1
				);
			}
		}
		surface_reset_target();

		// Desenha a surface na posição da caixa
		draw_surface(surf_fundo, _box_x + 3, _box_y + 4);
	}
	*/
	
	//=======================================================

	//Desenhando a caixa de texto - USANDO caixa_frame
	draw_sprite_ext(spr_text_box, caixa_frame, 70, _yy - 10, _escala_x, _escala_y, image_angle, c_white, image_alpha) ;
	/*
	//Personagem sprite - USANDO sprite_frame
	draw_sprite_ext(_retrato, sprite_frame, 75, _ret_y, _ret_escala, _ret_escala, image_angle, c_white, image_alpha) ;
	*/
	//Se o lerp se aproximar do valor desejado
	if (escala_caixa > .99)
	{
		//Ele fica em 1
		escala_caixa = 1 ;
	}
	
	//Só faço tudo que estar em baixo, se eu já terminei a animação
	if (escala_caixa >= 1)
	{
		//Sempre que eu apertar Enter 
		if (keyboard_check_released(vk_enter))
		{
			//Se eu ainda não terminei a página atual (as letras dela)
			if (indice < _txt_tam)
			{
				//O Texto chega no final
				indice = _txt_tam ;
			}
			//Caso contrário, eu pulo de páginas
			//Se eu ainda tenho paginas
			else if (pag < _qtd_pag)
			{
				//Zerando o indice
				indice = 0 ;
		
				//Eu pulo de página
				pag++ ;

				//Resetando o frame da sprite quando muda de página
				sprite_frame = 0;
			}
			else //Acabei a página atual e não tenho mais nenhuma para ler
			{
				//variável das vozes 
				//var _dublagem = _dialogo.sound[pag];
				 
				//O player é liberado
				libera_player() ;
				
				//Se as vozes dos personagens estão tocando
				//if (audio_is_playing(_dublagem))
				//{
				//	//Elas param
				//	audio_stop_sound(_dublagem);
				//}
			}
		}

		//=================== VOICES ===========================
		
		//Efeito Escrivaninha
		if (indice <= _txt_tam)
		{
		    //Aumentando o valor do indice (efeito escrevaninha)
		    indice += _txt_vel ;
			/*
		    //Dublagem
			//Se a página for diferente da pagina anterior
		    if (pag != pag_dublagem_anterior)
		    {
				//variável das vozes 
		        var _dublagem = _dialogo.sound[pag];
				
				//Se as vozes dos personagens estão tocando
		        if (audio_is_playing(_dublagem))
				{
					//Elas param
		            audio_stop_sound(_dublagem);
				}
				
				//As vozes tocam
		        audio_play_sound(_dublagem, 30, 0, 10.0);
				
				//Pagina anterior é igual a página
		        pag_dublagem_anterior = pag;
		    }
			*/
		}
		
		//==================================================
		
		
		//Desenhando o meu texto
		//_margem - Separação de texto
		draw_text_ext(100, _yy - 3, _txt_atual, _margem, _gui_w - 180 ) ;
					  //+ _ret_larg							         - _ret_larg
		//Resetando
		draw_set_font(-1) ;
	}

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




