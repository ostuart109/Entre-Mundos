#region Criando Variáveis

//Resolução
resolution_width	= 1280 ;
resolution_height	= 720 ;

//Escala da Resolução
resolution_scale	= 2 ;

//Largura e Altura da Janela
global.view_width	= resolution_width / resolution_scale ;
global.view_height	= resolution_height / resolution_scale ;

//Objeto Seguido
view_target = obj_player ;

//Velocidade da camera
view_spd	= 0.1 ;

//Tamanho da Janela
window_set_size(global.view_width * resolution_scale, global.view_height * resolution_scale) ;

//Barra preta do lado da camera
surface_resize(application_surface, global.view_width * resolution_scale, global.view_height * resolution_scale) ;

//Definindo o tamanho da GUI
display_set_gui_size(global.view_width, global.view_height) ;

#endregion

#region Criando métodos

//Setando e criando a camera
cria_camera = function()
{
	//Setando a camera
	camera_set_view_size(view_camera[0], global.view_width, global.view_height) ;

	//Se o objeto seguido existe
	if (instance_exists(view_target))
	{
		//O meio da Largura da tela segue o X do objeto seguido
		var _x1 = view_target.x - global.view_width/2
	
		//O meio da Altura da tela segue o Y do objeto seguido
		var _y1 = view_target.y - global.view_height/2
	
		//Definindo o tamanho da câmera
		_x1 = clamp(_x1, 0, room_width - global.view_width) ;
		_y1 = clamp(_y1, 0, room_height - global.view_height) ;
	
		//X e Y da Camera
		var c_x = camera_get_view_x(view_camera[0]) ;
		var c_y = camera_get_view_y(view_camera[0]) ;
	
		//Posição da Camera
		camera_set_view_pos(view_camera[0], clamp(_x1, c_x, _x1), clamp(_y1, c_y, _y1)) ;
	}	
}

//Habilitando a view da camera
habilita_view = function()
{
	//Habilitando a View
	view_enabled	= true ;
	//Deixando a View visível
	view_visible[0] = true ;
}

#endregion