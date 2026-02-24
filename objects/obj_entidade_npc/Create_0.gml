//Text Box
#region TEXT BOX

//============= Text Box Retangulo Variáveis =============

//Iniciando Variáveis
larg	= 33 ;
alt		= -5 ;
margem	= 0 ;

//=================== Text Box Estrutura =================

//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["Eu pareço eles, mas não sigo eles, tenho exemplos tristes com um papel igual esse, e os meus parentes só querem que eu fique, Faculdade é bênção, but I wanna make it big! ", "Fiz coco nas minhas calças e gostei, Fiz coco nas minhas calças e gostei, Fiz coco nas minhas calças e gostei "],
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	//sound	: [snd_elder_kettle, snd_elder_kettle]
}

//====== Desenhando o Debug da area do retangulo  ========

//DEBUG
debug_area = function()
{
	//Se o Debug estar ativo
	//if (global.debug = true)
	//{
		//Variavel da margem
		var margem = 5;
		
		//Variáveis configuradas pra definir 
		//o tamanho do retangulo conforme o npc
		//Com origem em bottom center:
		//x já está no centro horizontal
		//y está na base (parte de baixo) da sprite
		var esquerda = x - sprite_get_width(sprite_index) / 2 - margem;
		var direita = x + sprite_get_width(sprite_index) / 2 + margem;
		var topo = y - sprite_get_height(sprite_index) - margem;
		var baixo = y + margem;
		
		//Desenhando o retangulo
		draw_rectangle(esquerda, topo, direita, baixo, true);
	//}
}

//================== Area da Text Box ====================

//Area do diálogo
dialogo_area = function()
{
	//Variavel da margem
	var margem = 5;
	
	//Variáveis configuradas pra definir 
	//o tamanho do retangulo conforme o npc
	//Com origem em bottom center:
	//x já está no centro horizontal
	//y está na base (parte de baixo) da sprite
	var esquerda = x - sprite_get_width(sprite_index) / 2 - margem;
	var direita = x + sprite_get_width(sprite_index) / 2 + margem;
	var topo = y - sprite_get_height(sprite_index) - margem;
	var baixo = y + margem;

	//Variavel para checar a colisão do player com o retangulo
	var _player	= collision_rectangle(esquerda, topo, direita, baixo, obj_player, 0, 1) ;
	
	//Se o player está colidindo na area
	if (_player)
	{
		//Se eu apertar Espaço
		//if (keyboard_check_released(vk_enter))
		//{	
			with(_player)
			{
				//Se o Gemaplys não esta no estado de dialogo
				if (estado != estado_dialogo)
				{
					//Gemaplys entra no estado de dialogo
					_player.estado = _player.estado_dialogo ;
					
					//Passando que é o npc desse dialogo
					npc_dialogo = other.id ;
					
					//if (npc_dialogo)
					//{
					//	instance_destroy(other.id) ;
					//}
				}
			}
		//}
	}
}

//========================================================

#endregion
