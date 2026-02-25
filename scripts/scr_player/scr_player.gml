//Vida do player
global.vida				= 5 ; 

//Vida Anterior é a vida do Player
global.vida_anterior	= global.vida;

//Player Morreu
global.player_morreu	= false ;

//Gerando o Player
function scr_player_layer()
{
	//Gerando o player numa profundidade
	if (!instance_exists(obj_player))
	{
		var _depth = -1000
		
		var _gema = instance_create_depth(267, 69, _depth, obj_player) ;
	}
	//Gerando a Camera
	if (instance_exists(obj_player))
	{
		with (obj_player)
		{
			var _depth_camera = -10000 ;
			
			if (!instance_exists(obj_camera))
			{
				instance_create_depth(x, y, _depth_camera, obj_camera) ;
			}
		}
	}
}