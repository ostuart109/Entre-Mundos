//====================== VELOCIDADE ======================

//Variáveis velocidade
velh	= 0 ;
velv	= 0 ;
max_vel	= 3 ;

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
	    //estou me movendo
	    estado = estado_movendo ;
	}
}
	
//Segundo Estado
estado_movendo	= function()
{
	//ele mostra o estado dele movendo
	estado_txt = "movendo" ;
	
	//meu vetor movendo
	sprites_index = 1 ;	
	
	//Minha sprite vai ser igual ao meu vetor 1 (andando)
	//[sprites_index]    - vetor andando
	//[face]            - a face que estou olhando
	sprite = sprites[sprites_index][face] ;	
	
	//Saindo do estado movendo se a velocidade é quase 0
	if (abs(velv) <= 0.1 and abs(velh) <= 0.1)
	{
	    //estou parado
	    estado = estado_parado ;
	}
}

//Terceiro Estado
viaja_tempo		= function()
{
	if (keyboard_check_released(ord("F")))
	{
		if (room == Rm_1 and (!place_meeting(x, y, obj_pode_viajar)))
		{
			room_goto(Rm_2)
		}
		else if (room == Rm_2 and (!place_meeting(x, y, obj_pode_viajar)))
		{
			room_goto(Rm_1) ;
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

//Desesnha o Tempo
desenha_tempo = function()
{
	if (room == Rm_1)
	{
		draw_text(550, 20, "Presente")
		
		if (place_meeting(x, y, obj_pode_viajar))
		{
			draw_text(camera_get_view_width(view_camera[0])/2, camera_get_view_height(view_camera[0])/3, "Nao posso viajar aqui...")
		}
	}

	if (room == Rm_2)
	{
		draw_text(550, 20, "Passado")
		
		if (place_meeting(x, y, obj_pode_viajar))
		{
			draw_text(camera_get_view_width(view_camera[0])/2, camera_get_view_height(view_camera[0])/3, "Nao posso viajar aqui...")
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

#endregion
