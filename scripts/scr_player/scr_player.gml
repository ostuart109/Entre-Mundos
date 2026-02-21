function cria_player()
{
	//Se o player não existe
    if (!instance_exists(obj_player))
    {
		//Ele cria o player
        var _lay = layer_create(-1000, "Player");
        instance_create_layer(100, 100, _lay, obj_player);
		
		//se a camera não existe
        if (!instance_exists(obj_camera))
        {
			//Ela cria a camera
            var _lay_camera = layer_create(-10000, "Camera");
            instance_create_layer(x, y, _lay_camera, obj_camera);
        }
    }
}