#region Cria Métodos

//Camera
camera = function()
{
	//Se o player existe
	if (instance_exists(obj_player))
	{
		//Cria o objeto camera
		var _lay	= layer_create(-100, "Player")
		instance_create_layer(x, y, _lay, obj_camera) ;
	}
}

#endregion